Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129345AbQLGUtF>; Thu, 7 Dec 2000 15:49:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129413AbQLGUsq>; Thu, 7 Dec 2000 15:48:46 -0500
Received: from smtp01.mrf.mail.rcn.net ([207.172.4.60]:27318 "EHLO
	smtp01.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S129345AbQLGUs2>; Thu, 7 Dec 2000 15:48:28 -0500
Message-ID: <3A2FF076.946076FC@haque.net>
Date: Thu, 07 Dec 2000 15:17:58 -0500
From: "Mohammad A. Haque" <mhaque@haque.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: kernel BUG at buffer.c:827! and scsi modules no load at boot w/ initrd - 
 test12pre7
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting a BUG at boot in buffer.c:827. Oops/ksymoops at teh end of
this message. I also noticed that the driver for my scsi card isn't
loading at boot if compiled as a module using initrd. This is what I get
during the boot process. 

SCSI subsystem driver Revision: 1.00
request_module[scsi_hostadapter]: Root fs not mounted
request_module[scsi_hostadapter]: Root fs not mounted


Oops:

Reading Oops report from the terminal
kernel BUG at buffer.c:827!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0135e13>]
EFLAGS: 00010286
eax: 0000001c   ebx: c1541144   ecx: c02919c8   edx: 00000001
esi: d3d41c20   edi: 00000202   ebp: d3d41c68   esp: d3d0dbec
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 9, stackpage=d3d0d000)
Stack: c023fbf2 c023feda 0000033b d3eace40 d3ea4000 d3c7d800 d3d41c20
c0171570 
       d3d41c20 00000001 00000100 00000202 d3d41c20 0000018c c0168b9c
c0303da8 
       00000000 d3d41c20 d3d41c20 00000001 00000000 d3d0dc9c c0168d21
00000000 
Call Trace: [<c023fbf2>] [<c023feda>] [<c0171570>] [<c0168b9c>]
[<c0168d21>] [<c0137125>] [<c0130d63>] 
       [<c015a2ab>] [<c0158ad4>] [<c01291d3>] [<c012b1c3>] [<c012b42c>]
[<c013e0d6>] [<c014e76d>] [<c014e5e0>] 
       [<c0130d63>] [<c014a805>] [<c0129439>] [<c013e1e7>] [<c02308ad>]
[<c013e4ce>] [<c013e4e5>] [<c0109fbb>] 
       [<c010b4d3>] [<c02308ba>] [<c0100018>] [<c01070c5>] [<c02308ba>]
[<c0109d80>] [<c02308ba>] 
Code: 0f 0b 83 c4 0c 8d 73 28 8d 43 2c 39 43 2c 74 15 b9 01 00 00 
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0135e13>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 0000001c   ebx: c1541144   ecx: c02919c8   edx: 00000001
esi: d3d41c20   edi: 00000202   ebp: d3d41c68   esp: d3d0dbec
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 9, stackpage=d3d0d000)
Stack: c023fbf2 c023feda 0000033b d3eace40 d3ea4000 d3c7d800 d3d41c20
c0171570 
       d3d41c20 00000001 00000100 00000202 d3d41c20 0000018c c0168b9c
c0303da8 
       00000000 d3d41c20 d3d41c20 00000001 00000000 d3d0dc9c c0168d21
00000000 
Call Trace: [<c023fbf2>] [<c023feda>] [<c0171570>] [<c0168b9c>]
[<c0168d21>] [<c0137125>] [<c0130d63>] 
       [<c015a2ab>] [<c0158ad4>] [<c01291d3>] [<c012b1c3>] [<c012b42c>]
[<c013e0d6>] [<c014e76d>] [<c014e5e0>] 
       [<c0130d63>] [<c014a805>] [<c0129439>] [<c013e1e7>] [<c02308ad>]
[<c013e4ce>] [<c013e4e5>] [<c0109fbb>] 
       [<c010b4d3>] [<c02308ba>] [<c0100018>] [<c01070c5>] [<c02308ba>]
[<c0109d80>] [<c02308ba>] 
Code: 0f 0b 83 c4 0c 8d 73 28 8d 43 2c 39 43 2c 74 15 b9 01 00 00 

>>EIP; c0135e13 <end_buffer_io_async+cb/f8>   <=====
Trace; c023fbf2 <tvecs+35fe/10b78>
Trace; c023feda <tvecs+38e6/10b78>
Trace; c0171570 <rd_make_request+e0/ec>
Trace; c0168b9c <generic_make_request+130/140>
Trace; c0168d21 <ll_rw_block+175/1e4>
Trace; c0137125 <block_read_full_page+1f5/258>
Trace; c0130d63 <__alloc_pages+e3/42c>
Trace; c015a2ab <ext2_readpage+f/14>
Trace; c0158ad4 <ext2_get_block+0/484>
Trace; c01291d3 <do_generic_file_read+33b/5ac>
Trace; c012b1c3 <generic_file_read+5b/78>
Trace; c012b42c <file_read_actor+0/58>
Trace; c013e0d6 <prepare_binprm+24e/260>
Trace; c014e76d <load_script+18d/1b0>
Trace; c014e5e0 <load_script+0/1b0>
Trace; c0130d63 <__alloc_pages+e3/42c>
Trace; c014a805 <update_atime+4d/54>
Trace; c0129439 <do_generic_file_read+5a1/5ac>
Trace; c013e1e7 <search_binary_handler+57/15c>
Trace; c02308ad <stext_lock+1f1d/45a0>
Trace; c013e4ce <do_execve+1e2/250>
Trace; c013e4e5 <do_execve+1f9/250>
Trace; c0109fbb <sys_execve+2f/60>
Trace; c010b4d3 <system_call+33/38>
Trace; c02308ba <stext_lock+1f2a/45a0>
Trace; c0100018 <startup_32+18/139>
Trace; c01070c5 <do_linuxrc+c5/dc>
Trace; c02308ba <stext_lock+1f2a/45a0>
Trace; c0109d80 <kernel_thread+28/38>
Trace; c02308ba <stext_lock+1f2a/45a0>
Code;  c0135e13 <end_buffer_io_async+cb/f8>
00000000 <_EIP>:
Code;  c0135e13 <end_buffer_io_async+cb/f8>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0135e15 <end_buffer_io_async+cd/f8>
   2:   83 c4 0c                  add    $0xc,%esp
Code;  c0135e18 <end_buffer_io_async+d0/f8>
   5:   8d 73 28                  lea    0x28(%ebx),%esi
Code;  c0135e1b <end_buffer_io_async+d3/f8>
   8:   8d 43 2c                  lea    0x2c(%ebx),%eax
Code;  c0135e1e <end_buffer_io_async+d6/f8>
   b:   39 43 2c                  cmp    %eax,0x2c(%ebx)
Code;  c0135e21 <end_buffer_io_async+d9/f8>
   e:   74 15                     je     25 <_EIP+0x25> c0135e38
<end_buffer_io_async+f0/f8>
Code;  c0135e23 <end_buffer_io_async+db/f8>
  10:   b9 01 00 00 00            mov    $0x1,%ecx

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/ 
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
