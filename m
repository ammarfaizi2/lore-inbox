Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270984AbTHOVW4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 17:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270989AbTHOVW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 17:22:56 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:37646
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S270984AbTHOVWx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 17:22:53 -0400
Date: Fri, 15 Aug 2003 14:22:44 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Ed L Cashin <ecashin@uga.edu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] do_wp_page: BUG on invalid pfn
Message-ID: <20030815212244.GQ1027@matchmail.com>
Mail-Followup-To: Ed L Cashin <ecashin@uga.edu>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Rusty Russell <rusty@rustcorp.com.au>
References: <20030815184720.A4D482CE79@lists.samba.org> <877k5e8vwe.fsf@uga.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877k5e8vwe.fsf@uga.edu>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 15, 2003 at 05:15:45PM -0400, Ed L Cashin wrote:
> Rusty Russell <rusty@rustcorp.com.au> writes:
> 
> > In message <87d6fixvpm.fsf@uga.edu> you write:
> >> This patch just does what the comment says should be done.
> >
> > Hi Ed!
> >
> > 	Not trivial I'm afraid.  Send to Linus and lkml.
> 
> 
> This patch just does what the comment says should be done.  I thought
> it was a trivial patch, but Rusty Russell has informed me otherwise.
> (Thanks, RR).
> 
> 
> --- linux-2.6.0-test2/mm/memory.c.orig	Sun Jul 27 13:01:24 2003
> +++ linux-2.6.0-test2/mm/memory.c	Wed Aug  6 18:30:55 2003
> @@ -990,15 +990,10 @@
>  	int ret;
>  
>  	if (unlikely(!pfn_valid(pfn))) {
> -		/*
> -		 * This should really halt the system so it can be debugged or
> -		 * at least the kernel stops what it's doing before it corrupts
> -		 * data, but for the moment just pretend this is OOM.
> -		 */
> -		pte_unmap(page_table);
>  		printk(KERN_ERR "do_wp_page: bogus page at address %08lx\n",
>  				address);
> -		goto oom;
> +		dump_stack();
> +		BUG();

You're not unmapping the pte I guess to not interfere with the dump_stack,
but what about the printk?  Will that affect the dump_stack also?
