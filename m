Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268328AbUI2MEq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268328AbUI2MEq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 08:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268329AbUI2MEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 08:04:46 -0400
Received: from witte.sonytel.be ([80.88.33.193]:17063 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S268328AbUI2MEn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 08:04:43 -0400
Date: Wed, 29 Sep 2004 14:04:27 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Andreas Schwab <schwab@suse.de>
cc: Roland McGrath <roland@redhat.com>,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: notify_parent (was: Re: Linux 2.6.9-rc2)
In-Reply-To: <jey8j528n2.fsf@sykes.suse.de>
Message-ID: <Pine.GSO.4.61.0409291403560.18029@waterleaf.sonytel.be>
References: <200409142019.i8EKJ8HG002560@magilla.sf.frob.com>
 <Pine.LNX.4.61.0409192213250.14392@anakin> <jey8j528n2.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Sep 2004, Andreas Schwab wrote:
> Geert Uytterhoeven <geert@linux-m68k.org> writes:
> 
> > -			regs->sr &= ~PS_T;
> > -
> > -			/* Did we come from a system call? */
> > -			if (regs->orig_d0 >= 0) {
> > -				/* Restart the system call the same way as
> > -				   if the process were not traced.  */
> > -				struct k_sigaction *ka =
> > -					&current->sighand->action[signr-1];
> > -				int has_handler =
> > -					(ka->sa.sa_handler != SIG_IGN &&
> > -					 ka->sa.sa_handler != SIG_DFL);
> > -				handle_restart(regs, ka, has_handler);
> > -			}
> 
> This should be put in ptrace_signal_deliver.  That had fixed quite a few
> gdb testsuite failures.

OK.

> 
> > -			/* We're back.  Did the debugger cancel the sig?  */
> > -			if (!(signr = current->exit_code)) {
> > -			discard_frame:
> > -			    /* Make sure that a faulted bus cycle isn't
> > -			       restarted (only needed on the 680[23]0).  */
> > -			    if (regs->format == 10 || regs->format == 11)
> > -				regs->stkadj = frame_extra_sizes[regs->format];
> 
> This is important if you want continue after a SEGV.

IC. But where should I do that?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
