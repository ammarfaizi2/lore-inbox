Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266514AbSL2LQa>; Sun, 29 Dec 2002 06:16:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266520AbSL2LQa>; Sun, 29 Dec 2002 06:16:30 -0500
Received: from tag.witbe.net ([81.88.96.48]:7688 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id <S266514AbSL2LQ2>;
	Sun, 29 Dec 2002 06:16:28 -0500
From: "Paul Rolland" <rol@as2917.net>
To: <linux-kernel@vger.kernel.org>
Cc: <rol@as2917.net>
Subject: [2.5.53 Oops] Ide SCSI
Date: Sun, 29 Dec 2002 12:24:48 +0100
Message-ID: <009e01c2af2c$e5b6f5f0$2101a8c0@witbe>
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

When activating the IDE SCSI option to have Linux know everything 
about my IDE CD Recorder, I've an Oops at boot time.

Here are some details about my configuration :
 - Motherboard Asus P4S8X, P4 2.4 Ghz, 512 MB RAM
 - 1 SCSI Adaptec AHA 2944 U2W, driver AIC7XXX
 - 1 CDRW TDK 4800B
 - Some other IDE devices (IDE HD, IDE DVD)

Something that may help : There is an scsi PCI error Interrupt 
which is only present when boot with 2.5.53, never seen it before
with 2.4.xx...

The oops at boot time :
...
aic7xxx: PCI Device 0:8:0 failed memory mapped test.  Using PIO.
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.24
        <Adaptec 2940 Ultra2 SCSI adapter>
        aic7890/91: Ultra2 Wide Channel A, SCSI Id=7, 32/253 SCBs

scsi0: PCI error Interrupt at seqaddr = 0x3
scsi0: Signaled a Target Abort
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
c03171c4
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c03171c4>]    Not tainted
EFLAGS: 00010082
eax: 00000015   ebx: 00000082   ecx: dfc4b800   edx: 00000000
esi: 00000007   edi: dfc61b80   ebp: c057479c   esp: c17e9f74
ds: 0068   es: 0068   ss: 0068
Process scsi_eh_1 (pid: 11, threadinfo=c17e8000 task=c17e7980)
Stack: c046fa00 00000015 00000202 dfcc3580 c17e9fd4 00000000 c02ea550
dfc4b800 
       dfc4b800 c02ea659 dfc4b800 dfcc3580 dfcc3580 dfcc3580 c02eadaa
dfc4b800 
       dfcc3580 c0109bbf dfc4b800 c17e8000 c02eaeb7 dfcc3580 c047ee77
00000001 
Call Trace: [<c02ea550>]  [<c02ea659>]  [<c02eadaa>]  [<c0109bbf>]
[<c02eaeb7>]  [<c02eadf4>]  [<c0108b9d>] 
Code: 39 42 30 74 36 89 2c 24 e8 a5 5d f9 ff 85 c0 75 21 53 9d b8 
 
The oops decoded :

8 [12:19] rol@donald:~> more oops-idescsi.decode
ksymoops 2.4.8 on i686 2.4.20.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -K (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20/ (default)
     -m /boot/System.map-2.5.53 (specified)

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel NULL pointer dereference at virtual address
00000030
c03171c4
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c03171c4>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010082
eax: 00000015   ebx: 00000082   ecx: dfc4b800   edx: 00000000
esi: 00000007   edi: dfc61b80   ebp: c057479c   esp: c17e9f74
ds: 0068   es: 0068   ss: 0068
Stack: c046fa00 00000015 00000202 dfcc3580 c17e9fd4 00000000 c02ea550
dfc4b800 
       dfc4b800 c02ea659 dfc4b800 dfcc3580 dfcc3580 dfcc3580 c02eadaa
dfc4b800 
       dfcc3580 c0109bbf dfc4b800 c17e8000 c02eaeb7 dfcc3580 c047ee77
00000001 
Call Trace: [<c02ea550>]  [<c02ea659>]  [<c02eadaa>]  [<c0109bbf>]
[<c02eaeb7>]
  [<c02eadf4>]  [<c0108b9d>] 
Code: 39 42 30 74 36 89 2c 24 e8 a5 5d f9 ff 85 c0 75 21 53 9d b8 


>>EIP; c03171c4 <idescsi_abort+52/9e>   <=====

>>ebp; c057479c <ide_hwifs+a5c/4920>

Trace; c02ea550 <scsi_try_to_abort_cmd+48/4c>
Trace; c02ea659 <scsi_eh_abort_cmd+33/64>
Trace; c02eadaa <scsi_unjam_host+9e/e8>
Trace; c0109bbf <__down_failed_interruptible+7/c>
Trace; c02eaeb7 <scsi_error_handler+c3/f2>
Trace; c02eadf4 <scsi_error_handler+0/f2>
Trace; c0108b9d <kernel_thread_helper+5/c>

Code;  c03171c4 <idescsi_abort+52/9e>
00000000 <_EIP>:
Code;  c03171c4 <idescsi_abort+52/9e>   <=====
   0:   39 42 30                  cmp    %eax,0x30(%edx)   <=====
Code;  c03171c7 <idescsi_abort+55/9e>
   3:   74 36                     je     3b <_EIP+0x3b>
Code;  c03171c9 <idescsi_abort+57/9e>
   5:   89 2c 24                  mov    %ebp,(%esp,1)
Code;  c03171cc <idescsi_abort+5a/9e>
   8:   e8 a5 5d f9 ff            call   fff95db2 <_EIP+0xfff95db2>
Code;  c03171d1 <idescsi_abort+5f/9e>
   d:   85 c0                     test   %eax,%eax
Code;  c03171d3 <idescsi_abort+61/9e>
   f:   75 21                     jne    32 <_EIP+0x32>
Code;  c03171d5 <idescsi_abort+63/9e>
  11:   53                        push   %ebx
Code;  c03171d6 <idescsi_abort+64/9e>
  12:   9d                        popf   
Code;  c03171d7 <idescsi_abort+65/9e>
  13:   b8 00 00 00 00            mov    $0x0,%eax

Hope this helps,

Regards,
Paul Rolland, rol@as2917.net

