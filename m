Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262321AbTJDQK6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 12:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262374AbTJDQK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 12:10:58 -0400
Received: from home.nightdaughter.de ([194.95.224.141]:26895 "EHLO
	a141.shuttle.de") by vger.kernel.org with ESMTP id S262321AbTJDQK4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 12:10:56 -0400
Date: Sat, 4 Oct 2003 18:11:00 +0200
From: Joerg Hoh <joerg@devone.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0test5: ptrace() broken on alpha
Message-ID: <20031004161100.GC3573@hydra.joerghoh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While debugging screen we found a strange problem; you can reproduce it
with
                                                                                                                                                             
strace -tt fo sh -c "sleep 1; sleep 1"
                                                                                                                                                             
The strace hangs (like here)
                                                                                                                                                             
[strippd]
17:07:46.400332 getpgrp()               = 302
17:07:46.400691 rt_sigaction(SIGCHLD, {0x120040210, [], 0}, {SIG_DFL}, 8, 0xffffffffffffffff) = 0
17:07:46.401228 osf_sigprocmask(0x1, 0, 0x1200f8508) = 0
17:07:46.401632 osf_sigprocmask(0x1, 0, 0x1200f8508) = 0
17:07:46.402027 osf_sigprocmask(0x1, 0, 0x1200f8508) = 0
17:07:46.402833 stat(".", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
17:07:46.403283 stat("/usr/local/sbin/sleep", 0x11ffff620) = -1 ENOENT (No such file or directory)
17:07:46.403661 stat("/usr/local/bin/sleep", 0x11ffff620) = -1 ENOENT (No such file or directory)
17:07:46.404044 stat("/usr/sbin/sleep", 0x11ffff620) = -1 ENOENT (No such file or directory)
17:07:46.404374 stat("/usr/bin/sleep", 0x11ffff620) = -1 ENOENT (No such file or directory)
17:07:46.404733 stat("/sbin/sleep", 0x11ffff620) = -1 ENOENT (No such file or directory)
17:07:46.405065 stat("/bin/sleep", {st_mode=S_IFREG|0755, st_size=20608, ...}) = 0
17:07:46.405428 stat("/bin/sleep", {st_mode=S_IFREG|0755, st_size=20608, ...}) = 0
17:07:46.406012 osf_sigprocmask(0x1, 0x80002, 0x11ffff7d0) = 0
17:07:46.406361 fork()                  = 304
17:07:46.415170 osf_sigprocmask(0x3, 0, 0) = 524290
17:07:46.415639 osf_sigprocmask(0x1, 0x80000, 0x11ffff8f0) = 0
17:07:46.415920 osf_sigprocmask(0x3, 0, 0) = 524288
17:07:46.416151 osf_sigprocmask(0x1, 0x80000, 0x11ffff8f0) = 0
17:07:46.416376 rt_sigaction(SIGINT, {0x12003ec60, [], 0}, {SIG_DFL}, 8, 0xffffffffffffffff) = 0
17:07:46.416820 wait4(-1,
                                                                                                                                                             
It seems the child has been forked but hasn't done anything further (no
exit()); (btw screen has a race condition, first forking and then
registering the signal handler).
                                                                                                                                                             
The problem occurs also on 2.6.0test6
                                                                                                                                                             
Joerg

-- 
...Wenn man sich bei NetBSD auf eines verlassen kann, dann: Egal, WAS[...]
man updated, mplayer hat mit Sicherheit dependencies drauf.
  Rene Schickbauer, news:2591532.ZKZXAUW3eG@gandalf.grumpfzotz.org
