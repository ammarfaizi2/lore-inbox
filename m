Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266084AbUFWCq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266084AbUFWCq7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 22:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266085AbUFWCq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 22:46:59 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:45373 "EHLO
	pd4mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S266084AbUFWCqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 22:46:50 -0400
Date: Tue, 22 Jun 2004 20:44:34 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: APIC vs PIC on Thinkpad r50p (Pentium-M)
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <012f01c458cc$047ed490$6401a8c0@northbrook>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
X-Mailer: Microsoft Outlook Express 6.00.2800.1409
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7bit
X-Priority: 3
X-MSMail-priority: Normal
References: <fa.ggq0ptt.2m8mjv@ifi.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks to me like it is using the local APIC (on the CPU), but to use APIC
for IRQ routing it has to be able to use an IOAPIC, and it looks like your
ACPI data isn't saying that one exists (for whatever reason, a lot of
laptops don't seem to support IOAPIC).

As far as the lack of power-off, I think the ACPI errors quite likely are
related. Have you checked for a BIOS update?


----- Original Message ----- 
From: "Hamie" <hamish@travellingkiwi.com>
Newsgroups: fa.linux.kernel
To: "Linux Kernel Development" <linux-kernel@vger.kernel.org>
Sent: Monday, June 21, 2004 3:27 PM
Subject: APIC vs PIC on Thinkpad r50p (Pentium-M)


