Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285707AbRLHA2L>; Fri, 7 Dec 2001 19:28:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285710AbRLHA2C>; Fri, 7 Dec 2001 19:28:02 -0500
Received: from a-night-at-the-opera.cu.groogroo.com ([64.5.70.200]:9988 "EHLO
	a-night-at-the-opera.cu.groogroo.com") by vger.kernel.org with ESMTP
	id <S285707AbRLHA1z>; Fri, 7 Dec 2001 19:27:55 -0500
Message-Id: <200112080027.fB80Rra03466@a-night-at-the-opera.cu.groogroo.com>
To: linux-kernel@vger.kernel.org
Dcc: 
From: Arun Bhalla <bhalla@uiuc.edu>
Reply-To: Arun Bhalla <bhalla@uiuc.edu>
Subject: Oops report for 2.2.19(ext3)
Date: Fri, 07 Dec 2001 18:27:53 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I run linux 2.2.19ext3 on an Athlon 700 (and ASUS K7M motherboard) with
384MB.  The hard drives are all IDE, but the CD-RW drive (at hdd) is 
interfaced through the ide-scsi driver.  Fairly normal hardware setup
otherwise.

For at least a few months, if not most of the past year, my system
hasn't had an uptime longer than 14 days or so.  Every so often,
approximately every 10-12 days, the system inexplicably freezes up.
At that point, there are only two ways I can interact with the system
-- I can open a connection to this system via telnet from another networked
computer, but the system won't respond in any way except for opening
the connection.  Second, I can press Alt-SysRq-B to reboot.

A friend has been experiencing similar behavior with his 2.2.19 box
(which has the same model of CPU and motherboard).  However, his
production server running 2.2.19 with slightly different hardware has
an uptime of 220 days.  I thought I'd finally send in an Oops report
since work towards 2.2.20 appears to have been abandoned.  I have other
Oops reports from earlier this year that I could send in.  Perhaps of note,
I was running grip when the system crashed -- it was reading from
/dev/hdc and writing to /dec/hda.


[ksymoops output]

ksymoops 2.3.5 on i686 2.2.19ext3.  Options used
     -v /usr/src/linux/vmlinux (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.2.19ext3/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_ksyms_lsmod): module adlib_card is in lsmod but not in ksyms, probably no symbols exported
Warning (compare_ksyms_lsmod): module awe_wave is in lsmod but not in ksyms, probably no symbols exported
Oops: 0002 
CPU:    0 
EIP:    0010:[kmem_cache_alloc+51/292] 
EFLAGS: 00013246 
eax: 0000003d   ebx: c7ed577c   ecx: ffffffff   edx: 0000003c 
esi: d7fef740   edi: c7ed5fc0   ebp: c7ed5700   esp: d7fd3ecc 
ds: 0018   es: 0018   ss: 0018 
Process kswapd (pid: 4, process nr: 4, stackpage=d7fd3000) 
Stack: c7ed5700 c03558c0 c29994c0 c0559b58 c0109ff8 00003246 d7fef740 d0f23000  
       ffffffff c01277ea d7fef740 c7ed5700 00000018 00003202 c7ed5700 cdbccb40  
       d6f1f840 00003206 c7ed5700 c7ed5680 cad82240 c0128215 c7ed5700 d7fef740  
Call Trace: [IRQ0x01_interrupt+8/16] [create_buffers+262/412] [sync_old_buffers+189/444] [sync_old_buffers+180/444] [sync_old_buffers+237/444] [exit_mmap+286/288] [schedule+374/636] [kswapd+57/160] [head_vals.1010+6502/18040] [head_vals.1010+6502/18040] [rw_swap_page_base+103/1032] [rw_swap_page_base+110/1032] [rw_swap_page_base+86/1032] [exit_thread+3/4] [flush_thread+8/68]  
Code: c7 05 00 00 00 00 00 00 00 00 eb 13 90 83 c4 fc 56 57 68 0c  
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP-0x1>:
Code;  00000000 Before first symbol
   0:   c7 05 00 00 00 00 00      movl   $0x0,0x0
Code;  00000007 Before first symbol
   7:   00 00 00 
Code;  00000001 Before first symbol
00000001 <_EIP>:
Code;  00000001 Before first symbol
   1:   05 00 00 00 00            add    $0x0,%eax
Code;  00000006 Before first symbol
   6:   00 00                     add    %al,(%eax)
Code;  00000008 Before first symbol
   8:   00 00                     add    %al,(%eax)
Code;  0000000a Before first symbol
   a:   eb 13                     jmp    1f <_EIP+0x1e> 0000001e Before first symbol
Code;  0000000c Before first symbol
   c:   90                        nop    
Code;  0000000d Before first symbol
   d:   83 c4 fc                  add    $0xfffffffc,%esp
Code;  00000010 Before first symbol
  10:   56                        push   %esi
Code;  00000011 Before first symbol
  11:   57                        push   %edi
Code;  00000012 Before first symbol
  12:   68 0c 00 00 00            push   $0xc


3 warnings issued.  Results may not be reliable.
