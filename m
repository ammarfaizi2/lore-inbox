Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318783AbSIISbF>; Mon, 9 Sep 2002 14:31:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318785AbSIISbE>; Mon, 9 Sep 2002 14:31:04 -0400
Received: from horkos.telenet-ops.be ([195.130.132.45]:48602 "EHLO
	horkos.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S318783AbSIISbA>; Mon, 9 Sep 2002 14:31:00 -0400
Subject: 2.4.19: Oops, probably related to SCSI?
From: Frederik Himpe <fhimpe@pandora.be>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8-3mdk 
Date: 09 Sep 2002 20:35:38 +0200
Message-Id: <1031596539.2580.12.camel@Jupiter>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have an Agfa SnapScan 1236s connected to an Adaptec AVA-1505AE ISA
SCSI card (using the aha150x driver). When I try to scan something with
xsane, the kernel (Linux 2.4.19 with XFS patches) oopses.

I have analysed the oops with ksymoops. Here is the output:

ksymoops 2.4.5 on i686 2.4.19-xfs.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19-xfs/ (default)
     -m /boot/System.map-2.4.19-xfs (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Sep  9 18:41:57 Jupiter kernel: Unable to handle kernel NULL pointer
dereference at virtual address 0000001b
Sep  9 18:41:57 Jupiter kernel: d08f22a0
Sep  9 18:41:57 Jupiter kernel: *pde = 00000000
Sep  9 18:41:57 Jupiter kernel: Oops: 0000
Sep  9 18:41:57 Jupiter kernel: CPU:    0
Sep  9 18:41:57 Jupiter kernel: EIP:   
0010:[keybdev:__insmod_keybdev_O/lib/modules/2.4.19-xfs/kernel/drivers/in+-1678688/96]    Not tainted
Sep  9 18:41:57 Jupiter kernel: EIP:    0010:[<d08f22a0>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Sep  9 18:41:57 Jupiter kernel: EFLAGS: 00010002
Sep  9 18:41:57 Jupiter kernel: eax: 00000000   ebx: c5ca3000   ecx:
cec32000   edx: c5528500
Sep  9 18:41:57 Jupiter kernel: esi: cf6df400   edi: 00000004   ebp:
c5d83d88   esp: c5d83d6c
Sep  9 18:41:57 Jupiter kernel: ds: 0018   es: 0018   ss: 0018
Sep  9 18:41:57 Jupiter kernel: Process xsane (pid: 2478,
stackpage=c5d83000)
Sep  9 18:41:57 Jupiter kernel: Stack: cfffc0c0 00000020 c010d098
00000297 00000293 c7f7e514 c5ca3000 c5d83da4 
Sep  9 18:41:57 Jupiter kernel:        d08f23c0 c5ca3000 00000000
00000000 00000000 d08d9f70 c5d83de0 d08d9684 
Sep  9 18:41:57 Jupiter kernel:        c5ca3000 d08d9f70 d08de760
00000004 c7f7e576 c7f7e4c0 c7f7e514 cf8971a0 
Sep  9 18:41:57 Jupiter kernel: Call Trace:    [IRQ0x7c_interrupt+8/16]
[keybdev:__insmod_keybdev_O/lib/modules/2.4.19-xfs/kernel/drivers/in+-1678400/96] [keybdev:__insmod_keybdev_O/lib/modules/2.4.19-xfs/kernel/drivers/in+-1777808/96] [keybdev:__insmod_keybdev_O/lib/modules/2.4.19-xfs/kernel/drivers/in+-1780092/96] [keybdev:__insmod_keybdev_O/lib/modules/2.4.19-xfs/kernel/drivers/in+-1777808/96]
Sep  9 18:41:57 Jupiter kernel: Call Trace:    [<c010d098>] [<d08f23c0>]
[<d08d9f70>] [<d08d9684>] [<d08d9f70>]
Sep  9 18:41:57 Jupiter kernel:   [<d08de760>] [<d08e22ce>] [<d23e9628>]
[<d08e1765>] [<d08e17f9>] [<d08d9a7a>]
Sep  9 18:41:57 Jupiter kernel:   [<d23ea2e0>] [<d23e90b2>] [<d23ea2e0>]
[<d23e8df3>] [<d23e8bd7>] [<c013ce3c>]
Sep  9 18:41:57 Jupiter kernel:   [<c0109307>]
Sep  9 18:41:57 Jupiter kernel: Code: 0f b6 50 1b 8b 14 95 d8 b5 30 c0
2b 82 9c 00 00 00 c1 f8 02 


>>EIP; d08f22a0 <[scsi_mod].bss.end+251d/b2dd>   <=====

>>ebx; c5ca3000 <_end+597013c/1059d19c>
>>ecx; cec32000 <_end+e8ff13c/1059d19c>
>>edx; c5528500 <_end+51f563c/1059d19c>
>>esi; cf6df400 <_end+f3ac53c/1059d19c>
>>ebp; c5d83d88 <_end+5a50ec4/1059d19c>
>>esp; c5d83d6c <_end+5a50ea8/1059d19c>

Trace; c010d098 <call_do_IRQ+5/d>
Trace; d08f23c0 <[scsi_mod].bss.end+263d/b2dd>
Trace; d08d9f70 <[scsi_mod]scsi_done+0/d0>
Trace; d08d9684 <[scsi_mod]scsi_dispatch_cmd+124/390>
Trace; d08d9f70 <[scsi_mod]scsi_done+0/d0>
Trace; d08de760 <[scsi_mod]scsi_times_out+0/d0>
Trace; d08e22ce <[scsi_mod]scsi_request_fn+18e/310>
Trace; d23e9628 <[sg]sg_ioctl+4e8/c60>
Trace; d08e1765 <[scsi_mod]__scsi_insert_special+55/80>
Trace; d08e17f9 <[scsi_mod]scsi_insert_special_req+29/30>
Trace; d08d9a7a <[scsi_mod]scsi_do_req+da/1c0>
Trace; d23ea2e0 <[sg]sg_cmd_done_bh+0/370>
Trace; d23e90b2 <[sg]sg_common_write+202/290>
Trace; d23ea2e0 <[sg]sg_cmd_done_bh+0/370>
Trace; d23e8df3 <[sg]sg_new_write+1c3/280>
Trace; d23e8bd7 <[sg]sg_write+2f7/350>
Trace; c013ce3c <sys_write+9c/130>
Trace; c0109307 <system_call+33/38>

Code;  d08f22a0 <[scsi_mod].bss.end+251d/b2dd>
00000000 <_EIP>:
Code;  d08f22a0 <[scsi_mod].bss.end+251d/b2dd>   <=====
   0:   0f b6 50 1b               movzbl 0x1b(%eax),%edx   <=====
Code;  d08f22a4 <[scsi_mod].bss.end+2521/b2dd>
   4:   8b 14 95 d8 b5 30 c0      mov    0xc030b5d8(,%edx,4),%edx
Code;  d08f22ab <[scsi_mod].bss.end+2528/b2dd>
   b:   2b 82 9c 00 00 00         sub    0x9c(%edx),%eax
Code;  d08f22b1 <[scsi_mod].bss.end+252e/b2dd>
  11:   c1 f8 02                  sar    $0x2,%eax


1 warning issued.  Results may not be reliable.

