Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269806AbRHINsJ>; Thu, 9 Aug 2001 09:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269807AbRHINr7>; Thu, 9 Aug 2001 09:47:59 -0400
Received: from ma-northadams1a-359.bur.adelphia.net ([24.52.175.103]:44549
	"EHLO ma-northadams1a-359.bur.adelphia.net") by vger.kernel.org
	with ESMTP id <S269806AbRHINrz>; Thu, 9 Aug 2001 09:47:55 -0400
Date: Thu, 9 Aug 2001 09:48:37 -0400
From: Eric Buddington <eric@ma-northadams1a-359.bur.adelphia.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.3-ac3: Oops while insmoding BusLogic over ide-scsi
Message-ID: <20010809094837.A24095@ma-northadams1a-359.bur.adelphia.net>
Reply-To: ebuddington@wesleyan.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: ECS Labs
X-Eric-Conspiracy: there is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.3-ac3 on a K6-2, kernel compiled with gcc-3.0

The following oops occurred after the following sequence:
	modprobe BusLogic
	rmmod ide-cd
	modprobe ide-scsi -> shows up in proc, but not as /dev/scsi/host1!
	rmmod BusLogic
	insmod BusLogic -> Oops!

And lsmod tells me:
	BusLogic               82976 (initializing)

Time to reboot...

-Eric


-------------------------------------------------------------
ksymoops 2.4.1 on i586 2.4.3-ac3.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.3-ac3/ (default)
     -m /packages/linux/2.4.3-ac3/k6/boot/System.map (specified)

Warning (compare_maps): snd symbol pm_register not found in /packages/linux/2.4.3-ac3/k6/lib/modules/2.4.3-ac3/misc/snd.o.  Ignoring /packages/linux/2.4.3-ac3/k6/lib/modules/2.4.3-ac3/misc/snd.o entry
Warning (compare_maps): snd symbol pm_send not found in /packages/linux/2.4.3-ac3/k6/lib/modules/2.4.3-ac3/misc/snd.o.  Ignoring /packages/linux/2.4.3-ac3/k6/lib/modules/2.4.3-ac3/misc/snd.o entry
Warning (compare_maps): snd symbol pm_unregister not found in /packages/linux/2.4.3-ac3/k6/lib/modules/2.4.3-ac3/misc/snd.o.  Ignoring /packages/linux/2.4.3-ac3/k6/lib/modules/2.4.3-ac3/misc/snd.o entry
Unable to handle kernel NULL pointer dereference at virtual address 000000c4
c8c9514b
Oops: 0002
CPU:    0
EIP:    0010:[<c8c9514b>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: 00000000   ecx: c0b3c105   edx: c5224800
esi: 00000000   edi: 00000001   ebp: 00000000   esp: c3db5ebc
ds: 0018   es: 0018   ss: 0018
Process modprobe (pid: 24471, stackpage=c3db5000)
Stack: c8c96e00 00000000 00000001 00000000 c3db5ed0 00000286 00000000 c8c62d5f 
       c8c99000 00000001 00000001 00014420 c3db5f14 00000000 00000000 00014420 
       00000c0e 00000286 00000213 c8c99000 00000001 00000001 00014420 c1044010 
Call Trace: [<c8c96e00>] [<c8c62d5f>] [<c8c99000>] [<c8c99000>] [<c8c633a6>] [<c8cac4a0>] [<c8ca4f0a>] 
       [<c8cac4a0>] [<c01155fd>] [<c8c59000>] [<c8c99060>] [<c0106cf3>] 
Code: c7 80 c4 00 00 00 00 08 00 00 80 4c 1a 12 01 a1 d4 70 c9 c8 

>>EIP; c8c9514b <[sr_mod]sr_finish+53/1ac>   <=====
Trace; c8c96e00 <[sr_mod]sr_template+0/0>
Trace; c8c62d5f <[scsi_mod]scsi_register_host+2b7/2f4>
Trace; c8c99000 <[sr_mod]__module_parm_xa_test+1f11/1f71>
Trace; c8c99000 <[sr_mod]__module_parm_xa_test+1f11/1f71>
Trace; c8c633a6 <[scsi_mod]scsi_register_module+2a/4c>
Trace; c8cac4a0 <[BusLogic]driver_template+0/6b>
Trace; c8ca4f0a <[BusLogic]init_this_scsi_driver+16/40>
Trace; c8cac4a0 <[BusLogic]driver_template+0/6b>
Trace; c01155fd <sys_init_module+505/5a0>
Trace; c8c59000 <[cdrom].bss.end+1845/18a5>
Trace; c8c99060 <[BusLogic]FlashPoint_ProbeHostAdapter+0/0>
Trace; c0106cf3 <system_call+33/40>
Code;  c8c9514b <[sr_mod]sr_finish+53/1ac>
00000000 <_EIP>:
Code;  c8c9514b <[sr_mod]sr_finish+53/1ac>   <=====
   0:   c7 80 c4 00 00 00 00      movl   $0x800,0xc4(%eax)   <=====
Code;  c8c95152 <[sr_mod]sr_finish+5a/1ac>
   7:   08 00 00 
Code;  c8c95155 <[sr_mod]sr_finish+5d/1ac>
   a:   80 4c 1a 12 01            orb    $0x1,0x12(%edx,%ebx,1)
Code;  c8c9515a <[sr_mod]sr_finish+62/1ac>
   f:   a1 d4 70 c9 c8            mov    0xc8c970d4,%eax


3 warnings issued.  Results may not be reliable.

