Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272622AbTG1CC4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 22:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272404AbTG1CBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 22:01:44 -0400
Received: from twinlark.arctic.org ([168.75.98.6]:54684 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP id S272071AbTG1B6N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 21:58:13 -0400
Date: Sun, 27 Jul 2003 19:13:26 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test2 has i8042 mux problems
Message-ID: <Pine.LNX.4.53.0307271906020.18444@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this was a bug i reported back a few versions as well -- and i don't think
i received any responses (nor from the maintainer).

i've got a box on which 2.4.x works fine, but 2.6.0-test2 gets into a snit
when it's trying to initialize the i8042.  i can get 2.6.0-test2 to boot
if i add "i8042_nomux".

the mux initialization code seems kind of ... wonk -- it seems to write
values to the registers then read back and if the value is the same then
it assumes the mux is there.  that seems way too likely to be broken in
situations when the mux isn't there... it'd be better to be looking for
some value which is different after writing.

the southbridge in this system is the ali1563.  if it helps i can supply a
complete trace of in/out on ports 0x60 and 0x64.

thanks
-dean


Loading test..........................
BIOS data check successful
Linux version 2.6.0-test2 (root@zim) (gcc version 3.2.3 (Debian)) #1 Sun Jul 27 18:48:40 PDT 2003
[...snip...]
mice: PS/2 mouse device common for all mice
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
atkbd.c: frame/parity error: 02
atkbd.c: frame/parity error: 02
atkbd.c: frame/parity error: 02
atkbd.c: frame/parity error: 02
atkbd.c: frame/parity error: 02
atkbd.c: frame/parity error: 02
atkbd.c: frame/parity error: 02
atkbd.c: frame/parity error: 02
atkbd.c: frame/parity error: 02
atkbd.c: frame/parity error: 02
atkbd.c: frame/parity error: 02
atkbd.c: frame/parity error: 02
atkbd.c: frame/parity error: 02
atkbd.c: frame/parity error: 02
atkbd.c: frame/parity error: 02
atkbd.c: frame/parity error: 02
atkbd.c: frame/parity error: 02
atkbd.c: frame/parity error: 02
atkbd.c: frame/parity error: 02
bad: scheduling while atomic!
Call Trace:
 [<c01191a9>] schedule+0x3b9/0x3c0
 [<c01191e6>] preempt_schedule+0x36/0x50
 [<c011d037>] printk+0x127/0x180
 [<c02804cf>] atkbd_interrupt+0x1ff/0x230
 [<c0124740>] do_timer+0xe0/0xf0
 [<c0282fda>] serio_interrupt+0x5a/0x60
 [<c02838d5>] i8042_interrupt+0x135/0x270
 [<c010bb2e>] do_IRQ+0x11e/0x160
 [<c0123e96>] mod_timer+0x136/0x190
 [<c0234a3b>] poke_blanked_console+0x6b/0x80
 [<c0233d32>] vt_console_print+0x212/0x300
 [<c011cd00>] __call_console_drivers+0x60/0x70
 [<c011cde5>] call_console_drivers+0x65/0x120
 [<c021a544>] __delay+0x14/0x20
 [<c02833ed>] i8042_wait_write+0x1d/0x40
 [<c0283533>] i8042_command+0xb3/0xc0
 [<c02835f2>] i8042_aux_write+0x52/0x70
 [<c02804ef>] atkbd_interrupt+0x21f/0x230
 [<c01242d6>] update_wall_time+0x16/0x40
 [<c0282fda>] serio_interrupt+0x5a/0x60
 [<c02838d5>] i8042_interrupt+0x135/0x270
 [<c0123e96>] mod_timer+0x136/0x190
 [<c0234a3b>] poke_blanked_console+0x6b/0x80
 [<c0233d32>] vt_console_print+0x212/0x300
 [<c011cd00>] __call_console_drivers+0x60/0x70
 [<c011cde5>] call_console_drivers+0x65/0x120
 [<c021a544>] __delay+0x14/0x20
 [<c02833ed>] i8042_wait_write+0x1d/0x40
 [<c0283533>] i8042_command+0xb3/0xc0
 [<c02835f2>] i8042_aux_write+0x52/0x70
 [<c02804ef>] atkbd_interrupt+0x21f/0x230
 [<c01242d6>] update_wall_time+0x16/0x40
 [<c0282fda>] serio_interrupt+0x5a/0x60
 [<c02838d5>] i8042_interrupt+0x135/0x270
 [<c0114835>] mark_offset_tsc+0x205/0x2a0
 [<c0124466>] update_process_times+0x46/0x50
 [<c01242d6>] update_wall_time+0x16/0x40
 [<c0124740>] do_timer+0xe0/0xf0
 [<c010fb28>] timer_interrupt+0xe8/0x130
 [<c010b72b>] handle_IRQ_event+0x3b/0x70
 [<c010bb2e>] do_IRQ+0x11e/0x160
 [<c0109e68>] common_interrupt+0x18/0x20
 [<c01191b0>] preempt_schedule+0x0/0x50
 [<c0283533>] i8042_command+0xb3/0xc0
 [<c02835f2>] i8042_aux_write+0x52/0x70
 [<c02804ef>] atkbd_interrupt+0x21f/0x230
 [<c0124740>] do_timer+0xe0/0xf0
 [<c0282fda>] serio_interrupt+0x5a/0x60
 [<c02838d5>] i8042_interrupt+0x135/0x270
 [<c010bb2e>] do_IRQ+0x11e/0x160
 [<c0114835>] mark_offset_tsc+0x205/0x2a0
 [<c0124466>] update_process_times+0x46/0x50
 [<c01242d6>] update_wall_time+0x16/0x40
 [<c0124740>] do_timer+0xe0/0xf0
 [<c010fb28>] timer_interrupt+0xe8/0x130
 [<c010b72b>] handle_IRQ_event+0x3b/0x70
 [<c010bb2e>] do_IRQ+0x11e/0x160
 [<c0109e68>] common_interrupt+0x18/0x20
 [<c01191b0>] preempt_schedule+0x0/0x50
 [<c0283533>] i8042_command+0xb3/0xc0
 [<c02835f2>] i8042_aux_write+0x52/0x70
 [<c02804ef>] atkbd_interrupt+0x21f/0x230
 [<c0282fda>] serio_interrupt+0x5a/0x60
 [<c02838d5>] i8042_interrupt+0x135/0x270
 [<c0123e96>] mod_timer+0x136/0x190
 [<c0234a3b>] poke_blanked_console+0x6b/0x80
 [<c0233d32>] vt_console_print+0x212/0x300
 [<c011cd00>] __call_console_drivers+0x60/0x70
 [<c011cde5>] call_console_drivers+0x65/0x120
 [<c021a544>] __delay+0x14/0x20
 [<c02833ed>] i8042_wait_write+0x1d/0x40
 [<c0283533>] i8042_command+0xb3/0xc0
 [<c02835f2>] i8042_aux_write+0x52/0x70
 [<c02804ef>] atkbd_interrupt+0x21f/0x230
 [<c0124740>] do_timer+0xe0/0xf0
 [<c0282fda>] serio_interrupt+0x5a/0x60
 [<c02838d5>] i8042_interrupt+0x135/0x270
 [<c010bb2e>] do_IRQ+0x11e/0x160
 [<c0123e96>] mod_timer+0x136/0x190
 [<c0234a3b>] poke_blanked_console+0x6b/0x80
 [<c0233d32>] vt_console_print+0x212/0x300
 [<c011cd00>] __call_console_drivers+0x60/0x70
 [<c011cde5>] call_console_drivers+0x65/0x120
 [<c021a544>] __delay+0x14/0x20
 [<c02833ed>] i8042_wait_write+0x1d/0x40
 [<c0283533>] i8042_command+0xb3/0xc0
 [<c02835f2>] i8042_aux_write+0x52/0x70
 [<c02804ef>] atkbd_interrupt+0x21f/0x230
 [<c01242d6>] update_wall_time+0x16/0x40
 [<c0282fda>] serio_interrupt+0x5a/0x60
 [<c02838d5>] i8042_interrupt+0x135/0x270
 [<c0123e96>] mod_timer+0x136/0x190
 [<c0234a3b>] poke_blanked_console+0x6b/0x80
 [<c0233d32>] vt_console_print+0x212/0x300
 [<c011cd00>] __call_console_drivers+0x60/0x70
 [<c011cde5>] call_console_drivers+0x65/0x120
 [<c021a544>] __delay+0x14/0x20
 [<c02833ed>] i8042_wait_write+0x1d/0x40
 [<c0283533>] i8042_command+0xb3/0xc0
 [<c02835f2>] i8042_aux_write+0x52/0x70
 [<c02804ef>] atkbd_interrupt+0x21f/0x230
 [<c0124740>] do_timer+0xe0/0xf0
 [<c0282fda>] serio_interrupt+0x5a/0x60
 [<c02838d5>] i8042_interrupt+0x135/0x270
 [<c010bb2e>] do_IRQ+0x11e/0x160
 [<c0114835>] mark_offset_tsc+0x205/0x2a0
 [<c0124466>] update_process_times+0x46/0x50
 [<c01242d6>] update_wall_time+0x16/0x40
 [<c0124740>] do_timer+0xe0/0xf0
 [<c010fb28>] timer_interrupt+0xe8/0x130
 [<c010b72b>] handle_IRQ_event+0x3b/0x70
 [<c010bb2e>] do_IRQ+0x11e/0x160
 [<c0109e8a>] apic_timer_interrupt+0x1a/0x20
 [<c01191b0>] preempt_schedule+0x0/0x50
 [<c0283533>] i8042_command+0xb3/0xc0
 [<c02835f2>] i8042_aux_write+0x52/0x70
 [<c02804ef>] atkbd_interrupt+0x21f/0x230
 [<c0109e68>] common_interrupt+0x18/0x20
 [<c0282fda>] serio_interrupt+0x5a/0x60
 [<c02838d5>] i8042_interrupt+0x135/0x270
 [<c0123e96>] mod_timer+0x136/0x190
 [<c0234a3b>] poke_blanked_console+0x6b/0x80
 [<c0233d32>] vt_console_print+0x212/0x300
 [<c011cd00>] __call_console_drivers+0x60/0x70
 [<c011cde5>] call_console_drivers+0x65/0x120
 [<c0109e8a>] apic_timer_interrupt+0x1a/0x20
 [<c02835f2>] i8042_aux_write+0x52/0x70
 [<c02804ef>] atkbd_interrupt+0x21f/0x230
 [<c0124740>] do_timer+0xe0/0xf0
 [<c0282fda>] serio_interrupt+0x5a/0x60
 [<c02838d5>] i8042_interrupt+0x135/0x270
 [<c010bb2e>] do_IRQ+0x11e/0x160
 [<c0123e96>] mod_timer+0x136/0x190
 [<c0234a3b>] poke_blanked_console+0x6b/0x80
 [<c0233d32>] vt_console_print+0x212/0x300
 [<c011cd00>] __call_console_drivers+0x60/0x70
 [<c011cde5>] call_console_drivers+0x65/0x120
 [<c021a544>] __delay+0x14/0x20
 [<c02833ed>] i8042_wait_write+0x1d/0x40
 [<c0283533>] i8042_command+0xb3/0xc0
 [<c02835f2>] i8042_aux_write+0x52/0x70
 [<c02804ef>] atkbd_interrupt+0x21f/0x230
 [<c01242d6>] update_wall_time+0x16/0x40
 [<c0282fda>] serio_interrupt+0x5a/0x60
 [<c02838d5>] i8042_interrupt+0x135/0x270
 [<c0123e96>] mod_timer+0x136/0x190
 [<c0234a3b>] poke_blanked_console+0x6b/0x80
 [<c0233d32>] vt_console_print+0x212/0x300
 [<c011cd00>] __call_console_drivers+0x60/0x70
 [<c011cde5>] call_console_drivers+0x65/0x120
 [<c021a544>] __delay+0x14/0x20
 [<c02833ed>] i8042_wait_write+0x1d/0x40
 [<c0283533>] i8042_command+0xb3/0xc0
 [<c02835f2>] i8042_aux_write+0x52/0x70
 [<c02804ef>] atkbd_interrupt+0x21f/0x230
 [<c01242d6>] update_wall_time+0x16/0x40
 [<c0282fda>] serio_interrupt+0x5a/0x60
 [<c02838d5>] i8042_interrupt+0x135/0x270
 [<c0114835>] mark_offset_tsc+0x205/0x2a0
 [<c0124466>] update_process_times+0x46/0x50
 [<c01242d6>] update_wall_time+0x16/0x40
 [<c0124740>] do_timer+0xe0/0xf0
 [<c010fb28>] timer_interrupt+0xe8/0x130
 [<c010b72b>] handle_IRQ_event+0x3b/0x70
 [<c010bb2e>] do_IRQ+0x11e/0x160
 [<c0109e68>] common_interrupt+0x18/0x20
 [<c01191b0>] preempt_schedule+0x0/0x50
 [<c0283533>] i8042_command+0xb3/0xc0
 [<c02835f2>] i8042_aux_write+0x52/0x70
 [<c02804ef>] atkbd_interrupt+0x21f/0x230
 [<c01242d6>] update_wall_time+0x16/0x40
 [<c0282fda>] serio_interrupt+0x5a/0x60
 [<c02838d5>] i8042_interrupt+0x135/0x270
 [<c0123e96>] mod_timer+0x136/0x190
 [<c0234a3b>] poke_blanked_console+0x6b/0x80
 [<c0233d32>] vt_console_print+0x212/0x300
 [<c011cd00>] __call_console_drivers+0x60/0x70
 [<c011cde5>] call_console_drivers+0x65/0x120
 [<c0109e8a>] apic_timer_interrupt+0x1a/0x20
 [<c02835f2>] i8042_aux_write+0x52/0x70
 [<c02804ef>] atkbd_interrupt+0x21f/0x230
 [<c01242d6>] update_wall_time+0x16/0x40
 [<c0282fda>] serio_interrupt+0x5a/0x60
 [<c02838d5>] i8042_interrupt+0x135/0x270
 [<c0123e96>] mod_timer+0x136/0x190
 [<c0234a3b>] poke_blanked_console+0x6b/0x80
 [<c0233d32>] vt_console_print+0x212/0x300
 [<c011cd00>] __call_console_drivers+0x60/0x70
 [<c011cde5>] call_console_drivers+0x65/0x120
 [<c021a544>] __delay+0x14/0x20
 [<c02833ed>] i8042_wait_write+0x1d/0x40
 [<c0283533>] i8042_command+0xb3/0xc0
 [<c02835f2>] i8042_aux_write+0x52/0x70
 [<c02804ef>] atkbd_interrupt+0x21f/0x230
 [<c0124740>] do_timer+0xe0/0xf0
 [<c0282fda>] serio_interrupt+0x5a/0x60
 [<c02838d5>] i8042_interrupt+0x135/0x270
 [<c010bb2e>] do_IRQ+0x11e/0x160
 [<c0123e96>] mod_timer+0x136/0x190
 [<c0234a3b>] poke_blanked_console+0x6b/0x80
 [<c0233d32>] vt_console_print+0x212/0x300
 [<c011cd00>] __call_console_drivers+0x60/0x70
 [<c011cde5>] call_console_drivers+0x65/0x120
 [<c021a544>] __delay+0x14/0x20
 [<c02833ed>] i8042_wait_write+0x1d/0x40
 [<c0283533>] i8042_command+0xb3/0xc0
 [<c02835f2>] i8042_aux_write+0x52/0x70
 [<c02804ef>] atkbd_interrupt+0x21f/0x230
 [<c01242d6>] update_wall_time+0x16/0x40
 [<c0282fda>] serio_interrupt+0x5a/0x60
 [<c02838d5>] i8042_interrupt+0x135/0x270
 [<c0114835>] mark_offset_tsc+0x205/0x2a0
 [<c0124466>] update_process_times+0x46/0x50
 [<c01242d6>] update_wall_time+0x16/0x40
 [<c0124740>] do_timer+0xe0/0xf0
 [<c010fb28>] timer_interrupt+0xe8/0x130
 [<c010b72b>] handle_IRQ_event+0x3b/0x70
 [<c010bb2e>] do_IRQ+0x11e/0x160
 [<c0109e68>] common_interrupt+0x18/0x20
 [<c01191b0>] preempt_schedule+0x0/0x50
 [<c0283533>] i8042_command+0xb3/0xc0
 [<c02835f2>] i8042_aux_write+0x52/0x70
 [<c02804ef>] atkbd_interrupt+0x21f/0x230
 [<c0124740>] do_timer+0xe0/0xf0
 [<c0282fda>] serio_interrupt+0x5a/0x60
 [<c02838d5>] i8042_interrupt+0x135/0x270
 [<c010bb2e>] do_IRQ+0x11e/0x160
 [<c0114835>] mark_offset_tsc+0x205/0x2a0
 [<c0124466>] update_process_times+0x46/0x50
 [<c01242d6>] update_wall_time+0x16/0x40
 [<c0124740>] do_timer+0xe0/0xf0
 [<c010fb28>] timer_interrupt+0xe8/0x130
 [<c010b72b>] handle_IRQ_event+0x3b/0x70
 [<c010bb2e>] do_IRQ+0x11e/0x160
 [<c0109e8a>] apic_timer_interrupt+0x1a/0x20
 [<c02835f2>] i8042_aux_write+0x52/0x70
 [<c02804ef>] atkbd_interrupt+0x21f/0x230
 [<c0124740>] do_timer+0xe0/0xf0
 [<c0282fda>] serio_interrupt+0x5a/0x60
 [<c02838d5>] i8042_interrupt+0x135/0x270
 [<c010bb2e>] do_IRQ+0x11e/0x160
 [<c0123e96>] mod_timer+0x136/0x190
 [<c0234a3b>] poke_blanked_console+0x6b/0x80
 [<c0233d32>] vt_console_print+0x212/0x300
 [<c011cd00>] __call_console_drivers+0x60/0x70
 [<c011cde5>] call_console_drivers+0x65/0x120
 [<c021a544>] __delay+0x14/0x20
 [<c02833ed>] i8042_wait_write+0x1d/0x40
 [<c0283533>] i8042_command+0xb3/0xc0
 [<c02835f2>] i8042_aux_write+0x52/0x70
 [<c02804ef>] atkbd_interrupt+0x21f/0x230
 [<c0282fda>] serio_interrupt+0x5a/0x60
 [<c02838d5>] i8042_interrupt+0x135/0x270
 [<c0137e4d>] __alloc_pages+0x8d/0x340
 [<c0114835>] mark_offset_tsc+0x205/0x2a0
 [<c0124466>] update_process_times+0x46/0x50
 [<c01242d6>] update_wall_time+0x16/0x40
 [<c0124740>] do_timer+0xe0/0xf0
 [<c010fb28>] timer_interrupt+0xe8/0x130
 [<c010b72b>] handle_IRQ_event+0x3b/0x70
 [<c010bb2e>] do_IRQ+0x11e/0x160
 [<c0109e68>] common_interrupt+0x18/0x20
 [<c010b72b>] handle_IRQ_event+0x3b/0x70
 [<c010baac>] do_IRQ+0x9c/0x160
 [<c0109e68>] common_interrupt+0x18/0x20
 [<c01148e2>] delay_tsc+0x12/0x20
 [<c021a544>] __delay+0x14/0x20
 [<c028055c>] atkbd_sendbyte+0x5c/0xa0
 [<c0280753>] atkbd_command+0x1b3/0x1c0
 [<c02809f3>] atkbd_probe+0x33/0x160
 [<c0283252>] serio_open+0x12/0x30
 [<c0280e22>] atkbd_connect+0x292/0x300
 [<c0109e68>] common_interrupt+0x18/0x20
 [<c0282d0a>] serio_find_dev+0x6a/0x70
 [<c0283038>] serio_register_port+0x58/0x70
 [<c0398f3b>] i8042_port_register+0x5b/0x90
 [<c0399243>] i8042_init+0x143/0x150
 [<c038080b>] do_initcalls+0x2b/0xa0
 [<c012bd32>] init_workqueues+0x12/0x30
 [<c01050a6>] init+0x36/0x190
 [<c0105070>] init+0x0/0x190
 [<c0107429>] kernel_thread_helper+0x5/0xc

Unable to handle kernel paging request at virtual address 00ca8108
 printing eip:
c0118e89
*pde = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c0118e89>]    Not tainted
EFLAGS: 00010016
EIP is at schedule+0x99/0x3c0
eax: 7481e850   ebx: c0107429   ecx: c0107449   edx: 89000000
esi: 00ca8108   edi: c03d31c0   ebp: dbe9204c   esp: dbe92024
ds: 007b   es: 007b   ss: 0068
Process  (pid: -605094084, threadinfo=dbe90000 task=dbeefec0)
Stack: c02ff5e0 00000002 00000000 00000010 00000002 00000000 00000001 dbe92000
       00000246 00000020 dbe92058 c01191e6 c03d3f80 dbe9208c c011d037 0000000a
       00000400 c03247c2 dbe9209c 00000000 00000001 00000000 dbe9209c c03eaa90
