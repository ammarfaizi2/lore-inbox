Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265697AbUFDJnJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265697AbUFDJnJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 05:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265695AbUFDJnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 05:43:08 -0400
Received: from fw.osdl.org ([65.172.181.6]:10722 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265691AbUFDJmv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 05:42:51 -0400
Date: Fri, 4 Jun 2004 02:41:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: pj@sgi.com, nickpiggin@yahoo.com.au, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org, ak@muc.de, ashok.raj@intel.com,
       hch@infradead.org, jbarnes@sgi.com, joe.korty@ccur.com,
       manfred@colorfullife.com, colpatch@us.ibm.com, mikpe@csd.uu.se,
       Simon.Derr@bull.net, wli@holomorphy.com
Subject: Re: [PATCH] cpumask 5/10 rewrite cpumask.h - single bitmap based
 implementation
Message-Id: <20040604024153.2b820545.akpm@osdl.org>
In-Reply-To: <16576.16748.771295.988065@alkaid.it.uu.se>
References: <20040603094339.03ddfd42.pj@sgi.com>
	<20040603101010.4b15734a.pj@sgi.com>
	<1086313667.29381.897.camel@bach>
	<40BFD839.7060101@yahoo.com.au>
	<20040603221854.25d80f5a.pj@sgi.com>
	<16576.16748.771295.988065@alkaid.it.uu.se>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson <mikpe@csd.uu.se> wrote:
>
> Paul Jackson writes:
>  > Perhaps I should comment the cpus_addr() definition as 'deprecated'?
> 
> Please don't. cpus_addr() is useful when you need to get a
> handle on the representation for non-cpumask_t operations.
> 
> Case in point: the perfctr kernel extension needs to communicate
> a cpumask_t to user-space because of the asymmetric nature of
> HT P4s. Unfortunately, a simple copy_to_user() won't work because:
> a) the size depends on kernel .config, and
> b) the representation is defined in terms of sequences of ulong,
>    which breaks 32-bit applications on 64-bit kernels.
> So perfctr instead converts a cpumask_t to a sequence of uint,
> and copies both the number of uints and the uints themselves
> to user-space.

In that case the cpumask code should provide some API function which
converts a cpumask_t into (and from?) some canonical and documented form. 
Then you copy what it gave you to userspace.

Particular pieces of code shouldn't go poking inside the cpumask_t's
representation.  It's different on different architectures and we could
even change it in the future.

