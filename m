Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751385AbWFDJxm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385AbWFDJxm (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 05:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbWFDJxm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 05:53:42 -0400
Received: from wx-out-0102.google.com ([66.249.82.206]:34198 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751385AbWFDJxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 05:53:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=eEgHZ04Lq/o8BhQXN6BUwS2vms8lNsuzuzLrNEDmzYyL5r26voEXPyI9zHqgX1dkyPv54CjmroWNEWWxvaWcDJjlgUHUyZfG46UMrnONo8uHSW20GMVwm+v2tlgxkfxFtbSSXP0B3hUH69B+owhHY0OG1Omn7FqkOFmK/RFDj8w=
Message-ID: <986ed62e0606040253pfe9c300qf88029f88ae65039@mail.gmail.com>
Date: Sun, 4 Jun 2006 02:53:40 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: "Arjan van de Ven" <arjan@linux.intel.com>
Subject: Re: [patch, -rc5-mm3] lock validator: fix ns83820.c irq-flags bug part 2
Cc: "Ingo Molnar" <mingo@elte.hu>, linux-kernel@vger.kernel.org,
        "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <1149411525.3109.73.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060604083017.GA8241@elte.hu>
	 <1149411525.3109.73.camel@laptopd505.fenrus.org>
X-Google-Sender-Auth: ef477b26226668c0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/4/06, Arjan van de Ven <arjan@linux.intel.com> wrote:
> just the preempt the next email from Barry; while fixing this one I
> looked at the usage of the locks more and found another patch needed...
[snip]

Nice try, but it didn't work. ~_^

I was about to reply to the previous ns83820 patch with my dmesg, when
I saw this one. I applied this patch too, and like the previous patch,
it reports an instance of illegal lock usage. My dmesg follows.
-- 
-Barry K. Nathan <barryn@pobox.com>

[    0.000000] Linux version 2.6.17-rc5-mm3 (barryn@nserv) (gcc
version 4.1.1) #1 Sun Jun 4 02:03:43 PDT 2006
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] sanitize start
[    0.000000] sanitize end
[    0.000000] copy_e820_map() start: 0000000000000000 size:
000000000009fc00 end: 000000000009fc00 type: 1
[    0.000000] copy_e820_map() type is E820_RAM
[    0.000000] add_memory_region(0000000000000000, 000000000009fc00, 1)
[    0.000000] copy_e820_map() start: 000000000009fc00 size:
0000000000000400 end: 00000000000a0000 type: 2
[    0.000000] add_memory_region(000000000009fc00, 0000000000000400, 2)
[    0.000000] copy_e820_map() start: 00000000000f0000 size:
0000000000010000 end: 0000000000100000 type: 2
[    0.000000] add_memory_region(00000000000f0000, 0000000000010000, 2)
[    0.000000] copy_e820_map() start: 0000000000100000 size:
000000001fef0000 end: 000000001fff0000 type: 1
[    0.000000] copy_e820_map() type is E820_RAM
[    0.000000] add_memory_region(0000000000100000, 000000001fef0000, 1)
[    0.000000] copy_e820_map() start: 000000001fff0000 size:
0000000000008000 end: 000000001fff8000 type: 3
[    0.000000] add_memory_region(000000001fff0000, 0000000000008000, 3)
[    0.000000] copy_e820_map() start: 000000001fff8000 size:
0000000000008000 end: 0000000020000000 type: 4
[    0.000000] add_memory_region(000000001fff8000, 0000000000008000, 4)
[    0.000000] copy_e820_map() start: 00000000ffff0000 size:
0000000000010000 end: 0000000100000000 type: 2
[    0.000000] add_memory_region(00000000ffff0000, 0000000000010000, 2)
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[    0.000000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
[    0.000000]  BIOS-e820: 000000001fff0000 - 000000001fff8000 (ACPI data)
[    0.000000]  BIOS-e820: 000000001fff8000 - 0000000020000000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
[    0.000000] 511MB LOWMEM available.
[    0.000000] On node 0 totalpages: 131056
[    0.000000]   DMA zone: 4096 pages, LIFO batch:0
[    0.000000]   Normal zone: 126960 pages, LIFO batch:31
[    0.000000] DMI 2.3 present.
[    0.000000] ACPI: RSDP (v000 AMI
) @ 0x000fa8f0
[    0.000000] ACPI: RSDT (v001 AMIINT          0x00000010 MSFT
0x00000097) @ 0x1fff0000
[    0.000000] ACPI: FADT (v001 AMIINT          0x00000010 MSFT
0x00000097) @ 0x1fff0030
[    0.000000] ACPI: DSDT (v001 AMD75X IRONGATE 0x00001000 MSFT
0x0100000b) @ 0x00000000
[    0.000000] Allocating PCI resources starting at 30000000 (gap:
20000000:dfff0000)
[    0.000000] Detected 805.687 MHz processor.
[   73.586916] Built 1 zonelists
[   73.586923] Kernel command line: BOOT_IMAGE=bzimage lapic
root=/dev/sdc1 vga=6
[   73.587430] Local APIC disabled by BIOS -- reenabling.
[   73.587438] Found and enabled local APIC!
[   73.587447] mapped APIC to ffffd000 (fee00000)
[   73.587456] Enabling fast FPU save and restore... done.
[   73.587465] Initializing CPU#0
[   73.587609] CPU 0 irqstacks, hard=c03f3000 soft=c03f2000
[   73.587619] PID hash table entries: 2048 (order: 11, 8192 bytes)
[   73.591125] Console: colour VGA+ 80x60
[   73.593702] Lock dependency validator: Copyright (c) 2006 Red Hat,
Inc., Ingo Molnar
[   73.593851] ... MAX_LOCKDEP_SUBTYPES:    8
[   73.593943] ... MAX_LOCK_DEPTH:          30
[   73.594035] ... MAX_LOCKDEP_KEYS:        2048
[   73.594124] ... TYPEHASH_SIZE:           1024
[   73.594215] ... MAX_LOCKDEP_ENTRIES:     8192
[   73.594311] ... MAX_LOCKDEP_CHAINS:      8192
[   73.594406] ... CHAINHASH_SIZE:          4096
[   73.594496]  memory used by lock dependency info: 696 kB
[   73.594592]  per task-struct memory footprint: 1080 bytes
[   73.594687] ------------------------
[   73.594782] | Locking API testsuite:
[   73.594876] ----------------------------------------------------------------------------
[   73.595029]                                  | spin |wlock |rlock
|mutex | wsem | rsem |
[   73.595181]
--------------------------------------------------------------------------
[   73.595357]                      A-A deadlock:  ok  |  ok  |  ok  |
 ok  |  ok  |  ok  |
[   73.597758]                  A-B-B-A deadlock:  ok  |  ok  |  ok  |
 ok  |  ok  |  ok  |
[   73.600104]              A-B-B-C-C-A deadlock:  ok  |  ok  |  ok  |
 ok  |  ok  |  ok  |
[   73.602480]              A-B-C-A-B-C deadlock:  ok  |  ok  |  ok  |
 ok  |  ok  |  ok  |
[   73.604863]          A-B-B-C-C-D-D-A deadlock:  ok  |  ok  |  ok  |
 ok  |  ok  |  ok  |
[   73.607310]          A-B-C-D-B-D-D-A deadlock:  ok  |  ok  |  ok  |
 ok  |  ok  |  ok  |
[   73.609796]          A-B-C-D-B-C-D-A deadlock:  ok  |  ok  |  ok  |
 ok  |  ok  |  ok  |
[   73.612246]                     double unlock:  ok  |  ok  |  ok  |
 ok  |  ok  |  ok  |
[   73.614529]                  bad unlock order:  ok  |  ok  |  ok  |
 ok  |  ok  |  ok  |
[   73.616838]
--------------------------------------------------------------------------
[   73.616984]               recursive read-lock:             |  ok  |
            |  ok  |
[   73.617956]
--------------------------------------------------------------------------
[   73.618106]                 non-nested unlock:  ok  |  ok  |  ok  |  ok  |
[   73.619665]   ------------------------------------------------------------
[   73.619757]      hard-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
[   73.620943]      soft-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
[   73.622135]      hard-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
[   73.623315]      soft-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
[   73.624505]        sirq-safe-A => hirqs-on/12:  ok  |  ok  |  ok  |
[   73.625696]        sirq-safe-A => hirqs-on/21:  ok  |  ok  |  ok  |
[   73.626879]          hard-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
[   73.628085]          soft-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
[   73.629273]          hard-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
[   73.630454]          soft-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
[   73.631635]     hard-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
[   73.632844]     soft-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
[   73.634051]     hard-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
[   73.635251]     soft-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
[   73.636451]     hard-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
[   73.637679]     soft-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
[   73.638890]     hard-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
[   73.640092]     soft-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
[   73.641297]     hard-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
[   73.642484]     soft-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
[   73.643679]     hard-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
[   73.644888]     soft-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
[   73.646088]     hard-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
[   73.647296]     soft-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
[   73.648535]     hard-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
[   73.649752]     soft-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
[   73.650965]     hard-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
[   73.652178]     soft-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
[   73.653382]     hard-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
[   73.654585]     soft-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
[   73.655794]     hard-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
[   73.656999]     soft-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
[   73.658237]     hard-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
[   73.659450]     soft-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
[   73.660660]       hard-irq lock-inversion/123:  ok  |  ok  |  ok  |
[   73.661870]       soft-irq lock-inversion/123:  ok  |  ok  |  ok  |
[   73.663088]       hard-irq lock-inversion/132:  ok  |  ok  |  ok  |
[   73.664300]       soft-irq lock-inversion/132:  ok  |  ok  |  ok  |
[   73.665519]       hard-irq lock-inversion/213:  ok  |  ok  |  ok  |
[   73.666732]       soft-irq lock-inversion/213:  ok  |  ok  |  ok  |
[   73.667974]       hard-irq lock-inversion/231:  ok  |  ok  |  ok  |
[   73.669179]       soft-irq lock-inversion/231:  ok  |  ok  |  ok  |
[   73.670386]       hard-irq lock-inversion/312:  ok  |  ok  |  ok  |
[   73.671606]       soft-irq lock-inversion/312:  ok  |  ok  |  ok  |
[   73.672830]       hard-irq lock-inversion/321:  ok  |  ok  |  ok  |
[   73.674036]       soft-irq lock-inversion/321:  ok  |  ok  |  ok  |
[   73.675254]       hard-irq read-recursion/123:  ok  |
[   73.675748]       soft-irq read-recursion/123:  ok  |
[   73.676246]       hard-irq read-recursion/132:  ok  |
[   73.676740]       soft-irq read-recursion/132:  ok  |
[   73.677234]       hard-irq read-recursion/213:  ok  |
[   73.677747]       soft-irq read-recursion/213:  ok  |
[   73.678240]       hard-irq read-recursion/231:  ok  |
[   73.678736]       soft-irq read-recursion/231:  ok  |
[   73.679229]       hard-irq read-recursion/312:  ok  |
[   73.679725]       soft-irq read-recursion/312:  ok  |
[   73.680217]       hard-irq read-recursion/321:  ok  |
[   73.680710]       soft-irq read-recursion/321:  ok  |
[   73.681207] -------------------------------------------------------
[   73.681306] Good, all 210 testcases passed! |
[   73.681399] ---------------------------------
[   73.682349] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
[   73.683329] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
[   73.731760] Memory: 514628k/524224k available (1572k kernel code,
9028k reserved, 909k data, 160k init, 0k highmem)
[   73.731928] Checking if this processor honours the WP bit even in
supervisor mode... Ok.
[   73.877388] Calibrating delay using timer specific routine..
1613.94 BogoMIPS (lpj=8069734)
[   73.877840] Mount-cache hash table entries: 512
[   73.878796] CPU: After generic identify, caps: 0183fbff c1c3fbff
00000000 00000000 00000000 00000000 00000000
[   73.878828] CPU: After vendor identify, caps: 0183fbff c1c3fbff
00000000 00000000 00000000 00000000 00000000
[   73.878860] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[   73.878966] CPU: L2 Cache: 512K (64 bytes/line)
[   73.879060] CPU: After all inits, caps: 0183fbff c1c3fbff 00000000
00000420 00000000 00000000 00000000
[   73.879089] Intel machine check architecture supported.
[   73.879186] Intel machine check reporting enabled on CPU#0.
[   73.879289] Compat vDSO mapped to ffffe000.
[   73.879399] CPU: AMD Athlon(tm) Processor stepping 01
[   73.879567] Checking 'hlt' instruction... OK.
[   73.917472] SMP alternatives: switching to UP code
[   73.917563] Freeing SMP alternatives: 0k freed
[   73.926938] ACPI: setting ELCR to 0010 (from 0e00)
[   73.927753] lockdep: disabled NMI watchdog.
[   74.053321] NET: Registered protocol family 16
[   74.053729] ACPI: bus type pci registered
[   74.065724] PCI: PCI BIOS revision 2.10 entry at 0xfdaf1, last bus=1
[   74.065832] Setting up standard PCI resources
[   74.068330] spurious 8259A interrupt: IRQ7.
[   74.081547] ACPI: Subsystem revision 20060310
[   74.097165] ACPI: Interpreter enabled
[   74.097320] ACPI: Using PIC for interrupt routing
[   74.100331] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   74.100466] PCI: Probing PCI hardware (bus 00)
[   74.110098] Boot video device is 0000:01:05.0
[   74.110458] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[   74.121205] ACPI: Power Resource [URP1] (off)
[   74.121717] ACPI: Power Resource [URP2] (off)
[   74.122187] ACPI: Power Resource [FDDP] (off)
[   74.122657] ACPI: Power Resource [LPTP] (off)
[   74.124439] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 *10
11 12 14 15)
[   74.125981] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10
*11 12 14 15)
[   74.127521] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *9 10
11 12 14 15)
[   74.129033] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 11
12 14 15) *0, disabled.
[   74.130089] Linux Plug and Play Support v0.97 (c) Adam Belay
[   74.130299] pnp: PnP ACPI init
[   74.136579] pnp: PnP ACPI: found 8 devices
[   74.136688] PnPBIOS: Disabled by ACPI PNP
[   74.137816] SCSI subsystem initialized
[   74.138209] PCI: Using ACPI for IRQ routing
[   74.138301] PCI: If a device doesn't work, try "pci=routeirq".  If
it helps, post a report
[   74.149421] PCI: Bridge: 0000:00:01.0
[   74.149534]   IO window: 9000-9fff
[   74.149658]   MEM window: e7d00000-efdfffff
[   74.149775]   PREFETCH window: e3b00000-e3bfffff
[   74.150036] NET: Registered protocol family 2
[   74.247378] IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
[   74.248173] TCP established hash table entries: 16384 (order: 8,
1376256 bytes)
[   74.256402] TCP bind hash table entries: 8192 (order: 7, 720896 bytes)
[   74.260910] TCP: Hash tables configured (established 16384 bind 8192)
[   74.261061] TCP reno registered
[   74.263479] Machine check exception polling timer started.
[   74.269336] Initializing Cryptographic API
[   74.269474] io scheduler noop registered
[   74.269644] io scheduler cfq registered (default)
[   74.270194] ACPI: Power Button (FF) [PWRF]
[   74.270306] ACPI: Sleep Button (FF) [SLPF]
[   74.270430] ACPI: Power Button (CM) [PWRB]
[   74.271006] isapnp: Scanning for PnP cards...
[   74.628027] isapnp: No Plug & Play device found
[   74.645301] Floppy drive(s): fd0 is 1.44M
[   74.658905] FDC 0 is a post-1991 82077
[   74.661870] libata version 1.30 loaded.
[   74.662184] pata_pdc2027x 0000:00:0a.0: version 0.74
[   74.663009] ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
[   74.663121] PCI: setting IRQ 11 as level-triggered
[   74.663131] ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNKB] ->
GSI 11 (level, low) -> IRQ 11
[   74.763521] pata_pdc2027x 0000:00:0a.0: PLL input clock 16813 kHz
[   74.793952] ata1: PATA max UDMA/133 cmd 0xE08097C0 ctl 0xE0809FDA
bmdma 0xE0809000 irq 11
[   74.794290] ata2: PATA max UDMA/133 cmd 0xE08095C0 ctl 0xE0809DDA
bmdma 0xE0809008 irq 11
[   74.947356] ata1.00: cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c69
86:3e01 87:4003 88:407f
[   74.947372] ata1.00: ATA-7, max UDMA/133, 490234752 sectors: LBA48
[   74.948337] ata1.00: configured for UDMA/133
[   74.948440] scsi0 : pata_pdc2027x
[   75.107315] ata2.00: cfg 49:2f00 82:346b 83:7f01 84:4003 85:3469
86:3c01 87:4003 88:203f
[   75.107328] ata2.00: ATA-6, max UDMA/100, 625142448 sectors: LBA48
[   75.108429] ata2.00: configured for UDMA/100
[   75.108531] scsi1 : pata_pdc2027x
[   75.109758]   Vendor: ATA       Model: Maxtor 6Y250P0    Rev: YAR4
[   75.110792]   Type:   Direct-Access                      ANSI SCSI
revision: 05
[   75.112186]   Vendor: ATA       Model: WDC WD3200JB-00K  Rev: 08.0
[   75.113248]   Type:   Direct-Access                      ANSI SCSI
revision: 05
[   75.114516] sata_sil 0000:00:0d.0: version 1.0
[   75.115265] ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
[   75.115374] PCI: setting IRQ 10 as level-triggered
[   75.115384] ACPI: PCI Interrupt 0000:00:0d.0[A] -> Link [LNKA] ->
GSI 10 (level, low) -> IRQ 10
[   75.115653] sata_sil 0000:00:0d.0: Applying R_ERR on DMA activate
FIS errata fix
[   75.116016] ata3: SATA max UDMA/100 cmd 0xE080E480 ctl 0xE080E48A
bmdma 0xE080E400 irq 10
[   75.116357] ata4: SATA max UDMA/100 cmd 0xE080E4C0 ctl 0xE080E4CA
bmdma 0xE080E408 irq 10
[   75.116738] ata5: SATA max UDMA/100 cmd 0xE080E680 ctl 0xE080E68A
bmdma 0xE080E600 irq 10
[   75.117051] ata6: SATA max UDMA/100 cmd 0xE080E6C0 ctl 0xE080E6CA
bmdma 0xE080E608 irq 10
[   75.486123] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   75.487064] ata3.00: cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c69
86:3e01 87:4003 88:207f
[   75.487078] ata3.00: ATA-7, max UDMA/133, 585940320 sectors: LBA48
[   75.487187] ata3.00: applying bridge limits
[   75.488298] ata3.00: configured for UDMA/100
[   75.488395] scsi2 : sata_sil
[   75.855823] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   75.857125] ata4.00: cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469
86:3c01 87:4023 88:203f
[   75.857137] ata4.00: ATA-7, max UDMA/100, 781422768 sectors: LBA48
[   75.857235] ata4.00: applying bridge limits
[   75.858607] ata4.00: configured for UDMA/100
[   75.858710] scsi3 : sata_sil
[   76.225523] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   76.226496] ata5.00: cfg 49:2f00 82:346b 83:7f01 84:4003 85:3469
86:3e01 87:4003 88:203f
[   76.226509] ata5.00: ATA-6, max UDMA/100, 625142448 sectors: LBA48
[   76.226605] ata5.00: applying bridge limits
[   76.227685] ata5.00: configured for UDMA/100
[   76.227783] scsi4 : sata_sil
[   76.435337] ata6: SATA link down (SStatus 0 SControl 310)
[   76.435450] scsi5 : sata_sil
[   76.436397]   Vendor: ATA       Model: Maxtor 4A300J0    Rev: RAMB
[   76.437451]   Type:   Direct-Access                      ANSI SCSI
revision: 05
[   76.438841]   Vendor: ATA       Model: ST3400832A        Rev: 3.01
[   76.439911]   Type:   Direct-Access                      ANSI SCSI
revision: 05
[   76.441340]   Vendor: ATA       Model: WDC WD3200JB-00K  Rev: 08.0
[   76.442397]   Type:   Direct-Access                      ANSI SCSI
revision: 05
[   76.444277] SCSI device sda: 490234752 512-byte hdwr sectors (251000 MB)
[   76.444481] sda: Write Protect is off
[   76.444572] sda: Mode Sense: 00 3a 00 00
[   76.444744] SCSI device sda: drive cache: write back
[   76.445381] SCSI device sda: 490234752 512-byte hdwr sectors (251000 MB)
[   76.445594] sda: Write Protect is off
[   76.445688] sda: Mode Sense: 00 3a 00 00
[   76.445885] SCSI device sda: drive cache: write back
[   76.445984]  sda: unknown partition table
[   76.448576] sd 0:0:0:0: Attached scsi disk sda
[   76.449210] SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
[   76.449391] sdb: Write Protect is off
[   76.449478] sdb: Mode Sense: 00 3a 00 00
[   76.449645] SCSI device sdb: drive cache: write back
[   76.450141] SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
[   76.450332] sdb: Write Protect is off
[   76.450420] sdb: Mode Sense: 00 3a 00 00
[   76.450608] SCSI device sdb: drive cache: write back
[   76.450706]  sdb: unknown partition table
[   76.453773] sd 1:0:0:0: Attached scsi disk sdb
[   76.454378] SCSI device sdc: 585940320 512-byte hdwr sectors (300001 MB)
[   76.454567] sdc: Write Protect is off
[   76.454670] sdc: Mode Sense: 00 3a 00 00
[   76.454837] SCSI device sdc: drive cache: write back
[   76.455366] SCSI device sdc: 585940320 512-byte hdwr sectors (300001 MB)
[   76.455564] sdc: Write Protect is off
[   76.455670] sdc: Mode Sense: 00 3a 00 00
[   76.455864] SCSI device sdc: drive cache: write back
[   76.455961]  sdc: sdc1
[   76.466882] sd 2:0:0:0: Attached scsi disk sdc
[   76.467443] SCSI device sdd: 781422768 512-byte hdwr sectors (400088 MB)
[   76.467636] sdd: Write Protect is off
[   76.467725] sdd: Mode Sense: 00 3a 00 00
[   76.467892] SCSI device sdd: drive cache: write back
[   76.468408] SCSI device sdd: 781422768 512-byte hdwr sectors (400088 MB)
[   76.468616] sdd: Write Protect is off
[   76.468716] sdd: Mode Sense: 00 3a 00 00
[   76.468906] SCSI device sdd: drive cache: write back
[   76.469014]  sdd: unknown partition table
[   76.485819] sd 3:0:0:0: Attached scsi disk sdd
[   76.486391] SCSI device sde: 625142448 512-byte hdwr sectors (320073 MB)
[   76.486581] sde: Write Protect is off
[   76.486681] sde: Mode Sense: 00 3a 00 00
[   76.486848] SCSI device sde: drive cache: write back
[   76.487359] SCSI device sde: 625142448 512-byte hdwr sectors (320073 MB)
[   76.487560] sde: Write Protect is off
[   76.487664] sde: Mode Sense: 00 3a 00 00
[   76.487853] SCSI device sde: drive cache: write back
[   76.487960]  sde: sde1 sde2
[   76.508717] sd 4:0:0:0: Attached scsi disk sde
[   76.511901] PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at
0x60,0x64 irq 1,12
[   76.512803] serio: i8042 AUX port at 0x60,0x64 irq 12
[   76.512945] serio: i8042 KBD port at 0x60,0x64 irq 1
[   76.514756] mice: PS/2 mouse device common for all mice
[   76.515161] NET: Registered protocol family 1
[   76.515349] Using IPI Shortcut mode
[   76.516174] ACPI: (supports S0 S1 S4 S5)
[   76.517145] Freeing unused kernel memory: 160k freed
[   76.517418] Write protecting the kernel read-only data: 312k
[   76.525255] Time: tsc clocksource has been installed.
[   76.530890] ReiserFS: sdc1: found reiserfs format "3.6" with standard journal
[   76.550312] input: AT Translated Set 2 keyboard as /class/input/input0
[   76.725051] logips2pp: Detected unknown logitech mouse model 0
[   77.245394] input: PS/2 Logitech Mouse as /class/input/input1
[   94.958327] ReiserFS: sdc1: using ordered data mode
[   94.991667] ReiserFS: sdc1: journal params: device sdc1, size 8192,
journal first block 18, max trans len 1024, max batch 900, max commit
age 30, max trans age 30
[   94.994994] ReiserFS: sdc1: checking transaction log (sdc1)
[   95.080519] ReiserFS: sdc1: Using r5 hash to sort names
[  102.790993] Real Time Clock Driver v1.12ac
[  105.362817] Linux Tulip driver version 1.1.13-NAPI (December 15, 2004)
[  105.364136] ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 9
[  105.364252] PCI: setting IRQ 9 as level-triggered
[  105.364263] ACPI: PCI Interrupt 0000:00:0b.0[A] -> Link [LNKC] ->
GSI 9 (level, low) -> IRQ 9
[  105.380719] tulip0:  EEPROM default media type Autosense.
[  105.380828] tulip0:  Index #0 - Media MII (#11) described by a
21142 MII PHY (3) block.
[  105.385259] tulip0:  MII transceiver #1 config 1000 status 782d
advertising 01e1.
[  105.390474] eth0: Digital DS21143 Tulip rev 65 at 0001d000,
00:C0:F0:4A:0C:46, IRQ 9.
[  105.412046] pcnet32.c:v1.32 18.Mar.2006 tsbogend@alpha.franken.de
[  105.515961] NET: Registered protocol family 5
[  105.613710] ns83820.c: National Semiconductor DP83820 10/100/1000 driver.
[  105.614319] ACPI: PCI Interrupt 0000:00:09.0[A] -> Link [LNKA] ->
GSI 10 (level, low) -> IRQ 10
[  105.614625] eth1: ns83820.c: 0x22c: 00000000, subsystem: 0000:0000
[  105.641785] eth1: ns83820 v0.23: DP83820 v1.2: 00:4f:4a:00:13:5a
io=0xefffb000 irq=10 f=sg
[  106.289402] Loading Reiser4. See www.namesys.com for a description
of Reiser4.
[  139.047608] JFS: nTxBlock = 4023, nTxLock = 32185
[  157.171109] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[  158.611757] eth1: link now 1000 mbps, full duplex and up.
[  161.526960] eth0: Setting full-duplex based on MII#1 link partner
capability of cde1.
[  168.051671]
[  168.051676] ============================
[  168.055000] [ BUG: illegal lock usage! ]
[  168.055087] ----------------------------
[  168.055176] illegal {softirq-on-W} -> {in-softirq-W} usage.
[  168.055273] idle/0 [HC0[0]:SC1[1]:HE0:SE0] takes:
[  168.055368]  (&dev->rx_info.lock){-+..}, at: [<e090a98f>]
rx_irq+0x24/0x18f [ns83820]
[  168.055664] {softirq-on-W} state was registered at:
[  168.055755]   [<c012d27d>] trace_hardirqs_on+0x142/0x16d
[  168.055972]   [<c028815a>] _spin_unlock_irq+0x21/0x25
[  168.056166]   [<e090b78e>] ns83820_open+0x25b/0x381 [ns83820]
[  168.056357]   [<c0242c60>] dev_open+0x2d/0x64
[  168.056543]   [<c024171e>] dev_change_flags+0x51/0xf1
[  168.056728]   [<c0274e42>] devinet_ioctl+0x238/0x556
[  168.056915]   [<c02753d3>] inet_ioctl+0x73/0x91
[  168.057095]   [<c023929f>] sock_ioctl+0x190/0x1b6
[  168.057279]   [<c0164701>] do_ioctl+0x19/0x4f
[  168.057466]   [<c0164940>] vfs_ioctl+0x209/0x220
[  168.057648]   [<c0164983>] sys_ioctl+0x2c/0x59
[  168.057827]   [<c0288283>] syscall_call+0x7/0xb
[  168.058009] irq event stamp: 575395
[  168.058098] hardirqs last  enabled at (575394): [<c011a64d>]
tasklet_action+0x20/0x71
[  168.058299] hardirqs last disabled at (575395): [<c0287ffd>]
_spin_lock_irqsave+0xf/0x2f
[  168.058491] softirqs last  enabled at (575386): [<c011aa6a>]
__do_softirq+0x97/0x9c
[  168.058680] softirqs last disabled at (575391): [<c01045e3>]
do_softirq+0x45/0xb6
[  168.058873]
[  168.058875] other info that might help us debug this:
[  168.059056] no locks held by idle/0.
[  168.059149]
[  168.059151] stack backtrace:
[  168.059732]  [<c010311a>] show_trace_log_lvl+0x54/0xfd
[  168.059889]  [<c0103709>] show_trace+0xd/0x10
[  168.060031]  [<c0103750>] dump_stack+0x19/0x1b
[  168.060173]  [<c012b89a>] print_usage_bug+0x1a4/0x1ae
[  168.060512]  [<c012be3d>] mark_lock+0x16b/0x502
[  168.060844]  [<c012cae0>] __lockdep_acquire+0x3cb/0xa26
[  168.061181]  [<c012d56f>] lockdep_acquire+0x69/0x82
[  168.061515]  [<c028800e>] _spin_lock_irqsave+0x20/0x2f
[  168.061880]  [<e090a98f>] rx_irq+0x24/0x18f [ns83820]
[  168.062026]  [<e090acd9>] rx_action+0x19/0x5a [ns83820]
[  168.062164]  [<c011a672>] tasklet_action+0x45/0x71
[  168.062422]  [<c011aa19>] __do_softirq+0x46/0x9c
[  168.062681]  [<c01045e3>] do_softirq+0x45/0xb6
[  168.062838]  [<c011aa9f>] irq_exit+0x30/0x32
[  168.063095]  [<c01046d9>] do_IRQ+0x85/0x90
[  168.063246]  [<c0102c45>] common_interrupt+0x25/0x2c
[  170.236049] NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state
recovery directory
[  170.236840] NFSD: starting 90-second grace period
[  172.087631] program smartd is using a deprecated SCSI ioctl, please
convert it to SG_IO
[  172.088785] program smartd is using a deprecated SCSI ioctl, please
convert it to SG_IO
[  172.091643] program smartd is using a deprecated SCSI ioctl, please
convert it to SG_IO
[  172.092365] program smartd is using a deprecated SCSI ioctl, please
convert it to SG_IO
[  172.095425] program smartd is using a deprecated SCSI ioctl, please
convert it to SG_IO
[  172.096145] program smartd is using a deprecated SCSI ioctl, please
convert it to SG_IO
[  172.099023] program smartd is using a deprecated SCSI ioctl, please
convert it to SG_IO
[  172.099742] program smartd is using a deprecated SCSI ioctl, please
convert it to SG_IO
[  172.102564] program smartd is using a deprecated SCSI ioctl, please
convert it to SG_IO
[  172.103278] program smartd is using a deprecated SCSI ioctl, please
convert it to SG_IO
