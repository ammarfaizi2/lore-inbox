Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265906AbSKBJL4>; Sat, 2 Nov 2002 04:11:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265907AbSKBJL4>; Sat, 2 Nov 2002 04:11:56 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:33974 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S265906AbSKBJLw>;
	Sat, 2 Nov 2002 04:11:52 -0500
Date: Sat, 2 Nov 2002 10:18:11 +0100
From: Jens Axboe <axboe@suse.de>
To: Thomas Molina <tmolina@cox.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ide-cd still borken for me in 2.5.45
Message-ID: <20021102091811.GD31088@suse.de>
References: <Pine.LNX.4.44.0211011945170.863-100000@dad.molina> <Pine.LNX.4.44.0211012022190.862-100000@dad.molina>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211012022190.862-100000@dad.molina>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01 2002, Thomas Molina wrote:
> On Fri, 1 Nov 2002, Thomas Molina wrote:
> 
> > On Fri, 1 Nov 2002, Jens Axboe wrote:
> > 
> > > > hdc: irq timeout: status=0x90 {Busy}
> > > > hdc: irq timeout: error=0x01IllegalLengthIndication
> > > > hdc: drive not ready for command
> > > > hdc: ATAPI reset timed-out, status=0x80
> > > > ide1: reset: success
> > > 
> > > Interesting. Please send me a detailed list of your hardware, boot
> > > messages should suffice. Does 2.5.43 work correctly?
> > 
> > I get the same series of messages when booting 2.5.43.  I'll work my way 
> > back to find a version that works and report back when I find it.  
> > Following is the config file used to build this kernel:
> 
> Well that was quick.  2.5.42 works correctly.  The problems begin with 
> 2.5.43.

Ok, so Linus broke it :-)

Please boot with this patch, it looks like a command length screwup.

--- /opt/kernel/linux-2.5.45/drivers/ide/ide-cd.c	2002-11-01 11:31:53.000000000 +0100
+++ drivers/ide/ide-cd.c	2002-11-02 10:17:13.000000000 +0100
@@ -1498,6 +1498,8 @@
 	rq->flags &= ~REQ_FAILED;
 	len = rq->data_len;
 
+	printk("%s: starting %02x, len=%u\n", drive->name, rq->cmd[0], len);
+
 	/* Start sending the command to the drive. */
 	return cdrom_start_packet_command(drive, len, cdrom_do_pc_continuation);
 }

-- 
Jens Axboe

