Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267153AbTAOUTW>; Wed, 15 Jan 2003 15:19:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267178AbTAOUTW>; Wed, 15 Jan 2003 15:19:22 -0500
Received: from crack.them.org ([65.125.64.184]:58046 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S267153AbTAOUTT>;
	Wed, 15 Jan 2003 15:19:19 -0500
Date: Wed, 15 Jan 2003 15:27:51 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Daniel Barlow <dan@telent.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.x, can't ptrace a task created with clone() ?
Message-ID: <20030115202751.GA7696@nevyn.them.org>
Mail-Followup-To: Daniel Barlow <dan@telent.net>,
	linux-kernel@vger.kernel.org
References: <87r8bebcct.fsf@noetbook.telent.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r8bebcct.fsf@noetbook.telent.net>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2003 at 04:34:58PM +0000, Daniel Barlow wrote:
> 
> Tested with 4.2.20 and 2.4.21-pre3, after PTRACE_ATTACHing to a
> process I created with clone(), wait() returns ECHILD .  strace
> of the parent shows
> 
> clone(child_stack=0x80599a8, flags=CLONE_VM) = 1292
> rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
> rt_sigaction(SIGCHLD, NULL, {SIG_DFL}, 8) = 0
> rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
> nanosleep({5, 0}, {5, 0})               = 0
> ptrace(PTRACE_ATTACH, 1292, 0, 0)       = 0
> --- SIGCHLD (Child exited) ---
> wait4(-1, 0xbffffbf0, 0, NULL)          = -1 ECHILD (No child processes)
> write(2, "waitpid: No child processes\n", 28) = 28
> 
> If I replace the clone in my test program with a fork, everything
> works as I expected.  Is this a bug, or are my expectations at fault?
> if the latter, how _do_ I attach to one of my cloned children?

You did attach.  But if you want to wait for a cloned child, you need
to use __WCLONE or __WALL.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
