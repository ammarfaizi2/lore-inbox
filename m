Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267658AbSLFWzX>; Fri, 6 Dec 2002 17:55:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267659AbSLFWzW>; Fri, 6 Dec 2002 17:55:22 -0500
Received: from imrelay-2.zambeel.com ([209.240.48.8]:34320 "EHLO
	imrelay-2.zambeel.com") by vger.kernel.org with ESMTP
	id <S267658AbSLFWzT>; Fri, 6 Dec 2002 17:55:19 -0500
Message-ID: <233C89823A37714D95B1A891DE3BCE5202AB1AD0@xch-a.win.zambeel.com>
From: Manish Lachwani <manish@Zambeel.com>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>, David Ashley <dash@xdr.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: 2.4.18 beats 2.5.50 in hard drive access????
Date: Fri, 6 Dec 2002 15:02:34 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Try to set UDMA0 by 

hdparm -X64 /dev/hda

or UDMA 2 by using:

hdparm -X66 /dev/hda

OSB4 should support UDMA 2. If anyting > UDMA2, then IDE warning should
appear in dmesg

CHeck the IDENTIFY information using hdparm -I /dev/hda to determine the
UDMA mode supported or /proc/ide/hda/identify, word# 88



-----Original Message-----
From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
Sent: Friday, December 06, 2002 3:21 PM
To: David Ashley
Cc: Linux Kernel Mailing List
Subject: Re: 2.4.18 beats 2.5.50 in hard drive access????


On Fri, 2002-12-06 at 19:29, David Ashley wrote:
>     ide0: BM-DMA at 0x1880-0x1887, BIOS settings: hda:pio, hdb:DMA
>     ide1: BM-DMA at 0x1888-0x188f, BIOS settings: hdc:pio, hdd:DMA

When we read the settings DMA was disabled on hda and hdc. We therefore
assumed the BIOS did that for a reason and followed caution.

What happens if you do

	hdparm -d1 /dev/hda

?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
