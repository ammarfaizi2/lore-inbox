Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265153AbTIEPyL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 11:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265179AbTIEPyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 11:54:11 -0400
Received: from mail-2.tiscali.it ([195.130.225.148]:31123 "EHLO
	mail-2.tiscali.it") by vger.kernel.org with ESMTP id S265153AbTIEPyG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 11:54:06 -0400
From: Lorenzo Allegrucci <l.allegrucci@tiscali.it>
Organization: -ENOENT
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [OOPS] 2.6.0-test4 CONFIG_PREEMPT=y
Date: Fri, 5 Sep 2003 17:57:34 +0000
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200309051757.13205.l.allegrucci@tiscali.it>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I can get a quite reproducible oops under -test4 with
CONFIG_PREEMPT enabled:

Sep  5 17:35:46 odyssey kernel: kernel BUG at kernel/exit.c:729!
Sep  5 17:35:46 odyssey kernel: invalid operand: 0000 [#1]
Sep  5 17:35:46 odyssey kernel: CPU:    0
Sep  5 17:35:46 odyssey kernel: EIP:    0060:[do_exit+526/1024]    Not tainted
Sep  5 17:35:46 odyssey kernel: EFLAGS: 00010296
Sep  5 17:35:46 odyssey kernel: EIP is at do_exit+0x20e/0x400
Sep  5 17:35:46 odyssey kernel: eax: 00000004   ebx: dffeeaa0   ecx: dc0c4040   
edx: dc230000
Sep  5 17:35:46 odyssey kernel: esi: 00000000   edi: dcac3380   ebp: dc231ed0   
esp: dc231eb4
Sep  5 17:35:46 odyssey kernel: ds: 007b   es: 007b   ss: 0068
Sep  5 17:35:46 odyssey kernel: Process bomb.sh (pid: 14761, 
threadinfo=dc230000 task=dcac3380)
Sep  5 17:35:46 odyssey kernel: Stack: dcac3380 dc681c80 dc231f24 dcac3924 
dc230000 00000009 00000009 dc231ee4
Sep  5 17:35:46 odyssey kernel:        c011e09a 00000009 dc230000 dcac3380 
dc231f0c c0126c39 00000009 dcac3924
Sep  5 17:35:46 odyssey kernel:        dc231f24 dc230000 dcac3924 dc231fc4 
dcac3924 dc230000 dc231fb0 c01090d6
Sep  5 17:35:46 odyssey kernel: Call Trace:
Sep  5 17:35:46 odyssey kernel:  [do_group_exit+58/176] 
do_group_exit+0x3a/0xb0
Sep  5 17:35:46 odyssey kernel:  [get_signal_to_deliver+585/848] 
get_signal_to_deliver+0x249/0x350
Sep  5 17:35:46 odyssey kernel:  [do_signal+102/224] do_signal+0x66/0xe0
Sep  5 17:35:46 odyssey kernel:  [do_fork+77/368] do_fork+0x4d/0x170
Sep  5 17:35:46 odyssey kernel:  [sys_rt_sigprocmask+254/368] 
sys_rt_sigprocmask+0xfe/0x170
Sep  5 17:35:46 odyssey kernel:  [sys_fork+56/64] sys_fork+0x38/0x40
Sep  5 17:35:46 odyssey kernel:  [do_notify_resume+59/64] 
do_notify_resume+0x3b/0x40
Sep  5 17:35:46 odyssey kernel:  [work_notifysig+19/21] 
work_notifysig+0x13/0x15
Sep  5 17:35:46 odyssey kernel:
Sep  5 17:35:46 odyssey kernel: Code: 0f 0b d9 02 ec 51 2f c0 eb fe 8b 77 10 
85 f6 75 ea 89 3c 24
Sep  5 17:35:46 odyssey kernel:  <6>note: bomb.sh[14761] exited with 
preempt_count 1

-------------------------------


bomb.sh is the old subtle bash script:
#!/bin/sh
b(){ b|b&};b

running on a user console with ulimit -u = 512

Playing around with many "killall -9 bomb.sh&", after a while
there is a chance to get the oops above.

