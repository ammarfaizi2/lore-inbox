Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267639AbTALXLE>; Sun, 12 Jan 2003 18:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267636AbTALXJC>; Sun, 12 Jan 2003 18:09:02 -0500
Received: from smtp09.iddeo.es ([62.81.186.19]:33985 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id <S267635AbTALXHT>;
	Sun, 12 Jan 2003 18:07:19 -0500
Date: Mon, 13 Jan 2003 00:16:06 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Andrew Morton <akpm@digeo.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: updated CDROMREADAUDIO DMA patch
Message-ID: <20030112231606.GA1762@werewolf.able.es>
References: <3E177058.FF41AA10@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <3E177058.FF41AA10@digeo.com>; from akpm@digeo.com on Sun, Jan 05, 2003 at 00:38:00 +0100
X-Mailer: Balsa 2.0.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2003.01.05 Andrew Morton wrote:
> A refresh and retest of this patch, against 2.4.21-pre2.  It would
> be helpful if a few (or a lot of) people could test this, and report
> on the result.   Otherwise it'll never get anywhere...
> 
> Reading audio from IDE CDROMs always uses PIO.  This patch teaches the kernel
> to use DMA for the CDROMREADAUDIO ioctl.
> 

cdparanoia oopses on top of latest -aa:

Checking /dev/cdrom for cdrom...
Testing /dev/cdrom for cooked ioctl() interface
    CDROM sensed: ATAPI compatible CREATIVE CD5230E
Verifying drive can read CDDA...
Unable to handle kernel NULL pointer dereference at virtual address 00000014
*pde = 00000000
...

Decoded oops:

ksymoops 2.4.8 on i686 2.4.21-pre3-jam1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.21-pre3-jam1/ (default)
     -m /boot/System.map-2.4.21-pre3-jam1 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel NULL pointer dereference at virtual address 00000014
*pde = 00000000
Oops: 0000 2.4.21-pre3-jam1 #1 SMP sab ene 11 01:11:42 CET 2003
CPU: 1
EIP: 0010:[<401c06c0>] Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010046
eax: 00000001 ebx: 00000000 ecx: 00000001 edx: 40334600
esi: 47a016d0 edi: 47a01730 ebp: 00000004 esp: 419bbe98
ds: 0010 es: 0010 ss: 0018
Process swapper (pid: 0, stackpage=4199000)
Stack: 419cbfc8 402a2a14 00000001 419bbed0 00000002 47a01730 40334800 00000206
00000001 428105d5 47a01730 00000001 40334800 00000930 47a017ec 40334800
00000001 42811b96 40334800 00000001 00000000 419bbf00 00000003 ffffff80
Call Trace: [<428105d5>] [<42811b96>] [<401dd790>] [<401d6546>] [<42811ab0>]
[<40109520>] [<40109748>] [<40105340>] [<4010c2a8>] [<40105340>]
[<4010536c>] [<401053e2>] [<4011f845>] [<4011fab0>]
Code: 8b 43 14 85 c0 78 71 8b 46 2c 89 47 4c c7 46 2c 00 00 00 00


>>EIP; 401c06c0 <end_that_request_first+80/150>   <=====

>>edx; 40334600 <ide_hwifs+0/2c88>
>>esp; 419bbe98 <_end+1681c9c/1cc9e64>

Trace; 428105d5 <[dmi_scan]dmi_ident+1f0f95/410a20>
Trace; 42811b96 <[dmi_scan]dmi_ident+1f2556/410a20>
Trace; 401dd790 <__ide_dma_test_irq+20/80>
Trace; 401d6546 <ide_intr+e6/180>
Trace; 42811ab0 <[dmi_scan]dmi_ident+1f2470/410a20>
Trace; 40109520 <handle_IRQ_event+70/b0>
Trace; 40109748 <do_IRQ+98/f0>
Trace; 40105340 <default_idle+0/50>
Trace; 4010c2a8 <call_do_IRQ+5/d>
Trace; 40105340 <default_idle+0/50>
Trace; 4010536c <default_idle+2c/50>
Trace; 401053e2 <cpu_idle+32/50>
Trace; 4011f845 <call_console_drivers+65/120>
Trace; 4011fab0 <printk+140/180>

Code;  401c06c0 <end_that_request_first+80/150>
00000000 <_EIP>:
Code;  401c06c0 <end_that_request_first+80/150>   <=====
   0:   8b 43 14                  mov    0x14(%ebx),%eax   <=====
Code;  401c06c3 <end_that_request_first+83/150>
   3:   85 c0                     test   %eax,%eax
Code;  401c06c5 <end_that_request_first+85/150>
   5:   78 71                     js     78 <_EIP+0x78>
Code;  401c06c7 <end_that_request_first+87/150>
   7:   8b 46 2c                  mov    0x2c(%esi),%eax
Code;  401c06ca <end_that_request_first+8a/150>
   a:   89 47 4c                  mov    %eax,0x4c(%edi)
Code;  401c06cd <end_that_request_first+8d/150>
   d:   c7 46 2c 00 00 00 00      movl   $0x0,0x2c(%esi)


1 warning issued.  Results may not be reliable.

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.21-pre3-jam1 (gcc 3.2.1 (Mandrake Linux 9.1 3.2.1-2mdk))
