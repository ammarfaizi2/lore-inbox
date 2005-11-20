Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750798AbVKTUhh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbVKTUhh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 15:37:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbVKTUhh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 15:37:37 -0500
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:54967 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S1750798AbVKTUhg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 15:37:36 -0500
Date: Sun, 20 Nov 2005 21:36:03 +0100
From: Luca <kronos@kronoz.cjb.net>
To: linux-kernel@vger.kernel.org
Cc: axboe@suse.de
Subject: [2.6.14.2] Badness in as_insert_request at drivers/block/as-iosched.c:1519
Message-ID: <20051120203603.GA12216@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
while playing an audio CD with XMMS using digital audio extraction the
kernel started flooding my logs (syslog writes my kernel logs synchronously)
with the following message:

 cdrom: dropping to single frame dma
 arq->state: 4
 Badness in as_insert_request at drivers/block/as-iosched.c:1519
  [<c0104027>] dump_stack+0x17/0x20
  [<c0263b2c>] as_insert_request+0x5c/0x160
  [<c025aa0a>] __elv_add_request+0x8a/0xc0
  [<c025aa75>] elv_add_request+0x35/0x70
  [<c025dc4b>] blk_execute_rq_nowait+0x3b/0x50
  [<c025dcda>] blk_execute_rq+0x7a/0xb0
  [<c028daad>] cdrom_read_cdda_bpc+0x14d/0x1b0
  [<c028db68>] cdrom_read_cdda+0x58/0xc0
  [<c028f025>] mmc_ioctl+0x735/0x930
  [<c028e5c2>] cdrom_ioctl+0x9f2/0xca0
  [<c028aabe>] idecd_ioctl+0x5e/0x70
  [<c025ffa5>] blkdev_driver_ioctl+0x45/0x80
  [<c0260157>] blkdev_ioctl+0x177/0x180
  [<c0162a7b>] block_ioctl+0x1b/0x30
  [<c016cf74>] do_ioctl+0x74/0x90
  [<c016d109>] vfs_ioctl+0x59/0x1c0
  [<c016d2a9>] sys_ioctl+0x39/0x60
  [<c01031a5>] syscall_call+0x7/0xb

This happens both with my DVD unit and the CD/RW unit. The cause may be
a couple of skratches on the disk (my portable cd player is happy with
it though) and the drives behave fine with other audio disks. In the
dmesg there isn't any other error related to the cd (i.e. no medium
errors...)

As workaround I'm using noop scheduler for the unit...

Luca
-- 
Home: http://kronoz.cjb.net
K.R.O.N.O.S
Kinetic Replicant Optimized for Nocturnal Observation and Sabotage
