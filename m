Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750973AbVLBTcF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750973AbVLBTcF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 14:32:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750918AbVLBTcF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 14:32:05 -0500
Received: from smtp.osdl.org ([65.172.181.4]:32211 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750973AbVLBTcD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 14:32:03 -0500
Date: Fri, 2 Dec 2005 11:31:47 -0800
From: Andrew Morton <akpm@osdl.org>
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [SCSI BUG 2.6.15-rc3-mm1] scheduling while atomic on boot time
Message-Id: <20051202113147.600b80cd.akpm@osdl.org>
In-Reply-To: <20051202141455.GA10038@mail.ustc.edu.cn>
References: <20051202141455.GA10038@mail.ustc.edu.cn>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wu Fengguang <wfg@mail.ustc.edu.cn> wrote:
>
> My server occasionally crashes on boot time, this has been happening in many
> recent kernel versions(at least from 2.6.14-rcx). It is rare enough, I setup
> netconsole and rebooted numerous times, but still failed to catch it. Luckily
> it happened again this time, and does not panic. Here is the logs. 
> 
> Thanks,
> Wu
> 
> Error messages:
> [4294676.927000] scheduling while atomic: ksoftirqd/0/0x00000200/3
> [4294676.927000]  [dump_stack+21/32] dump_stack+0x15/0x20
> [4294676.927000]  [schedule+3563/3584] schedule+0xdeb/0xe00
> [4294676.927000]  [__down+138/272] __down+0x8a/0x110
> [4294676.927000]  [__sched_text_start+10/16] <6>scsi[0]: scanning scsi channel 1 [Phy 1] for non-raid devices
> [4294676.927000] __down_failed+0xa/0x10
> [4294676.927000]  [.text.lock.main+43/71] .text.lock.main+0x2b/0x47
> [4294676.928000]  [device_del+62/112] device_del+0x3e/0x70
> [4294676.928000]  [scsi_target_reap+137/176] scsi_target_reap+0x89/0xb0
> [4294676.928000]  [scsi_device_dev_release+251/400] scsi_device_dev_release+0xfb/0x190
> [4294676.928000]  [device_release+23/80] device_release+0x17/0x50
> [4294676.928000]  [kobject_cleanup+116/128] kobject_cleanup+0x74/0x80
> [4294676.928000]  [kobject_release+11/16] kobject_release+0xb/0x10
> [4294676.929000]  [kref_put+52/160] kref_put+0x34/0xa0
> [4294676.929000]  [kobject_put+20/32] kobject_put+0x14/0x20
> [4294676.929000]  [put_device+17/32] put_device+0x11/0x20
> [4294676.929000]  [scsi_next_command+48/64] scsi_next_command+0x30/0x40
> [4294676.929000]  [scsi_end_request+165/192] scsi_end_request+0xa5/0xc0
> [4294676.929000]  [scsi_io_completion+540/1152] scsi_io_completion+0x21c/0x480
> [4294676.929000]  [scsi_generic_done+43/64] scsi_generic_done+0x2b/0x40
> [4294676.930000]  [scsi_finish_command+146/240] scsi_finish_command+0x92/0xf0
> [4294676.930000]  [scsi_softirq+215/320] scsi_softirq+0xd7/0x140
> [4294676.930000]  [__do_softirq+216/240] __do_softirq+0xd8/0xf0
> [4294676.930000]  [do_softirq+74/96] do_softirq+0x4a/0x60
> [4294676.930000]  =======================

Which device driver are you using?

This is just a warning - it won't necessarily cause a crash and in this
case it didn't appear to do so.

I seem to recall diagnosing this exact locking problem a month or so ago,
and cc'ing linux-scsi on that analysis.
