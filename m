Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263030AbUCMCrY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 21:47:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263032AbUCMCrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 21:47:23 -0500
Received: from pop.gmx.net ([213.165.64.20]:55529 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263030AbUCMCrM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 21:47:12 -0500
X-Authenticated: #1426509
From: =?iso-8859-1?q?J=FCrgen_Repolusk?= <juerep@gmx.at>
To: Len Brown <len.brown@intel.com>
Subject: Re: ALSA via82xx fails since 2.6.2
Date: Sat, 13 Mar 2004 03:36:26 +0100
User-Agent: KMail/1.6
References: <A6974D8E5F98D511BB910002A50A6647615F4E8F@hdsmsx402.hd.intel.com> <1079142765.2175.71.camel@dhcppc4>
In-Reply-To: <1079142765.2175.71.camel@dhcppc4>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200403130336.36845.juerep@gmx.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Saturday 13 March 2004 02:52, you wrote:
> On Fri, 2004-03-12 at 15:34, Jürgen Repolusk wrote:
> > I see this in dmesg on 2.6.4-rc1:
> >
> > VIA 82xx Audio: probe of 0000:00:07.5 failed with error -16
>
> I don't know if it is related to the audio failure, but interrupts in
> general and the ACPI SCI in particular seem totally broken on this box
> (below)
>
> > this is on a sony vaio pcg-fx505
> >
> > regards
> > juergen repolusk, please CC me personally
> >
> > complete dmesg (+lspci follow)
> > ADT (v001 SONY   K5       0x06040000 PTL_ 0x000f4240) @ 0x0fefee4c
> > ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @
> > 0x0fefeec0
> > ACPI: SSDT (v001 PTLTD  POWERNOW 0x06040000  LTP 0x00000001) @
> > 0x0fefeee8
> > ACPI: DSDT (v001  SONY  K5       0x06040000 MSFT 0x0100000d) @
> > 0x00000000
> > Built 1 zonelists
> > Kernel command line: BOOT_IMAGE=gentoo264 ro root=303 apm=off acpi=on
> > vga=0x318
> > Local APIC disabled by BIOS -- reenabling.
> > Found and enabled local APIC!
> > Initializing CPU#0
> > PID hash table entries: 2048 (order 11: 16384 bytes)
> > Detected 1200.077 MHz processor.
> > Using tsc for high-res timesource
> > Console: colour dummy device 80x25
> > Memory: 254264k/262144k available (2817k kernel code, 7056k reserved,
> > 1078k
> > data, 172k init, 0k highmem)
> > Checking if this processor honours the WP bit even in supervisor
> > mode... Ok.
> > Calibrating delay loop... 2359.29 BogoMIPS
> > Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
> > Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
> > Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
> > CPU:     After generic identify, caps: 0383fbff c1cbfbff 00000000
> > 00000000
> > CPU:     After vendor identify, caps: 0383fbff c1cbfbff 00000000
> > 00000000
> > CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
> > CPU: L2 Cache: 256K (64 bytes/line)
> > CPU:     After all inits, caps: 0383fbff c1cbfbff 00000000 00000020
> > Intel machine check architecture supported.
> > Intel machine check reporting enabled on CPU#0.
> > CPU: AMD mobile AMD Athlon(tm) 4  stepping 02
> > Enabling fast FPU save and restore... done.
> > Enabling unmasked SIMD FPU exception support... done.
> > Checking 'hlt' instruction... OK.
> > POSIX conformance testing by UNIFIX
> > enabled ExtINT on CPU#0
> > ESR value before enabling vector: 00000000
> > ESR value after enabling vector: 00000000
> > Using local APIC timer interrupts.
> > calibrating APIC timer ...
> > ..... CPU clock speed is 1199.0872 MHz.
> > ..... host bus clock speed is 199.0978 MHz.
> > NET: Registered protocol family 16
> > PCI: PCI BIOS revision 2.10 entry at 0xfd7cd, last bus=1
> > PCI: Using configuration type 1
> > mtrr: v2.0 (20020519)
> > ACPI: Subsystem revision 20040211
> > ACPI: IRQ9 SCI: Level Trigger.
> > spurious 8259A interrupt: IRQ7.
>
> Spurious on IRQ7 may mean that a device is pulling an interrupt line
> which has no driver attached.
>
> > irq 9: nobody cared!
> > Call Trace:
> >  [<c010b69b>] __report_bad_irq+0x2b/0x90
> >  [<c02592ad>] acpi_irq+0xf/0x1a
> >  [<c010b794>] note_interrupt+0x64/0xa0
> >  [<c010ba73>] do_IRQ+0x143/0x160
> >  [<c0109dc8>] common_interrupt+0x18/0x20
>
> Here we've apparently gone recursive on the interrupt handler, I don't
> think that is supposed to be possible.
>
> >  [<c0126a94>] do_softirq+0x44/0xa0
> >  [<c025929e>] acpi_irq+0x0/0x1a
> >  [<c010ba47>] do_IRQ+0x117/0x160
> >  [<c0109dc8>] common_interrupt+0x18/0x20
> >  [<c010c04c>] setup_irq+0x9c/0x100
> >  [<c025929e>] acpi_irq+0x0/0x1a
>
> okay, so we got an acpi_irq() right when we requeted the IRQ, that is
> unusual, but should be okay.  Curious that common_interrupt/do_IRQ are
> not on the stack here though...
>
> >  [<c010bb68>] request_irq+0x98/0xd0
> >  [<c02592ed>] acpi_os_install_interrupt_handler+0x35/0x5b
> >
> >  [<c025929e>] acpi_irq+0x0/0x1a
> >  [<c025929e>] acpi_irq+0x0/0x1a
>
> dunno what's the deal with the stack here acpi_irq() is not called from
> acpi_ev_install_sci_handler(), and request_irq() hasn't even been called
> yet!
>
> >  [<c025d58e>] acpi_ev_install_sci_handler+0x1d/0x1f
> >  [<c025d548>] acpi_ev_sci_xrupt_handler+0x0/0x1c
> >  [<c025cf8d>] acpi_ev_handler_initialize+0x9/0x71
> >  [<c026ebf4>] acpi_enable_subsystem+0x2e/0x5b
> >  [<c04e35d2>] acpi_bus_init+0x7c/0x111
> >  [<c04e36c0>] acpi_init+0x59/0xb4
> >  [<c04d082c>] do_initcalls+0x2c/0xa0
> >  [<c01332c2>] init_workqueues+0x12/0x30
> >  [<c01050d5>] init+0x35/0x140
> >  [<c01050a0>] init+0x0/0x140
> >  [<c01072c9>] kernel_thread_helper+0x5/0xc
> >
> > handlers:
> > [<c025929e>] (acpi_irq+0x0/0x1a)
> > Disabling IRQ #9
> > ACPI: Interpreter enabled
>
> What does /proc/interrupts on this box look like?
here is "cat /proc/interrupts" says:

           CPU0
  0:   22589343          XT-PIC  timer
  1:       3716          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  8:          2          XT-PIC  rtc
  9:     100000          XT-PIC  acpi, uhci_hcd, uhci_hcd, yenta, eth1
 10:     453565          XT-PIC  yenta, eth0
 11:          0          XT-PIC  sonypi
 12:     101345          XT-PIC  i8042
 14:      42157          XT-PIC  ide0
 15:         22          XT-PIC  ide1
NMI:          0
LOC:   22589934
ERR:      42084
MIS:          0


> how about when you boot with acpi=off or pci=noacpi?
actually i gave it a try but it doesn't change anything. still the same error.

>
> Are you sure you didn't see these messages before 2.6.2 -- was ACPI
> enabled in the working release?
>

Yes I'm sure that before 2.6.2 I did not see this message at all - sound was 
working real fine. with changin to 2.6.2 up to 2.6.4 now I've this problem.

	greets, jürgen
> thanks,
> -Len

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAUnOw86YqkexXDbgRAgk7AJ9XG2LssNpNnFh2iC/13wmcHuz+6QCglGal
K5fNlk2Gc+6DiElQ4ZWyhOU=
=FwwY
-----END PGP SIGNATURE-----
