Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965112AbWEKBYs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965112AbWEKBYs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 21:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965114AbWEKBYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 21:24:48 -0400
Received: from build.arklinux.osuosl.org ([140.211.166.26]:24513 "EHLO
	mail.arklinux.org") by vger.kernel.org with ESMTP id S965112AbWEKBYs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 21:24:48 -0400
From: Bernhard Rosenkraenzer <bero@arklinux.org>
To: linux-kernel@vger.kernel.org
Subject: Total machine lockup w/ current kernels while installing from CD
Date: Thu, 11 May 2006 03:22:14 +0200
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605110322.14774.bero@arklinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I've built a CD that installs a customized system; basically what it does is 
boot from CD (iso9660) and run

mke2fs -m0 -j -O dir_index,filetype,has_journal,sparse_super /dev/hda1
mount -text3 /dev/hda1 /mnt/dest
rpm -r /mnt/dest -ivh /RPMS/*

This worked perfectly up until some recent kernel updates - with current 
kernels (both Linus and -mm branch), the system locks up totally at a random 
point during rpm installation (everything goes down, including the NumLock 
LED etc).

I'm currently building some old kernels to see when this problem was 
introduced and sort out what patch did it.
With 2.6.16-rc6, the problem occurs, but unlike later revisions it gives an 
error message before freezing:

BUG: soft lockup detected on CPU#0!

Pid: 421, comm: kjournald
EIP: 0060:[<b01a2f52>] CPU: 0
EIP is at journal_commit_transaction+0x92e/0xfcc
EFLAGS: 00000297 Not tainted (2.6.16-rc6 #1)
EAX: 00000001 EBX: c2d34788 ECX: 00000001 EDX: c785e000
ESI: b3ff8d04 EDI: 000000f0 EBP: b683b840 DS: 007b ES: 007b
CR0: 8005003b CR2: 0841f7fc CR3: 17217000 CR4: 000006d0
 [<b02bd52e>] schedule+0x2ee/0x5b6
 [<b01a6a88>] kjournald+0x201/0x213
 [<b0111089>] smp_apic_timer_interrupt+0x32/0x49
 [<b01a6937>] kjournald+0xb0/0x213
 [<b01a5ffa>] commit_timeout+0x0/0x9
 [<b012a789>] autoremove_wake_function+0x0/0x4b
 [<b01a6887>] kjournald+0x0/0x213
 [<b0101005>] kernel_thread_helper+0x5/0xb

I'll keep trying to isolate which patch introduced this; at the moment the 
last known working kernel is 2.6.15 (and 2.6.15-mm4), the first known broken 
one is 2.6.16-rc6; the ones in between are still waiting for the compile box.
