Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130683AbRCEVbr>; Mon, 5 Mar 2001 16:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130684AbRCEVbi>; Mon, 5 Mar 2001 16:31:38 -0500
Received: from sheffield.concentric.net ([207.155.252.12]:16114 "EHLO
	sheffield.cnchost.com") by vger.kernel.org with ESMTP
	id <S130683AbRCEVbZ>; Mon, 5 Mar 2001 16:31:25 -0500
Message-ID: <3AA405AA.136EEFFC@aerizen.com>
Date: Mon, 05 Mar 2001 13:31:22 -0800
From: John Silva <jps@aerizen.com>
Organization: None
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.18-14mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: OOPS in 2.2.18-14mdk RAID code
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recieved this oops after rearranging my SMP system to include a large
(>100GB) raid5 array and copying approximately 15GB to it.  The array
was still synchronizing at the time.

Motherboard is MSI 694D.  RAID array in question is attached to the
Promise 20265 chipset.  No drives were attached to the VIA
IDE controller.

Anyone knowledgable have any ideas?  I have not seen this since.

[jsilva@tetsuo jsilva]$ uname -a
Linux tetsuo.concentric.net 2.2.18-14mdksmp #1 SMP Thu Feb 22 19:02:28
CET 2001 i686 unknown
[jsilva@tetsuo jsilva]$ cat /proc/ide/pdc202xx

                                PDC20265 Chipset.
------------------------------- General Status
---------------------------------
Burst Mode                           : enabled
Host Mode                            : Normal
Bus Clocking                         : 66 External
IO pad select                        : 10 mA
Status Polling Period                : 7
Interrupt Check Status Polling Delay : 15
--------------- Primary Channel ---------------- Secondary Channel
-------------
                enabled                          enabled
66 Clocking     enabled                          enabled
           Mode MASTER                      Mode MASTER
                FIFO Empty                       FIFO Empty
--------------- drive0 --------- drive1 -------- drive0 ----------
drive1 ------
DMA enabled:    yes              yes             yes               yes
DMA Mode:       UDMA 4           UDMA 4          UDMA 4            UDMA
4
PIO Mode:       PIO 4            PIO 4           PIO 4            PIO 4
[jsilva@tetsuo jsilva]$ cat /proc/ide/hde/model
IBM-DTLA-307045
[jsilva@tetsuo jsilva]$ cat /proc/ide/hd?/model
Pioneer DVD-ROM ATAPIModel DVD-114 0203
CREATIVEDVD-ROM DVD2240E 03/18/98
IBM-DTLA-307045
IBM-DTLA-307045
IBM-DTLA-307045
IBM-DTLA-307045
[jsilva@tetsuo jsilva]$

[jsilva@tetsuo jsilva]$ cat /OOPS
Oops: 0000
CPU: 0
EIP: 0010:[<c0116c59>]
EFLAGS: 00010206
 eax: dc7456f0 ebx: 07d000ab ecx: 00000004 edx: 0871010a
 ds: 0018 es:0018 ss:0018
Process raid5d (pid: 595, process nr: 10, stackpage=cfcf5000)
Stack: c0ad6aac 00000003 00000000 c013c07a 00000000 e00a7883 dc7456c0
00000001
  c0ad6a00 cad4e000 c0ad6a00 caf42e00 c0ad6a00 000003cf c0ad6aac
c0ad6a4c
  00000000 00000004 e00a79fc c0ad6a00 c0adca00 caf42e00 00000000
000003cf
Call Trace: [<c0130c7a>] [<e00a7783>] [<e00a79fc>] [<c01909fc>]
[<c010c815>] [<e00a88a7>] [<c0198a58>]
 [<c010903b>]
Code: 8b 02 85 45 fc 74 f0 8b 02 a8 20 74 0a 85 ff 75 e6 bf 01 00

[jsilva@tetsuo jsilva]$ cat /OOPS.out
ksymoops 2.3.7 on i686 2.2.18-14mdksmp.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.2.18-14mdksmp/ (default)
     -m /boot/System.map (specified)

Warning (compare_maps): ksyms_base symbol module_list_R__ver_module_list
not found in System.map.  Ignoring ksyms_base entry
Oops:   0000
CPU:    0
EIP:    0010:[<c0116c59>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
        eax: dc7456f0  ebx: 07d000ab    ecx: 00000004      edx: 0871010a

        ds: 0018       es:0018       ss:0018
Process raid5d (pid: 595, process nr: 10, stackpage=cfcf5000)
Stack:  c0ad6aac 00000003 00000000 c013c07a 00000000 e00a7883 dc7456c0
00000001
               c0ad6a00 cad4e000 c0ad6a00 caf42e00 c0ad6a00 000003cf
c0ad6aac c0ad6a4c
               00000000 00000004 e00a79fc c0ad6a00 c0adca00 caf42e00
00000000 000003cf
Call Trace: [<c0130c7a>] [<e00a7783>] [<e00a79fc>] [<c01909fc>]
[<c010c815>] [<e00a88a7>] [<c0198a58>]
        [<c010903b>]
Code:   8b 02 85 45 fc 74 f0 8b 02 a8 20 74 0a 85 ff 75 e6 bf 01 00

>>EIP; c0116c59 <__wake_up+31/7c>   <=====
Trace; c0130c7a <end_buffer_io_sync+2a/2c>
Trace; e00a7783 <[raid5]complete_stripe+c7/18c>
Trace; e00a79fc <[raid5]handle_stripe+15c/cf4>
Trace; c01909fc <ide_do_request+2d8/330>
Trace; c010c815 <__global_restore_flags+25/44>
Trace; e00a88a7 <[raid5]raid5d+b7/10c>
Trace; c0198a58 <md_thread+d8/1ac>
Trace; c010903b <kernel_thread+23/30>
Code;  c0116c59 <__wake_up+31/7c>
00000000 <_EIP>:
Code;  c0116c59 <__wake_up+31/7c>   <=====
   0:   8b 02                     mov    (%edx),%eax   <=====
Code;  c0116c5b <__wake_up+33/7c>
   2:   85 45 fc                  test   %eax,0xfffffffc(%ebp)
Code;  c0116c5e <__wake_up+36/7c>
   5:   74 f0                     je     fffffff7 <_EIP+0xfffffff7>
c0116c50 <__wake_up+28/7c>
Code;  c0116c60 <__wake_up+38/7c>
   7:   8b 02                     mov    (%edx),%eax
Code;  c0116c62 <__wake_up+3a/7c>
   9:   a8 20                     test   $0x20,%al
Code;  c0116c64 <__wake_up+3c/7c>
   b:   74 0a                     je     17 <_EIP+0x17> c0116c70
<__wake_up+48/7c>
Code;  c0116c66 <__wake_up+3e/7c>
   d:   85 ff                     test   %edi,%edi
Code;  c0116c68 <__wake_up+40/7c>
   f:   75 e6                     jne    fffffff7 <_EIP+0xfffffff7>
c0116c50 <__wake_up+28/7c>
Code;  c0116c6a <__wake_up+42/7c>
  11:   bf 01 00 00 00            mov    $0x1,%edi


1 warning issued.  Results may not be reliable.
[jsilva@tetsuo jsilva]$