> I have a Pentium-M based Thinkpad r50p. 2 problems occur when using a
> kernel compiled with local APIC for uniprocessors.
>
> 1. Although the local APIC is detected, it doesn't get used. (dmesg
> appended below).
>
> 2. When local APIC is enabled, then the poweroff doesn't actually
> poweroff... e.g. shutdpown -h leaves the fan spinning, and presumably
> other things wit hpower as well.
>
> Anyone know why
>
> 1. PIC is used instead of APIC?
> 2. Why no power off?
>
> Are these due to the ACPI errors indicated in the dmeag output?
>
>
> TIA
>
> Hamish Marson.,
>
>
> DMI present.
> IBM machine detected. Enabling interrupts during APM calls.
> IBM machine detected. Disabling SMBus accesses.
> ACPI: RSDP (v002 IBM                                       ) @ 0x000f6df0
> ACPI: XSDT (v001 IBM    TP-1R    0x00003030  LTP 0x00000000) @ 0x1ff6b28d
> ACPI: FADT (v003 IBM    TP-1R    0x00003030 IBM  0x00000001) @ 0x1ff6b300
> ACPI: SSDT (v001 IBM    TP-1R    0x00003030 MSFT 0x0100000e) @ 0x1ff6b4b4
> ACPI: ECDT (v001 IBM    TP-1R    0x00003030 IBM  0x00000001) @ 0x1ff76dfc
> ACPI: TCPA (v001 IBM    TP-1R    0x00003030 PTL  0x00000001) @ 0x1ff76e4e
> ACPI: BOOT (v001 IBM    TP-1R    0x00003030  LTP 0x00000001) @ 0x1ff76fd8
> ACPI: DSDT (v001 IBM    TP-1R    0x00003030 MSFT 0x0100000e) @ 0x00000000
> ACPI: PM-Timer IO Port: 0x1008
> Built 1 zonelists
> Kernel command line: BOOT_IMAGE=Linux-2.6.7 ro root=302
> acpi_sleep=s3_bios video=radeonfb:1600x1200-16@85 apm=power-off
> Local APIC disabled by BIOS -- reenabling.
> Found and enabled local APIC!
> Initializing CPU#0
> PID hash table entries: 2048 (order 11: 16384 bytes)
> Detected 1595.005 MHz processor.
> Using pmtmr for high-res timesource
> Console: colour VGA+ 80x25
> Memory: 515144k/523648k available (2236k kernel code, 7736k reserved,
> 939k data, 148k init, 0k highmem)
> Checking if this processor honours the WP bit even in supervisor mode...
Ok.
> Calibrating delay loop... 3162.11 BogoMIPS
> Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
> Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
> Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
> CPU:     After generic identify, caps: a7e9fbbf 00000000 00000000 00000000
> CPU:     After vendor identify, caps: a7e9fbbf 00000000 00000000 00000000
> CPU: L1 I cache: 32K, L1 D cache: 32K
> CPU: L2 cache: 1024K
> CPU:     After all inits, caps: a7e9fbbf 00000000 00000000 00000040
> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#0.
> CPU: Intel(R) Pentium(R) M processor 1600MHz stepping 05
> Enabling fast FPU save and restore... done.
> Enabling unmasked SIMD FPU exception support... done.
> Checking 'hlt' instruction... OK.
> enabled ExtINT on CPU#0
> ESR value before enabling vector: 00000000
> ESR value after enabling vector: 00000000
> Using local APIC timer interrupts.
> calibrating APIC timer ...
> ..... CPU clock speed is 1594.0538 MHz.
> ..... host bus clock speed is 99.0658 MHz.
> NET: Registered protocol family 16
> PCI: PCI BIOS revision 2.10 entry at 0xfd8d6, last bus=8
> PCI: Using configuration type 1
> mtrr: v2.0 (20020519)
> ACPI: Subsystem revision 20040326
>  tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully
acquired
> Parsing all Control
>
Methods:....................................................................
..........................................................................
>
............................................................................
............................................................................
..................
>
............................................................................
...
> Table [DSDT](id F005) - 1322 Objects with 63 Devices 391 Methods 20
Regions
> Parsing all Control Methods:.
> Table [SSDT](id F003) - 1 Objects with 0 Devices 1 Methods 0 Regions
> ACPI Namespace successfully loaded at root c045fe1c
> ACPI: IRQ9 SCI: Edge set to Level Trigger.
> evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode
> successful
> evgpeblk-0867 [06] ev_create_gpe_block   : GPE 00 to 31 [_GPE] 4 regs at
> 0000000000001028 on int 9
> evgpeblk-0925 [06] ev_create_gpe_block   : Found 0 Wake, Enabled 1
> Runtime GPEs in this block
> ACPI: Found ECDT
> Completing Region/Field/Buffer/Package
>
initialization:.............................................................
.......................................................
>
............................................................................
...............................................................
> Initialized 19/20 Regions 123/123 Fields 67/67 Buffers 46/46 Packages
> (1332 nodes)
> Executing all Device _STA and_INI
> methods:.......................................................
> exfldio-0143 [22] ex_setup_region       : Field [PWKI] access width (4 b
> ytes) too large for region [U7CS] (length 2)
>  exfldio-0155 [22] ex_setup_region       : Field [PWKI]
> Base+Offset+Width 0+0+4 is beyond end of region [U7CS] (length 2)
>  exfldio-0179: *** Warning: The ACPI AML in your computer contains
> errors, please nag the manufacturer to correct it.
>  exfldio-0182: *** Warning: Allowing relaxed access to fields; turn on
> CONFIG_ACPI_DEBUG for details.
>  exfldio-0143 [22] ex_setup_region       : Field [PWKI] access width (4
> bytes) too large for region [U7CS] (length 2)
>  exfldio-0155 [22] ex_setup_region       : Field [PWKI]
> Base+Offset+Width 0+0+4 is beyond end of region [U7CS] (length 2)
>  exfldio-0143 [22] ex_setup_region       : Field [PWUC] access width (4
> bytes) too large for region [U7CS] (length 2)
>  exfldio-0155 [22] ex_setup_region       : Field [PWUC]
> Base+Offset+Width 0+0+4 is beyond end of region [U7CS] (length 2)
>  exfldio-0143 [22] ex_setup_region       : Field [PWUC] access width (4
> bytes) too large for region [U7CS] (length 2)
>  exfldio-0155 [22] ex_setup_region       : Field [PWUC]
> Base+Offset+Width 0+0+4 is beyond end of region [U7CS] (length 2)
> ....
> 59 Devices found containing: 59 _STA, 8 _INI methods
> ACPI: Interpreter enabled
> ACPI: Using PIC for interrupt routing
> ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11)
> ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 *11)
> ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11)
> ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11)
> ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11) *0, disabled.
> ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11) *0, disabled.
> ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11) *0, disabled.
> ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 *11)
> ACPI: PCI Root Bridge [PCI0] (00:00)
> PCI: Probing PCI hardware (bus 00)
> PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
> PCI: Transparent bridge - 0000:00:1e.0
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> ACPI: Embedded Controller [EC] (gpe 28)
> ACPI: Power Resource [PUBS] (on)
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

