Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261846AbUK2Wnb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261846AbUK2Wnb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 17:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261845AbUK2WkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 17:40:05 -0500
Received: from av9-2-sn4.m-sp.skanova.net ([81.228.10.107]:21390 "EHLO
	av9-2-sn4.m-sp.skanova.net") by vger.kernel.org with ESMTP
	id S261855AbUK2WgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 17:36:25 -0500
Message-ID: <41ABA453.7070103@lanil.mine.nu>
Date: Mon, 29 Nov 2004 23:36:03 +0100
From: Christian Axelsson <smiler@lanil.mine.nu>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041119)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [2.6.10-rc2-mm3] Broken usb2 mass-storage?
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Im trying to attach a usb2 200gb drive to my laptop that is runnig 
2.6.10-rc2-mm3. Upon connect I get this in dmesg:

   usb 1-2: new high speed USB device using ehci_hcd and address 4
   scsi0 : SCSI emulation for USB Mass Storage devices
   usb-storage: device found at 4
   usb-storage: waiting for device to settle before scanning
     Vendor: Maxtor 6  Model: Y200P0            Rev: YAR4
     Type:   Direct-Access                      ANSI SCSI revision: 04
   SCSI device sda: 398297088 512-byte hdwr sectors (203928 MB)
   sda: assuming drive cache: write through
    sda: sda1
   Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
   Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0

Then I try to access the disk (via fdisk or mount anything) and I get 
the following in dmesg:

   usb 1-2: reset high speed USB device using ehci_hcd and address 4
   usb 1-2: scsi_eh_0 timed out on ep0in
   usb 1-2: device descriptor read/64, error -110
   usb 1-2: scsi_eh_0 timed out on ep0in
   usb 1-2: device descriptor read/64, error -110
   usb 1-2: reset high speed USB device using ehci_hcd and address 4
   usb 1-2: scsi_eh_0 timed out on ep0in
   usb 1-2: device descriptor read/64, error -110

Then it stalls a while and this shows up:

   scsi: Device offlined - not ready after error recovery: host 0 
channel 0 id 0 lun 0
   usb 1-2: USB disconnect, address 4
   scsi0 (0:0): rejecting I/O to offline device
   scsi0 (0:0): rejecting I/O to offline device
   usb-storage: device scan complete
   usb 1-2: new high speed USB device using ehci_hcd and address 5
   usb 1-2: khubd timed out on ep0in
   usb 1-2: device descriptor read/64, error -110

And repeats this.. I think you get the point ;)
The process trying to access the disk hangs.
Note: the drive works flawless under windows and has worked fine under 
linux during various stages of the 2.5 and early 2.6 kernels :)

-- 
Regards,
Christian
