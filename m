Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270646AbRHJU5V>; Fri, 10 Aug 2001 16:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270645AbRHJU5M>; Fri, 10 Aug 2001 16:57:12 -0400
Received: from ma-northadams1a-359.bur.adelphia.net ([24.52.175.103]:1797 "EHLO
	ma-northadams1a-359.bur.adelphia.net") by vger.kernel.org with ESMTP
	id <S270643AbRHJU5A>; Fri, 10 Aug 2001 16:57:00 -0400
Date: Fri, 10 Aug 2001 16:56:08 -0400
From: Eric Buddington <eric@sparrow.bur.adelphia.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.7-ac10 acpi BUG (again)
Message-ID: <20010810165608.C77@sparrow.bur.adelphia.net>
Reply-To: ebuddington@wesleyan.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: ECS Labs
X-Eric-Conspiracy: there is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I earlier reported a BUG on boot with 2.4.3-ac3 in the acpi
code. Andy's patches made the kernel not boot (out of data while
decompressing), so here's another shot with 2.4.7-ac10.

I enabled ACPI_DEBUG in the kernel config - is that the same as your
earlier patch, Andy? In any case, I get the same problem, pretty much.
Here it is. Oh, yeah - my Penguin is an AMD K6-2. Can'd give an ID on
the motherboard offhand (Gigabyte, I think).

-Eric

------------------------------------------------
ksymoops 2.4.1 on i586 2.4.3-ac3.  Options used
     -V (default)
     -K (specified)
     -L (specified)
     -o /packages/linux/2.4.7-ac10/k6/lib/modules/2.4.7-ac10 (specified)
     -m /packages/linux/2.4.7-ac10/any/src/linux/System.map (specified)

No modules in ksyms, skipping objects
kernel BUG at sched.c:711!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c011310d>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010082
eax: 0000001b   ebx: c1216000   ecx: 00000001   edx: 00000b31
esi: c1217dc0   edi: c0189e7c   ebp: c1217d84   esp: c1217d58
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 1, stackpage=c1217000)
Stack: c02444cf 000002c7 c02444b6 c1217dc0 c1216000 00000000 c1216000 00000711 
       c1216000 c1217dc0 c0189e7c c1217e7c c0106d31 00000711 c0184238 c7fa1460 
       c1217dc0 c0189e7c c1217e7c 00000008 00000018 00000018 00000078 c0105471 
Call Trace: [<c0189e7c>] [<c0106d31>] [<c0184238>] [<c0189e7c>] [<c0105471>] 
   [<c0184386>] [<c0184238>] [<c01844b9>] [<c0189ece>] [<c0189e7c>] [<c0189829>] 
   [<c01897a9>] [<c018a723>] [<c0183dfc>] [<c0107e81>] [<c0183df0>] [<c0107fd4>] 
   [<c010a14e>] [<c0183efe>] [<c018c4a6>] [<c018bff5>] [<c018bc86>] [<c018aef1>] 
   [<c018a922>] [<c0189eed>] [<c0189e94>] [<c01896bc>] [<c0186a61>] [<c01999d9>] 
   [<c0105000>] [<c0105000>] [<c010503f>] [<c0105000>] [<c010547a>] [<c0105034>] 
Code: 0f 0b 83 c4 0c 8d 65 f4 5b 5e 5f 5d c3 89 f6 8b 45 e8 c1 e0 

>>EIP; c011310d <schedule+5d/3c0>   <=====
Trace; c0189e7c <acpi_ev_global_lock_thread+0/18>
Trace; c0106d31 <reschedule+5/c>
Trace; c0184238 <acpi_os_queue_exec+0/e0>
Trace; c0189e7c <acpi_ev_global_lock_thread+0/18>
Trace; c0105471 <kernel_thread+1d/30>
Trace; c0184386 <acpi_os_schedule_exec+6e/118>
Trace; c0184238 <acpi_os_queue_exec+0/e0>
Trace; c01844b9 <acpi_os_queue_for_execution+89/14c>
Trace; c0189ece <acpi_ev_global_lock_handler+3a/44>
Trace; c0189e7c <acpi_ev_global_lock_thread+0/18>
Trace; c0189829 <acpi_ev_fixed_event_dispatch+41/a4>
Trace; c01897a9 <acpi_ev_fixed_event_detect+55/94>
Trace; c018a723 <acpi_ev_sci_handler+1b/2c>
Trace; c0183dfc <acpi_irq+c/10>
Trace; c0107e81 <handle_IRQ_event+31/68>
Trace; c0183df0 <acpi_irq+0/10>
Trace; c0107fd4 <do_IRQ+54/a0>
Trace; c010a14e <call_do_IRQ+5/b>
Trace; c0183efe <acpi_os_out16+a/c>
Trace; c018c4a6 <acpi_hw_low_level_write+176/180>
Trace; c018bff5 <acpi_hw_register_write+91/240>
Trace; c018bc86 <acpi_hw_register_bit_access+28a/37c>
Trace; c018aef1 <acpi_enable_event+6d/ac>
Trace; c018a922 <acpi_install_fixed_event_handler+76/94>
Trace; c0189eed <acpi_ev_init_global_lock_handler+15/2c>
Trace; c0189e94 <acpi_ev_global_lock_handler+0/44>
Trace; c01896bc <acpi_ev_initialize+48/5c>
Trace; c0186a61 <acpi_enable_subsystem+55/80>
Trace; c01999d9 <acpi_init+121/15c>
Trace; c0105000 <_stext+0/0>
Trace; c0105000 <_stext+0/0>
Trace; c010503f <init+b/140>
Trace; c0105000 <_stext+0/0>
Trace; c010547a <kernel_thread+26/30>
Trace; c0105034 <init+0/140>
Code;  c011310d <schedule+5d/3c0>
00000000 <_EIP>:
Code;  c011310d <schedule+5d/3c0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c011310f <schedule+5f/3c0>
   2:   83 c4 0c                  add    $0xc,%esp
Code;  c0113112 <schedule+62/3c0>
   5:   8d 65 f4                  lea    0xfffffff4(%ebp),%esp
Code;  c0113115 <schedule+65/3c0>
   8:   5b                        pop    %ebx
Code;  c0113116 <schedule+66/3c0>
   9:   5e                        pop    %esi
Code;  c0113117 <schedule+67/3c0>
   a:   5f                        pop    %edi
Code;  c0113118 <schedule+68/3c0>
   b:   5d                        pop    %ebp
Code;  c0113119 <schedule+69/3c0>
   c:   c3                        ret    
Code;  c011311a <schedule+6a/3c0>
   d:   89 f6                     mov    %esi,%esi
Code;  c011311c <schedule+6c/3c0>
   f:   8b 45 e8                  mov    0xffffffe8(%ebp),%eax
Code;  c011311f <schedule+6f/3c0>
  12:   c1 e0 00                  shl    $0x0,%eax

 <0>Kernel panic: Aiee, killing interrupt handler!

