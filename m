Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423049AbWBBBhQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423049AbWBBBhQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 20:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423047AbWBBBhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 20:37:15 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:31163 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1423044AbWBBBhO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 20:37:14 -0500
Date: Thu, 2 Feb 2006 10:37:11 +0900
To: "Luck, Tony" <tony.luck@intel.com>
Cc: linux-kernel@vger.kernel.org, Richard Henderson <rth@twiddle.net>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-ia64@vger.kernel.org,
       linuxsh-dev@lists.sourceforge.net, Andi Kleen <ak@suse.de>
Subject: Re: [patch 41/44] make thread_info.flags an unsigned long
Message-ID: <20060202013711.GA7143@miraclelinux.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F0595DB4D@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F0595DB4D@scsmsx401.amr.corp.intel.com>
User-Agent: Mutt/1.5.9i
From: mita@miraclelinux.com (Akinobu Mita)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2006 at 10:17:43AM -0800, Luck, Tony wrote:
>  
> --- 2.6-git.orig/include/asm-ia64/thread_info.h
> +++ 2.6-git/include/asm-ia64/thread_info.h
> @@ -24,7 +24,7 @@
>  struct thread_info {
>  	struct task_struct *task;	/* XXX not really needed, except for dup_task_struct() */
>  	struct exec_domain *exec_domain;/* execution domain */
> -	__u32 flags;			/* thread_info flags (see TIF_*) */
> +	unsigned long flags;		/* thread_info flags (see TIF_*) */
>  	__u32 cpu;			/* current CPU */
>  	mm_segment_t addr_limit;	/* user-level address space limit */
>  	int preempt_count;		/* 0=premptable, <0=BUG; will also serve as bh-counter */
> 
> This leaves a useless hole in the structure.  Tell me again why
> this is a good thing?

This patch stops warning message introduced by the "[patch 25/44]
ia64: use generic bitops" which replaces __set_bit() family to
generic one.

But I realize that I can't replace to generic one for ia64.
Because __set_bit() family are using the pointer to __u32, but
generic __set_bit() family are using the pointer to unsigned long.

So the patch 25/44 is wrong and the change above is unnessesary.
Thanks
