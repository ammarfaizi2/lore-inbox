Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290882AbSARX7d>; Fri, 18 Jan 2002 18:59:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290885AbSARX7X>; Fri, 18 Jan 2002 18:59:23 -0500
Received: from ns.suse.de ([213.95.15.193]:40965 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S290882AbSARX7G> convert rfc822-to-8bit;
	Fri, 18 Jan 2002 18:59:06 -0500
To: Pavel Machek <pavel@suse.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.17: sys_sigsuspend does not return value
In-Reply-To: <20020118210825.GA6175@elf.ucw.cz>
X-Yow: How's it going in those MODULAR LOVE UNITS??
From: Andreas Schwab <schwab@suse.de>
Date: Sat, 19 Jan 2002 00:59:04 +0100
In-Reply-To: <20020118210825.GA6175@elf.ucw.cz> (Pavel Machek's message of
 "Fri, 18 Jan 2002 22:08:26 +0100")
Message-ID: <jewuyfw6rb.fsf@sykes.suse.de>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) Emacs/21.1.30 (ia64-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> writes:

|> Hi!
|> 
|> >From 2.4.17:
|> 
|> asmlinkage int
|> sys_sigsuspend(int history0, int history1, old_sigset_t mask)
|> {
|>         struct pt_regs * regs = (struct pt_regs *) &history0;
|>         sigset_t saveset;
|> 
|>         mask &= _BLOCKABLE;
|>         spin_lock_irq(&current->sigmask_lock);
|>         saveset = current->blocked;
|>         siginitset(&current->blocked, mask);
|>         recalc_sigpending(current);
|>         spin_unlock_irq(&current->sigmask_lock);
|> 
|>         regs->eax = -EINTR;
|>         while (1) {
           ^^^^^^^^^
|>                 current->state = TASK_INTERRUPTIBLE;
|>                 schedule();
|>                 if (do_signal(regs, &saveset))
|>                         return -EINTR;
|>         }
|> }
|> 
|> ...Which looks to me like it returns something undefined when
|> do_signal returns 0.

There is only one return path from this function.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE GmbH, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
