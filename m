Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261254AbRFASry>; Fri, 1 Jun 2001 14:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261213AbRFASro>; Fri, 1 Jun 2001 14:47:44 -0400
Received: from smtpnotes.altec.com ([209.149.164.10]:20487 "HELO
	smtpnotes.altec.com") by vger.kernel.org with SMTP
	id <S261217AbRFASr2>; Fri, 1 Jun 2001 14:47:28 -0400
X-Lotus-FromDomain: ALTEC
From: Wayne.Brown@altec.com
To: Alan Cox <laughing@shared-source.org>
cc: linux-kernel@vger.kernel.org
Message-ID: <86256A5E.0066F63D.00@smtpnotes.altec.com>
Date: Fri, 1 Jun 2001 13:45:55 -0500
Subject: Re: Linux 2.4.5-ac6
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



The oops problem with the cs46xx in my ThinkPad 600X under -ac4 and -ac5 has
changed now.  It no longer gives an oops; instead the program trying to access
the sound card hangs (until I kill it).  Subsequent attempts to access the sound
card get a "Device or resource busy" error.  There are no messages on the screen
or sent to syslog (or messages or debug) when the hang occurs.  I don't know if
it will help or not, but here are the last few lines of an strace of the hanging
process:

stat("/usr/bin/sox", {st_mode=S_IFREG|0755, st_size=120744, ...}) = 0
rt_sigprocmask(SIG_BLOCK, ~[], [], 8)   = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
fork()                                  = 186
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {0x806c04c, [], 0x4000000}, {SIG_DFL}, 8) = 0
wait4(-1, 0xbffff744, 0, NULL)          = ? ERESTARTSYS (To be restarted)
--- SIGTERM (Terminated) ---
+++ killed by SIGTERM +++

At the point of the hang, the output stops at "wait4(-1, " and the rest of that
line (and the next two lines) appears after I kill the process.


Here are the last few lines of another strace of the same program under
2.4.5-ac3, which works fine:

stat("/usr/bin/sox", {st_mode=S_IFREG|0755, st_size=120744, ...}) = 0
rt_sigprocmask(SIG_BLOCK, ~[], [], 8)   = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
fork()                                  = 435
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {0x806c04c, [], 0x4000000}, {SIG_DFL}, 8) = 0
wait4(-1, [WIFEXITED(s) && WEXITSTATUS(s) == 0], 0, NULL) = 435
rt_sigprocmask(SIG_BLOCK, [CHLD TTOU], [CHLD], 8) = 0
rt_sigprocmask(SIG_SETMASK, [CHLD], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [CHLD], 8) = 0
rt_sigprocmask(SIG_SETMASK, [CHLD], NULL, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
--- SIGCHLD (Child exited) ---
wait4(-1, 0xbffff438, WNOHANG, NULL)    = -1 ECHILD (No child processes)
sigreturn()                             = ? (mask now [])
rt_sigaction(SIGINT, {SIG_DFL}, {0x806c04c, [], 0x4000000}, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, [CHLD TTOU], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
read(255, "", 4472)                     = 0
_exit(0)                                = ?h


