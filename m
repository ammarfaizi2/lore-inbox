Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267860AbTAHRQC>; Wed, 8 Jan 2003 12:16:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267861AbTAHRQC>; Wed, 8 Jan 2003 12:16:02 -0500
Received: from adsl-67-113-154-34.dsl.sntc01.pacbell.net ([67.113.154.34]:7667
	"EHLO postbox.aslab.com") by vger.kernel.org with ESMTP
	id <S267860AbTAHRQA>; Wed, 8 Jan 2003 12:16:00 -0500
Message-ID: <3E1C5EF7.8090004@aslab.com>
Date: Wed, 08 Jan 2003 09:25:11 -0800
From: Michael Madore <mmadore@aslab.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.20 IDE for 2.4.21-pre3 
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get the following oops when running 2.4.21-pre3 + 
 2.4.21-pre3-2420ide-1.  The oops occurred after running the Cerberus 
stress test for about 5 hours.  The machine uses an ASUS A7N8X single 
AMD Athlon XP motherboard with the Nvidia nforce2 chipset.  I had to 
pass ide0=ata66 ide1=ata66 to the kernel in order to use DMA.

Mike

ksymoops 2.4.4 on i686 2.4.21-1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.21-1/ (default)
     -m /boot/System.map-2.4.21-1 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

ide_dmaproc: chipset supported ide_dma_timeout func
hda: status error: status=0x58 {driveReady Seekcomplete DataRequeset}
hda: drive not ready for command

Unable to handle kernel NULL pointer dereference at virtual address 00000018
c013cf60
*pde = 00000000
Oops: 0000
CPU: 0
EIP: 0010:[<c013cf60>] Not Tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010007
eax: 00000001 ebx: cd999d40 ecx: 00000000 edx: 00000000
esi: 00000002 edi: c11f3070 ebp: 00000001 esp: c1c1bedc
ds: 0018 es: 0018 ss: 0018
Stack: cd999d40 cff1d640 00000002 00000001 c0203d4c cd999d40 00000001
cff1d640 c1330d80 00000001 00000046 c020ed3f cff1d640 00000001 c03ac68c
0000007a cff1d640 00000001 ca657a00 c02205ef 00000001 c1330d80 c1c1bf3c
00000000
Call Trace: [<c0203d4c>] [<c020ed3f>] [<c02205ef>] [<c0122879>]
[<c0210a07>] [<c0220460>] [<c010a55c>] [<c010a773>]
Code: 8b 42 18 89 c1 83 e1 04 74 16 83 e0 40 74 17 c6 05 84 5e 2f

 >>EIP; c013cf60 <end_buffer_io_async+60/c0>   <=====
Trace; c0203d4c <end_that_request_first+5c/b0>
Trace; c020ed3f <ide_end_request+5f/b0>
Trace; c02205ef <read_intr+18f/1d0>
Trace; c0122879 <timer_bh+2a9/3f0>
Trace; c0210a07 <ide_intr+e7/160>
Trace; c0220460 <read_intr+0/1d0>
Trace; c010a55c <handle_IRQ_event+5c/90>
Trace; c010a773 <do_IRQ+a3/f0>
Code;  c013cf60 <end_buffer_io_async+60/c0>
00000000 <_EIP>:
Code;  c013cf60 <end_buffer_io_async+60/c0>   <=====
   0:   8b 42 18                  mov    0x18(%edx),%eax   <=====
Code;  c013cf63 <end_buffer_io_async+63/c0>
   3:   89 c1                     mov    %eax,%ecx
Code;  c013cf65 <end_buffer_io_async+65/c0>
   5:   83 e1 04                  and    $0x4,%ecx
Code;  c013cf68 <end_buffer_io_async+68/c0>
   8:   74 16                     je     20 <_EIP+0x20> c013cf80 
<end_buffer_io_async+80/c0>
Code;  c013cf6a <end_buffer_io_async+6a/c0>
   a:   83 e0 40                  and    $0x40,%eax
Code;  c013cf6d <end_buffer_io_async+6d/c0>
   d:   74 17                     je     26 <_EIP+0x26> c013cf86 
<end_buffer_io_async+86/c0>
Code;  c013cf6f <end_buffer_io_async+6f/c0>
   f:   c6 05 84 5e 2f 00 00      movb   $0x0,0x2f5e84

<0> Kernel panic: Aiee, killing interrupt handler!

1 warning issued.  Results may not be reliable.


