Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932317AbVKUOyS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317AbVKUOyS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 09:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbVKUOyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 09:54:18 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:32025 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932316AbVKUOyR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 09:54:17 -0500
Date: Mon, 21 Nov 2005 15:55:31 +0100
From: Jens Axboe <axboe@suse.de>
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
Cc: Anders Karlsson <trudheim@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.14.2 - Badness in as_insert_request at drivers/block/as-iosched.c:1519
Message-ID: <20051121145531.GB15804@suse.de>
References: <515e525f0511210027u67d8e924j9edb95af7fdd4d9e@mail.gmail.com> <438186D0.1000704@ens-lyon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <438186D0.1000704@ens-lyon.org>
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21 2005, Brice Goglin wrote:
> Anders Karlsson wrote:
> 
> >Morning,
> >
> >I am getting loads of these:
> >
> >Nov 21 08:10:19 lenin kernel: [17304475.764000] arq->state: 4
> >Nov 21 08:10:19 lenin kernel: [17304475.764000] Badness in
> >as_insert_request at drivers/block/as-iosched.c:1519
> >Nov 21 08:10:19 lenin kernel: [17304475.764000] 
> >[as_insert_request+109/464] as_insert_request+0x6d/0x1d0
> >Nov 21 08:10:19 lenin kernel: [17304475.764000] 
> >[__elv_add_request+155/224] __elv_add_request+0x9b/0xe0
> >Nov 21 08:10:19 lenin kernel: [17304475.764000] 
> >[elv_add_request+43/64] elv_add_request+0x2b/0x40
> >Nov 21 08:10:19 lenin kernel: [17304475.764000] 
> >[blk_execute_rq_nowait+69/96] blk_execute_rq_nowait+0x45/0x60
> >Nov 21 08:10:19 lenin kernel: [17304475.764000] 
> >[blk_execute_rq+123/224] blk_execute_rq+0x7b/0xe0
> >Nov 21 08:10:19 lenin kernel: [17304475.764000] 
> >[blk_end_sync_rq+0/48] blk_end_sync_rq+0x0/0x30
> >Nov 21 08:10:19 lenin kernel: [17304475.764000] 
> >[bio_phys_segments+39/48] bio_phys_segments+0x27/0x30
> >Nov 21 08:10:19 lenin kernel: [17304475.764000] 
> >[blk_rq_bio_prep+133/176] blk_rq_bio_prep+0x85/0xb0
> >Nov 21 08:10:19 lenin kernel: [17304475.764000] 
> >[cdrom_read_cdda_bpc+403/512] cdrom_read_cdda_bpc+0x193/0x200
> >Nov 21 08:10:19 lenin kernel: [17304475.764000] 
> >[cdrom_read_cdda+91/192] cdrom_read_cdda+0x5b/0xc0
> >Nov 21 08:10:19 lenin kernel: [17304475.764000]  [mmc_ioctl+2098/2784]
> >mmc_ioctl+0x832/0xae0
> >Nov 21 08:10:19 lenin kernel: [17304475.764000] 
> >[__wake_up_common+67/112] __wake_up_common+0x43/0x70
> >Nov 21 08:10:19 lenin kernel: [17304475.764000] 
> >[scsi_cmd_ioctl+191/1328] scsi_cmd_ioctl+0xbf/0x530
> >Nov 21 08:10:19 lenin kernel: [17304475.764000] 
> >[n_tty_receive_buf+225/3888] n_tty_receive_buf+0xe1/0xf30
> >Nov 21 08:10:19 lenin kernel: [17304475.764000] 
> >[log_wait_commit+202/256] log_wait_commit+0xca/0x100
> >Nov 21 08:10:19 lenin kernel: [17304475.764000] 
> >[fast_clear_page+10/80] fast_clear_page+0xa/0x50
> >Nov 21 08:10:19 lenin kernel: [17304475.764000] 
> >[buffered_rmqueue+398/480] buffered_rmqueue+0x18e/0x1e0
> >Nov 21 08:10:19 lenin kernel: [17304475.764000] 
> >[generic_ide_ioctl+60/1408] generic_ide_ioctl+0x3c/0x580
> >Nov 21 08:10:19 lenin kernel: [17304475.764000] 
> >[cdrom_ioctl+230/3536] cdrom_ioctl+0xe6/0xdd0
> >Nov 21 08:10:20 lenin kernel: [17304475.764000]  [pty_write+103/128]
> >pty_write+0x67/0x80
> >Nov 21 08:10:20 lenin kernel: [17304475.764000]  [idecd_ioctl+133/160]
> >idecd_ioctl+0x85/0xa0
> >Nov 21 08:10:20 lenin kernel: [17304475.764000] 
> >[blkdev_ioctl+304/432] blkdev_ioctl+0x130/0x1b0
> >Nov 21 08:10:20 lenin kernel: [17304475.764000]  [block_ioctl+43/48]
> >block_ioctl+0x2b/0x30
> >Nov 21 08:10:20 lenin kernel: [17304475.764000]  [do_ioctl+50/144]
> >do_ioctl+0x32/0x90
> >Nov 21 08:10:20 lenin kernel: [17304475.764000]  [vfs_ioctl+96/496]
> >vfs_ioctl+0x60/0x1f0
> >Nov 21 08:10:20 lenin kernel: [17304475.764000]  [sys_ioctl+136/160]
> >sys_ioctl+0x88/0xa0
> >Nov 21 08:10:20 lenin kernel: [17304475.764000] 
> >[sysenter_past_esp+84/117] sysenter_past_esp+0x54/0x75
> >
> >I flipped the drive (LG GSA4167B DVD±RW) into udma2 mode, enabled udma
> >and started reading from an audio disc with cdparanoia. I had to abort
> >the read (^C in shell where running cdparanoia) and noticed the system
> >became slower for a while. When checking the system logs, I spotted
> >these stacktraces.
> >  
> >
> 
> I reported a similar problem while ripping a CD with cdparanoia on
> 2.6.14 on a
> thinkpad R52 (http://lkml.org/lkml/2005/11/10/286). But I didn't get any
> answer.
> I hope you will get some. Good luck :)

Oops, just responded to you, here is the similar report from yesterday:

http://lkml.org/lkml/2005/11/20/119

-- 
Jens Axboe

