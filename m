Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130108AbQL2JWc>; Fri, 29 Dec 2000 04:22:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129352AbQL2JWR>; Fri, 29 Dec 2000 04:22:17 -0500
Received: from netsrvr.ami.com.au ([203.55.31.38]:13604 "EHLO
	netsrvr.ami.com.au") by vger.kernel.org with ESMTP
	id <S130108AbQL2JWM>; Fri, 29 Dec 2000 04:22:12 -0500
Date: Fri, 29 Dec 2000 08:52:00 +0800
From: John Summerfield <summer@os2.ami.com.au>
Message-Id: <200012290052.IAA08785@dugite.os2.ami.com.au>
to: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
subject: kernel BUG at buffer.c:765
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[root@dugite /root]# sfdisk -l /dev/sda
ll_rw_block: device 08:00: only 2048-char blocks implemented (1024)
kernel BUG at buffer.c:765!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c012f0cd>]
EFLAGS: 00010282
eax: 0000001c   ebx: c1b91ac8   ecx: c029ca68   edx: c029ca68
esi: 00000001   edi: 00000001   ebp: c1f55f2c   esp: c1f55ef0
ds: 0018   es: 0018   ss: 0018
Process sfdisk (pid: 1323, stackpage=c1f55000)
Stack: c024aba5 c024ae5a 000002fd c1b91a80 c017a4c4 c1b91a80 00000000 00000000
       bffffaa8 c1f55f78 c1215400 c012f663 00000000 00000001 c1f55f2c c1b91a80
       c01c8a68 00000800 00000000 00000400 00000000 bffffaa8 bffffaa8 00000800
Call Trace: [<c024aba5>] [<c024ae5a>] [<c017a4c4>] [<c012f663>] [<c01c8a68>] [<c01ce84e>] [<c01349b1>]
       [<c013ad96>] [<c010a933>]
Code: 0f 0b 83 c4 0c 5b c3 55 57 56 53 8b 74 24 14 8b 54 24 18 85
eth0: Abnormal interrupt, status 00000051.
eth0: Abnormal interrupt, status 00000010.
eth0: Abnormal interrupt, status 00000020.
Segmentation fault
[root@dugite /root]# uname -a
Linux dugite 2.4.0-test12 #11 Wed Dec 20 16:28:41 WST 2000 i586 unknown
[root@dugite /root]# 

lspci says:

00:0b.0 SCSI storage controller: Adaptec AHA-294x / AIC-7871 (rev 03)

relevant kernel boot-time messages

Dec 28 15:10:13 dugite kernel: PCI: Found IRQ 10 for device 00:0b.0
Dec 28 15:10:13 dugite kernel: (scsi0) <Adaptec AHA-294X SCSI host adapter> found at PCI 0/11/0
Dec 28 15:10:13 dugite kernel: (scsi0) Narrow Channel, SCSI ID=7, 16/255 SCBs
Dec 28 15:10:13 dugite kernel: (scsi0) Downloading sequencer code... 415 instructions downloaded
Dec 28 15:10:13 dugite kernel: scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.1/5.2.0
Dec 28 15:10:13 dugite kernel:        <Adaptec AHA-294X SCSI host adapter>
Dec 28 15:10:13 dugite kernel: (scsi0:0:0:0) Synchronous at 10.0 Mbyte/sec, offset 10.
Dec 28 15:10:13 dugite kernel:   Vendor: FUJITSU   Model: M2513A            Rev: 1200
Dec 28 15:10:13 dugite kernel:   Type:   Direct-Access                      ANSI SCSI revision: 01
Dec 28 15:10:13 dugite kernel: (scsi0:0:4:0) Synchronous at 5.0 Mbyte/sec, offset 15.
Dec 28 15:10:13 dugite kernel:   Vendor: CONNER    Model: CTT8000-S         Rev: 1.17
Dec 28 15:10:13 dugite kernel:   Type:   Sequential-Access                  ANSI SCSI revision: 02
Dec 28 15:10:13 dugite kernel: Detected scsi tape st0 at scsi0, channel 0, id 4, lun 0
Dec 28 15:10:13 dugite kernel: st: bufsize 32768, wrt 30720, max init. buffers 4, s/g segs 16.
Dec 28 15:10:13 dugite kernel: Detected scsi removable disk sda at scsi0, channel 0, id 0, lun 0
Dec 28 15:10:13 dugite kernel: SCSI device sda: 310352 2048-byte hdwr sectors (636 MB)
Dec 28 15:10:13 dugite kernel: sda: Write Protect is off
Dec 28 15:10:13 dugite kernel:  sda: sda1


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
