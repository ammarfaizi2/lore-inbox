Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292212AbSBBDhA>; Fri, 1 Feb 2002 22:37:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292213AbSBBDgw>; Fri, 1 Feb 2002 22:36:52 -0500
Received: from mx1.fuse.net ([216.68.2.90]:31375 "EHLO mta01.fuse.net")
	by vger.kernel.org with ESMTP id <S292212AbSBBDgo>;
	Fri, 1 Feb 2002 22:36:44 -0500
Message-ID: <3C5B5EC0.40503@fuse.net>
Date: Fri, 01 Feb 2002 22:36:32 -0500
From: Nathan <wfilardo@fuse.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20020121
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: Issues with 2.5.3-dj1
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

System is a Sony VAIO R505JE, kernel 2.5.3-dj1 + preempt + acpi + acpi 
pci irq routing.  Debian unstable, updated today.

1: USB dies a very similar death in 2.5.3-dj1 as it did in 2.5.2-dj6 
(OOPS below and in previous mail).  What else can I provide?

Feb  1 12:11:13 Vivations kernel: usb.c: USB disconnect on device 1
Feb  1 12:11:13 Vivations kernel: usb.c: USB bus 1 deregistered
Feb  1 12:11:13 Vivations kernel: usb.c: USB disconnect on device 1
Feb  1 12:11:13 Vivations kernel: usb.c: USB disconnect on device 2
Feb  1 12:11:13 Vivations kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 00000032
Feb  1 12:11:13 Vivations kernel:  printing eip:
Feb  1 12:11:13 Vivations kernel: c0153caa
Feb  1 12:11:13 Vivations kernel: *pde = 00000000
Feb  1 12:11:13 Vivations kernel: Oops: 0000
Feb  1 12:11:13 Vivations kernel: CPU:    0
Feb  1 12:11:13 Vivations kernel: EIP:    0010:[<c0153caa>]    Tainted: P
Feb  1 12:11:13 Vivations kernel: EFLAGS: 00010202
Feb  1 12:11:13 Vivations kernel: eax: cf207260   ebx: 00000003   ecx: 
00000000   edx: ce436320
Feb  1 12:11:13 Vivations kernel: esi: 00000000   edi: 00000000   ebp: 
ce436320   esp: ce11ff54
Feb  1 12:11:13 Vivations kernel: ds: 0018   es: 0018   ss: 0018
Feb  1 12:11:13 Vivations kernel: Process usb.agent (pid: 1056, 
stackpage=ce11f000)
Feb  1 12:11:13 Vivations kernel: Stack: 00000003 ce436320 00000000 
00000001 00000001 c013c01a 00000000 ce436320
Feb  1 12:11:13 Vivations kernel:        00000000 00000003 cfb7e1e0 
00000000 c011dcf9 ce436320 cfb7e1e0 ce11e000
Feb  1 12:11:13 Vivations kernel:        cfb7e1e0 ce11e000 bffff95c 
cfb7e300 c011e597 ce11e000 4017f384 00000000
Feb  1 12:11:13 Vivations kernel: Call Trace: [<c013c01a>] [<c011dcf9>] 
[<c011e597>] [<c011e7ce>] [<c0108a1b>]
Feb  1 12:11:13 Vivations kernel:
Feb  1 12:11:13 Vivations kernel: Code: 0f b7 46 32 25 00 f0 ff ff 66 3d 
00 40 74 0a b8 ec ff ff ff

 >>EIP; c01ceb54 <is_read_only+c/40>   <=====
Trace; c01cec8c <blkdev_release_request+10/74>
Trace; c014096e <kupdate+4e/164>
Trace; c0107058 <exit_thread+0/4>
Code;  c01ceb54 <is_read_only+c/40>
00000000 <_EIP>:
Code;  c01ceb54 <is_read_only+c/40>   <=====
   0:   0f b7 40 32               movzwl 0x32(%eax),%eax   <=====
Code;  c01ceb58 <is_read_only+10/40>
   4:   25 00 f0 ff ff            and    $0xfffff000,%eax
Code;  c01ceb5c <is_read_only+14/40>
   9:   66 3d 00 80               cmp    $0x8000,%ax
Code;  c01ceb60 <is_read_only+18/40>
   d:   75 04                     jne    13 <_EIP+0x13> c01ceb66 
<is_read_only+1e/40>
Code;  c01ceb62 <is_read_only+1a/40>
   f:   80 62 1c fd               andb   $0xfd,0x1c(%edx)
Code;  c01ceb66 <is_read_only+1e/40>
  13:   8b 00                     mov    (%eax),%eax

