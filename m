Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964809AbWBTJZs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964809AbWBTJZs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 04:25:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964807AbWBTJZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 04:25:48 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:43720 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S964808AbWBTJZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 04:25:47 -0500
Date: Mon, 20 Feb 2006 10:25:46 +0100
From: Jan Kara <jack@suse.cz>
To: Maurice Volaski <mvolaski@aecom.yu.edu>
Cc: ext3-users@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: ext3 involved in kernel panic in 2.6.13?
Message-ID: <20060220092546.GA12208@atrey.karlin.mff.cuni.cz>
References: <a06230908c01e6d2b77b3@[129.98.90.227]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a06230908c01e6d2b77b3@[129.98.90.227]>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Dual Opteron system running ext3 atop drbd (network RAID) devices, 
> which, in turn, are atop LVM logical volumes. The underlying device 
> is hardware SCSI RAID via a LSILogic HBA. The kernel is vanilla 
> 2.6.13 on a Gentoo-based system.
> 
> A panic occurred, which contains references to ext3 code.
> 
> I'm not sure how others manage to get these typed out, but I'm 
> manually typing it from what's on the monitor:

  There should be more in the logs (just before the Call Trace:). Didn't
you capture also that information? Without it it is rather hard to find
out what was happening.

> Call Trace: <IRQ> <ffffffff802820df>{i8042_interrupt+111} 
> <ffffffff80200080>{commit_timeout+0}
> <ffffffff8013f143>{run_timer_softirq+387} 
> <ffffffff8013b111>{__do_softirq+113}
> <ffffffff8010ee63>{call_softirq+31} <ffffffff80110a55>{do_softirq+53}
> <ffffffff8010e5c8>{apic_timer_interrupt+132} <EOI> 
> <ffffffff801fb8a6>{do_get_write_access+118}
> <ffffffff801fb88e>{do_get_write_access+94} <ffffffff80185d1f>{__getblk+47}
> <ffffffff80195170>{filldir+0} 
> <ffffffff801fbf69>{journal_get_write_access+41}
> <ffffffff801ec41c>{ext3_reserve_inode+write+76} 
> <ffffffff80195170>{filldir+0}
> <ffffffff801ec4d8>{ext3_mark_inode_dirty+56} 
> <ffffffff801fa9e5>{journal_start_229}
> <ffffffff801ee571>{ext3_dirty_inode+113} 
> <ffffffff801a5604>{__mark_inode_dirty+52}
> <ffffffff8019bd2b>{update_atime+123} <ffffffff80195016>{vfs_readdir+166}
> <ffffffff801952e2>{syst_getdents+130} <ffffffff8019465e>{sys_fcntl+830}
> <ffffffff8010dc46>{system_call+126}
> 
> Code: 8b 40 18 48 c1 e0 07 48 8b 98 08 58 5b 80 4c 01 e3 48 89 df
> RIP <ffffffff8012f369>{try_to_wake_up+57} RSP <ffff810004827e88>
> <0>Kernel panic - not syncing: Aiee, killing interrupt handler!

								Bye
									Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
