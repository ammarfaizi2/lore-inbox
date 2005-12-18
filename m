Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965100AbVLRLXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965100AbVLRLXQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 06:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964848AbVLRLXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 06:23:16 -0500
Received: from cpe-68-173-12-128.nyc.res.rr.com ([68.173.12.128]:40117 "EHLO
	fireether.net") by vger.kernel.org with ESMTP id S965100AbVLRLXP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 06:23:15 -0500
Message-ID: <43A54683.3030202@fireether.net>
Date: Sun, 18 Dec 2005 06:22:43 -0500
From: Kernel - Noah Blumenfeld <kernel@fireether.net>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: IT821x driver
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings..

I'm not 100% positive if this is the correct place to post about this 
driver, but seeing that it related to the kernel, I believe its related 
to this mailing list.

I've been running into many problems with the ITE 8212F chip, which is 
used as both an IDE controller and as a RAID controller (0, 1, and 1+0).

I've done the following - all with the same results:

-Downloaded Gentoo-sources (2.6.14-r5), configurated kernel with the 
it821x driver, and tried to enable dma.
-Downloaded a vanilla kernel 2.6.11 from www.kernel.org, and applied the 
ac7 patches, configurated and then tried to enable dma.

As far as I can tell - and from the information within the driver's file 
  /drivers/ide/pci/it821x.c - the current driver does not support mwdma 
or dma, only udma. It also says that if - and I quote Alan Cox -

"If you write LBA48 sized I/O's (ie > 256 sector) in smart mode raid 
then the controller firmware dies"

I recently brought it for $40 from compusa, and I'm sure this problem 
may come up more often soon.

It works fine in PIO mode, I've transmitted files to it via samba (I'm 
setting it up as a file server) - with a rate of about 2.378 MB/sec.

When I enable it in UDMA mode using hdparm -X64 -d1 /dev/hdc - or in ANY 
dma mode.. It will accept a certain amount of data before literally 
crapping its pants. As the quote above says, when LBA48 sized I/O's are 
written to the raid card, it will die. I'm using it as a RAID 0, so its 
in smart mode, and it will die when LBA48 sized I/O's are written to it.

My question is then, and if this doesnt belong here, please let me know.

Is there a way to restrict the size of the files being written by the 
kernel to a hardware device? I.e. make it so it will not write LBA48 
sized I/O's, but still work in UDMA mode - because not using DMA mode 
makes hard drive write painfully slow - and unsuitable for a network 
file server.

I've also tried compiling the SCSI driver given by the company - and the 
kernel doesnt even boot up with it. The only way I could boot up with 
the it821x driver is to configure the kernel not to enable DMA mode for 
hard drives by default.

If the chip was dying out (not being sold anymore) I wouldnt bring this 
up. But it appears it will be sold more.. And so this may become a 
problem further down the road. I'm considering taking Alan Cox's driver 
for it and modifying it. Several people reported that it worked great 
for through mode (using the chip as a IDE controller) - few kernel 
versions ago (2.6.9, 2.6.11) - thats why I downloaded 2.6.11 to patch 
with the AC7 patches and to test it. Didnt work in RAID mode.

Thanks you,
Noah Blumenfeld
