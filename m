Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261228AbSKBOsu>; Sat, 2 Nov 2002 09:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261258AbSKBOsu>; Sat, 2 Nov 2002 09:48:50 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:57299 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261228AbSKBOsl>;
	Sat, 2 Nov 2002 09:48:41 -0500
Date: Sat, 2 Nov 2002 15:54:51 +0100
From: Jens Axboe <axboe@suse.de>
To: Thomas Molina <tmolina@cox.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ide-cd still borken for me in 2.5.45
Message-ID: <20021102145451.GA1820@suse.de>
References: <20021102091811.GD31088@suse.de> <Pine.LNX.4.44.0211020847550.876-100000@dad.molina>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211020847550.876-100000@dad.molina>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 02 2002, Thomas Molina wrote:
> On Sat, 2 Nov 2002, Jens Axboe wrote:
> 
> > > Well that was quick.  2.5.42 works correctly.  The problems begin with 
> > > 2.5.43.
> > 
> > Ok, so Linus broke it :-)
> > 
> > Please boot with this patch, it looks like a command length screwup.
> 
> Your patch produced:
> 
> hdc: starting 5a, len = 24

ok looks fine, now please try (on top of the other one):

--- /opt/kernel/linux-2.5.45/drivers/ide/ide-cd.c	2002-11-01 11:31:53.000000000 +0100
+++ drivers/ide/ide-cd.c	2002-11-02 15:54:16.000000000 +0100
@@ -906,7 +906,7 @@
 	ide_set_handler(drive, handler, rq->timeout, cdrom_timer_expiry);
 
 	/* Send the command to the device. */
-	HWIF(drive)->atapi_output_bytes(drive, rq->cmd, sizeof(rq->cmd));
+	HWIF(drive)->atapi_output_bytes(drive, rq->cmd, 12);
 
 	/* Start the DMA if need be */
 	if (info->dma)

-- 
Jens Axboe