Feb  1 12:11:13 Vivations kernel:  <1>Unable to handle kernel NULL 
pointer dereference at virtual address 000000a8
Feb  1 12:11:13 Vivations kernel:  printing eip:
Feb  1 12:11:13 Vivations kernel: c013c54a
Feb  1 12:11:13 Vivations kernel: *pde = 00000000
Feb  1 12:11:13 Vivations kernel: Oops: 0000
Feb  1 12:11:13 Vivations kernel: CPU:    0
Feb  1 12:11:13 Vivations kernel: EIP:    0010:[<c013c54a>]    Tainted: P
Feb  1 12:11:13 Vivations kernel: EFLAGS: 00010202
Feb  1 12:11:13 Vivations kernel: eax: cf207260   ebx: ce436320   ecx: 
00000000   edx: 00000000
Feb  1 12:11:13 Vivations kernel: esi: 00000000   edi: 00000000   ebp: 
00000080   esp: ceaf3fb0
Feb  1 12:11:13 Vivations kernel: ds: 0018   es: 0018   ss: 0018
Feb  1 12:11:13 Vivations kernel: Process usb.agent (pid: 1041, 
stackpage=ceaf3000)
Feb  1 12:11:13 Vivations kernel: Stack: ceaf2000 00000080 bffff8dc 
bffff89c c0108a1b 00000000 bffff8dc 00000080
Feb  1 12:11:13 Vivations kernel:        00000080 bffff8dc bffff89c 
00000003 0000002b 0000002b 00000003 4012b3c4
Feb  1 12:11:13 Vivations kernel:        00000023 00000293 bffff86c 0000002b
Feb  1 12:11:13 Vivations kernel: Call Trace: [<c0108a1b>]
Feb  1 12:11:13 Vivations kernel:
Feb  1 12:11:13 Vivations kernel: Code: 83 ba a8 00 00 00 00 74 2e 8b 82 
98 00 00 00 f6 40 28 40 74

 >>EIP; c013c54a <sys_write+be/c4>   <=====
Trace; c0108a1a <ret_from_fork+12/18>
Code;  c013c54a <sys_write+be/c4>
00000000 <_EIP>:
Code;  c013c54a <sys_write+be/c4>   <=====
   0:   83 ba a8 00 00 00 00      cmpl   $0x0,0xa8(%edx)   <=====
Code;  c013c550 <do_readv_writev+0/230>
   7:   74 2e                     je     37 <_EIP+0x37> c013c580 
<do_readv_writev+30/230>
Code;  c013c552 <do_readv_writev+2/230>
   9:   8b 82 98 00 00 00         mov    0x98(%edx),%eax
Code;  c013c558 <do_readv_writev+8/230>
   f:   f6 40 28 40               testb  $0x40,0x28(%eax)
Code;  c013c55c <do_readv_writev+c/230>
  13:   74 00                     je     15 <_EIP+0x15> c013c55e 
<do_readv_writev+e/230>

Feb  1 12:11:13 Vivations kernel:  <1>Unable to handle kernel NULL 
pointer dereference at virtual address 00000032
Feb  1 12:11:13 Vivations kernel:  printing eip:
Feb  1 12:11:13 Vivations kernel: c0153caa
Feb  1 12:11:13 Vivations kernel: *pde = 00000000
Feb  1 12:11:13 Vivations kernel: Oops: 0000
Feb  1 12:11:13 Vivations kernel: CPU:    0
Feb  1 12:11:13 Vivations kernel: EIP:    0010:[<c0153caa>]    Tainted: P
Feb  1 12:11:13 Vivations kernel: EFLAGS: 00010202
Feb  1 12:11:13 Vivations kernel: eax: cf207260   ebx: 00000001   ecx: 
00000000   edx: ce436320
Feb  1 12:11:13 Vivations kernel: esi: 00000000   edi: 00000000   ebp: 
ce436320   esp: ceaf3e54
Feb  1 12:11:13 Vivations kernel: ds: 0018   es: 0018   ss: 0018
Feb  1 12:11:13 Vivations kernel: Process usb.agent (pid: 1041, 
stackpage=ceaf3000)
Feb  1 12:11:13 Vivations kernel: Stack: 00000001 ce436320 00000000 
00000001 00000001 c013c01a 00000000 ce436320
Feb  1 12:11:13 Vivations kernel:        00000000 00000001 cfb7e520 
00000000 c011dcf9 ce436320 cfb7e520 ceaf2000
Feb  1 12:11:13 Vivations kernel:        cfb7e520 ceaf2000 cf63fb3c 
cfb7e640 c011e597 ceaf2000 00000000 cf63fb20
Feb  1 12:11:13 Vivations kernel: Call Trace: [<c013c01a>] [<c011dcf9>] 
[<c011e597>] [<c0108fda>] [<c0116215>]
Feb  1 12:11:13 Vivations kernel:    [<c0115e70>] [<c0116017>] 
[<c0115e70>] [<c0108b40>] [<c013c54a>] [<c0108a1b>]
Feb  1 12:11:13 Vivations kernel:
Feb  1 12:11:13 Vivations kernel: Code: 0f b7 46 32 25 00 f0 ff ff 66 3d 
00 40 74 0a b8 ec ff ff ff

 >>EIP; c0153caa <free_kiovec+2/64>   <=====
