Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263980AbUDGADZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 20:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264026AbUDGADZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 20:03:25 -0400
Received: from ausmtp01.au.ibm.com ([202.81.18.186]:64217 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP id S263980AbUDGADY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 20:03:24 -0400
Subject: Re: [PATCH] mask ADT: new mask.h file [2/22]
From: Rusty Russell <rusty@rustcorp.com.au>
To: Paul Jackson <pj@sgi.com>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mbligh@aracnet.com, Andrew Morton <akpm@osdl.org>, wli@holomorphy.com,
       colpatch@us.ibm.com
In-Reply-To: <20040406034055.1dbe2eac.pj@sgi.com>
References: <20040329041253.5cd281a5.pj@sgi.com>
	 <1081128401.18831.6.camel@bach> <20040405000528.513a4af8.pj@sgi.com>
	 <1081150967.20543.23.camel@bach> <20040405010839.65bf8f1c.pj@sgi.com>
	 <1081227547.15274.153.camel@bach> <20040405230601.62c0b84c.pj@sgi.com>
	 <1081233543.15274.190.camel@bach> <20040405234552.23f810cd.pj@sgi.com>
	 <1081235999.28514.9.camel@bach>  <20040406034055.1dbe2eac.pj@sgi.com>
Content-Type: text/plain
Message-Id: <1081255616.28514.72.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 07 Apr 2004 10:02:13 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-04-06 at 20:40, Paul Jackson wrote:
> Rusty - thank-you very much for your constructive feedback so far.
> 
> Seems to me that we are in agreement that slimming down the
> internals of cpumask_t is worth proceeding with, but not on possible
> changes to the cpumask API seen by the rest of the kernel.

OK, cool.  We can have that debate later.

> static inline void bitmap_and(unsigned long *d, const unsigned long *s1,
> 			const unsigned long *s2, int nbits)
> {
> 	if (nbits <= BITS_PER_LONG)
> 		d[0] = s1[0] & s2[0];
> 	else
> 		_bitmap_and(d, s1, s2, nbits);
> }

Two suggestions:
1) I think you only want the fastpath when it's eliminated by the
compiler, so perhaps:
	if (__builtin_constant_p(nbits) && nbits <= BITS_PER_LONG)

2) The normal kernel naming scheme is two underscores (__bitmap_and),
probably because it's clearer visually.

Thanks,
Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

