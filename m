Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261229AbVBGSdD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261229AbVBGSdD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 13:33:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbVBGSdD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 13:33:03 -0500
Received: from 66-162-60-3.gen.twtelecom.net ([66.162.60.3]:54101 "EHLO
	lpdsrv13.logicpd.com") by vger.kernel.org with ESMTP
	id S261229AbVBGScx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 13:32:53 -0500
Message-ID: <4207B453.2090203@visi.com>
Date: Mon, 07 Feb 2005 12:32:51 -0600
From: Jeff Cooper <jacooper@visi.com>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Disk corruption problem with nVidia motherboard and Silicon Image
 680 ATA controller
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Feb 2005 18:32:52.0251 (UTC) FILETIME=[6EC82EB0:01C50D43]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I tried posting this question last week on comp.os.linux.hardware and 
didn't get much of a response.  So I thought I'd try it here and see if 
anyone can give me a hand.

I'm trying to track down an issue I'm having with corrupted files on 
some of my hard drives and I'm hoping someone can offer some help or 
ideas of things to try.

I'm running a Gentoo system with a 2.6.10-r6 kernel.  This is the 
gentoo-dev-sources ebuild.  My motherboard is a Asus A7N8X with an 
nForce2 nVidia chipset.  The system has five 40 gig hard drives, all set 
as masters.  Each drive is connected to a single IDE channel.  Two 
drives are connected to the motherboard IDE connectors.  The remaining 
three drivers are connected to two SIIG UltraATA 133 PCI controllers. 
These controllers use the Silicon Image 0680 chipset.

The system is setup to use software raid and LVM.  The / partition is a 
RAID1 using drive partitions run from the motherboard IDE controller. 
The /tmp partition is a RAID0 using partitions from the SIIG 
controllers.  The LVM is on top of a RAID5 partition using the rest of 
the partitions, some controlled by the motherboard and some by the 
SIIGs.  All file systems are formatted using JFS.

There have been no unusual messages in /var/log/messages.

I started noticed problems with Quake3 Arena not being able to load 
certain maps.  So I checked the md5sum of the pak0.pk3 and it didn't 
match the one on the CD.  So I tried to recopy it from the CD and the 
new copy had a different md5sum than the other two.  Then I tried to 
copy the file to the root partition.  That copy succeeded with the 
correct md5sum, however, when I tried to copy it to the Quake3 install, 
it was corrupted.

My Quake3 install is in my /opt which resides on the LVM.  So my first 
thought is perhaps there is a bug running an LVM on top of a RAID or 
possibly with JFS.  So to test that theory I stopped the /tmp RAID and 
reformatted the 3 partitions as EXT2 and mounted them.  Then I started 
copying pak0.pk3 to my new filesystems and md5suming the copies.  Most 
of the copies succeeded, but a few were corrupted, about 5 out of 300. 
The failed copies were not limited to a particular drive, all three 
drives had at least one bad copy.

That eliminated LVM or JFS or RAID as a source of the problem.

I haven't run the same test on my root partition.  So I can't state yet 
that the root partition never corrupts.  But I can state that I've never 
noticed a corrupt file on the root partition.

So then I started to wonder about the drivers for the Silicom Image 
chipset since the problem so far has only occured with drives running on 
those external controller cards.

In the source for the driver (siimage.c), I noticed the following comment:
     If you have strange problems with nVidia chipset systems
     please see the SI support documentation and update your
     system BIOS if neccessary.

Does anyone know what that comment means or where this 'SI support 
documentation' can be found?

Both the BIOS on my system and on the SIIG controller cards is up to date.

The system has has ran memtest86 for about24 hours without an error.

I'm willing to put some time and effort into finding this problem (as 
opposed to simple chucking the controllers and buying ones based on a 
different chipset) if someone can help me along the way.

Thanks for any advice anyone can offer!

Jeff Cooper
jacooper@visi.com

