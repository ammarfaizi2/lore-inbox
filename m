Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314083AbSGYOAJ>; Thu, 25 Jul 2002 10:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313867AbSGYOAI>; Thu, 25 Jul 2002 10:00:08 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:49635 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S314083AbSGYOAF>;
	Thu, 25 Jul 2002 10:00:05 -0400
Subject: Re: kernel BUG at page_alloc.c:92! & page allocation failure. order:0,   mode:0x0
To: Andrew Morton <akpm@zip.com.au>
Cc: akpm@us.ibm.com, Andrea Arcangeli <andrea@suse.de>,
       linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF43E65842.8EA11A7B-ON85256C01.004CDE6E@pok.ibm.com>
From: "David F Barrera" <dbarrera@us.ibm.com>
Date: Thu, 25 Jul 2002 09:02:50 -0500
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 5.0.10 SPR# MIAS5B3GZN |June
 28, 2002) at 07/25/2002 10:03:10 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The problem occurs after the ptrace.c change, as I indicated earlier.
Following is the ksymoops output:

ksymoops 2.4.1 on i686 2.4.17-3.1smp64gigmem.  Options used
     -v /boot/vmlinux-2.5.26 (specified)
     -K (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.5.26/ (specified)
     -m /boot/System.map-2.5.26 (specified)

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel NULL pointer dereference at virtual address
00000014
*pde = 373f2001
Oops: 0000
CPU:    0
EIP:    0010:[<c0133a83>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 00000000   ebx: 00000000   ecx: c357c058   edx: c03d5e20
esi: 00000000   edi: f73e900a   ebp: f73e900a   esp: f73fdee0
ds: 0018   es: 0018   ss: 0018
Stack: 0000000a c011e12b c357c058 f73fc000 f73e9000 f75f1ee0 c357c058
f75dcf60
       00000000 f75f1ee0 f73e9000 f73e9000 c015ccd3 c88c2ce0 bfffffa4
f73e9000
       0000000a 00000000 000001d0 f7552950 00000400 c88c2ce0 f73e9000
c015d046
Call Trace: [<c011e12b>] [<c015ccd3>] [<c015d046>] [<c013ca18>]
[<c010cd79>]
   [<c013cbca>] [<c010700b>]
Code: 8b 43 14 a9 00 08 00 00 75 24 f0 ff 4b 10 0f 94 c0 84 c0 74

>>EIP; c0133a83 <page_cache_release+3/40>   <=====
Trace; c011e12b <access_process_vm+13b/1c0>
Trace; c015ccd3 <proc_pid_cmdline+63/f0>
Trace; c015d046 <proc_info_read+46/100>
Trace; c013ca18 <vfs_read+98/110>
Trace; c010cd79 <sys_mmap2+69/a0>
Trace; c013cbca <sys_read+2a/40>
Trace; c010700b <syscall_call+7/b>
Code;  c0133a83 <page_cache_release+3/40>
00000000 <_EIP>:
Code;  c0133a83 <page_cache_release+3/40>   <=====
   0:   8b 43 14                  mov    0x14(%ebx),%eax   <=====
Code;  c0133a86 <page_cache_release+6/40>
   3:   a9 00 08 00 00            test   $0x800,%eax
Code;  c0133a8b <page_cache_release+b/40>
   8:   75 24                     jne    2e <_EIP+0x2e> c0133ab1
<page_cache_release+31/40>
Code;  c0133a8d <page_cache_release+d/40>
   a:   f0 ff 4b 10               lock decl 0x10(%ebx)
Code;  c0133a91 <page_cache_release+11/40>
   e:   0f 94 c0                  sete   %al
Code;  c0133a94 <page_cache_release+14/40>
  11:   84 c0                     test   %al,%al
Code;  c0133a96 <page_cache_release+16/40>
  13:   74 00                     je     15 <_EIP+0x15> c0133a98
<page_cache_release+18/40>

 <1>Unable to handle kernel NULL pointer dereference at virtual address
00000000
c01b7e5b
*pde = 00104001
Oops: 0002
CPU:    5
EIP:    0010:[<c01b7e5b>]    Not tainted
EFLAGS: 00010003
eax: 00000000   ebx: 00000000   ecx: f75d1000   edx: 00000000
esi: 0000f01b   edi: 00000001   ebp: c886f4c0   esp: c88c7ec0
ds: 0018   es: 0018   ss: 0018
Stack: 00000001 0000270f c886f4c0 00000000 c01b8e0d c886f4c0 0000001b
00000000
       c03e69a0 01010000 00000000 00000001 0000270f 00000001 c01b923b
00000001
       00000001 c88c7f15 c0112da0 c03994c0 00000001 00000000 c03994c0
00000000
Call Trace: [<c01b8e0d>] [<c01b923b>] [<c0112da0>] [<c01b92ac>]
[<c01092de>]
   [<c01094e4>] [<c01052f0>] [<c0107957>] [<c01052f0>] [<c01052f0>]
[<c010531a>]
   [<c01053c2>] [<c0117088>]
Code: c6 00 00 8b 91 58 01 00 00 ff 81 5c 01 00 00 8b 44 24 18 88

>>EIP; c01b7e5b <put_queue+2b/60>   <=====
Trace; c01b8e0d <handle_scancode+24d/2a0>
Trace; c01b923b <handle_kbd_event+14b/1a0>
Trace; c0112da0 <scheduler_tick+a0/370>
Trace; c01b92ac <keyboard_interrupt+1c/30>
Trace; c01092de <handle_IRQ_event+5e/90>
Trace; c01094e4 <do_IRQ+a4/f0>
Trace; c01052f0 <default_idle+0/40>
Trace; c0107957 <common_interrupt+1f/24>
Trace; c01052f0 <default_idle+0/40>
Trace; c01052f0 <default_idle+0/40>
Trace; c010531a <default_idle+2a/40>
Trace; c01053c2 <cpu_idle+52/70>
Trace; c0117088 <printk+128/140>
Code;  c01b7e5b <put_queue+2b/60>
00000000 <_EIP>:
Code;  c01b7e5b <put_queue+2b/60>   <=====
   0:   c6 00 00                  movb   $0x0,(%eax)   <=====
Code;  c01b7e5e <put_queue+2e/60>
   3:   8b 91 58 01 00 00         mov    0x158(%ecx),%edx
Code;  c01b7e64 <put_queue+34/60>
   9:   ff 81 5c 01 00 00         incl   0x15c(%ecx)
Code;  c01b7e6a <put_queue+3a/60>
   f:   8b 44 24 18               mov    0x18(%esp,1),%eax
Code;  c01b7e6e <put_queue+3e/60>
  13:   88 00                     mov    %al,(%eax)

 <0>Kernel panic: Aiee, killing interrupt handler!


David F Barrera
Linux Technology Center, IBM
T/L 678-1375   External 838-1375
dbarrera@us.ibm.com


                                                                                                                                       
                      Andrew Morton                                                                                                    
                      <akpm@zip.com.au>        To:       David F Barrera/Austin/IBM@IBMUS                                              
                      Sent by:                 cc:       Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org               
                      akpm@us.ibm.com          Subject:  Re: kernel BUG at page_alloc.c:92! & page allocation failure. order:0,        
                                                mode:0x0                                                                               
                                                                                                                                       
                      07/24/2002 02:35                                                                                                 
                      PM                                                                                                               
                                                                                                                                       
                                                                                                                                       



David F Barrera wrote:
>
> Andrew,
>
> I tried the change to ptrace.c, but it did not work.  I cannot boot the
> machine.  It gives an oops upon boot.

That won't be due to the ptrace change.  Suggest you do a clean
build and if the oops is still there, please pass it through ksymoops and
let us know.

And please drop the ptrace.c change and use
http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.27/lru-removal.patch
instead.

Thanks.





