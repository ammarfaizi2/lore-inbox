Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312582AbSEDMPY>; Sat, 4 May 2002 08:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312619AbSEDMPX>; Sat, 4 May 2002 08:15:23 -0400
Received: from web21510.mail.yahoo.com ([66.163.169.59]:60576 "HELO
	web21510.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S312582AbSEDMPU>; Sat, 4 May 2002 08:15:20 -0400
Message-ID: <20020504121520.52836.qmail@web21510.mail.yahoo.com>
Date: Sat, 4 May 2002 13:15:20 +0100 (BST)
From: =?iso-8859-1?q?Neil=20Conway?= <nconway_kernel@yahoo.co.uk>
Subject: Re: PATCH, IDE corruption, 2.4.18
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1632615904-1020514520=:49222"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-1632615904-1020514520=:49222
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

Argh, humble apologies.  Just noticed that Yahoo didn't like it that my
attachment didn't have a suffix and encoded it base64 :((

Here it is as a plain text attachment.

Neil

__________________________________________________
Do You Yahoo!?
Everything you'll ever need on one web page
from News and Sport to Email and Music Charts
http://uk.my.yahoo.com
--0-1632615904-1020514520=:49222
Content-Type: text/plain; name="ide_patch030502.txt"
Content-Description: ide_patch030502.txt
Content-Disposition: inline; filename="ide_patch030502.txt"

--- ide-features.c.orig	Fri Feb  9 19:40:02 2001
+++ ide-features.c	Fri May  3 20:21:58 2002
@@ -281,12 +281,18 @@
  */
 int ide_config_drive_speed (ide_drive_t *drive, byte speed)
 {
+	ide_hwgroup_t *hwgroup = HWGROUP(drive);
 	ide_hwif_t *hwif = HWIF(drive);
 	int	i, error = 1;
-	byte stat;
+	byte stat,unit;
+
+	if (hwgroup->busy) {
+		printk("Argh: hwgroup is busy in ide_config_drive_speed\n");
+		return error;
+	}
 
 #if defined(CONFIG_BLK_DEV_IDEDMA) && !defined(CONFIG_DMA_NONPCI)
-	byte unit = (drive->select.b.unit & 0x01);
+	unit = (drive->select.b.unit & 0x01);
 	outb(inb(hwif->dma_base+2) & ~(1<<(5+unit)), hwif->dma_base+2);
 #endif /* (CONFIG_BLK_DEV_IDEDMA) && !(CONFIG_DMA_NONPCI) */
 

--0-1632615904-1020514520=:49222--
