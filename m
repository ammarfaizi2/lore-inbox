Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267666AbSLFXzx>; Fri, 6 Dec 2002 18:55:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267668AbSLFXzx>; Fri, 6 Dec 2002 18:55:53 -0500
Received: from imrelay-2.zambeel.com ([209.240.48.8]:8721 "EHLO
	imrelay-2.zambeel.com") by vger.kernel.org with ESMTP
	id <S267666AbSLFXzw>; Fri, 6 Dec 2002 18:55:52 -0500
Message-ID: <233C89823A37714D95B1A891DE3BCE5202AB1AD2@xch-a.win.zambeel.com>
From: Manish Lachwani <manish@Zambeel.com>
To: linux-kernel@vger.kernel.org
Cc: Manish Lachwani <manish@Zambeel.com>
Subject: CSB5 support for UDMA 6 ...
Date: Fri, 6 Dec 2002 16:03:18 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have made changes to serverworks.c to support UDMA 6 and tested on CSB5.
It works fine and the Maxtor 160 GB drives are detected in the UDMA 6 mode
both in the kernel log messages on bootup and in the IDENTIFY information
from the drive.

Following changes in in config_chipset_for_dma(..)

        if ( (id->dma_ultra & 0x0040) || (ultra100)) {
                speed = XFER_UDMA_6;
        }

and 

        return ((int)   ((id->dma_ultra >> 14) & 3) ? ide_dma_on :
                        ((id->dma_ultra >> 11) & 7) ? ide_dma_on :
                        ((id->dma_ultra >> 8) & 7) ? ide_dma_on :
                        ((id->dma_mword >> 8) & 7) ? ide_dma_on :
                        ((id->dma_1word >> 8) & 7) ? ide_dma_on :
                                                     ide_dma_off_quietly);


We can also set the UDMA speed successfully from hdparm and the changes show
UDMA 6. I have add long runs with these changes and the controller/drive
seem to work fine. 

hdparm -x70 /dev/hdX


Thanks
Manish


