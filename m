Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262496AbTESO2t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 10:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262493AbTESO2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 10:28:49 -0400
Received: from us02smtp1.synopsys.com ([198.182.60.75]:26503 "HELO
	vaxjo.synopsys.com") by vger.kernel.org with SMTP id S262490AbTESO2q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 10:28:46 -0400
Date: Mon, 19 May 2003 16:41:30 +0200
From: Alex Riesen <alexander.riesen@synopsys.COM>
To: mikpe@csd.uu.se
Cc: sfr@canb.auug.org.au, linux-kernel@vger.kernel.org,
       linux-laptop@vger.kernel.org
Subject: Re: 2.5.69+bk: oops in apmd after waking up from suspend mode
Message-ID: <20030519144130.GM32559@Synopsys.COM>
Reply-To: alexander.riesen@synopsys.COM
References: <200305191216.h4JCGONj015081@harpo.it.uu.se> <20030519123119.GA20385@Synopsys.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030519123119.GA20385@Synopsys.COM>
Organization: Synopsys, Inc.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Riesen, Mon, May 19, 2003 14:31:19 +0200:
> > >EIP is at fix_processor_context+0x5f/0x100
> > >Process kapmd (pid: 4, threadinfo=c5f0e000 task=c5fbc640)
> > 
> > After receiving Alex' .config and gcc version (3.2.3), I've been
> > able to decipher this. current->mm is NULL in the kapmd task. The call
> > 
> > 	load_LDT(&current->mm->context);	/* This does lldt */
> > 
> > in fix_processor_context() computes the address of context as
> > (current->mm)+0x7c, which is 0x7c. load_LDT_nolock() dereferences
> > 0x7c+0x14 (void *segments = pc->ldt) and the oops follows.
> > 
> > As to _why_ kapmd's current->mm is NULL, I don't know. It isn't
> > when I test APM suspend in 2.5.69-bk. A lot of code dereferences
> > current->mm without checking, so I guess current->mm==NULL is a bug.
> > 
> 
> i just go and try it with the latest -bk.
> 

no change. Still oopses.

Is it safe to trace this path with printks? I'm about to put them in,
but a good advice could probably come before the compilation finishes.

-alex


