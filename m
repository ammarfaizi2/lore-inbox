Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750764AbVJWUpl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbVJWUpl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 16:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbVJWUpl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 16:45:41 -0400
Received: from burton-2.bford.kiva.net ([64.151.144.2]:62412 "EHLO
	burtonpontiac.com") by vger.kernel.org with ESMTP id S1750764AbVJWUpl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 16:45:41 -0400
Message-ID: <435BF66B.7040508@cs.indiana.edu>
Date: Sun, 23 Oct 2005 15:45:31 -0500
From: Robert Jones <rowjones@cs.indiana.edu>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041005)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.13.4 aacraid: Partitioning array makes adapter go "dead"
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I apologize if I happen to break list etiquette, as this is the first
time I have posted here before. I'll try to make this as short as possible.

Here's some information regarding the machine I'm having the problem with:
2-Way Dual-Core AMD Opteron 275's
8GB Reg ECC
Tyan 2882-D (K8SD-Pro) motherboard (AMD-8000 series chipset)
2 Seagate ST336754LC's, updated to latest firmware (0004)
Adaptec 2230S (updated to latest firmware, 8205)

The machine boots wonderfully with any kernel I have tried (2.6.9,
2.6.12.9, 2.6.13.4, 2.6.14-rc5; all kernels are vanilla kernels) and
binds the array to /dev/sda, so long as the array is unpartitioned.
Here's what the kernel reports when booting:

-----------

SCSI device sda: 71619584 512-byte hdwr sectors (36669 MB)
sda: Write Protect is off
sda: Mode Sense: 03 00 00 00
sda: got wrong page
sda: assuming drive cache: write through
SCSI device sda: 71619584 512-byte hdwr sectors (36669 MB)
sda: Write Protect is off
sda: Mode Sense: 03 00 00 00
sda: got wrong page
sda: assuming drive cache: write through
   sda: unknown partition table
Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0

-----------

However, once I partition the array things begin to go wrong. While the
partitioning succeeds, any point after this aacraid will state the
controller is "dead". Here's what the kernel is telling me at this point:

-----------

SCSI device sda: 71619584 512-byte hdwr sectors (36669 MB)
sda: Write Protect is off
sda: Mode Sense: 03 00 00 00
sda: got wrong page
sda: assuming drive cache: write through
   sda: sda1 sda2 sda3
SCSI device sda: 71619584 512-byte hdwr sectors (36669 MB)
sda: Write Protect is off
sda: Mode Sense: 03 00 00 00
sda: got wrong page
sda: assuming drive cache: write through
   sda: sda1 sda2 sda3

-----------

This looks fine too, however, when I reboot or try to access the array
directly such as a mke2fs /dev/sda1, the kernel says this:

-----------

aacraid: Host adapter reset request. SCSI hang ?
aacraid: Host adapter appears dead
scsi: Device offlined - not ready after error recovery: host 0 channel 0
id 0 lun 0
sd 0:0:0:0: SCSI error: return code = 0x6000000
end_request: I/O error, dev sda, sector 63
Buffer I/O error on device sda1, logical block 0
scsi0 (0:0): rejecting I/O to offline device
Buffer I/O error on device sda1, logical block 0
scsi0 (0:0): rejecting I/O to offline device
Buffer I/O error on device sda1, logical block 64
scsi0 (0:0): rejecting I/O to offline device
Buffer I/O error on device sda1, logical block 64

-----------

The same machine will install Win2K w/ Adaptec's driver just fine, so I
think the hardware is okay. I went ahead and pulled Adaptec's "official"
aacraid implementation and replaced the "vanilla" implementation in
2.6.9 with it. Unfortunately, this did not seem to help.

Also, if I remove the partitions aacraid is happy again and will bind
the array into /dev/sda as before. It's only after partitioning do
things go bad.

I have three of these machines and they don't have to go live until
January 1, 2006, so I have some time-and am willing-to knock around some
trial and error work with aacraid if needed.

Thanks,
Robert
	
