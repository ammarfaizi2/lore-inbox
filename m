Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130688AbQJ2DIa>; Sat, 28 Oct 2000 23:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130700AbQJ2DIV>; Sat, 28 Oct 2000 23:08:21 -0400
Received: from fw.SuSE.com ([202.58.118.35]:40957 "EHLO linux.local")
	by vger.kernel.org with ESMTP id <S130688AbQJ2DII>;
	Sat, 28 Oct 2000 23:08:08 -0400
Date: Sat, 28 Oct 2000 20:10:47 -0700
From: Jens Axboe <axboe@suse.de>
To: Hisaaki Shibata <shibata@luky.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: patch: atapi dvd-ram support
Message-ID: <20001028201047.A5879@suse.de>
In-Reply-To: <20001028000448.D3919@suse.de> <20001028232703S.shibata@luky.org> <20001028134056.J3919@suse.de> <20001029120703Y.shibata@luky.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001029120703Y.shibata@luky.org>; from shibata@luky.org on Sun, Oct 29, 2000 at 12:07:03PM +0900
X-OS: Linux 2.4.0-test10 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Oct 29 2000, Hisaaki Shibata wrote:
> > Ok, does /proc/sys/dev/cdrom/info list DVD-RAM as a capability?
> 
> Yes.
> I think it seems good.
> 
> # more info 
> CD-ROM information, Id: cdrom.c 3.12 2000/10/22
> 
> Can write DVD-RAM:      1

So far, so good.

> Should I set any flags to permit write a DVD-RAM media ?

No, as I said it should detect it automatically. But d'oh, I
just realised that it is set too soon... Sorry, try with this
patch.

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs

--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dvdram-ro_fix.diff"

--- drivers/block/ide-cd.c~	Sat Oct 28 20:09:03 2000
+++ drivers/block/ide-cd.c	Sat Oct 28 20:09:23 2000
@@ -2597,8 +2597,6 @@
 	int minor = drive->select.b.unit << PARTN_BITS;
 	int nslots, ro;
 
-	ro = !CDROM_CONFIG_FLAGS(drive)->dvd_ram;
-	set_device_ro(MKDEV(HWIF(drive)->major, minor), ro);
 	set_blocksize(MKDEV(HWIF(drive)->major, minor), CD_FRAMESIZE);
 
 	drive->special.all	= 0;
@@ -2718,6 +2716,9 @@
 	info->start_seek	= 0;
 
 	nslots = ide_cdrom_probe_capabilities (drive);
+
+	ro = !CDROM_CONFIG_FLAGS(drive)->dvd_ram;
+	set_device_ro(MKDEV(HWIF(drive)->major, minor), ro);
 
 	if (ide_cdrom_register (drive, nslots)) {
 		printk ("%s: ide_cdrom_setup failed to register device with the cdrom driver.\n", drive->name);

--SUOF0GtieIMvvwua--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