Trace; c013c01a <.text.lock.open+48/7e>
Trace; c011dcf8 <session_of_pgrp+7c/9c>
Trace; c011e596 <exit_notify+15a/360>
Trace; c0108fda <die+2e/84>
Trace; c0116214 <do_page_fault+218/4de>
Trace; c0115e70 <__verify_write+90/198>
Trace; c0116016 <do_page_fault+1a/4de>
Trace; c0115e70 <__verify_write+90/198>
Trace; c0108b40 <syscall_badsys+0/10>
Trace; c013c54a <sys_write+be/c4>
Trace; c0108a1a <ret_from_fork+12/18>
Code;  c0153caa <free_kiovec+2/64>
00000000 <_EIP>:
Code;  c0153caa <free_kiovec+2/64>   <=====
   0:   0f b7 46 32               movzwl 0x32(%esi),%eax   <=====
Code;  c0153cae <free_kiovec+6/64>
   4:   25 00 f0 ff ff            and    $0xfffff000,%eax
Code;  c0153cb2 <free_kiovec+a/64>
   9:   66 3d 00 40               cmp    $0x4000,%ax
Code;  c0153cb6 <free_kiovec+e/64>
   d:   74 0a                     je     19 <_EIP+0x19> c0153cc2 
<free_kiovec+1a/64>
Code;  c0153cb8 <free_kiovec+10/64>
   f:   b8 ec ff ff ff            mov    $0xffffffec,%eax

Feb  1 12:11:13 Vivations kernel:  <6>usb.c: USB bus 2 deregistered
Feb  1 12:11:13 Vivations kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 00000000
Feb  1 12:11:13 Vivations kernel:  printing eip:
Feb  1 12:11:13 Vivations kernel: 00000000
Feb  1 12:11:13 Vivations kernel: *pde = 00000000
Feb  1 12:11:13 Vivations kernel: Oops: 0000
Feb  1 12:11:13 Vivations kernel: CPU:    0
Feb  1 12:11:13 Vivations kernel: EIP:    0010:[<00000000>]    Tainted: P
Feb  1 12:11:13 Vivations kernel: EFLAGS: 00010206
Feb  1 12:11:13 Vivations kernel: eax: 00000000   ebx: c1396dc0   ecx: 
ce436420   edx: 00000000
Feb  1 12:11:13 Vivations kernel: esi: ce5b7000   edi: 00000000   ebp: 
cfe28ab4   esp: cec85f30
Feb  1 12:11:13 Vivations kernel: ds: 0018   es: 0018   ss: 0018
Feb  1 12:11:13 Vivations kernel: Process rmmod (pid: 1024, 
stackpage=cec85000)
Feb  1 12:11:13 Vivations kernel: Stack: c012fdeb ce436420 c1396dc0 
00000000 00001000 ce436420 ffffffea 00000000
Feb  1 12:11:13 Vivations kernel:        00001000 cfc5baa8 00001000 
00000000 00001000 fffffff4 00000000 00000000
Feb  1 12:11:13 Vivations kernel:        00000000 cfc5ba40 cfc5baf0 
00000000 72000000 c016109a ce436420 bfffdcc4
Feb  1 12:11:13 Vivations kernel: Call Trace: [<c012fdeb>] [<c016109a>] 
[<c013c66b>] [<c0108a1b>]
Feb  1 12:11:13 Vivations kernel:
Feb  1 12:11:13 Vivations kernel: Code:  Bad EIP value.


 >>EIP; 00000000 Before first symbol
Trace; c012fdea <.text.lock.filemap+2/268>
Trace; c016109a <find_next_usable_block+256/2b4>
Trace; c013c66a <do_readv_writev+11a/230>
Trace; c0108a1a <ret_from_fork+12/18>