Call Trace:
 [<c01191e6>] preempt_schedule+0x36/0x50
 [<c011d037>] printk+0x127/0x180
 [<c02804cf>] atkbd_interrupt+0x1ff/0x230
 [<c0124740>] do_timer+0xe0/0xf0
 [<c0282fda>] serio_interrupt+0x5a/0x60
 [<c02838d5>] i8042_interrupt+0x135/0x270
 [<c010bb2e>] do_IRQ+0x11e/0x160
 [<c0123e96>] mod_timer+0x136/0x190
 [<c0234a3b>] poke_blanked_console+0x6b/0x80
 [<c0233d32>] vt_console_print+0x212/0x300
 [<c011cd00>] __call_console_drivers+0x60/0x70
 [<c011cde5>] call_console_drivers+0x65/0x120
 [<c021a544>] __delay+0x14/0x20
 [<c02833ed>] i8042_wait_write+0x1d/0x40
 [<c0283533>] i8042_command+0xb3/0xc0
 [<c02835f2>] i8042_aux_write+0x52/0x70
 [<c02804ef>] atkbd_interrupt+0x21f/0x230
 [<c01242d6>] update_wall_time+0x16/0x40
 [<c0282fda>] serio_interrupt+0x5a/0x60
 [<c02838d5>] i8042_interrupt+0x135/0x270
 [<c0123e96>] mod_timer+0x136/0x190
 [<c0234a3b>] poke_blanked_console+0x6b/0x80
 [<c0233d32>] vt_console_print+0x212/0x300
 [<c011cd00>] __call_console_drivers+0x60/0x70
 [<c011cde5>] call_console_drivers+0x65/0x120
 [<c021a544>] __delay+0x14/0x20
 [<c02833ed>] i8042_wait_write+0x1d/0x40
 [<c0283533>] i8042_command+0xb3/0xc0
 [<c02835f2>] i8042_aux_write+0x52/0x70
 [<c02804ef>] atkbd_interrupt+0x21f/0x230
 [<c01242d6>] update_wall_time+0x16/0x40
 [<c0282fda>] serio_interrupt+0x5a/0x60
 [<c02838d5>] i8042_interrupt+0x135/0x270
 [<c0114835>] mark_offset_tsc+0x205/0x2a0
 [<c0124466>] update_process_times+0x46/0x50
 [<c01242d6>] update_wall_time+0x16/0x40
 [<c0124740>] do_timer+0xe0/0xf0
 [<c010fb28>] timer_interrupt+0xe8/0x130
 [<c010b72b>] handle_IRQ_event+0x3b/0x70
 [<c010bb2e>] do_IRQ+0x11e/0x160
 [<c0109e68>] common_interrupt+0x18/0x20
 [<c01191b0>] preempt_schedule+0x0/0x50
 [<c0283533>] i8042_command+0xb3/0xc0
 [<c02835f2>] i8042_aux_write+0x52/0x70
 [<c02804ef>] atkbd_interrupt+0x21f/0x230
 [<c0124740>] do_timer+0xe0/0xf0
 [<c0282fda>] serio_interrupt+0x5a/0x60
 [<c02838d5>] i8042_interrupt+0x135/0x270
 [<c010bb2e>] do_IRQ+0x11e/0x160
 [<c0114835>] mark_offset_tsc+0x205/0x2a0
 [<c0124466>] update_process_times+0x46/0x50
 [<c01242d6>] update_wall_time+0x16/0x40
 [<c0124740>] do_timer+0xe0/0xf0
 [<c010fb28>] timer_interrupt+0xe8/0x130
 [<c010b72b>] handle_IRQ_event+0x3b/0x70
 [<c010bb2e>] do_IRQ+0x11e/0x160
 [<c0109e68>] common_interrupt+0x18/0x20
 [<c01191b0>] preempt_schedule+0x0/0x50
 [<c0283533>] i8042_command+0xb3/0xc0
 [<c02835f2>] i8042_aux_write+0x52/0x70
 [<c02804ef>] atkbd_interrupt+0x21f/0x230
 [<c0282fda>] serio_interrupt+0x5a/0x60
 [<c02838d5>] i8042_interrupt+0x135/0x270
 [<c0123e96>] mod_timer+0x136/0x190
 [<c0234a3b>] poke_blanked_console+0x6b/0x80
 [<c0233d32>] vt_console_print+0x212/0x300
 [<c011cd00>] __call_console_drivers+0x60/0x70
 [<c011cde5>] call_console_drivers+0x65/0x120
 [<c021a544>] __delay+0x14/0x20
 [<c02833ed>] i8042_wait_write+0x1d/0x40
 [<c0283533>] i8042_command+0xb3/0xc0
 [<c02835f2>] i8042_aux_write+0x52/0x70
 [<c02804ef>] atkbd_interrupt+0x21f/0x230
 [<c0124740>] do_timer+0xe0/0xf0
 [<c0282fda>] serio_interrupt+0x5a/0x60
 [<c02838d5>] i8042_interrupt+0x135/0x270
 [<c010bb2e>] do_IRQ+0x11e/0x160
 [<c0123e96>] mod_timer+0x136/0x190
 [<c0234a3b>] poke_blanked_console+0x6b/0x80
 [<c0233d32>] vt_console_print+0x212/0x300
 [<c011cd00>] __call_console_drivers+0x60/0x70
 [<c011cde5>] call_console_drivers+0x65/0x120
 [<c021a544>] __delay+0x14/0x20
 [<c02833ed>] i8042_wait_write+0x1d/0x40
 [<c0283533>] i8042_command+0xb3/0xc0
 [<c02835f2>] i8042_aux_write+0x52/0x70
 [<c02804ef>] atkbd_interrupt+0x21f/0x230
 [<c01242d6>] update_wall_time+0x16/0x40
 [<c0282fda>] serio_interrupt+0x5a/0x60
 [<c02838d5>] i8042_interrupt+0x135/0x270
 [<c0123e96>] mod_timer+0x136/0x190
 [<c0234a3b>] poke_blanked_console+0x6b/0x80
 [<c0233d32>] vt_console_print+0x212/0x300
 [<c011cd00>] __call_console_drivers+0x60/0x70
 [<c011cde5>] call_console_drivers+0x65/0x120
 [<c021a544>] __delay+0x14/0x20
 [<c02833ed>] i8042_wait_write+0x1d/0x40
 [<c0283533>] i8042_command+0xb3/0xc0
 [<c02835f2>] i8042_aux_write+0x52/0x70
 [<c02804ef>] atkbd_interrupt+0x21f/0x230
 [<c0124740>] do_timer+0xe0/0xf0
 [<c0282fda>] serio_interrupt+0x5a/0x60
 [<c02838d5>] i8042_interrupt+0x135/0x270
 [<c010bb2e>] do_IRQ+0x11e/0x160
 [<c0114835>] mark_offset_tsc+0x205/0x2a0
 [<c0124466>] update_process_times+0x46/0x50
 [<c01242d6>] update_wall_time+0x16/0x40
 [<c0124740>] do_timer+0xe0/0xf0
 [<c010fb28>] timer_interrupt+0xe8/0x130
 [<c010b72b>] handle_IRQ_event+0x3b/0x70
 [<c010bb2e>] do_IRQ+0x11e/0x160
 [<c0109e8a>] apic_timer_interrupt+0x1a/0x20
 [<c01191b0>] preempt_schedule+0x0/0x50
 [<c0283533>] i8042_command+0xb3/0xc0
 [<c02835f2>] i8042_aux_write+0x52/0x70
 [<c02804ef>] atkbd_interrupt+0x21f/0x230
 [<c0109e68>] common_interrupt+0x18/0x20
 [<c0282fda>] serio_interrupt+0x5a/0x60
 [<c02838d5>] i8042_interrupt+0x135/0x270
 [<c0123e96>] mod_timer+0x136/0x190
 [<c0234a3b>] poke_blanked_console+0x6b/0x80
 [<c0233d32>] vt_console_print+0x212/0x300
 [<c011cd00>] __call_console_drivers+0x60/0x70
 [<c011cde5>] call_console_drivers+0x65/0x120
 [<c0109e8a>] apic_timer_interrupt+0x1a/0x20
 [<c02835f2>] i8042_aux_write+0x52/0x70
 [<c02804ef>] atkbd_interrupt+0x21f/0x230
 [<c0124740>] do_timer+0xe0/0xf0
 [<c0282fda>] serio_interrupt+0x5a/0x60
 [<c02838d5>] i8042_interrupt+0x135/0x270
 [<c010bb2e>] do_IRQ+0x11e/0x160
 [<c0123e96>] mod_timer+0x136/0x190
 [<c0234a3b>] poke_blanked_console+0x6b/0x80
 [<c0233d32>] vt_console_print+0x212/0x300
 [<c011cd00>] __call_console_drivers+0x60/0x70
 [<c011cde5>] call_console_drivers+0x65/0x120
 [<c021a544>] __delay+0x14/0x20
 [<c02833ed>] i8042_wait_write+0x1d/0x40
 [<c0283533>] i8042_command+0xb3/0xc0
 [<c02835f2>] i8042_aux_write+0x52/0x70
 [<c02804ef>] atkbd_interrupt+0x21f/0x230
 [<c01242d6>] update_wall_time+0x16/0x40
 [<c0282fda>] serio_interrupt+0x5a/0x60
 [<c02838d5>] i8042_interrupt+0x135/0x270
 [<c0123e96>] mod_timer+0x136/0x190
 [<c0234a3b>] poke_blanked_console+0x6b/0x80
 [<c0233d32>] vt_console_print+0x212/0x300
 [<c011cd00>] __call_console_drivers+0x60/0x70
 [<c011cde5>] call_console_drivers+0x65/0x120
 [<c021a544>] __delay+0x14/0x20
 [<c02833ed>] i8042_wait_write+0x1d/0x40
 [<c0283533>] i8042_command+0xb3/0xc0
 [<c02835f2>] i8042_aux_write+0x52/0x70
 [<c02804ef>] atkbd_interrupt+0x21f/0x230
 [<c01242d6>] update_wall_time+0x16/0x40
 [<c0282fda>] serio_interrupt+0x5a/0x60
 [<c02838d5>] i8042_interrupt+0x135/0x270
 [<c0114835>] mark_offset_tsc+0x205/0x2a0
 [<c0124466>] update_process_times+0x46/0x50
 [<c01242d6>] update_wall_time+0x16/0x40
 [<c0124740>] do_timer+0xe0/0xf0
 [<c010fb28>] timer_interrupt+0xe8/0x130
 [<c010b72b>] handle_IRQ_event+0x3b/0x70
 [<c010bb2e>] do_IRQ+0x11e/0x160
 [<c0109e68>] common_interrupt+0x18/0x20
 [<c01191b0>] preempt_schedule+0x0/0x50
 [<c0283533>] i8042_command+0xb3/0xc0
 [<c02835f2>] i8042_aux_write+0x52/0x70
 [<c02804ef>] atkbd_interrupt+0x21f/0x230
 [<c01242d6>] update_wall_time+0x16/0x40
 [<c0282fda>] serio_interrupt+0x5a/0x60
 [<c02838d5>] i8042_interrupt+0x135/0x270
 [<c0123e96>] mod_timer+0x136/0x190
 [<c0234a3b>] poke_blanked_console+0x6b/0x80
 [<c0233d32>] vt_console_print+0x212/0x300
 [<c011cd00>] __call_console_drivers+0x60/0x70
 [<c011cde5>] call_console_drivers+0x65/0x120
 [<c0109e8a>] apic_timer_interrupt+0x1a/0x20
 [<c02835f2>] i8042_aux_write+0x52/0x70
 [<c02804ef>] atkbd_interrupt+0x21f/0x230
 [<c01242d6>] update_wall_time+0x16/0x40
 [<c0282fda>] serio_interrupt+0x5a/0x60
 [<c02838d5>] i8042_interrupt+0x135/0x270
 [<c0123e96>] mod_timer+0x136/0x190
 [<c0234a3b>] poke_blanked_console+0x6b/0x80
 [<c0233d32>] vt_console_print+0x212/0x300
 [<c011cd00>] __call_console_drivers+0x60/0x70
 [<c011cde5>] call_console_drivers+0x65/0x120
 [<c021a544>] __delay+0x14/0x20
 [<c02833ed>] i8042_wait_write+0x1d/0x40
 [<c0283533>] i8042_command+0xb3/0xc0
 [<c02835f2>] i8042_aux_write+0x52/0x70
 [<c02804ef>] atkbd_interrupt+0x21f/0x230
 [<c0124740>] do_timer+0xe0/0xf0
 [<c0282fda>] serio_interrupt+0x5a/0x60
 [<c02838d5>] i8042_interrupt+0x135/0x270
 [<c010bb2e>] do_IRQ+0x11e/0x160
 [<c0123e96>] mod_timer+0x136/0x190
 [<c0234a3b>] poke_blanked_console+0x6b/0x80
 [<c0233d32>] vt_console_print+0x212/0x300
 [<c011cd00>] __call_console_drivers+0x60/0x70
 [<c011cde5>] call_console_drivers+0x65/0x120
 [<c021a544>] __delay+0x14/0x20
 [<c02833ed>] i8042_wait_write+0x1d/0x40
 [<c0283533>] i8042_command+0xb3/0xc0
 [<c02835f2>] i8042_aux_write+0x52/0x70
 [<c02804ef>] atkbd_interrupt+0x21f/0x230
 [<c01242d6>] update_wall_time+0x16/0x40
 [<c0282fda>] serio_interrupt+0x5a/0x60
 [<c02838d5>] i8042_interrupt+0x135/0x270
 [<c0114835>] mark_offset_tsc+0x205/0x2a0
 [<c0124466>] update_process_times+0x46/0x50
 [<c01242d6>] update_wall_time+0x16/0x40
 [<c0124740>] do_timer+0xe0/0xf0
 [<c010fb28>] timer_interrupt+0xe8/0x130
 [<c010b72b>] handle_IRQ_event+0x3b/0x70
 [<c010bb2e>] do_IRQ+0x11e/0x160
 [<c0109e68>] common_interrupt+0x18/0x20
 [<c01191b0>] preempt_schedule+0x0/0x50
 [<c0283533>] i8042_command+0xb3/0xc0
 [<c02835f2>] i8042_aux_write+0x52/0x70
 [<c02804ef>] atkbd_interrupt+0x21f/0x230
 [<c0124740>] do_timer+0xe0/0xf0
 [<c0282fda>] serio_interrupt+0x5a/0x60
 [<c02838d5>] i8042_interrupt+0x135/0x270
 [<c010bb2e>] do_IRQ+0x11e/0x160
 [<c0114835>] mark_offset_tsc+0x205/0x2a0
 [<c0124466>] update_process_times+0x46/0x50
 [<c01242d6>] update_wall_time+0x16/0x40
 [<c0124740>] do_timer+0xe0/0xf0
 [<c010fb28>] timer_interrupt+0xe8/0x130
 [<c010b72b>] handle_IRQ_event+0x3b/0x70
 [<c010bb2e>] do_IRQ+0x11e/0x160
 [<c0109e8a>] apic_timer_interrupt+0x1a/0x20
 [<c02835f2>] i8042_aux_write+0x52/0x70
 [<c02804ef>] atkbd_interrupt+0x21f/0x230
 [<c0124740>] do_timer+0xe0/0xf0
 [<c0282fda>] serio_interrupt+0x5a/0x60
 [<c02838d5>] i8042_interrupt+0x135/0x270
 [<c010bb2e>] do_IRQ+0x11e/0x160
 [<c0123e96>] mod_timer+0x136/0x190
 [<c0234a3b>] poke_blanked_console+0x6b/0x80
 [<c0233d32>] vt_console_print+0x212/0x300
 [<c011cd00>] __call_console_drivers+0x60/0x70
 [<c011cde5>] call_console_drivers+0x65/0x120
 [<c021a544>] __delay+0x14/0x20
 [<c02833ed>] i8042_wait_write+0x1d/0x40
 [<c0283533>] i8042_command+0xb3/0xc0
 [<c02835f2>] i8042_aux_write+0x52/0x70
 [<c02804ef>] atkbd_interrupt+0x21f/0x230
 [<c0282fda>] serio_interrupt+0x5a/0x60
 [<c02838d5>] i8042_interrupt+0x135/0x270
 [<c0137e4d>] __alloc_pages+0x8d/0x340
 [<c0114835>] mark_offset_tsc+0x205/0x2a0
 [<c0124466>] update_process_times+0x46/0x50
 [<c01242d6>] update_wall_time+0x16/0x40
 [<c0124740>] do_timer+0xe0/0xf0
 [<c010fb28>] timer_interrupt+0xe8/0x130
 [<c010b72b>] handle_IRQ_event+0x3b/0x70
 [<c010bb2e>] do_IRQ+0x11e/0x160
 [<c0109e68>] common_interrupt+0x18/0x20
 [<c010b72b>] handle_IRQ_event+0x3b/0x70
 [<c010baac>] do_IRQ+0x9c/0x160
 [<c0109e68>] common_interrupt+0x18/0x20
 [<c01148e2>] delay_tsc+0x12/0x20
 [<c021a544>] __delay+0x14/0x20
 [<c028055c>] atkbd_sendbyte+0x5c/0xa0
 [<c0280753>] atkbd_command+0x1b3/0x1c0
 [<c02809f3>] atkbd_probe+0x33/0x160
 [<c0283252>] serio_open+0x12/0x30
 [<c0280e22>] atkbd_connect+0x292/0x300
 [<c0109e68>] common_interrupt+0x18/0x20
 [<c0282d0a>] serio_find_dev+0x6a/0x70
 [<c0283038>] serio_register_port+0x58/0x70
 [<c0398f3b>] i8042_port_register+0x5b/0x90
 [<c0399243>] i8042_init+0x143/0x150
 [<c038080b>] do_initcalls+0x2b/0xa0
 [<c012bd32>] init_workqueues+0x12/0x30
 [<c01050a6>] init+0x36/0x190
 [<c0105070>] init+0x0/0x190
 [<c0107429>] kernel_thread_helper+0x5/0xc

