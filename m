Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265523AbTBQCwn>; Sun, 16 Feb 2003 21:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265885AbTBQCwn>; Sun, 16 Feb 2003 21:52:43 -0500
Received: from crack.them.org ([65.125.64.184]:29373 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S265523AbTBQCwm>;
	Sun, 16 Feb 2003 21:52:42 -0500
Date: Sun, 16 Feb 2003 22:02:25 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Roland McGrath <roland@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: Signal/gdb oddity in 2.5.61
Message-ID: <20030217030225.GA9917@nevyn.them.org>
Mail-Followup-To: Roland McGrath <roland@redhat.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
References: <20030216232751.GA7687@nevyn.them.org> <200302170100.h1H10aQ28610@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302170100.h1H10aQ28610@magilla.sf.frob.com>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 16, 2003 at 05:00:36PM -0800, Roland McGrath wrote:
> > That said, I've still got two issues with your change.  For one thing,
> > the version of GDB that Russell was running, you'll note, was 5.0.  A
> > lot of people haven't upgraded GDB in years, and have some dispute with
> > the present version that means they don't want to upgrade.  I've only
> > just stopped seeing people using 4.18.  In conversation with Russell
> > I've already encountered another reason he doesn't want to upgrade. 
> 
> Anyone who wants to use an old gdb with a new kernel can use "handle
> SIGSTOP nopass".  Is that a real imposition?  Anyway, aside from the test
> suite, it only affects gdb users in a way that may confuse them for a few
> seconds but doesn't prevent them from debugging normally.
> 
> > And I'm also concerned that other programs may use it.
> 
> Other programs may use PTRACE_CONT with SIGSTOP and expect it to act like
> PTRACE_CONT with 0?  It's certainly possible.  But since the quirk with
> SIGSTOP was so counterintuitive to begin with, it seems unlikely to me that
> someone would have expected that behavior in particular.  Some programs
> like strace are written to treat all signals the same and pass them through
> to PTRACE_CONT (actually PTRACE_SYSCALL); they will now cause an endless
> stream of SIGSTOP stops until someone uses SIGCONT, instead of swallowing
> the SIGSTOP--now they do for SIGSTOP what they've always done for SIGTSTP
> et al.

I think I'm convinced.  Sorry for wasting your time.  If it comes up we
can put it on a GDB FAQ somewhere.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
