Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264409AbUFLLnf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264409AbUFLLnf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 07:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264725AbUFLLnf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 07:43:35 -0400
Received: from mail0.epfl.ch ([128.178.50.57]:44557 "HELO mail0.epfl.ch")
	by vger.kernel.org with SMTP id S264409AbUFLLna convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 07:43:30 -0400
Date: Sat, 12 Jun 2004 13:43:27 +0200
From: Gregoire Favre <Gregoire.Favre@freesurf.ch>
To: linux-kernel@vger.kernel.org
Subject: Memory stick usb and 2.6.7-rc3 (works with 2.6.7-rc2)
Message-ID: <20040612114327.GA5539@magma.epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have already written to this list about my problem introduced with the
2.6.7-rc3 kernel.

When I plug my memory stick, I got this :

Jun 12 13:26:25 greg kernel: usb 1-2: new high speed USB device using address 3
Jun 12 13:26:25 greg kernel: scsi3 : SCSI emulation for USB Mass Storage devices
Jun 12 13:26:25 greg kernel:   Vendor: USB       Model: Flash Drive       Rev: 1.12
Jun 12 13:26:25 greg kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Jun 12 13:26:25 greg kernel: SCSI device sdg: 1015805 512-byte hdwr sectors (520 MB)
Jun 12 13:26:25 greg kernel: sdg: assuming Write Enabled
Jun 12 13:26:25 greg kernel: sdg: assuming drive cache: write through
Jun 12 13:26:25 greg kernel:  sdg: unknown partition table
Jun 12 13:26:25 greg kernel: Attached scsi removable disk sdg at scsi3, channel 0, id 0, lun 0
Jun 12 13:26:25 greg kernel: Attached scsi generic sg9 at scsi3, channel 0, id 0, lun 0,  type 0
Jun 12 13:26:26 greg scsi.agent[3639]: disk at /devices/pci0000:00/0000:00:1d.7/usb1/1-2/1-2:1.0/host3/3:0:0:0

My other USB mass storage device (a 8-1 cards reader) works just fine with
this 2.6.7-rc3 kernel.

The partition as shown in fdisk on this kernel is :

Disk /dev/sdg: 520 MB, 520092160 bytes
16 heads, 62 sectors/track, 1023 cylinders
Units = cylinders of 992 * 512 = 507904 bytes

   Device Boot      Start         End      Blocks   Id  System
/dev/sdg1   ?      784412     1935127   570754815+  72  Unknown
Partition 1 has different physical/logical beginnings (non-Linux?):
     phys=(357, 116, 40) logical=(784411, 3, 11)
Partition 1 has different physical/logical endings:
     phys=(357, 32, 45) logical=(1935126, 8, 51)
Partition 1 does not end on cylinder boundary.
/dev/sdg2   ?      170050     2121692   968014120   65  Novell Netware 386
Partition 2 has different physical/logical beginnings (non-Linux?):
     phys=(288, 115, 43) logical=(170049, 14, 47)
Partition 2 has different physical/logical endings:
     phys=(367, 114, 50) logical=(2121691, 4, 42)
Partition 2 does not end on cylinder boundary.
/dev/sdg3   ?     1884962     3836603   968014096   79  Unknown
Partition 3 has different physical/logical beginnings (non-Linux?):
     phys=(366, 32, 33) logical=(1884961, 2, 30)
Partition 3 has different physical/logical endings:
     phys=(357, 32, 43) logical=(3836602, 7, 39)
Partition 3 does not end on cylinder boundary.
/dev/sdg4   ?           1     3666559  1818613248    d  Unknown
Partition 4 has different physical/logical beginnings (non-Linux?):
     phys=(372, 97, 50) logical=(0, 0, 1)
Partition 4 has different physical/logical endings:
     phys=(0, 10, 0) logical=(3666558, 15, 30)
Partition 4 does not end on cylinder boundary.

Partition table entries are not in disk order

If I reboot with 2.6.7-rc2 (and remove the Memory Stick, otherwise I don't
have my device in same order, I haven't found out how to solve this issue)
I got the following in putting the Memory Stick in :

Jun 12 13:40:01 greg kernel: usb 1-2: new high speed USB device using address 3
Jun 12 13:40:01 greg kernel: scsi3 : SCSI emulation for USB Mass Storage devices
Jun 12 13:40:01 greg kernel:   Vendor: USB       Model: Flash Drive       Rev: 1.12
Jun 12 13:40:01 greg kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Jun 12 13:40:01 greg kernel: SCSI device sdg: 1015805 512-byte hdwr sectors (520 MB)
Jun 12 13:40:01 greg kernel: sdg: assuming Write Enabled
Jun 12 13:40:01 greg kernel: sdg: assuming drive cache: write through
Jun 12 13:40:01 greg kernel:  sdg: sdg1 sdg2 sdg3 sdg4
Jun 12 13:40:01 greg kernel: Attached scsi removable disk sdg at scsi3, channel 0, id 0, lun 0
Jun 12 13:40:01 greg kernel: Attached scsi generic sg9 at scsi3, channel 0, id 0, lun 0,  type 0
Jun 12 13:40:02 greg scsi.agent[4073]: disk at /devices/pci0000:00/0000:00:1d.7/usb1/1-2/1-2:1.0/host3/3:0:0:0

NOTICE the partition is recognized...

And fdisk tells me :

Disk /dev/sdg: 520 MB, 520092160 bytes
16 heads, 62 sectors/track, 1023 cylinders
Units = cylinders of 992 * 512 = 507904 bytes

   Device Boot      Start         End      Blocks   Id  System
/dev/sdg1   ?      784412     1935127   570754815+  72  Unknown
Partition 1 has different physical/logical beginnings (non-Linux?):
     phys=(357, 116, 40) logical=(784411, 3, 11)
Partition 1 has different physical/logical endings:
     phys=(357, 32, 45) logical=(1935126, 8, 51)
Partition 1 does not end on cylinder boundary.
/dev/sdg2   ?      170050     2121692   968014120   65  Novell Netware 386
Partition 2 has different physical/logical beginnings (non-Linux?):
     phys=(288, 115, 43) logical=(170049, 14, 47)
Partition 2 has different physical/logical endings:
     phys=(367, 114, 50) logical=(2121691, 4, 42)
Partition 2 does not end on cylinder boundary.
/dev/sdg3   ?     1884962     3836603   968014096   79  Unknown
Partition 3 has different physical/logical beginnings (non-Linux?):
     phys=(366, 32, 33) logical=(1884961, 2, 30)
Partition 3 has different physical/logical endings:
     phys=(357, 32, 43) logical=(3836602, 7, 39)
Partition 3 does not end on cylinder boundary.
/dev/sdg4   ?           1     3666559  1818613248    d  Unknown
Partition 4 has different physical/logical beginnings (non-Linux?):
     phys=(372, 97, 50) logical=(0, 0, 1)
Partition 4 has different physical/logical endings:
     phys=(0, 10, 0) logical=(3666558, 15, 30)
Partition 4 does not end on cylinder boundary.

Partition table entries are not in disk order

And I can mount it and use it perfectly ;-)

Any idea what's wrong with 2.6.7-rc3 ?

Thank you very much and have a great day !!!

PLEASE: CC to me as I only read this list though NNTP :-)

-- 
	Grégoire Favre
__________________________________________________________________________
http://algebra.epfl.ch/greg ICQ:16624071 mailto:Gregoire.Favre@freesurf.ch
