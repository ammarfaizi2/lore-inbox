Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317189AbSFBO1C>; Sun, 2 Jun 2002 10:27:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317191AbSFBO06>; Sun, 2 Jun 2002 10:26:58 -0400
Received: from mail.gmx.de ([213.165.64.20]:60677 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S317189AbSFBO0q> convert rfc822-to-8bit;
	Sun, 2 Jun 2002 10:26:46 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Peter Kirk <pwk.linuxfan@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Found an Oops in 2.4.19-pre7 + lowlatency patch
Date: Sun, 2 Jun 2002 16:26:39 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200206021626.39554.pwk.linuxfan@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

ok, when I boot up my system, then, with a chance of about 1/20 the kernel 
will not boot, but have an Oops instead. I copied it down, and ran it through 
the ksymoops... I hope its usable. If you have questions, just ask back (as I 
dont realy know what information you need)

here is the output of ksymoops:
---------------------------
ksymoops 2.4.5 on i686 2.4.19-pre7-lowlatency.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19-pre7-lowlatency/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): ksyms_base symbol 
IO_APIC_get_PCI_irq_vector_R__ver_IO_APIC_get_PCI_irq_vector not found in 
System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol 
vmalloc_to_page_R__ver_vmalloc_to_page not found in System.map.  Ignoring 
ksyms_base entry
Unable to handle kernel NULL pointer dereference at virtual adress: 00000028
e0b8a061
*pde = 00000000
Oops: 0000
CPU: 0
EIP: 0010:[<e0b8a061>] Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: 00000028 ebx: dc683ca8 ecx: 01808205 edx: 00000000
esi: dc683ca8 edi: dc4be420 edp: 00000000 esp: dc487ef8
Warning (Oops_set_regs): garbage 'edp: 00000000 esp: dc487ef8' at end of 
register line ignored
ds: 0018 es: 0018 ss: 0018
Process hwscan (pid: 540, stackpage=dc487000)
Stack: dd2de19c dc4be420 dd2de180 00000000 dc487f34 dc6aca80 dbfd6c80 dc4be408
       dc683ce0 dc683c80 dc27a180 00000000 e0b8a700 dd2de180 dc4be420 00000001
       dd2de19c dd2de180 00000000 00000000 dc4be408 c158d300 00000000 e0b8a97c
Call Trace: [<e0b8a700>] [<e0b8a97c>] [<c0130001>] [<c0109aff>] [<c0109c7e>] 
[<c010bbe8>]
Code: 8b 2c 90 8b 44 24 28 c1 e9 08 83 e1 0f d3 ed 83 e5 01 c7 44


>>EIP; e0b8a061 <[usb-uhci]process_transfer+51/2e0>   <=====

>>ebx; dc683ca8 <_end+1c3fce34/2062718c>
>>ecx; 01808205 Before first symbol
>>esi; dc683ca8 <_end+1c3fce34/2062718c>
>>edi; dc4be420 <_end+1c2375ac/2062718c>

Trace; e0b8a700 <[usb-uhci]process_urb+50/200>
Trace; e0b8a97c <[usb-uhci]uhci_interrupt+cc/130>
Trace; c0130001 <shmem_free_swp+31/40>
Trace; c0109aff <handle_IRQ_event+2f/60>
Trace; c0109c7e <do_IRQ+6e/b0>
Trace; c010bbe8 <call_do_IRQ+5/d>

Code;  e0b8a061 <[usb-uhci]process_transfer+51/2e0>
00000000 <_EIP>:
Code;  e0b8a061 <[usb-uhci]process_transfer+51/2e0>   <=====
   0:   8b 2c 90                  mov    (%eax,%edx,4),%ebp   <=====
Code;  e0b8a064 <[usb-uhci]process_transfer+54/2e0>
   3:   8b 44 24 28               mov    0x28(%esp,1),%eax
Code;  e0b8a068 <[usb-uhci]process_transfer+58/2e0>
   7:   c1 e9 08                  shr    $0x8,%ecx
Code;  e0b8a06b <[usb-uhci]process_transfer+5b/2e0>
   a:   83 e1 0f                  and    $0xf,%ecx
Code;  e0b8a06e <[usb-uhci]process_transfer+5e/2e0>
   d:   d3 ed                     shr    %cl,%ebp
Code;  e0b8a070 <[usb-uhci]process_transfer+60/2e0>
   f:   83 e5 01                  and    $0x1,%ebp
Code;  e0b8a073 <[usb-uhci]process_transfer+63/2e0>
  12:   c7 44 00 00 00 00 00      movl   $0x0,0x0(%eax,%eax,1)
Code;  e0b8a07a <[usb-uhci]process_transfer+6a/2e0>
  19:   00

<0> Kernel panic: Aiee, killing interupt handler!

4 warnings issued.  Results may not be reliable.
---------------
Some system speccs:
Athlon (C) 1.2 GHz, 512 MB PC-133 2-2-2 RAM, SuSE 8.0 (with updates by me)

Peter
-- 
Nothing makes one so vain as being told that one is a sinner.
Conscience makes egotists of us all.
		-- Oscar Wilde

