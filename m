Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264647AbTAEKxC>; Sun, 5 Jan 2003 05:53:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264649AbTAEKxC>; Sun, 5 Jan 2003 05:53:02 -0500
Received: from tag.witbe.net ([81.88.96.48]:51463 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id <S264647AbTAEKxA>;
	Sun, 5 Jan 2003 05:53:00 -0500
From: "Paul Rolland" <rol@witbe.net>
To: <linux-kernel@vger.kernel.org>
Subject: [2.5.54] Oops IDE-SCSI and failure AIC7xxx
Date: Sun, 5 Jan 2003 12:01:34 +0100
Organization: Witbe.net
Message-ID: <012a01c2b4a9$cfe095b0$2101a8c0@witbe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here is the copy of a boot sequence using kernel 2.5.54 :
aic7xxx: PCI Device 0:8:0 failed memory mapped test.  Using PIO.
scsi0: PCI error Interrupt at seqaddr = 0x3
scsi0: Signaled a Target Abort
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.25
        <Adaptec 2940 Ultra2 SCSI adapter>
        aic7890/91: Ultra2 Wide Channel A, SCSI Id=7, 32/253 SCBs

(scsi0:A:0): 40.000MB/s transfers (20.000MHz, offset 127, 16bit)
  Vendor: FUJITSU   Model: MAN3367MP         Rev: 5507
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:0:0: Tagged Queuing enabled.  Depth 64
scsi1 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: TDK       Model: CDRW4800B         Rev: S7S3
  Type:   CD-ROM                             ANSI SCSI revision: 02
ide-scsi: abort called for 21
Unable to handle kernel NULL pointer dereference at virtual address
00000030
 printing eip:
c030802c
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c030802c>]    Not tainted
EFLAGS: 00010082
Unable to handle kernel paging request at virtual address ffffff8d
 printing eip:
c012ecc7
*pde = 00001067
*pte = 00000000
Oops: 0002
CPU:    0
EIP:    0060:[<c012ecc7>]    Not tainted
EFLAGS: 00010006

Out of this, two problems :
 - AIC7xxx fails to use DMA, with :
aic7xxx: PCI Device 0:8:0 failed memory mapped test.  Using PIO.
scsi0: PCI error Interrupt at seqaddr = 0x3
scsi0: Signaled a Target Abort

 - IDE scsi oops at boot.
7 [12:01] rol@donald:~> ksymoops -v /usr/src/linux/vmlinux -m
/boot/System.map-2.5.54 -K < oops-idescsi2
ksymoops 2.4.8 on i686 2.4.20.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -K (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20/ (default)
     -m /boot/System.map-2.5.54 (specified)

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel NULL pointer dereference at virtual address
00000030
c030802c
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c030802c>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010082
Warning (Oops_read): Code line not seen, dumping what data is available


>>EIP; c030802c <idescsi_abort+74/108>   <=====


1 warning issued.  Results may not be reliable.

Regards,
Paul Rolland, rol@as2917.net