Later, as the system tries to do an emergency remount r/o:

Feb  1 12:11:31 Vivations kernel: SysRq : Emergency Remount R/O
Feb  1 12:11:31 Vivations kernel: Remounting device 03:06 ... <1>Unable 
to handle kernel NULL pointer dereference at virtual address 00000032
Feb  1 12:11:31 Vivations kernel:  printing eip:
Feb  1 12:11:31 Vivations kernel: c01ceb54
Feb  1 12:11:31 Vivations kernel: *pde = 00000000
Feb  1 12:11:31 Vivations kernel: Oops: 0000
Feb  1 12:11:31 Vivations kernel: CPU:    0
Feb  1 12:11:31 Vivations kernel: EIP:    0010:[<c01ceb54>]    Tainted: P
Feb  1 12:11:31 Vivations kernel: EFLAGS: 00010202
Feb  1 12:11:31 Vivations kernel: eax: 00000000   ebx: cfb55470   ecx: 
cfce8f20   edx: ce436420
Feb  1 12:11:31 Vivations kernel: esi: cfb55400   edi: 0000000f   ebp: 
0008e000   esp: cfc3bfbc
Feb  1 12:11:31 Vivations kernel: ds: 0018   es: 0018   ss: 0018
Feb  1 12:11:31 Vivations kernel: Process bdflush (pid: 6, 
stackpage=cfc3b000)
Feb  1 12:11:31 Vivations kernel: Stack: cfb55400 00000001 cfc3a34e 
cfc3a34e c01cec8c cfb55400 00000001 cfc3a000
Feb  1 12:11:31 Vivations kernel:        c024c88e c014096e 00010f00 
cfe6bfbc c02bb9e8 c0107058 c02bb9e8 00000078
Feb  1 12:11:31 Vivations kernel:        c02a5fc0
Feb  1 12:11:31 Vivations kernel: Call Trace: [<c01cec8c>] [<c014096e>] 
[<c0107058>]
Feb  1 12:11:31 Vivations kernel:
Feb  1 12:11:31 Vivations kernel: Code: 0f b7 40 32 25 00 f0 ff ff 66 3d 
00 80 75 04 80 62 1c fd 8b

 >>EIP; c01ceb54 <is_read_only+c/40>   <=====
Trace; c01cec8c <blkdev_release_request+10/74>
Trace; c014096e <kupdate+4e/164>
Trace; c0107058 <exit_thread+0/4>
Code;  c01ceb54 <is_read_only+c/40>
00000000 <_EIP>:
Code;  c01ceb54 <is_read_only+c/40>   <=====
   0:   0f b7 40 32               movzwl 0x32(%eax),%eax   <=====
Code;  c01ceb58 <is_read_only+10/40>
   4:   25 00 f0 ff ff            and    $0xfffff000,%eax
Code;  c01ceb5c <is_read_only+14/40>
   9:   66 3d 00 80               cmp    $0x8000,%ax
Code;  c01ceb60 <is_read_only+18/40>
   d:   75 04                     jne    13 <_EIP+0x13> c01ceb66 
<is_read_only+1e/40>
Code;  c01ceb62 <is_read_only+1a/40>
   f:   80 62 1c fd               andb   $0xfd,0x1c(%edx)
Code;  c01ceb66 <is_read_only+1e/40>
  13:   8b 00                     mov    (%eax),%eax

I hope these oopses were decoded correctly... ksymoops options used: -V 
-m /boot/System.map-2.5.3-dj1 -o /lib/modules/2.5.3-dj1/ --no-ksyms

2: Mouse issues still persist (missed one detection, haven't seen it 
slow yet).  I'm going to rebuild my kernel now with the latest ACPI 
patch and with the mouse input device as a module.  ACPI IRQ routing 
appears necessary to detect my mouse (not sure, but it seems that way) - 
does that even make sense?  Oh, and is there a way with a non-modular 
mouse input core driver to force it to re-scan the hardware?  Sometimes 
/proc/bus/input/devices doesn't show my mouse [so far I've been rebooting].

3: PCMCIA seems to have an issue.  Got a "socket cdcde800 voltage 
interrogation timed out" at bootup with my wavelan card (which only 
works with pcmcia-cs's wvlan_cs and neither wavelan_cs nor orinoco_cs) - 
this worked fine (slightly flaky, though - sometimes needed multiple 
"cardctl reset"s before it worked) in 2.5.2-dj6.  I don't know if this 
is a symptom of the kernel or just a chance with my card.  I will test 
further and report if it keeps acting up.

--Nathan


