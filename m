Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264278AbUHNRhA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264278AbUHNRhA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 13:37:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264371AbUHNRhA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 13:37:00 -0400
Received: from rproxy.gmail.com ([64.233.170.198]:51903 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S264278AbUHNRg5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 13:36:57 -0400
Message-ID: <2a4f155d0408141036e114001@mail.gmail.com>
Date: Sat, 14 Aug 2004 20:36:57 +0300
From: =?ISO-8859-1?Q?ismail_d=F6nmez?= <ismail.donmez@gmail.com>
Reply-To: =?ISO-8859-1?Q?ismail_d=F6nmez?= <ismail.donmez@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Latest 2.6 kernels broke debugging of threaded applications
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I am having weird problems with gdb & latest 2.6 kernels

I tested 2.6.6,.2.6.7,.2.6.8 and they all have the same problem. When
I try to debug a threaded application in gdb applications freezes and
gdb doesn't output anything. strace shows this interesting piece at
the point the application freezes :

<snip>

--- SIGCHLD (Child exited) @ 0 (0) ---
sigreturn()                             = ? (mask now [RTMIN])
wait4(-1, [{WIFSTOPPED(s) && WSTOPSIG(s) == SIGTRAP}], 0, NULL) = 17055
ptrace(PTRACE_GETREGS, 17055, 0, 0xbfffea60) = 0
ptrace(PTRACE_PEEKUSER, 17055, offsetof(struct user, u_debugreg) + 24,
[0xffff4ff0]) = 0
ptrace(PTRACE_PEEKTEXT, 17055, 0x4000af40, [0x5de58955]) = 0
ptrace(PTRACE_PEEKTEXT, 17055, 0x4000af40, [0x5de58955]) = 0
ptrace(PTRACE_POKEDATA, 17055, 0x4000af40, 0x5de589cc) = 0
ptrace(PTRACE_CONT, 17055, 0, SIG_0)    = 0
wait4(-1, [{WIFSTOPPED(s) && WSTOPSIG(s) == SIGTRAP} | 0x30000], 0,
NULL) = 17055
--- SIGCHLD (Child exited) @ 0 (0) ---
sigreturn()                             = ? (mask now [RTMIN])
--- SIGCHLD (Child exited) @ 0 (0) ---
sigreturn()                             = ? (mask now [RTMIN])
ptrace(0x4201 /* PTRACE_??? */, 17055, 0, 0xbfffec08) = 0
wait4(17062, [{WIFSTOPPED(s) && WSTOPSIG(s) == SIGSTOP}], __WCLONE,
NULL) = 17062
ptrace(PTRACE_DETACH, 17062, 0, SIG_0)  = 0
wait4(-1,

</snip>

Debugging works fine with 2.4.26 and 2.6.8-rc4-mm1. Any ideas?

P.S: I am on a Slackware 10 box.

Cheers,
ismail


-- 
Time is what you make of it
