Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265351AbSKTAN3>; Tue, 19 Nov 2002 19:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267157AbSKTAN3>; Tue, 19 Nov 2002 19:13:29 -0500
Received: from imrelay-2.zambeel.com ([209.240.48.8]:43019 "EHLO
	imrelay-2.zambeel.com") by vger.kernel.org with ESMTP
	id <S265351AbSKTAN2>; Tue, 19 Nov 2002 19:13:28 -0500
Message-ID: <233C89823A37714D95B1A891DE3BCE5202AB1953@xch-a.win.zambeel.com>
From: Manish Lachwani <manish@Zambeel.com>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
       Manish Lachwani <manish@Zambeel.com>
Cc: "'Steven Timm'" <timm@fnal.gov>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: Serverworks dma_intr: error=0x40 { UncorrectableError }
Date: Tue, 19 Nov 2002 16:20:19 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I will try to repeat the experiment with FreeBSD and send the config space
information. 

btw, I had also noticed the corruption in the PIO4 mode. This is the sample
o/p from dt that shows the 4 bytes shifts in PIO4:

Original Buffer:
=====================

0x51972be0  35 a7 a4 81 36 a8 a5 82 37 a9 a6 83 38 aa a7 84
0x51972bf0  39 ab a8 85 3a ac a9 86 3b ad aa 87 3c ae ab 88
0x51972c00 *be 2e 2c 09 bf 2f 2d 0a c0 30 2e 0b c1 31 2f 0c
0x51972c10  c2 32 30 0d c3 33 31 0e c4 34 32 0f c5 35 33 10

dt: The incorrect data starts at address 0x3ed70c00 (marked by asterisk '*')
dt: Dumping Verify Buffer (base = 0x3d6af000, offset = 23862272, limit = 64
bytes):

Verify buffer
=================

0x3ed70be0  35 a7 a4 81 36 a8 a5 82 37 a9 a6 83 38 aa a7 84
0x3ed70bf0  39 ab a8 85 3a ac a9 86 3b ad aa 87 3c ae ab 88
0x3ed70c00 *3c ae ab 88 be 2e 2c 09 bf 2f 2d 0a c0 30 2e 0b
0x3ed70c10  c1 31 2f 0c c2 32 30 0d c3 33 31 0e c4 34 32 0f

Thanks
Manish

-----Original Message-----
From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
Sent: Tuesday, November 19, 2002 4:43 PM
To: Manish Lachwani
Cc: 'Steven Timm'; Linux Kernel Mailing List
Subject: RE: Serverworks dma_intr: error=0x40 { UncorrectableError }


On Wed, 2002-11-20 at 00:04, Manish Lachwani wrote:
> Yes, CSB5/CSB6 does not have this problem. I have been using this with the
> GC-LE chipset. 
> 
> However, there was something that I noticed when I was experimenting with
> the FreeBSD kernel for producing these corruptions. I could not reproduce
> these corruptions with FreeBSD 4.6 and at UDMA 2. I also noticed that the
> PCI config space settings for the IDE controller were different in FreeBSD
> and Linux 2.4.17.

It might be interesting to know what the differences are. Certainly the
bug is a very strange one.
