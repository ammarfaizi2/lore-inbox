Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269617AbUJGBdd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269617AbUJGBdd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 21:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269603AbUJGBdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 21:33:33 -0400
Received: from smtp.tierzero.net ([66.6.216.67]:31127 "HELO smtp.tierzero.net")
	by vger.kernel.org with SMTP id S269617AbUJGBd1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 21:33:27 -0400
Message-ID: <41649CE6.6010405@vinyltribe.com>
Date: Wed, 06 Oct 2004 18:33:26 -0700
From: Emiliano Garcia <emi@vinyltribe.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: RE: [BUG: multiple kernels] data corruption while reading from an
 USB2 connected HD
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Everyone,
  
     I can confirm I am also experiencing problems with usb-storage on 
usb 2.0 devices. I have two separate usb 2.0 drives, one with the oxford 
911 usb/firewire chipset and another with a gensys chip. Anyhow, I tar 
up my servers once a week and copy the bzipped tar to my usb hard drive. 
I have found now that I cannot extract the tar.bz2 files due to crc 
errors. When I run bzip2 -tvv on the original archive on the server, it 
passes without failure. When I run the test (bzip2 -tvv) on the copy of 
the archive on the usb 2.0 disks, it says they have crc errors. dmesg 
does not show anything exciting besides the mounting/detection of the 
drives. Please help!

Thanks to all of you for you hard work.

Emiliano Garcia


    * /To/: linux-kernel@vger.kernel.org
      <mailto:linux-kernel%40vger.kernel.org>
    * /Subject/: [BUG: multiple kernels] data corruption while reading
      from an USB2 connected HD
    * /From/: Hajo Simons <simons@dc-systeme.de
      <mailto:simons%40dc-systeme.de>>
    * /Date/: Mon, 27 Sep 2004 11:06:06 +0200
    * /Cc/: hsimons@gmx.de <mailto:hsimons%40gmx.de>
    * /Organization/: dc-Systeme
    * /Sender/: linux-kernel-owner@vger.kernel.org
      <mailto:linux-kernel-owner%40vger.kernel.org>
    * /User-agent/: KMail/1.7

------------------------------------------------------------------------

usb-storage sporadically loses data while reading

In a data stream of 20M about 10 bytes get lost averagely while reading from a 
HD connected via USB 2.0 which practically means that most files stored on 
that HD show different md5 fingerprints if the IO read buffer was flushed 
meanwhile.

keywords:
 usb-storage, external Disk, USB 2.0, data corruption while reading

data get lost while reading on:
 2.4.27
 2.6.8.1
 2.6.8-gentoo-r3
 2.6.8-gentoo-r4 preemptive/non-preemptive
 2.6.9-rc1

whereas no faults are seen on: 
 Windows XP SP1 (without specific drivers for that USB2 disk device) 

system:
 Barton 3.2 200
 Asus A7N8XX (nforce2) FSB at 192MHz, CPU at FSB*11.5
 (A7N8* or CPU (don't know) cannot run stable for over a week at 200MHz FSB)
 1G 400MHz DDR RAM (tested) runnung at FSB Speed
 2 IDE disks connected to the onboard nforce2 IDE controller
 1 IDE disk USB2ish connected to ALi (ID 0402:5621 ALi Corp.) via onboard 
nforce2 USB controller

test: 
 (UAHD: usb attached HD)
 create a big file on a UAHD, say 20M
 md5sum it
 umount UAHD
 remount it
 md5sum that file again
 chances are 50/50, that you get a different number
 if md5sums are equal, repeat the procedure

 ( did the same test on that mentioned WinXP: everything ok;
   and yes, I did unplug the device between the reads )

note:
 system behaves rock-solid besides that issue
 tried blk_queue_max_sectors(sdev->request_queue, 1) in 
scsiglue.c:slave_configure() to no avail
 tried PREEMPTIVE on/off, same


details:


....
snip

