Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263002AbTLMC0o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 21:26:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263102AbTLMC0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 21:26:44 -0500
Received: from viefep12-int.chello.at ([213.46.255.25]:33318 "EHLO
	viefep12-int.chello.at") by vger.kernel.org with ESMTP
	id S263002AbTLMC0b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 21:26:31 -0500
From: Simon Roscic <simon.roscic@chello.at>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [2.6.0-test11] dpt/adaptec i2o trouble (long)
Date: Sat, 13 Dec 2003 03:26:41 +0100
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200312130326.41190.simon.roscic@chello.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I own a dpt smart raid v (1554U2) scsi controller, for wich i used the
dpt_i2o driver under kernel 2.4, wich is currently broken in 2.6.
I googled a bit around, and found out that the suggested solution
is to use use the i2o-scsi driver:
http://marc.theaimsgroup.com/?l=linux-scsi&m=106046024506801&w=2
also see this thread:
http://marc.theaimsgroup.com/?t=106191158100004&r=1&w=2

So i compiled a fresh 2.6.0-test11 kernel, and build i2o-core, i2o-proc, i2o-scsi
and i2o-block as modules.
While modprobing i2o-core without parameters it told me:
"Skipping Adaptec/DPT I2O raid with preferred native driver."
with "dpt=1" the module loads, but it complains that it cant
get the size of the device:

--
Activating I2O controllers...
This may take a few minutes if there are many devices
i2o/iop0: LCT has 15 entries.
i2o_scsi.c: Version 0.1.2
  chain_pool: 2048 bytes @ df1a7800
  (512 byte buffers X 4 can_queue X 1 i2o controllers)
-->   PARAMS_GET - Error:
-->     ErrorInfoSize = 0x01, BlockStatus = 0x08, BlockSize = 0x0002
scsi1 : i2o/iop0
  Vendor: IBM       Model: DDRS-39130W       Rev: S97B
  Type:   Direct-Access                      ANSI SCSI revision: 02
-->   sda : READ CAPACITY failed.
-->   sda : status=0, message=00, host=7, driver=00
-->   sda : sense not available.
SCSI device sda: drive cache: write back
 sda: sda1
Attached scsi disk sda at scsi1, channel 0, id 2, lun 0
Attached scsi generic sg1 at scsi1, channel 0, id 2, lun 0,  type 0
--

in this state fdisk tells me the following:

--
Disk /dev/sda: 1073 MB, 1073741824 bytes
255 heads, 63 sectors/track, 130 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

   Device Boot      Start         End      Blocks   Id  System
/dev/sda1               1        1111     8924076   83  Linux
Partition 1 has different physical/logical endings:
     phys=(1023, 254, 63) logical=(1110, 254, 63)
--

which is wrong, because the attached harddisk
(i dont use the raid features of this controller) is
an ibm ddrs-39130w -> size = 9.1 gb

on 2.4, using the dpt_i2o driver, i dont experience
this problems:

--
Loading Adaptec I2O RAID: Version 2.4 Build 5
Detecting Adaptec I2O RAID controllers...
PCI: Found IRQ 5 for device 00:0d.1
Adaptec I2O RAID controller 0 at e14b0000 size=100000 irq=5
dpti: If you have a lot of devices this could take a few minutes.
dpti0: Reading the hardware resource table.
TID 008  Vendor: SYMBIOS      Device: SYM53C895    Rev: 00000001
TID 515  Vendor: IBM          Device: DDRS-39130W  Rev: S97B
scsi2 : Vendor: Adaptec  Model: PM1554U2         FW:3013
  Vendor: IBM       Model: DDRS-39130W       Rev: S97B
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi disk sda at scsi2, channel 0, id 2, lun 0
SCSI device sda: 17849983 512-byte hdwr sectors (9139 MB)
 sda: sda1
--

i´ve put up further information (log entries,...) here:
http://segfault.info/simon/i2o/

my .config:
http://segfault.info/simon/i2o/2.6.0-test11.config

best regards,
	simon.

