Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261723AbUFJPwx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261723AbUFJPwx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 11:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbUFJPwx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 11:52:53 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:12021 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261723AbUFJPww (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 11:52:52 -0400
Date: Thu, 10 Jun 2004 09:01:57 -0700
From: Paul Jackson <pj@sgi.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6.7-rc3-mm1] perfctr cpumask cleanup
Message-Id: <20040610090157.04fa62ee.pj@sgi.com>
In-Reply-To: <16584.9947.222378.506457@alkaid.it.uu.se>
References: <200406092050.i59KoWoa000621@alkaid.it.uu.se>
	<20040609154750.241df741.pj@sgi.com>
	<16584.9947.222378.506457@alkaid.it.uu.se>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael wrote:
>  > -		cpus_andnot(new_mask, old_mask, tmp);
>  > +		cpus_andnot(new_mask, old_mask, perfctr_cpus_forbidden_mask);
> 
> Doesn't work because cpus_andnot() requires all three parameters
> to be lvalues. ... CPU_MASK_NONE ...

I think your other fix (also done by Bill Irwin), make the above possible:

 #define CPU_MASK_NONE							\
-{ {									\
+((cpumask_t) { {							\


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
