Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261970AbTE2Hni (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 03:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261989AbTE2Hni
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 03:43:38 -0400
Received: from natsmtp01.webmailer.de ([192.67.198.81]:36527 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S261970AbTE2Hng
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 03:43:36 -0400
Date: Thu, 29 May 2003 09:56:36 +0200
From: Kristian Peters <kristian.peters@korseby.net>
To: frahm@irsamc.ups-tlse.fr
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-rc5: DMA disabled for IDE Cdrom, works with 2.4.20
Message-Id: <20030529095636.693610bb.kristian.peters@korseby.net>
In-Reply-To: <200305272133.h4RLXlN1000712@albireo.free.fr>
References: <200305272133.h4RLXlN1000712@albireo.free.fr>
X-Mailer: Sylpheed version 0.8.10claws13 (GTK+ 1.2.10; i386-debian-linux-gnu)
X-Operating-System: i686-debian-linux-gnu 2.4.21-rc2
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

frahm@irsamc.ups-tlse.fr schrieb:
> 2.4.21-rc5: DMA disabled for IDE Cdrom, works with 2.4.20

Just a me too. I already posted that issue to the list but without any answer. So I gave it up.

I'm getting no errors which you're encountering but I'm now unable to read/burn cds in DMA mode which is very slow.
Curious what changes (it's there since -pre5) might have triggered that.

hdb: LTN485, ATAPI CD/DVD-ROM drive
hdd: Hewlett-Packard CD-Writer Plus 9100b, ATAPI CD/DVD-ROM drive
00:14.1 IDE interface: Intel Corp. 82371AB PIIX4 IDE (rev 01)

# hdparm -d1 -X34 /dev/hdb

/dev/hdb:
 setting using_dma to 1 (on)
 HDIO_SET_DMA failed: Operation not permitted
 setting xfermode to 34 (multiword DMA mode2)
 using_dma    =  0 (off)

$ cat /usr/src/linux/.config| grep IDE | grep -v ^# 
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_STROKE=y
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDEFLOPPY=y
CONFIG_BLK_DEV_IDESCSI=m
CONFIG_IDE_TASK_IOCTL=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_IDEDMA_FORCED=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_IDEDMA_ONLYDISK=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_VIDEO_DEV=m
CONFIG_VIDEO_PROC_FS=y
CONFIG_VIDEO_BT848=m
CONFIG_VIDEO_SELECT=y
CONFIG_VIDEO_SELECT=y

$ cat /usr/src/linux/.config| grep DMA | grep -v ^#
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_IDEDMA_FORCED=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_IDEDMA_ONLYDISK=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_AUTO=y
CONFIG_SOUND_DMAP=y

-- 

  :... [snd.science] ...:
 ::                             _o)
 :: http://www.korseby.net      /\\
 ::                            _\_V
  :.........................:
