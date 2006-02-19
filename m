Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932217AbWBSTJx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbWBSTJx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 14:09:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbWBSTJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 14:09:53 -0500
Received: from mailgw.aecom.yu.edu ([129.98.1.16]:54496 "EHLO
	mailgw.aecom.yu.edu") by vger.kernel.org with ESMTP id S932217AbWBSTJx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 14:09:53 -0500
Mime-Version: 1.0
Message-Id: <a06230908c01e6d2b77b3@[129.98.90.227]>
Date: Sun, 19 Feb 2006 14:09:51 -0500
To: ext3-users@redhat.com
From: Maurice Volaski <mvolaski@aecom.yu.edu>
Subject: ext3 involved in kernel panic in 2.6.13?
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dual Opteron system running ext3 atop drbd (network RAID) devices, 
which, in turn, are atop LVM logical volumes. The underlying device 
is hardware SCSI RAID via a LSILogic HBA. The kernel is vanilla 
2.6.13 on a Gentoo-based system.

A panic occurred, which contains references to ext3 code.

I'm not sure how others manage to get these typed out, but I'm 
manually typing it from what's on the monitor:

Call Trace: <IRQ> <ffffffff802820df>{i8042_interrupt+111} 
<ffffffff80200080>{commit_timeout+0}
<ffffffff8013f143>{run_timer_softirq+387} <ffffffff8013b111>{__do_softirq+113}
<ffffffff8010ee63>{call_softirq+31} <ffffffff80110a55>{do_softirq+53}
<ffffffff8010e5c8>{apic_timer_interrupt+132} <EOI> 
<ffffffff801fb8a6>{do_get_write_access+118}
<ffffffff801fb88e>{do_get_write_access+94} <ffffffff80185d1f>{__getblk+47}
<ffffffff80195170>{filldir+0} <ffffffff801fbf69>{journal_get_write_access+41}
<ffffffff801ec41c>{ext3_reserve_inode+write+76} <ffffffff80195170>{filldir+0}
<ffffffff801ec4d8>{ext3_mark_inode_dirty+56} 
<ffffffff801fa9e5>{journal_start_229}
<ffffffff801ee571>{ext3_dirty_inode+113} 
<ffffffff801a5604>{__mark_inode_dirty+52}
<ffffffff8019bd2b>{update_atime+123} <ffffffff80195016>{vfs_readdir+166}
<ffffffff801952e2>{syst_getdents+130} <ffffffff8019465e>{sys_fcntl+830}
<ffffffff8010dc46>{system_call+126}

Code: 8b 40 18 48 c1 e0 07 48 8b 98 08 58 5b 80 4c 01 e3 48 89 df
RIP <ffffffff8012f369>{try_to_wake_up+57} RSP <ffff810004827e88>
<0>Kernel panic - not syncing: Aiee, killing interrupt handler!
-- 

Maurice Volaski, mvolaski@aecom.yu.edu
Computing Support, Rose F. Kennedy Center
Albert Einstein College of Medicine of Yeshiva University
