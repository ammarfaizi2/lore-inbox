Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264106AbUEEIrF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264106AbUEEIrF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 04:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264272AbUEEIrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 04:47:05 -0400
Received: from noralf.uib.no ([129.177.30.12]:16268 "EHLO noralf.uib.no")
	by vger.kernel.org with ESMTP id S263885AbUEEIqz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 04:46:55 -0400
Date: Wed, 5 May 2004 10:46:48 +0200
From: Jan-Frode Myklebust <janfrode@parallab.uib.no>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Cc: "Moore, Eric Dean" <Emoore@lsil.com>
Subject: qla2300 at only 1 GBit on kernel 2.6.5
Message-ID: <20040505084648.GA17444@ii.uib.no>
Mail-Followup-To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
	"Moore, Eric Dean" <Emoore@lsil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-checked-clean: by exiscan on noralf
X-Scanner: fa729c004f9c8b2636ab11abc9ca2c25 http://tjinfo.uib.no/virus.html
X-UiB-SpamFlag: NO UIB: -39.0 hits, 11.0 required
X-UiB-SpamReport: spamassassin found;
  -30 -- From is listed in 'whitelist_from'
  -9.0 -- Message received from UIB
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I gave up on the LSI Logic FC HBA, since we couldn't get it to work
with the SMP-kernel, so now I've gotten a qlogic QLA2300 as
replacement.

This seems to be working fine with the RedHat 2.4.21-9.0.1.ELsmp
kernel, but when I try running on the vanilla 2.6.5 kernel, it only
operates in 1 GB mode. The HBA is connected to a Infortrend SATA/RAID
box. If I try forcing the connection to 2 GBit from the Infortrend, I
get an error saying 'Cable unplugged' when loading the qla2300 module
on 2.6.5.

So, are there any module parameters I can give the qla2300, to force
it to 2 Gbit? Or anything else I can try to get full speed on my
channels?

Kernel logs while loading the qla2300 module on 2.4.21-9.0.1.ELsmp:

-------------------------------------------------------------------
qla2x00_set_info starts at address = f8a94060
qla2x00: Found  VID=1077 DID=2300 SSVID=1077 SSDID=9
scsi(1): Found a QLA2300  @ bus 1, device 0x5, irq 20, iobase 0xf8a8e000
scsi(1): Allocated 4096 SRB(s).
scsi(1): Configure NVRAM parameters...
scsi(1): 64 Bit PCI Addressing Enabled.
scsi(1): Scatter/Gather entries= 3584 qla2x00_nvram_config ZIO enabled:intr_timer_delay=3
scsi(1): Verifying loaded RISC code...
scsi(1): Verifying chip...
scsi(1): Waiting for LIP to complete...
scsi(1): LOOP UP detected.
scsi(1): Port database changed.
scsi(1) qla2x00_isr MBA_PORT_UPDATE ignored
scsi(1): Topology - (N_Port-to-N_Port), Host Loop address 0x1
qla2x00_find_all_fabric_devs GNN_FT Failed-Try issuing GAN
scsi1 : QLogic QLA2300 PCI to Fibre Channel Host Adapter: bus 1 device 5 irq 20
        Firmware version:  3.02.13, Driver version 6.06.00b11
 
scsi(1): Waiting for LIP to complete...
scsi(1): Topology - (N_Port-to-N_Port), Host Loop address 0x1
initializing plug timer for queue f6915e18
Starting timer : 1 1
blk: queue f6915e18, I/O limit 4294967295Mb (mask 0xffffffffffffffff)
  Vendor: IFT       Model: A16F-G1A2         Rev: 334A
  Type:   Direct-Access                      ANSI SCSI revision: 03
initializing plug timer for queue f6915c18
Starting timer : 1 1
blk: queue f6915c18, I/O limit 4294967295Mb (mask 0xffffffffffffffff)
scsi(1:0:0:0): Enabled tagged queuing, queue depth 64.
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
SCSI device sdb: 1048576000 512-byte hdwr sectors (536871 MB)
 sdb: sdb1
-------------------------------------------------------------------

Kernel logs while loading the qla2300 module on vanila 2.6.5:

-------------------------------------------------------------------
QLogic Fibre Channel HBA Driver (f8b4c000)
qla2300 0000:01:05.0: Found an ISP2300, irq 145, iobase 0xf89b3000
qla2300 0000:01:05.0: Configuring PCI space...
qla2300 0000:01:05.0: Configure NVRAM parameters...
qla2300 0000:01:05.0: Verifying loaded RISC code...
qla2300 0000:01:05.0: Waiting for LIP to complete...
qla2300 0000:01:05.0: LOOP UP detected (1 Gbps).
qla2300 0000:01:05.0: Topology - (N_Port-to-N_Port), Host Loop address 0x1
qla2300 0000:01:05.0: Failed SNS login: loop_id=80 mb[0]=4005 mb[1]=5 mb[2]=0 mb[6]=423 mb[7]=922e
scsi1 : qla2xxx
qla2300 0000:01:05.0:
 QLogic Fibre Channel HBA Driver: 8.00.00b10
  QLogic QLA2300 -
  ISP2300: PCI (33 MHz) @ 0000:01:05.0 hdma-, host#=1, fw=3.02.21 IPX
  Vendor: IFT       Model: A16F-G1A2         Rev: 334A
  Type:   Direct-Access                      ANSI SCSI revision: 03
qla2300 0000:01:05.0: scsi(1:0:0:0): Enabled tagged queuing, queue depth 32.
SCSI device sdb: 1048576000 512-byte hdwr sectors (536871 MB)
SCSI device sdb: drive cache: write through
 sdb:<4>  Warning: Disk has a valid GPT signature but invalid PMBR.
  Assuming this disk is *not* a GPT disk anymore.
  Use gpt kernel option to override.  Use GNU Parted to correct disk.
 sdb1
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
Attached scsi generic sg2 at scsi1, channel 0, id 0, lun 0,  type 0
  Vendor: IFT       Model: A16F-G1A2         Rev: 334A
  Type:   Direct-Access                      ANSI SCSI revision: 03
qla2300 0000:01:05.0: scsi(1:0:0:1): Enabled tagged queuing, queue
depth 32.
SCSI device sdc: 1048576000 512-byte hdwr sectors (536871 MB)
SCSI device sdc: drive cache: write through
 sdc: sdc1
Attached scsi disk sdc at scsi1, channel 0, id 0, lun 1
Attached scsi generic sg3 at scsi1, channel 0, id 0, lun 1,  type 0
  Vendor: IFT       Model: A16F-G1A2         Rev: 334A
  Type:   Direct-Access                      ANSI SCSI revision: 03
qla2300 0000:01:05.0: scsi(1:0:0:2): Enabled tagged queuing, queue
depth 32.
SCSI device sdd: 1317883904 512-byte hdwr sectors (674757 MB)
SCSI device sdd: drive cache: write through
 sdd: sdd1
Attached scsi disk sdd at scsi1, channel 0, id 0, lun 2
Attached scsi generic sg4 at scsi1, channel 0, id 0, lun 2,  type 0
-------------------------------------------------------------------

Any advice?


  -jf
