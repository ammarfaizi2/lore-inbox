Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263376AbTIHSJo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 14:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263439AbTIHSJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 14:09:44 -0400
Received: from fw.osdl.org ([65.172.181.6]:26760 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263376AbTIHSJh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 14:09:37 -0400
Date: Mon, 8 Sep 2003 11:03:31 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "John Stoffel" <stoffel@lucent.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4-mm4 - bad floppy hangs keyboard input
Message-Id: <20030908110331.1c9ab53b.rddunlap@osdl.org>
In-Reply-To: <16220.41581.316059.514526@gargle.gargle.HOWL>
References: <200309030710.h837AXnR000500@81-2-122-30.bradfords.org.uk>
	<16220.41581.316059.514526@gargle.gargle.HOWL>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Sep 2003 11:38:21 -0400 "John Stoffel" <stoffel@lucent.com> wrote:

| 
| Hi,
| 
| I've run into a wierd problem with 2.6.0-test4-mm4 on an SMP Xeon
| 550Mhz system.  I was dd'ing some images to floppy and when I used a
| bad floppy, it would read 17+0 blocks, write 16+0 blocks and then
| hang.  At this point, I couldn't use the keyboard at all, and I got an
| error message about "lost serial connection to UPS", which is from
| apcupsd, which I have talking over my Cyclades Cyclom-8y ISA serial
| port card.  
| 
| At this point, the load jumps to 1, nothing happes on the floppy
| drive, and I can't input data to xterms.  I can browse the web just
| fine using the mouse inside Galeon, and other stuff runs just fine.  I
| can even cut'n'paste stuff from one xterm and have it run in another.  
| 
| But the only way I've found to fix this is to reboot, which requires
| an fsck of my disks, which takes a while.  I'll see if I can re-create
| this in more detail tonight while at home, and hopefully from a
| console.
| 
| Strangley enough, Magic SysReq still seems to work, since that's how I
| reboot.  Logging out of Xwindows works, but then when I try to reboot
| the system from gdm, it hangs at a blank screen.
| 
| Whee!
| 
| Here's my interrupts:
| 
| jfsnew:~> cat /proc/interrupts 
|            CPU0       CPU1       
|   0:   44911738        411    IO-APIC-edge  timer
|   1:       1290          0    IO-APIC-edge  i8042
|   2:          0          0          XT-PIC  cascade
|   8:          1          0    IO-APIC-edge  rtc
|  11:     861346          2    IO-APIC-edge  Cyclom-Y
|  12:       2053          0    IO-APIC-edge  i8042
|  14:     141353          0    IO-APIC-edge  ide0
|  16:          0          0   IO-APIC-level  ohci-hcd
|  17:       6447          0   IO-APIC-level  ohci-hcd, eth0
|  18:     214706          1   IO-APIC-level  aic7xxx, aic7xxx, ehci_hcd
|  19:         50          0   IO-APIC-level  aic7xxx, uhci-hcd
| NMI:          0          0 
| LOC:   44911434   44911479 
| ERR:          0
| MIS:          0
| 
| -------------------------------------------------------------------
| /var/log/messages
| -------------------------------------------------------------------
| 
| Sep  7 22:55:26 jfsnew kernel: floppy0: sector not found: track 0, head 1, secto
| r 1, size 2
| Sep  7 22:55:26 jfsnew kernel: floppy0: sector not found: track 0, head 1, secto
| r 1, size 2
| Sep  7 22:55:26 jfsnew kernel: end_request: I/O error, dev fd0, sector 18
| Sep  7 22:55:26 jfsnew kernel: Unable to handle kernel paging request at virtual
|  address eb655050
| Sep  7 22:55:26 jfsnew kernel:  printing eip:
| Sep  7 22:55:26 jfsnew kernel: c02ac816
| Sep  7 22:55:26 jfsnew kernel: *pde = 00541063
| Sep  7 22:55:26 jfsnew kernel: *pte = 2b655000
| Sep  7 22:55:26 jfsnew kernel: Oops: 0000 [#1]
| Sep  7 22:55:26 jfsnew kernel: SMP DEBUG_PAGEALLOC
| Sep  7 22:55:26 jfsnew kernel: CPU:    0
| Sep  7 22:55:26 jfsnew kernel: EIP:    0060:[bad_flp_intr+150/224]    Not tainte
| d VLI
| Sep  7 22:55:26 jfsnew kernel: EIP:    0060:[<c02ac816>]    Not tainted VLI
| Sep  7 22:55:26 jfsnew kernel: EFLAGS: 00010246
| Sep  7 22:55:26 jfsnew kernel: EIP is at bad_flp_intr+0x96/0xe0
| Sep  7 22:55:26 jfsnew kernel: eax: 00000000   ebx: 00000000   ecx: 00000000   e
| dx: eb655050
| Sep  7 22:55:26 jfsnew kernel: esi: c0520c00   edi: eb655050   ebp: 00000002   e
| sp: efea7f5c
| Sep  7 22:55:26 jfsnew kernel: ds: 007b   es: 007b   ss: 0068
| Sep  7 22:55:26 jfsnew kernel: Process events/0 (pid: 6, threadinfo=efea6000 tas
| k=c17ef000)
| Sep  7 22:55:26 jfsnew kernel: Stack: 00000000 00000000 00000001 c02ad0ba 000000
| 00 c0430940 00000003 c0471680 
| Sep  7 22:55:26 jfsnew kernel:        00000283 c17f0004 00000000 c02aa5f1 c04716
| c0 c013547d 00000000 5a5a5a5a 
| Sep  7 22:55:26 jfsnew kernel:        c02aa5e0 00000001 00000000 c011f840 000100
| 00 00000000 00000000 c17dbf1c 
| Sep  7 22:55:26 jfsnew kernel: Call Trace:
| Sep  7 22:55:26 jfsnew kernel:  [rw_interrupt+474/800] rw_interrupt+0x1da/0x320
| Sep  7 22:55:26 jfsnew kernel:  [<c02ad0ba>] rw_interrupt+0x1da/0x320
| Sep  7 22:55:26 jfsnew kernel:  [main_command_interrupt+17/32] main_command_inte
| rrupt+0x11/0x20
| Sep  7 22:55:26 jfsnew kernel:  [<c02aa5f1>] main_command_interrupt+0x11/0x20
| Sep  7 22:55:26 jfsnew kernel:  [worker_thread+525/816] worker_thread+0x20d/0x33
| 0
| Sep  7 22:55:26 jfsnew kernel:  [<c013547d>] worker_thread+0x20d/0x330
| Sep  7 22:55:26 jfsnew kernel:  [main_command_interrupt+0/32] main_command_inter
| rupt+0x0/0x20
| Sep  7 22:55:26 jfsnew kernel:  [<c02aa5e0>] main_command_interrupt+0x0/0x20
| Sep  7 22:55:26 jfsnew kernel:  [default_wake_function+0/32] default_wake_functi
| on+0x0/0x20
| Sep  7 22:55:26 jfsnew kernel:  [<c011f840>] default_wake_function+0x0/0x20
| Sep  7 22:55:26 jfsnew kernel:  [ret_from_fork+6/20] ret_from_fork+0x6/0x14
| Sep  7 22:55:26 jfsnew kernel:  [<c03b5fd2>] ret_from_fork+0x6/0x14
| Sep  7 22:55:26 jfsnew kernel:  [default_wake_function+0/32] default_wake_functi
| on+0x0/0x20
| Sep  7 22:55:26 jfsnew kernel:  [<c011f840>] default_wake_function+0x0/0x20
| Sep  7 22:55:26 jfsnew kernel:  [worker_thread+0/816] worker_thread+0x0/0x330
| Sep  7 22:55:26 jfsnew kernel:  [<c0135270>] worker_thread+0x0/0x330
| Sep  7 22:55:26 jfsnew kernel:  [kernel_thread_helper+5/12] kernel_thread_helper
| +0x5/0xc
| Sep  7 22:55:26 jfsnew kernel:  [<c010ac69>] kernel_thread_helper+0x5/0xc
| Sep  7 22:55:26 jfsnew kernel: 
| Sep  7 22:55:26 jfsnew kernel: Code: 52 c0 8d 04 9b 8d 04 43 8b 44 c6 28 39 07 7
| 6 0b 6a 00 a1 24 1c 52 c0 ff 50 0c 5b 0f b6 0d 84 1c 52 c0 8b 15 20 1c 52 c0 8d 
| 04 89 <8b> 12 8d 04 41 c1 e0 03 3b 54 06 30 76 11 a1 80 1c 52 c0 c1 e0 
| Sep  7 22:55:38 jfsnew apcupsd[1324]: Serial communications with UPS lost 
| Sep  7 22:55:46 jfsnew kernel:  
| Sep  7 22:55:46 jfsnew kernel: floppy driver state
| Sep  7 22:55:46 jfsnew kernel: -------------------
| Sep  7 22:55:46 jfsnew kernel: now=4294937721 last interrupt=4294917720 diff=200
| 01 last called handler=c02aa5e0
| Sep  7 22:55:46 jfsnew kernel: timeout_message=request done %%d
| Sep  7 22:55:46 jfsnew kernel: last output bytes:
| Sep  7 22:55:46 jfsnew kernel:  0 90 4294917324
| Sep  7 22:55:46 jfsnew kernel: 13 80 4294917324
| Sep  7 22:55:46 jfsnew kernel:  0 90 4294917324
| Sep  7 22:55:46 jfsnew kernel: 1a 90 4294917324
| Sep  7 22:55:46 jfsnew kernel:  0 90 4294917324
| Sep  7 22:55:46 jfsnew kernel:  3 80 4294917324
| Sep  7 22:55:46 jfsnew kernel: c1 90 4294917324
| Sep  7 22:55:46 jfsnew kernel: 10 90 4294917324
| Sep  7 22:55:46 jfsnew kernel:  7 80 4294917324
| Sep  7 22:55:46 jfsnew kernel:  0 90 4294917324
| Sep  7 22:55:46 jfsnew kernel:  8 81 4294917324
| Sep  7 22:55:46 jfsnew kernel: e6 80 4294917324
| Sep  7 22:55:46 jfsnew kernel:  4 90 4294917324
| Sep  7 22:55:46 jfsnew kernel:  0 90 4294917324
| Sep  7 22:55:46 jfsnew kernel:  1 90 4294917324
| Sep  7 22:55:46 jfsnew kernel:  1 90 4294917324
| Sep  7 22:55:46 jfsnew kernel:  2 90 4294917325
| Sep  7 22:55:46 jfsnew kernel: 12 90 4294917325
| Sep  7 22:55:46 jfsnew kernel: 1b 90 4294917325
| Sep  7 22:55:46 jfsnew kernel: ff 90 4294917325
| Sep  7 22:55:46 jfsnew kernel: last result at 4294917720
| Sep  7 22:55:46 jfsnew kernel: last redo_fd_request at 4294917324
| Sep  7 22:55:46 jfsnew kernel: 44  1  0  0  1  1  2 
| Sep  7 22:55:46 jfsnew kernel: status=80
| Sep  7 22:55:46 jfsnew kernel: fdc_busy=1
| Sep  7 22:55:46 jfsnew kernel: cont=c0471720
| Sep  7 22:55:46 jfsnew kernel: current_req=00000000
| Sep  7 22:55:46 jfsnew kernel: command_status=-1
| Sep  7 22:55:46 jfsnew kernel: 
| Sep  7 22:55:46 jfsnew kernel: floppy0: floppy timeout called
| Sep  7 22:55:46 jfsnew kernel: floppy.c: no request in request_done
| Sep  7 22:55:49 jfsnew kernel: 
| Sep  7 22:55:49 jfsnew kernel: floppy driver state
| Sep  7 22:55:49 jfsnew kernel: -------------------
| Sep  7 22:55:49 jfsnew kernel: now=4294940721 last interrupt=4294937722 diff=299
| 9 last called handler=c02abc40
| Sep  7 22:55:49 jfsnew kernel: timeout_message=redo fd request
| Sep  7 22:55:49 jfsnew kernel: last output bytes:
| Sep  7 22:55:49 jfsnew kernel:  0 90 4294917324
| Sep  7 22:55:49 jfsnew kernel:  3 80 4294917324
| Sep  7 22:55:49 jfsnew kernel: c1 90 4294917324
| Sep  7 22:55:49 jfsnew kernel: 10 90 4294917324
| Sep  7 22:55:49 jfsnew kernel:  7 80 4294917324
| Sep  7 22:55:49 jfsnew kernel:  0 90 4294917324
| Sep  7 22:55:49 jfsnew kernel:  8 81 4294917324
| Sep  7 22:55:49 jfsnew kernel: e6 80 4294917324
| Sep  7 22:55:49 jfsnew kernel:  4 90 4294917324
| Sep  7 22:55:49 jfsnew kernel:  0 90 4294917324
| Sep  7 22:55:49 jfsnew kernel:  1 90 4294917324
| Sep  7 22:55:49 jfsnew kernel:  1 90 4294917324
| Sep  7 22:55:49 jfsnew kernel:  2 90 4294917325
| Sep  7 22:55:49 jfsnew kernel: 12 90 4294917325
| Sep  7 22:55:49 jfsnew kernel: 1b 90 4294917325
| Sep  7 22:55:49 jfsnew kernel: ff 90 4294917325
| Sep  7 22:55:49 jfsnew kernel:  8 80 4294937722
| Sep  7 22:55:49 jfsnew last message repeated 3 times
| Sep  7 22:55:49 jfsnew kernel: last result at 4294937722
| Sep  7 22:55:49 jfsnew kernel: last redo_fd_request at 4294937721
| Sep  7 22:55:49 jfsnew kernel: c3  0 
| Sep  7 22:55:49 jfsnew kernel: status=80
| Sep  7 22:55:49 jfsnew kernel: fdc_busy=1
| Sep  7 22:55:49 jfsnew kernel: floppy_work.func=c02abc40
| Sep  7 22:55:49 jfsnew kernel: cont=c0471720
| Sep  7 22:55:49 jfsnew kernel: current_req=eb794004
| Sep  7 22:55:49 jfsnew kernel: command_status=-1
| Sep  7 22:55:49 jfsnew kernel: 
| Sep  7 22:55:49 jfsnew kernel: floppy0: floppy timeout called
| Sep  7 22:55:49 jfsnew kernel: end_request: I/O error, dev fd0, sector 0
| Sep  7 22:55:49 jfsnew kernel: Buffer I/O error on device fd0, logical block 0
| Sep  7 22:55:49 jfsnew kernel: lost page write due to I/O error on fd0
| Sep  7 22:55:52 jfsnew kernel: 
| Sep  7 22:55:52 jfsnew kernel: floppy driver state
| Sep  7 22:55:52 jfsnew kernel: -------------------
| Sep  7 22:55:52 jfsnew kernel: now=4294943721 last interrupt=4294940722 diff=299
| 9 last called handler=c02abc40
| Sep  7 22:55:52 jfsnew kernel: timeout_message=redo fd request
| Sep  7 22:55:52 jfsnew kernel: last output bytes:
| Sep  7 22:55:52 jfsnew kernel:  7 80 4294917324
| Sep  7 22:55:52 jfsnew kernel:  0 90 4294917324
| Sep  7 22:55:52 jfsnew kernel:  8 81 4294917324
| Sep  7 22:55:52 jfsnew kernel: e6 80 4294917324
| Sep  7 22:55:52 jfsnew kernel:  4 90 4294917324
| Sep  7 22:55:52 jfsnew kernel:  0 90 4294917324
| Sep  7 22:55:52 jfsnew kernel:  1 90 4294917324
| Sep  7 22:55:52 jfsnew kernel:  1 90 4294917324
| Sep  7 22:55:52 jfsnew kernel:  2 90 4294917325
| Sep  7 22:55:52 jfsnew kernel: 12 90 4294917325
| Sep  7 22:55:52 jfsnew kernel: 1b 90 4294917325
| Sep  7 22:55:52 jfsnew kernel: ff 90 4294917325
| Sep  7 22:55:52 jfsnew kernel:  8 80 4294937722
| Sep  7 22:55:52 jfsnew last message repeated 3 times
| Sep  7 22:55:52 jfsnew kernel:  8 80 4294940722
| Sep  7 22:55:52 jfsnew last message repeated 3 times
| Sep  7 22:55:52 jfsnew kernel: last result at 4294940722
| Sep  7 22:55:52 jfsnew kernel: last redo_fd_request at 4294940721
| Sep  7 22:55:52 jfsnew kernel: c3  0 
| Sep  7 22:55:52 jfsnew kernel: status=80
| Sep  7 22:55:52 jfsnew kernel: fdc_busy=1
| Sep  7 22:55:52 jfsnew kernel: floppy_work.func=c02abc40
| Sep  7 22:55:52 jfsnew kernel: cont=c0471720
| Sep  7 22:55:52 jfsnew kernel: current_req=eb794004
| Sep  7 22:55:52 jfsnew kernel: command_status=-1
| Sep  7 22:55:52 jfsnew kernel: 
| Sep  7 22:55:52 jfsnew kernel: floppy0: floppy timeout called
| Sep  7 22:55:52 jfsnew kernel: end_request: I/O error, dev fd0, sector 8
| Sep  7 22:55:52 jfsnew kernel: Buffer I/O error on device fd0, logical block 1
| Sep  7 22:55:52 jfsnew kernel: lost page write due to I/O error on fd0
| Sep  7 22:55:55 jfsnew kernel: work still pending

Yes, bad_flp_intr() has some problem(s).  See
http://bugme.osdl.org/show_bug.cgi?id=1033 and
http://marc.theaimsgroup.com/?l=linux-kernel&m=105837886921297&w=2

It's on my long work list.

--
~Randy
