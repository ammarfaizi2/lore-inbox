Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318760AbSHQWr4>; Sat, 17 Aug 2002 18:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318762AbSHQWrz>; Sat, 17 Aug 2002 18:47:55 -0400
Received: from web14003.mail.yahoo.com ([216.136.175.94]:20826 "HELO
	web14003.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S318760AbSHQWry>; Sat, 17 Aug 2002 18:47:54 -0400
Message-ID: <20020817225153.73736.qmail@web14003.mail.yahoo.com>
Date: Sat, 17 Aug 2002 15:51:53 -0700 (PDT)
From: Tony Spinillo <tspinillo@yahoo.com>
Subject: Re: 2.4.20-pre2-ac3 oops
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just ran into something similar with 2.4.20-pre2-ac3. 
I have my CD burner on /dev/hda (ide-scsi).
If DMA is off, it will burn (slow). If I enable DMA (hdparm -d1
/dev/hda), 
cdrecord bombs. Burning with DMA on works fine 
with linux-2.4.20-pre1-ac1 as well as the 2.4.19-ac's. 
I am on a stock RedHat 7.3 system, all updates applied,
gcc 2.96, modutils 2.4.19. I burned from the
console and made sure the NVidia module never loaded.

I took the output from my log and ran it through ksymoops
(If I missed something - let me know)
I put my lspci -vvv,kernelconfig and a copy of the message below at:
http://ac.marywood.edu/tspin/www/lspci.txt
http://ac.marywood.edu/tspin/www/koops.txt
http://ac.marywood.edu/tspin/www/dotconfig.txt

Thanks!

Tony

The following happens right when cdrecord starts to burn:

localhost kernel: kernel BUG in header file at line 157
localhost kernel: kernel BUG at panic.c:286!
localhost kernel: invalid operand: 0000
localhost kernel: CPU:    0
localhost kernel: EIP:    0010:[<c011853f>]    Tainted: PF
Using defaults from ksymoops -t elf32-i386 -a i386
localhost kernel: EFLAGS: 00010282
localhost kernel: eax: 00000026   ebx: 00000000   ecx: 00000000  
edx: f6c8a000
localhost kernel: esi: 00007800   edi: 00000000   ebp: 00000000  
esp: d3a77b64
localhost kernel: ds: 0018   es: 0018   ss: 0018
localhost kernel: Process cdrecord (pid: 1863, stackpage=d3a77000)
localhost kernel: Stack: c025c540 0000009d c01b97ed 0000009d 00000002
f7ea4000 fffffffe c011c76b
localhost kernel:        00000046 d3a77bb0 f7ea7000 c03195e0 f69dc380
00000000 c01b99ff c03195e0
localhost kernel:        f69dc380 00000006 00000000 c03195e0 c03195e0
f7140780 c01b1555 c0319690
localhost kernel: Call Trace:    [<c01b97ed>] [<c011c76b>]
[<c01b99ff>] [<c01b1555>] [<c01b9f49>]
localhost kernel:   [<c01e431d>] [<c01b64f0>] [<c01b6815>]
[<c01b6dea>] [<c01c8db0>] [<c01e501b>]
localhost kernel:   [<c0151391>] [<c01c3a6c>] [<c01c8db0>]
[<c01ca6fc>] [<c01c9ae4>] [<c01c9b3a>]
localhost kernel:   [<c01efaab>] [<c01f0a80>] [<c01ef8a5>]
[<c01efd40>] [<c019936f>] [<c0135e5e>]
localhost kernel:   [<c0135d7a>] [<c0126247>] [<c0126946>]
[<c01988f9>] [<c0114ffa>] [<c018cd57>]
localhost kernel:   [<c0190a80>] [<c0122093>] [<c0144397>]
[<c01088d3>]
localhost kernel: Code: 0f 0b 1e 01 0b bf 25 c0 58 5a 8d b4 26 00 00
00 00 eb fe 8d

>>EIP; c011853f <__out_of_line_bug+f/30>   <=====
Trace; c01b97ed <ide_build_sglist+11d/170>
Trace; c011c76b <do_softirq+4b/90>
Trace; c01b99ff <ide_build_dmatable+5f/190>
Trace; c01b1555 <atapi_output_bytes+25/60>
Trace; c01b9f49 <__ide_dma_write+29/110>
Trace; c01e431d <idescsi_issue_pc+6d/1c0>
Trace; c01b64f0 <start_request+180/1e0>
Trace; c01b6815 <ide_do_request+275/2c0>
Trace; c01b6dea <ide_do_drive_cmd+da/110>
Trace; c01c8db0 <scsi_old_done+0/650>
Trace; c01e501b <idescsi_queue+56b/5b0>
Trace; c0151391 <load_elf_binary+961/aa0>
Trace; c01c3a6c <scsi_dispatch_cmd+1ac/210>
Trace; c01c8db0 <scsi_old_done+0/650>
Trace; c01ca6fc <scsi_request_fn+31c/360>
Trace; c01c9ae4 <__scsi_insert_special+64/70>
Trace; c01c9b3a <scsi_insert_special_req+1a/20>
Trace; c01efaab <sg_common_write+1db/1f0>
Trace; c01f0a80 <sg_cmd_done_bh+0/2b0>
Trace; c01ef8a5 <sg_new_write+215/240>
Trace; c01efd40 <sg_ioctl+280/bd0>
Trace; c019936f <lf+2f/60>
Trace; c0135e5e <page_remove_rmap+8e/b0>
Trace; c0135d7a <page_add_rmap+3a/90>
Trace; c0126247 <do_wp_page+1e7/220>
Trace; c0126946 <handle_mm_fault+106/150>
Trace; c01988f9 <set_cursor+69/80>
Trace; c0114ffa <do_page_fault+12a/45b>
Trace; c018cd57 <tty_write+187/200>
Trace; c0190a80 <write_chan+0/200>
Trace; c0122093 <sys_rt_sigaction+93/f0>
Trace; c0144397 <sys_ioctl+217/230>
Trace; c01088d3 <system_call+33/38>
Code;  c011853f <__out_of_line_bug+f/30>
00000000 <_EIP>:
Code;  c011853f <__out_of_line_bug+f/30>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0118541 <__out_of_line_bug+11/30>
   2:   1e                        push   %ds
Code;  c0118542 <__out_of_line_bug+12/30>
   3:   01 0b                     add    %ecx,(%ebx)
Code;  c0118544 <__out_of_line_bug+14/30>
   5:   bf 25 c0 58 5a            mov    $0x5a58c025,%edi
Code;  c0118549 <__out_of_line_bug+19/30>
   a:   8d b4 26 00 00 00 00      lea    0x0(%esi,1),%esi
Code;  c0118550 <__out_of_line_bug+20/30>
  11:   eb fe                     jmp    11 <_EIP+0x11> c0118550
<__out_of_line_bug+20/30>
Code;  c0118552 <__out_of_line_bug+22/30>
  13:   8d 00                     lea    (%eax),%eax



__________________________________________________
Do You Yahoo!?
HotJobs - Search Thousands of New Jobs
http://www.hotjobs.com
