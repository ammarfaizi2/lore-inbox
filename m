Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262317AbSKCSkD>; Sun, 3 Nov 2002 13:40:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262322AbSKCSkD>; Sun, 3 Nov 2002 13:40:03 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:36797 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262317AbSKCSkC>;
	Sun, 3 Nov 2002 13:40:02 -0500
Message-ID: <3DC56EC1.4040403@us.ibm.com>
Date: Sun, 03 Nov 2002 10:45:21 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Margit Schubert-While <margit@margit.com>, linux-kernel@vger.kernel.org
Subject: Re: U160 on Adaptec 39160
References: <4.3.2.7.2.20021103124403.00b4c860@mail.dns-host.com> <20021103133014.GJ23425@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
 > 39160 does 80MB/s/channel, the 160MB/s happens pretty much only as
 > the sum of both channels.

Nope, quoting from Adaptec's site:
 > <snip>
 > enterprise servers. Combining a 64-bit PCI interface with two
 > Ultra160 SCSI channels, this card moves data at the fastest speeds
 > possible. <snip>

The 3950 had dual 80MB/s channels.

 > I've had one for a couple of years, and it performs very well,
 > though it won't ever quite live up to the marketing gimmick for
 > bandwidth on a single channel. ISTR something about RAID across
 > channels involved, but I just use disks directly instead.

Even out of good disks, you're unlikely to get more than 20MB/S out of 
each of them.  So, it would take at least 8 of those in a striped 
array to fill up a U160 channel.  Unlike IDE's claims of _burst_ 
speeds, SCSI can take all the bandwidth up, if you give it enough 
devices.

 > On Sun, Nov 03, 2002 at 12:59:44PM +0100, Margit Schubert-While
 > wrote:
> 
> <4>Attached scsi disk sdb at scsi1, channel 0, id 1, lun 0
> <4>(scsi1:A:0): 80.000MB/s transfers (40.000MHz, offset 127, 16bit)
> <4>SCSI device sda: 35885448 512-byte hdwr sectors (18373 MB) 

During negotiation, the drives will train down in speed if they don't 
think they can run at full speed which can be caused by cabling or 
termination issues.  You can also take their speed down manually in 
the card's BIOS, so check that too.

It looks to me from your dmesg that all of your devices are on the 
same channel.  Am I misreading things?

-- 
Dave Hansen
haveblue@us.ibm.com

