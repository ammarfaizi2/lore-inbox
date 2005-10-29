Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751160AbVJ2RaR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbVJ2RaR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 13:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbVJ2RaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 13:30:17 -0400
Received: from jenny.ondioline.org ([66.220.1.122]:22027 "EHLO
	jenny.ondioline.org") by vger.kernel.org with ESMTP
	id S1751160AbVJ2RaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 13:30:16 -0400
From: Paul Collins <paul@briny.ondioline.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.14: Oops on suspend after on-the-fly switch to anticipatory i/o scheduler - PowerBook5,4
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Sat, 29 Oct 2005 18:26:56 +0100
Message-ID: <87mzkscjz3.fsf@briny.internal.ondioline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I boot with elevator=cfq (wanted to try the ionice stuff, never got
around to it).  Having decided to go back to the anticipatory
scheduler, I did the following:

# echo anticipatory > /sys/block/hda/queue/scheduler
# echo anticipatory > /sys/block/hdc/queue/scheduler

A while later I did 'sudo snooze', which produced the Oops below.

Booting with elevator=as and then changing to cfq, sleep works fine.
But if I resume and change back to anticipatory I get a similar Oops
on the next 'sudo snooze'.


  Oops: kernel access of bad area, sig: 11 [#1]
  NIP: C01E1948 LR: C01D6A60 SP: EFBC5C20 REGS: efbc5b70 TRAP: 0300    Not tainted
  MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
  DAR: 00000020, DSISR: 40000000
  TASK = efb012c0[1213] 'pmud' THREAD: efbc4000
  Last syscall: 54 
  GPR00: 00080000 EFBC5C20 EFB012C0 EFE9E044 EFBC5CE8 00000002 00000000 C03B0000 
  GPR08: C046E5D8 00000000 C03B47C8 E6A58360 22042422 1001E4DC 10010000 10000000 
  GPR16: 10000000 10000000 10000000 7FE4EB40 10000000 10000000 10010000 C0400000 
  GPR24: C0380000 00000002 00000002 C046E0C0 00000000 00000002 00000000 EFBC5CE8 
  NIP [c01e1948] as_insert_request+0xa8/0x6b0
  LR [c01d6a60] __elv_add_request+0xa0/0x100
  Call trace:
   [c01d6a60] __elv_add_request+0xa0/0x100
   [c01ffb84] ide_do_drive_cmd+0xb4/0x190
   [c01fc1c0] generic_ide_suspend+0x80/0xa0
   [c01d4574] suspend_device+0x104/0x160
   [c01d47c0] device_suspend+0x120/0x330
   [c03f3b50] pmac_suspend_devices+0x50/0x1b0
   [c03f4294] pmu_ioctl+0x344/0x9b0
   [c0082aa4] do_ioctl+0x84/0x90
   [c0082b3c] vfs_ioctl+0x8c/0x460
   [c0082f50] sys_ioctl+0x40/0x80
   [c0004850] ret_from_syscall+0x0/0x4c

-- 
Dag vijandelijk luchtschip de huismeester is dood
