Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264571AbUISWbq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264571AbUISWbq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 18:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264704AbUISWbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 18:31:46 -0400
Received: from cantor.suse.de ([195.135.220.2]:48321 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264571AbUISWbo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 18:31:44 -0400
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Roland McGrath <roland@redhat.com>,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: notify_parent (was: Re: Linux 2.6.9-rc2)
References: <200409142019.i8EKJ8HG002560@magilla.sf.frob.com>
	<Pine.LNX.4.61.0409192213250.14392@anakin>
From: Andreas Schwab <schwab@suse.de>
X-Yow: Yow!  Am I having fun yet?
Date: Mon, 20 Sep 2004 00:31:29 +0200
In-Reply-To: <Pine.LNX.4.61.0409192213250.14392@anakin> (Geert
 Uytterhoeven's message of "Sun, 19 Sep 2004 22:16:21 +0200 (CEST)")
Message-ID: <jey8j528n2.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> -			regs->sr &= ~PS_T;
> -
> -			/* Did we come from a system call? */
> -			if (regs->orig_d0 >= 0) {
> -				/* Restart the system call the same way as
> -				   if the process were not traced.  */
> -				struct k_sigaction *ka =
> -					&current->sighand->action[signr-1];
> -				int has_handler =
> -					(ka->sa.sa_handler != SIG_IGN &&
> -					 ka->sa.sa_handler != SIG_DFL);
> -				handle_restart(regs, ka, has_handler);
> -			}

This should be put in ptrace_signal_deliver.  That had fixed quite a few
gdb testsuite failures.

> -			/* We're back.  Did the debugger cancel the sig?  */
> -			if (!(signr = current->exit_code)) {
> -			discard_frame:
> -			    /* Make sure that a faulted bus cycle isn't
> -			       restarted (only needed on the 680[23]0).  */
> -			    if (regs->format == 10 || regs->format == 11)
> -				regs->stkadj = frame_extra_sizes[regs->format];

This is important if you want continue after a SEGV.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
