Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030253AbVIILZ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030253AbVIILZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 07:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030252AbVIILZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 07:25:59 -0400
Received: from relay.uni-heidelberg.de ([129.206.100.212]:43482 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S1030250AbVIILZr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 07:25:47 -0400
From: Bernd Schubert <bernd.schubert@pci.uni-heidelberg.de>
Reply-To: bernd-schubert@gmx.de
To: linux-scsi@vger.kernel.org
Subject: aic79xx oops
Date: Fri, 9 Sep 2005 13:25:45 +0200
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200509091325.45620.bernd.schubert@pci.uni-heidelberg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this morning our server crashed without any log messages, nothing captured via 
serial cable and magic sysrqs also didn't work.
Anyway during the reboot on oops of the aic79xx module occured, see below .

This is a 2.6.11.12 kernel, patched with bluesmoke and the bio-clone fix. 
Furthermore, the drbd module is loaded. You may find a dmesg, lsmod and lspci 
information and the kernel config here:

http://www.pci.uni-heidelberg.de/tc/usr/bernd/downloads/aic79xx-oops/


Ooops:

(none) login: ACPI: PCI interrupt 0000:02:06.0[A] -> GSI 24 (level, low) -> 
IRQ 24
ACPI: PCI interrupt 0000:02:06.1[B] -> GSI 25 (level, low) -> IRQ 25
scsi4 : Adaptec AIC79XX PCI-X SCSI HBA DRIVER, Rev 1.3.11
        <Adaptec AIC7902 Ultra320 SCSI adapter>
        aic7902: Ultra320 Wide Channel A, SCSI Id=7, PCI-X 67-100Mhz, 512 SCBs

scsi4:A:0:0: DV failed to configure device.  Please file a bug report against 
this driver.
(scsi4:A:0): 160.000MB/s transfers (80.000MHz DT, 16bit)
  Vendor: transtec  Model: T5008             Rev: 0001
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi4:A:0:0: Tagged Queuing enabled.  Depth 32
SCSI device sdc: 4101521408 512-byte hdwr sectors (2099979 MB)
SCSI device sdc: drive cache: write back
SCSI device sdc: 4101521408 512-byte hdwr sectors (2099979 MB)
SCSI device sdc: drive cache: write back
 sdc: sdc1 sdc2 sdc3 < sdc5 sdc6 sdc7 sdc8 >
Attached scsi disk sdc at scsi4, channel 0, id 0, lun 0
Attached scsi generic sg2 at scsi4, channel 0, id 0, lun 0,  type 0
scsi: host 4 channel 0 id 0 lun 0x00000200080c0400 has a LUN larger than 
currently supported.
scsi: host 4 channel 0 id 0 lun1002486961 has a LUN larger than allowed by the 
host adapter
scsi: host 4 channel 0 id 0 lun 0x01000000407a27c0 has a LUN larger than 
currently supported.
scsi: host 4 channel 0 id 0 lun 0x007a27c0d05d27c0 has a LUN larger than 
currently supported.
scsi: host 4 channel 0 id 0 lun 0x305e27c0907b27c0 has a LUN larger than 
currently supported.
scsi: host 4 channel 0 id 0 lun 0xf08227c0b08d27c0 has a LUN larger than 
currently supported.
scsi: host 4 channel 0 id 0 lun 0x307827c0008527c0 has a LUN larger than 
currently supported.
scsi: host 4 channel 0 id 0 lun 0x00000000b06727c0 has a LUN larger than 
currently supported.
scsi: host 4 channel 0 id 0 lun 0x306727c0706727c0 has a LUN larger than 
currently supported.
  Vendor: transtec  Model: T5008             Rev: 0001
  Type:   Direct-Access                      ANSI SCSI revision: 03
Unable to handle kernel NULL pointer dereference at virtual address 00000403
 printing eip:
f8a4de8e
*pde = 00000000
Oops: 0000 [#1]
SMP 
Modules linked in: aic79xx
CPU:    0
EIP:    0060:[<f8a4de8e>]    Not tainted VLI
EFLAGS: 00010246   (2.6.11.12-tc2) 
EIP is at ahd_send_async+0xde/0x2a0 [aic79xx]
eax: 0000000f   ebx: 00000042   ecx: f7f05d28   edx: 00000000
esi: 00000400   edi: f7f74000   ebp: 00000000   esp: f7f05c64
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 1081, threadinfo=f7f04000 task=f7ee1540)
Stack: c0135aae 0006162f 00000000 00000282 00000000 f7f05c88 00000050 00000000 
       00000000 00000001 c01230a0 00000001 f7f05d00 c0107376 f7f05d00 c03fb620 
       00000000 f7f05d0a ffffffff c038f3a0 20000000 f7323536 20000000 00000000 
Call Trace:
 [<c0135aae>] __do_IRQ+0x10e/0x160
 [<c01230a0>] do_timer+0xc0/0xd0
 [<c0107376>] timer_interrupt+0xb6/0x130
 [<c0135aae>] __do_IRQ+0x10e/0x160
 [<f8a2be35>] ahd_set_tags+0x55/0x70 [aic79xx]
 [<f8a4d107>] ahd_linux_device_queue_depth+0xa7/0xd0 [aic79xx]
 [<f8a4dc42>] ahd_linux_free_target+0x112/0x160 [aic79xx]
 [<f8a479d2>] ahd_linux_slave_configure+0x72/0xe0 [aic79xx]
 [<f8a47960>] ahd_linux_slave_configure+0x0/0xe0 [aic79xx]
 [<c02cb97a>] scsi_add_lun+0x2aa/0x300
 [<c02cbaa9>] scsi_probe_and_add_lun+0xd9/0x220
 [<c02cc090>] scsi_report_lun_scan+0x330/0x480
 [<c02cbac2>] scsi_probe_and_add_lun+0xf2/0x220
 [<c02cc3f2>] scsi_scan_target+0x102/0x130
 [<c02cc49a>] scsi_scan_channel+0x7a/0x90
 [<c02cc565>] scsi_scan_host_selected+0xb5/0xf0
 [<c02cc5cf>] scsi_scan_host+0x2f/0x40
 [<f8a497ae>] ahd_linux_register_host+0x21e/0x270 [aic79xx]
 [<c01916c8>] sysfs_add_file+0x58/0x80
 [<c019171e>] sysfs_create_file+0x2e/0x50
 [<c0247137>] pci_create_newid_file+0x27/0x30
 [<c024762e>] pci_register_driver+0x8e/0x90
 [<f8a4752c>] ahd_linux_detect+0x4c/0x70 [aic79xx]
 [<f8a6f00f>] ahd_linux_init+0xf/0x13 [aic79xx]
 [<c0132bc7>] sys_init_module+0x167/0x200
 [<c01027d3>] syscall_call+0x7/0xb
Code: c7 44 24 20 00 00 00 00 80 fb 42 0f b6 87 41 1d 00 00 8d 50 08 0f 44 c2 
8d 54 ed 00 01 d2 03 94 87 6c 18 00 00 8d b2 00 04 00 00 <0f> b6 56 03 3a 56 
09 0f 84 2b 01 00 00 a1 28 d1 a6 f8 85 c0 0f 



Even though there was an oops, the aic79xx module and the card still seem to 
work, we currently uncertain if we better should reboot again and/or try to 
use a newer kernel or can leave the system as it is without another reboot. 
Of course, we would also like to know the reason for the oops. Any help is 
appreciated.

Thanks in advance,
	Bernd


-- 
Bernd Schubert
Physikalisch Chemisches Institut / Theoretische Chemie
Universität Heidelberg
INF 229
69120 Heidelberg
e-mail: bernd.schubert@pci.uni-heidelberg.de