Code: ff 0e 8b 51 04 8b 43 20 89 50 04 89 02 c7 41 04 00 02 20 00
 <0>Kernel panic: Fatal exception in interrupt
In interrupt handler - not syncing
 <1>Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c0125736
*pde = 00000000
Oops: 0002 [#2]
CPU:    0
EIP:    0060:[<c0125736>]    Not tainted
EFLAGS: 00010002
EIP is at send_signal+0x56/0x150
eax: 00000000   ebx: 00000001   ecx: dbdb4910   edx: 00000010
esi: dbef0474   edi: 00000018   ebp: dbe91dcc   esp: dbe91db0
ds: 007b   es: 007b   ss: 0068
Process  (pid: -605094084, threadinfo=dbe90000 task=dbeefec0)
Stack: dbee795c 00000020 dbe91de0 00000000 dbeefec0 00000018 00000000 dbe91df0
       c01258ae 00000018 00000001 dbef0474 00000000 00000002 dbe90000 00000000
       dbe91e10 c0126368 00000018 00000001 dbeefec0 00000001 dbeefec0 00000000
Call Trace:
 [<c01258ae>] specific_send_sig_info+0x7e/0x140
 [<c0126368>] send_sig_info+0x38/0x70
 [<c012440c>] update_one_process+0x10c/0x120
 [<c0124455>] update_process_times+0x35/0x50
 [<c0124695>] do_timer+0x35/0xf0
 [<c010fa92>] timer_interrupt+0x52/0x130
 [<c010b72b>] handle_IRQ_event+0x3b/0x70
 [<c010baac>] do_IRQ+0x9c/0x160
 [<c0109e68>] common_interrupt+0x18/0x20
 [<c011c810>] panic+0xe0/0x110
 [<c010a594>] die+0xd4/0xf0
 [<c011788d>] do_page_fault+0x15d/0x4dc
 [<c01245a2>] run_timer_softirq+0x112/0x1c0
 [<c0119312>] __wake_up_locked+0x22/0x30
 [<c0108463>] __down_trylock+0x53/0x64
 [<c01084a2>] __down_failed_trylock+0xa/0x10
 [<c011d052>] printk+0x142/0x180
 [<c0107429>] kernel_thread_helper+0x5/0xc
 [<c0117730>] do_page_fault+0x0/0x4dc
 [<c0109f05>] error_code+0x2d/0x38
 [<c0107429>] kernel_thread_helper+0x5/0xc
 [<c0107449>] kernel_thread+0x19/0x90

Code: 89 08 89 41 04 74 65 83 fb 01 74 3f 8b 53 08 8d 41 10 85 d2
 <0>Kernel panic: Fatal exception in interrupt
In interrupt handler - not syncing

