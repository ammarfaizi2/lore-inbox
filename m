Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932464AbVL1GYh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932464AbVL1GYh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 01:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932469AbVL1GYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 01:24:37 -0500
Received: from neopsis.com ([213.239.204.14]:52447 "EHLO
	matterhorn.dbservice.com") by vger.kernel.org with ESMTP
	id S932464AbVL1GYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 01:24:36 -0500
Message-ID: <43B23DE0.5080201@dbservice.com>
Date: Wed, 28 Dec 2005 07:25:20 +0000
From: Tomas Carnecky <tom@dbservice.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051204)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Serial ATA Lockups
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Neopsis-MailScanner-Information: Please contact the ISP for more information
X-Neopsis-MailScanner: Found to be clean
X-MailScanner-From: tom@dbservice.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My setup: Shuttle XPC Barebone, AMD CPU, two serial ATA disks in a 
software raid setup.
When the system is under heavy load (start World of Warcraft, dd 
if=/dev/zero of=/part/file etc) I get these messages in dmesg:

ata1: translated ATA stat/err 0x51/84 to SCSI SK/ASC/ASCQ 0xb/47/00
ata1: status=0x51 { DriveReady SeekComplete Error }
ata1: error=0x84 { DriveStatusError BadCRC }

over and over, pages with these messages.
The system will eventually lockup hard, HDD led is on, no disk activity, 
I have to reboot the system. Some kernels ago (2.6.14.2) I got a kernel 
backtrace on the console, I don't remember exactly anymore but there was 
something with scsi_resume(). I don't get this backtrace with this 
kernel: 2.6.15-rc6-gd5ea4e26, now it just locks up hard.

Sometimes I can't even boot (like just before), it locked up before init 
could be started. And I've seen this on my console (transcript):

command 0x35 timeout, stat 0xd0 host_stat 0x21
translated ATA stat/err 0x51/84 to SCSI SK/ASC/ASCQ 0xb/47/00
status=0xd0 { busy }
SCSI error: return code = 0x8000002
sda: Current: sense key = 0xB
end_request: I/O error, dev sda, sector [sector #]
ATA abnormal status 0xD0 on port 0x9f7

Its very hard recover from a hard lockup because at the next reboot, the 
kernel wants to RESYNC the raid arrays and this causes heavy load which 
again causes a hard lockup. And endless loop. Sometimes, I can boot and 
then I change to 'init 2' to stop as many services as I can and unmount 
as many partitions as I can but even then it sometimes locks up again.

The Barebone SATA chip supports SATA-II, but the harddrives are SATA-I. 
The two disks are Seagate 120GB. I've had problems with the harddrives 
before, I've had them on a ICP Vortex SATA hardware-raid controller and 
sometimes, one disk would fail and I'd have to rebuild the array. It was 
always the same disk, and I don't think it one that I have in my new 
computer now.

Can this be fixed in the kernel? Or do I have to buy new harddisks?

tom
