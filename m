Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132562AbRDULoi>; Sat, 21 Apr 2001 07:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132563AbRDULo2>; Sat, 21 Apr 2001 07:44:28 -0400
Received: from obelix.hrz.tu-chemnitz.de ([134.109.132.55]:61345 "EHLO
	obelix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S132562AbRDULoP>; Sat, 21 Apr 2001 07:44:15 -0400
Date: Sat, 21 Apr 2001 13:44:12 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Dan Aloni <karrde@callisto.yi.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@image.dk>
Subject: Re: cdrom driver dependency problem (and a workaround patch)
Message-ID: <20010421134412.O682@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <Pine.LNX.4.32.0104210107160.1148-100000@callisto.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.32.0104210107160.1148-100000@callisto.yi.org>; from karrde@callisto.yi.org on Sat, Apr 21, 2001 at 02:17:18AM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 21, 2001 at 02:17:18AM +0300, Dan Aloni wrote:
> One reason for this misdependency is that the IDE is initialized before
> the cdrom driver, register_cdrom() gets called from inside the IDE
> initialization functions. (ide_init() -> ide_init_builtin_drivers() ->
> ide_cdrom_init() -> ide_cdrom_setup() -> ide_cdrom_register() ->
> register_cdrom())
> 
> In order to get my kernel to boot, I've made the following temporary
> workaround patch. I'd be glad to hear about other ways of solving this.

The link order is wrong. So why not changing the link order then?

--- Makefile.orig       Sat Apr 21 12:34:34 2001
+++ Makefile    Sat Apr 21 12:35:12 2001
@@ -149,15 +149,15 @@
 DRIVERS-$(CONFIG_WAN) += drivers/net/wan/wan.o
 DRIVERS-$(CONFIG_ARCNET) += drivers/net/arcnet/arcnetdrv.o
 DRIVERS-$(CONFIG_ATM) += drivers/atm/atm.o
-DRIVERS-$(CONFIG_IDE) += drivers/ide/idedriver.o
-DRIVERS-$(CONFIG_SCSI) += drivers/scsi/scsidrv.o
-DRIVERS-$(CONFIG_FUSION_BOOT) += drivers/message/fusion/fusion.o
-DRIVERS-$(CONFIG_IEEE1394) += drivers/ieee1394/ieee1394drv.o

 ifneq ($(CONFIG_CD_NO_IDESCSI)$(CONFIG_BLK_DEV_IDECD)$(CONFIG_BLK_DEV_SR)$(CONFIG_PARIDE_PCD),)
 DRIVERS-y += drivers/cdrom/driver.o
 endif

+DRIVERS-$(CONFIG_IDE) += drivers/ide/idedriver.o
+DRIVERS-$(CONFIG_SCSI) += drivers/scsi/scsidrv.o
+DRIVERS-$(CONFIG_FUSION_BOOT) += drivers/message/fusion/fusion.o
+DRIVERS-$(CONFIG_IEEE1394) += drivers/ieee1394/ieee1394drv.o
 DRIVERS-$(CONFIG_SOUND) += drivers/sound/sounddrivers.o
 DRIVERS-$(CONFIG_PCI) += drivers/pci/driver.o
 DRIVERS-$(CONFIG_MTD) += drivers/mtd/mtdlink.o


Would be my idea of solving this issue.

Regards

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<     been there and had much fun   >>>>>>>>>>>>
