Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281051AbRKTMcL>; Tue, 20 Nov 2001 07:32:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281052AbRKTMcC>; Tue, 20 Nov 2001 07:32:02 -0500
Received: from zeus.kernel.org ([204.152.189.113]:24034 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S281051AbRKTMbr>;
	Tue, 20 Nov 2001 07:31:47 -0500
Date: Tue, 20 Nov 2001 13:30:33 +0100 (MET)
From: Andreas Busch <abusch@gmx.net>
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: [oops] 2.4.13 kswapd invalid operand: 0000 (same stackpage as 2.4.12i before)
X-Priority: 3 (Normal)
X-Authenticated-Sender: #0000109679@gmx.net
X-Authenticated-IP: [194.15.145.12]
Message-ID: <24456.1006259433@www55.gmx.net>
X-Mailer: WWW-Mail 1.5 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rik,

I posted the [oops] 2.4.12+i kswapd invalid operand: 0000 on october 22nd.
That time I used the crypto patches and NVidia, but I couldn't
reproduce the problem. This time it's on 2.4.13 without cryptopatch
but with loaded NVidia-driver again, sorry.

The fascinating point is that it's the same stackpage again !

ksymoops 2.4.1 on i686 2.4.13.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.13/ (default)
     -m /boot/System.map-2.4.13 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_Version): Version mismatch.  NVdriver says 2.4.13,
pwcx-i386 says 2.4.6.  Expect lots of address mismatches.
Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base says
c01fc890, System.map says c014ce90.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol proc_scsi  , scsi_mod says
d9c7d6c0, /lib/modules/2.4.13/kernel/drivers/scsi/scsi_mod.o says d9c7d124. 
Ignoring /lib/modules/2.4.13/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_devicelist  , scsi_mod says
d9c7d6ec, /lib/modules/2.4.13/kernel/drivers/scsi/scsi_mod.o says d9c7d150. 
Ignoring /lib/modules/2.4.13/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_hostlist  , scsi_mod says
d9c7d6e8, /lib/modules/2.4.13/kernel/drivers/scsi/scsi_mod.o says d9c7d14c. 
Ignoring /lib/modules/2.4.13/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_hosts  , scsi_mod says
d9c7d6f0, /lib/modules/2.4.13/kernel/drivers/scsi/scsi_mod.o says d9c7d154. 
Ignoring /lib/modules/2.4.13/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol usb_devfs_handle  , usbcore says
d9902234, /lib/modules/2.4.13/kernel/drivers/usb/usbcore.o says d9901d54. 
Ignoring /lib/modules/2.4.13/kernel/drivers/usb/usbcore.o entry
Nov 19 23:39:46 zuse1 kernel: invalid operand: 0000
Nov 19 23:39:46 zuse1 kernel: CPU:    0
Nov 19 23:39:46 zuse1 kernel: EIP:    0010:[__free_pages_ok+27/480]   
Tainted: PF
Nov 19 23:39:46 zuse1 kernel: EIP:    0010:[<c012c26b>]    Tainted: PF
Using defaults from ksymoops -t elf32-i386 -a i386
Nov 19 23:39:46 zuse1 kernel: EFLAGS: 00010282
Nov 19 23:39:46 zuse1 kernel: eax: c13ea3c0   ebx: 00000000   ecx: c13ea3c0 
 edx: cff446b0
Nov 19 23:39:46 zuse1 kernel: esi: c13ea3c0   edi: 0000000f   ebp: 00000000 
 esp: c1435f08
Nov 19 23:39:46 zuse1 kernel: ds: 0018   es: 0018   ss: 0018
Nov 19 23:39:46 zuse1 kernel: Process kswapd (pid: 5, stackpage=c1435000)
Nov 19 23:39:46 zuse1 kernel: Stack: c1040000 c02a1680 000001d0 c13ea3c0
000001d0 c13ea3c0 0000000f 00000013 
Nov 19 23:39:46 zuse1 kernel:        c012b9e1 00000000 c1434000 c02a1668
000007f9 c14070a0 c303e340 c1407490 
Nov 19 23:39:46 zuse1 kernel:        00000001 00000020 000001d0 00000006
00005fb4 c012bc9b 000001d0 0000000c 
Nov 19 23:39:46 zuse1 kernel: Call Trace: [shrink_cache+497/816]
[shrink_caches+91/144] [try_to_free_pages+44/96] [kswapd_balance_pgdat+81/160]
[kswapd_balance+38/80] 
Nov 19 23:39:46 zuse1 kernel: Call Trace: [<c012b9e1>] [<c012bc9b>]
[<c012bcfc>] [<c012bdb1>] [<c012be26>] 
Nov 19 23:39:46 zuse1 kernel:    [<c012bf71>] [<c012bed0>] [<c0105000>]
[<c0105516>] [<c012bed0>] 
Nov 19 23:39:47 zuse1 kernel: Code: 0f 0b 8b 0d ec 1e 30 c0 89 f0 29 c8 c1
f8 06 3b 05 e0 1e 30 

>>EIP; c012c26b <__free_pages_ok+1b/1e0>   <=====
Trace; c012b9e1 <shrink_cache+1f1/330>
Trace; c012bc9b <shrink_caches+5b/90>
Trace; c012bcfc <try_to_free_pages+2c/60>
Trace; c012bdb1 <kswapd_balance_pgdat+51/a0>
Trace; c012be26 <kswapd_balance+26/50>
Trace; c012bf71 <kswapd+a1/c0>
Trace; c012bed0 <kswapd+0/c0>
Trace; c0105000 <_stext+0/0>
Trace; c0105516 <kernel_thread+26/30>
Trace; c012bed0 <kswapd+0/c0>
Code;  c012c26b <__free_pages_ok+1b/1e0>
00000000 <_EIP>:
Code;  c012c26b <__free_pages_ok+1b/1e0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012c26d <__free_pages_ok+1d/1e0>
   2:   8b 0d ec 1e 30 c0         mov    0xc0301eec,%ecx
Code;  c012c273 <__free_pages_ok+23/1e0>
   8:   89 f0                     mov    %esi,%eax
Code;  c012c275 <__free_pages_ok+25/1e0>
   a:   29 c8                     sub    %ecx,%eax
Code;  c012c277 <__free_pages_ok+27/1e0>
   c:   c1 f8 06                  sar    $0x6,%eax
Code;  c012c27a <__free_pages_ok+2a/1e0>
   f:   3b 05 e0 1e 30 00         cmp    0x301ee0,%eax

Nov 20 01:35:25 zuse1 kernel: cpu: 0, clocks: 668206, slice: 334103
Nov 20 01:35:29 zuse1 kernel:   Receiver lock-up bug exists -- enabling
work-around.
Nov 20 01:35:31 zuse1 kernel: UDF-fs DEBUG
lowlevel.c:65:udf_get_last_session: CDROMMULTISESSION not supported: rc=-5
Nov 20 01:35:31 zuse1 kernel: UDF-fs DEBUG super.c:1414:udf_read_super:
Multi-session=0
Nov 20 01:35:31 zuse1 kernel: UDF-fs DEBUG super.c:409:udf_vrs: Starting at
sector 16 (2048 byte sectors)
Nov 20 01:36:13 zuse1 kernel: ac97_codec: AC97 Audio codec, id:
0x8384:0x7608 (SigmaTel STAC9708)

8 warnings issued.  Results may not be reliable.


Andy.


-- 
GMX - Die Kommunikationsplattform im Internet.
http://www.gmx.net

