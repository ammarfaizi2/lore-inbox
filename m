Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751496AbWJ1BMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496AbWJ1BMz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 21:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751506AbWJ1BMy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 21:12:54 -0400
Received: from mail.kroah.org ([69.55.234.183]:10644 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751496AbWJ1BMx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 21:12:53 -0400
Date: Fri, 27 Oct 2006 18:11:26 -0700
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Stephen Hemminger <shemminger@osdl.org>,
       Pavel Machek <pavel@ucw.cz>, Matthew Wilcox <matthew@wil.cx>,
       Adrian Bunk <bunk@stusta.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [patch] drivers: wait for threaded probes between initcall levels
Message-ID: <20061028011126.GB22273@kroah.com>
References: <20061026191131.003f141d@localhost.localdomain> <20061027170748.GA9020@kroah.com> <20061027172219.GC30416@elf.ucw.cz> <20061027113908.4a82c28a.akpm@osdl.org> <20061027114144.f8a5addc.akpm@osdl.org> <20061027114237.d577c153.akpm@osdl.org> <20061027114729.49185fd2@freekitty> <20061027131529.980cd53e.akpm@osdl.org> <Pine.LNX.4.64.0610271323020.3849@g5.osdl.org> <Pine.LNX.4.64.0610271347320.3849@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610271347320.3849@g5.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2006 at 01:48:54PM -0700, Linus Torvalds wrote:
> 
> 
> On Fri, 27 Oct 2006, Linus Torvalds wrote:
> 
> > 
> > 	static int do_in_parallel(void *arg)
> > 	{
> > 		struct thread_exec *p = arg;
> > 		int (*fn)(void *) = p->fn;
> > 		void *arg = p->arg;
> > 		int retval;
> > 
> > 		/* Tell the caller we are done with the arguments */
> > 		complete(&p->completion);
> > 
> > 		/* Do the actual work in parallel */
> > 		retval = p->fn(p->arg);
> 
> Duh. The whole reason I copied them was to _not_ do that. That last line 
> should obviously be
> 
> 		retval = fn(arg);
> 
> because "p" may gone after we've done the "complete()".
> 
> > (And I repeat: the above code is untested, and was written in the email 
> > client. It has never seen a compiler, and not gotten a _whole_ lot of 
> > thinking).
> 
> .. This hasn't changed, I just looked through the code once and found that 
> obvious bug.

Heh, ok, I'll take this idea, and Andrew's patch, and rework things for
the next round of 2.6.20-rc kernels, and mark the current stuff as
BROKEN for now.

thanks,

greg k-h
