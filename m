Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262630AbVAKJHP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262630AbVAKJHP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 04:07:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262635AbVAKJHO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 04:07:14 -0500
Received: from sys-241.netcologne.de ([194.8.193.241]:3205 "EHLO
	sys-241.netcologne.de") by vger.kernel.org with ESMTP
	id S262630AbVAKJFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 04:05:47 -0500
Date: Tue, 11 Jan 2005 10:05:46 +0100
From: Roland Rosenfeld <rrosenfeld@netcologne.de>
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Oops in kjournald
Message-ID: <20050111090546.GB25756@sys-241.netcologne.de>
Mail-Followup-To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the last week I got the following Oops five times on two machines,
when they are under very heavy load  (mailserver based on Debian sarge
with postfix 2.1.4) when the load is >4 for some hours.

---------------------- schnipp --------------------------------
Unable to handle kernel NULL pointer dereference at virtual address 0000000c
 printing eip:
c01a65a5
*pde = 00000000
Oops: 0002 [#1]
PREEMTP SMP
Modules linked in: e1000 tg3 bonding rtc unix
CPU:    0
EIP:    0060:[<c01a65a5>]    Not tainted VLI
EFLAGS: 00010282   (2.6.10-686-nc-smp-1)
EIP is at jounral_commit_transaction+0x315/0x12f0
eax: f157117c   ebx: 00000000   ecx: 00000000   edx: f7cffb80
es: 007b   es: 007b   ss: 0068
Process kjournald (pid: 171, threadinfo=f6f7e000 task=f6e92520)
Stack: e2efd5cc e2efd5cc 00000008 000011da 00000000 f6e97ac0 f6f7e000 f6f7e000
       f6ef6bb8 f6e97a14 00000000 00000000 00000000 00000000 00000000 f0fa9dac
       e8a39ecc 000011da 00000000 f6e92520 c012d580 f6f7fe44 f6f7fe44 00000000
Call Trace:
 [<c012d580>] autoremove_wake_function+0x0/0x60
 [<c012d580>] autoremove_wake_function+0x0/0x60
 [<c01a9af5>] kjounald+0xe5/0x240
 [<c011b837>] do_exit+0x2d7/0x480
 [<c012d580>] autoremove_wake_function+0x0/0x60
 [<c012d580>] autoremove_wake_function+0x0/0x60
 [<c0102572>] ret_from_fork+0x6/0x14
 [<c01a99f0>] commit_timeout+0x0/0x10
 [<c01a9a10>] kjournald+0x0/0x240
 [<c01007f5>] kernel_thread_helper+0x5/0x10
Code: 00 8b 45 20 85 c0 75 be 8b 44 24 38 85 c0 0f 85 16 0d 00 00 8b 45 18 85 c0 0f 84 83 00 00 00 be 00 e0 ff ff 21 e6 8b 78 20 8b 1f <f0> ff 43 0c 8b 03 a8 04 0f 85 b3 0c 00 00 89 5c 24 04 8b 94 24
 <6>note: kjournald[171] exited with preempt_count 1
---------------------- schnipp --------------------------------

I run a 2.6.10 kernel (with aacraid 1.1.5 2372 driver from Adaptec,
everything else vanilla) on Dual Xeon machines. The kernel has ext3fs
and XFS compiled in but currently all filesystems are ext3.

In the logs I don't see anything, because the machines freeze with the
above message (I retyped the messages from the screen, so there may be
some typos, if necessary I have a screenshot here to correct some
misspellings).

What can I do to fix this problem?  Using google I didn't find a hint
for further search, but my kernel knowledge is very limited :-|

Tschoeeee

        Roland
