Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932118AbWFDMEc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbWFDMEc (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 08:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932234AbWFDMEc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 08:04:32 -0400
Received: from wx-out-0102.google.com ([66.249.82.200]:27020 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932118AbWFDMEb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 08:04:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=QA+hjGPqlvD2KY/zoBTr02jH8EBcdv2fYdjA8ngvYyUV254mTo0ewxlCHFb9LSI8OrRR6lsmafoaTgtfyU5mVA9DJsIxbB1foxS3Pb33DDgmcZzCMsVDOIXf3xND0VxV7aW/rWBZyWVGVGUIk4+t/M/lmH/JhRSutU5iit3oGJM=
Message-ID: <986ed62e0606040504n148bf744x77bd0669a5642dd0@mail.gmail.com>
Date: Sun, 4 Jun 2006 05:04:29 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: "Andrew Morton" <akpm@osdl.org>, "Ingo Molnar" <mingo@elte.hu>,
        "Arjan van de Ven" <arjan@linux.intel.com>
Subject: 2.6.17-rc5-mm3: bad unlock ordering (reiser4?)
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Google-Sender-Auth: 2930cd2db857a1fc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is 2.6.17-rc5-mm3 + the 3 ns83820 patches. I have no idea what I
did to cause this to happen (i.e. it claims that mv is the culprit,
but I don't think I was running mv myself -- I guess it was spawned by
another process, but I have *no* idea what would have done it). I'm
including the full dmesg.
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
[    0.000000] Detected 805.700 MHz processor.
[   73.423215] Built 1 zonelists
[   73.423223] Kernel command line: BOOT_IMAGE=bzimage lapic
root=/dev/sdc1 vga=6
[   73.423729] Local APIC disabled by BIOS -- reenabling.
[   73.423737] Found and enabled local APIC!
[   73.423746] mapped APIC to ffffd000 (fee00000)
[   73.423755] Enabling fast FPU save and restore... done.
[   73.423764] Initializing CPU#0
[   73.423909] CPU 0 irqstacks, hard=c03f3000 soft=c03f2000
[   73.423920] PID hash table entries: 2048 (order: 11, 8192 bytes)
[   73.427064] Console: colour VGA+ 80x60
[   73.429590] Lock dependency validator: Copyright (c) 2006 Red Hat,
Inc., Ingo Molnar
[   73.429743] ... MAX_LOCKDEP_SUBTYPES:    8
[   73.429838] ... MAX_LOCK_DEPTH:          30
[   73.429935] ... MAX_LOCKDEP_KEYS:        2048
[   73.430030] ... TYPEHASH_SIZE:           1024
[   73.430127] ... MAX_LOCKDEP_ENTRIES:     8192
[   73.430222] ... MAX_LOCKDEP_CHAINS:      8192
[   73.430316] ... CHAINHASH_SIZE:          4096
[   73.430411]  memory used by lock dependency info: 696 kB
[   73.430508]  per task-struct memory footprint: 1080 bytes
[   73.430595] ------------------------
[   73.430677] | Locking API testsuite:
[   73.430760] ----------------------------------------------------------------------------
[   73.430894]                                  | spin |wlock |rlock
|mutex | wsem | rsem |
[   73.431030]
--------------------------------------------------------------------------
[   73.431186]                      A-A deadlock:  ok  |  ok  |  ok  |
 ok  |  ok  |  ok  |
[   73.433526]                  A-B-B-A deadlock:  ok  |  ok  |  ok  |
 ok  |  ok  |  ok  |
[   73.435923]              A-B-B-C-C-A deadlock:  ok  |  ok  |  ok  |
 ok  |  ok  |  ok  |
[   73.438304]              A-B-C-A-B-C deadlock:  ok  |  ok  |  ok  |
 ok  |  ok  |  ok  |
[   73.440688]          A-B-B-C-C-D-D-A deadlock:  ok  |  ok  |  ok  |
 ok  |  ok  |  ok  |
[   73.443151]          A-B-C-D-B-D-D-A deadlock:  ok  |  ok  |  ok  |
 ok  |  ok  |  ok  |
[   73.445640]          A-B-C-D-B-C-D-A deadlock:  ok  |  ok  |  ok  |
 ok  |  ok  |  ok  |
[   73.448083]                     double unlock:  ok  |  ok  |  ok  |
 ok  |  ok  |  ok  |
[   73.450360]                  bad unlock order:  ok  |  ok  |  ok  |
 ok  |  ok  |  ok  |
[   73.452675]
--------------------------------------------------------------------------
[   73.452823]               recursive read-lock:             |  ok  |
            |  ok  |
[   73.453768]
--------------------------------------------------------------------------
[   73.453947]                 non-nested unlock:  ok  |  ok  |  ok  |  ok  |
[   73.455518]   ------------------------------------------------------------
[   73.455618]      hard-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
[   73.456799]      soft-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
[   73.457985]      hard-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
[   73.459163]      soft-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
[   73.460340]        sirq-safe-A => hirqs-on/12:  ok  |  ok  |  ok  |
[   73.461532]        sirq-safe-A => hirqs-on/21:  ok  |  ok  |  ok  |
[   73.462723]          hard-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
[   73.463929]          soft-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
[   73.465113]          hard-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
[   73.466299]          soft-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
[   73.467487]     hard-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
[   73.468692]     soft-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
[   73.469907]     hard-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
[   73.471119]     soft-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
[   73.472331]     hard-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
[   73.473538]     soft-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
[   73.474779]     hard-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
[   73.475982]     soft-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
[   73.477182]     hard-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
[   73.478371]     soft-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
[   73.479574]     hard-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
[   73.480780]     soft-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
[   73.481976]     hard-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
[   73.483181]     soft-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
[   73.484423]     hard-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
[   73.485629]     soft-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
[   73.486848]     hard-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
[   73.488061]     soft-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
[   73.489268]     hard-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
[   73.490471]     soft-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
[   73.491680]     hard-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
[   73.492885]     soft-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
[   73.494122]     hard-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
[   73.495334]     soft-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
[   73.496548]       hard-irq lock-inversion/123:  ok  |  ok  |  ok  |
[   73.497751]       soft-irq lock-inversion/123:  ok  |  ok  |  ok  |
[   73.498966]       hard-irq lock-inversion/132:  ok  |  ok  |  ok  |
[   73.500182]       soft-irq lock-inversion/132:  ok  |  ok  |  ok  |
[   73.501394]       hard-irq lock-inversion/213:  ok  |  ok  |  ok  |
[   73.502607]       soft-irq lock-inversion/213:  ok  |  ok  |  ok  |
[   73.503822]       hard-irq lock-inversion/231:  ok  |  ok  |  ok  |
[   73.505056]       soft-irq lock-inversion/231:  ok  |  ok  |  ok  |
[   73.506275]       hard-irq lock-inversion/312:  ok  |  ok  |  ok  |
[   73.507488]       soft-irq lock-inversion/312:  ok  |  ok  |  ok  |
[   73.508720]       hard-irq lock-inversion/321:  ok  |  ok  |  ok  |
[   73.509936]       soft-irq lock-inversion/321:  ok  |  ok  |  ok  |
[   73.511156]       hard-irq read-recursion/123:  ok  |
[   73.511652]       soft-irq read-recursion/123:  ok  |
[   73.512146]       hard-irq read-recursion/132:  ok  |
[   73.512640]       soft-irq read-recursion/132:  ok  |
[   73.513135]       hard-irq read-recursion/213:  ok  |
[   73.513630]       soft-irq read-recursion/213:  ok  |
[   73.514146]       hard-irq read-recursion/231:  ok  |
[   73.514628]       soft-irq read-recursion/231:  ok  |
[   73.515111]       hard-irq read-recursion/312:  ok  |
[   73.515590]       soft-irq read-recursion/312:  ok  |
[   73.516077]       hard-irq read-recursion/321:  ok  |
[   73.516562]       soft-irq read-recursion/321:  ok  |
[   73.517057] -------------------------------------------------------
[   73.517155] Good, all 210 testcases passed! |
[   73.517246] ---------------------------------
[   73.518188] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
[   73.519170] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
[   73.567701] Memory: 514628k/524224k available (1572k kernel code,
9028k reserved, 909k data, 160k init, 0k highmem)
[   73.567877] Checking if this processor honours the WP bit even in
supervisor mode... Ok.
[   73.713687] Calibrating delay using timer specific routine..
1613.93 BogoMIPS (lpj=8069673)
[   73.714134] Mount-cache hash table entries: 512
[   73.715094] CPU: After generic identify, caps: 0183fbff c1c3fbff
00000000 00000000 00000000 00000000 00000000
[   73.715127] CPU: After vendor identify, caps: 0183fbff c1c3fbff
00000000 00000000 00000000 00000000 00000000
[   73.715159] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[   73.715259] CPU: L2 Cache: 512K (64 bytes/line)
[   73.715345] CPU: After all inits, caps: 0183fbff c1c3fbff 00000000
00000420 00000000 00000000 00000000
[   73.715375] Intel machine check architecture supported.
[   73.715464] Intel machine check reporting enabled on CPU#0.
[   73.715560] Compat vDSO mapped to ffffe000.
[   73.715663] CPU: AMD Athlon(tm) Processor stepping 01
[   73.715818] Checking 'hlt' instruction... OK.
[   73.753770] SMP alternatives: switching to UP code
[   73.753865] Freeing SMP alternatives: 0k freed
[   73.763218] ACPI: setting ELCR to 0010 (from 0e00)
[   73.764030] lockdep: disabled NMI watchdog.
[   73.889610] NET: Registered protocol family 16
[   73.890016] ACPI: bus type pci registered
[   73.902012] PCI: PCI BIOS revision 2.10 entry at 0xfdaf1, last bus=1
[   73.902116] Setting up standard PCI resources
[   73.904737] spurious 8259A interrupt: IRQ7.
[   73.917948] ACPI: Subsystem revision 20060310
[   73.933832] ACPI: Interpreter enabled
[   73.933926] ACPI: Using PIC for interrupt routing
[   73.936924] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   73.937057] PCI: Probing PCI hardware (bus 00)
[   73.946681] Boot video device is 0000:01:05.0
[   73.947042] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[   73.957760] ACPI: Power Resource [URP1] (off)
[   73.958278] ACPI: Power Resource [URP2] (off)
[   73.958749] ACPI: Power Resource [FDDP] (off)
[   73.959221] ACPI: Power Resource [LPTP] (off)
[   73.961008] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 *10
11 12 14 15)
[   73.962554] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10
*11 12 14 15)
[   73.964102] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *9 10
11 12 14 15)
[   73.965597] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 11
12 14 15) *0, disabled.
[   73.966646] Linux Plug and Play Support v0.97 (c) Adam Belay
[   73.966851] pnp: PnP ACPI init
[   73.973130] pnp: PnP ACPI: found 8 devices
[   73.973242] PnPBIOS: Disabled by ACPI PNP
[   73.974372] SCSI subsystem initialized
[   73.974759] PCI: Using ACPI for IRQ routing
[   73.974867] PCI: If a device doesn't work, try "pci=routeirq".  If
it helps, post a report
[   73.986036] PCI: Bridge: 0000:00:01.0
[   73.986144]   IO window: 9000-9fff
[   73.986267]   MEM window: e7d00000-efdfffff
[   73.986376]   PREFETCH window: e3b00000-e3bfffff
[   73.986638] NET: Registered protocol family 2
[   74.083678] IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
[   74.084451] TCP established hash table entries: 16384 (order: 8,
1376256 bytes)
[   74.092659] TCP bind hash table entries: 8192 (order: 7, 720896 bytes)
[   74.097170] TCP: Hash tables configured (established 16384 bind 8192)
[   74.097333] TCP reno registered
[   74.099775] Machine check exception polling timer started.
[   74.105643] Initializing Cryptographic API
[   74.105781] io scheduler noop registered
[   74.105959] io scheduler cfq registered (default)
[   74.106509] ACPI: Power Button (FF) [PWRF]
[   74.106627] ACPI: Sleep Button (FF) [SLPF]
[   74.106745] ACPI: Power Button (CM) [PWRB]
[   74.107319] isapnp: Scanning for PnP cards...
[   74.464326] isapnp: No Plug & Play device found
[   74.481654] Floppy drive(s): fd0 is 1.44M
[   74.495209] FDC 0 is a post-1991 82077
[   74.498173] libata version 1.30 loaded.
[   74.498489] pata_pdc2027x 0000:00:0a.0: version 0.74
[   74.499315] ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
[   74.499430] PCI: setting IRQ 11 as level-triggered
[   74.499440] ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNKB] ->
GSI 11 (level, low) -> IRQ 11
[   74.599821] pata_pdc2027x 0000:00:0a.0: PLL input clock 16813 kHz
[   74.630253] ata1: PATA max UDMA/133 cmd 0xE08097C0 ctl 0xE0809FDA
bmdma 0xE0809000 irq 11
[   74.630582] ata2: PATA max UDMA/133 cmd 0xE08095C0 ctl 0xE0809DDA
bmdma 0xE0809008 irq 11
[   74.783656] ata1.00: cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c69
86:3e01 87:4003 88:407f
[   74.783672] ata1.00: ATA-7, max UDMA/133, 490234752 sectors: LBA48
[   74.784639] ata1.00: configured for UDMA/133
[   74.784736] scsi0 : pata_pdc2027x
[   74.943624] ata2.00: cfg 49:2f00 82:346b 83:7f01 84:4003 85:3469
86:3c01 87:4003 88:203f
[   74.943638] ata2.00: ATA-6, max UDMA/100, 625142448 sectors: LBA48
[   74.944727] ata2.00: configured for UDMA/100
[   74.944827] scsi1 : pata_pdc2027x
[   74.946048]   Vendor: ATA       Model: Maxtor 6Y250P0    Rev: YAR4
[   74.947132]   Type:   Direct-Access                      ANSI SCSI
revision: 05
[   74.948531]   Vendor: ATA       Model: WDC WD3200JB-00K  Rev: 08.0
[   74.949587]   Type:   Direct-Access                      ANSI SCSI
revision: 05
[   74.950858] sata_sil 0000:00:0d.0: version 1.0
[   74.951608] ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
[   74.951721] PCI: setting IRQ 10 as level-triggered
[   74.951731] ACPI: PCI Interrupt 0000:00:0d.0[A] -> Link [LNKA] ->
GSI 10 (level, low) -> IRQ 10
[   74.952000] sata_sil 0000:00:0d.0: Applying R_ERR on DMA activate
FIS errata fix
[   74.952353] ata3: SATA max UDMA/100 cmd 0xE080E480 ctl 0xE080E48A
bmdma 0xE080E400 irq 10
[   74.952744] ata4: SATA max UDMA/100 cmd 0xE080E4C0 ctl 0xE080E4CA
bmdma 0xE080E408 irq 10
[   74.953057] ata5: SATA max UDMA/100 cmd 0xE080E680 ctl 0xE080E68A
bmdma 0xE080E600 irq 10
[   74.953387] ata6: SATA max UDMA/100 cmd 0xE080E6C0 ctl 0xE080E6CA
bmdma 0xE080E608 irq 10
[   75.322421] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   75.323384] ata3.00: cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c69
86:3e01 87:4003 88:207f
[   75.323400] ata3.00: ATA-7, max UDMA/133, 585940320 sectors: LBA48
[   75.323492] ata3.00: applying bridge limits
[   75.324594] ata3.00: configured for UDMA/100
[   75.324694] scsi2 : sata_sil
[   75.692121] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   75.693397] ata4.00: cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469
86:3c01 87:4023 88:203f
[   75.693410] ata4.00: ATA-7, max UDMA/100, 781422768 sectors: LBA48
[   75.693513] ata4.00: applying bridge limits
[   75.694898] ata4.00: configured for UDMA/100
[   75.694996] scsi3 : sata_sil
[   76.061822] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   76.062791] ata5.00: cfg 49:2f00 82:346b 83:7f01 84:4003 85:3469
86:3e01 87:4003 88:203f
[   76.062805] ata5.00: ATA-6, max UDMA/100, 625142448 sectors: LBA48
[   76.062906] ata5.00: applying bridge limits
[   76.063980] ata5.00: configured for UDMA/100
[   76.064076] scsi4 : sata_sil
[   76.271637] ata6: SATA link down (SStatus 0 SControl 310)
[   76.271756] scsi5 : sata_sil
[   76.272693]   Vendor: ATA       Model: Maxtor 4A300J0    Rev: RAMB
[   76.273756]   Type:   Direct-Access                      ANSI SCSI
revision: 05
[   76.275160]   Vendor: ATA       Model: ST3400832A        Rev: 3.01
[   76.276243]   Type:   Direct-Access                      ANSI SCSI
revision: 05
[   76.277685]   Vendor: ATA       Model: WDC WD3200JB-00K  Rev: 08.0
[   76.278717]   Type:   Direct-Access                      ANSI SCSI
revision: 05
[   76.280592] SCSI device sda: 490234752 512-byte hdwr sectors (251000 MB)
[   76.280796] sda: Write Protect is off
[   76.280900] sda: Mode Sense: 00 3a 00 00
[   76.281068] SCSI device sda: drive cache: write back
[   76.281711] SCSI device sda: 490234752 512-byte hdwr sectors (251000 MB)
[   76.281919] sda: Write Protect is off
[   76.282019] sda: Mode Sense: 00 3a 00 00
[   76.282214] SCSI device sda: drive cache: write back
[   76.282312]  sda: unknown partition table
[   76.284598] sd 0:0:0:0: Attached scsi disk sda
[   76.285234] SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
[   76.285426] sdb: Write Protect is off
[   76.285521] sdb: Mode Sense: 00 3a 00 00
[   76.285687] SCSI device sdb: drive cache: write back
[   76.286193] SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
[   76.286393] sdb: Write Protect is off
[   76.286491] sdb: Mode Sense: 00 3a 00 00
[   76.286680] SCSI device sdb: drive cache: write back
[   76.286787]  sdb: unknown partition table
[   76.290732] sd 1:0:0:0: Attached scsi disk sdb
[   76.291330] SCSI device sdc: 585940320 512-byte hdwr sectors (300001 MB)
[   76.291521] sdc: Write Protect is off
[   76.291654] sdc: Mode Sense: 00 3a 00 00
[   76.291827] SCSI device sdc: drive cache: write back
[   76.292338] SCSI device sdc: 585940320 512-byte hdwr sectors (300001 MB)
[   76.292542] sdc: Write Protect is off
[   76.292640] sdc: Mode Sense: 00 3a 00 00
[   76.292830] SCSI device sdc: drive cache: write back
[   76.292932]  sdc: sdc1
[   76.295994] sd 2:0:0:0: Attached scsi disk sdc
[   76.296559] SCSI device sdd: 781422768 512-byte hdwr sectors (400088 MB)
[   76.296750] sdd: Write Protect is off
[   76.296855] sdd: Mode Sense: 00 3a 00 00
[   76.297021] SCSI device sdd: drive cache: write back
[   76.297532] SCSI device sdd: 781422768 512-byte hdwr sectors (400088 MB)
[   76.297732] sdd: Write Protect is off
[   76.297838] sdd: Mode Sense: 00 3a 00 00
[   76.298029] SCSI device sdd: drive cache: write back
[   76.298125]  sdd: unknown partition table
[   76.318711] sd 3:0:0:0: Attached scsi disk sdd
[   76.319289] SCSI device sde: 625142448 512-byte hdwr sectors (320073 MB)
[   76.319486] sde: Write Protect is off
[   76.319585] sde: Mode Sense: 00 3a 00 00
[   76.319753] SCSI device sde: drive cache: write back
[   76.320256] SCSI device sde: 625142448 512-byte hdwr sectors (320073 MB)
[   76.320459] sde: Write Protect is off
[   76.320556] sde: Mode Sense: 00 3a 00 00
[   76.320744] SCSI device sde: drive cache: write back
[   76.320845]  sde: sde1 sde2
[   76.345135] sd 4:0:0:0: Attached scsi disk sde
[   76.348042] PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at
0x60,0x64 irq 1,12
[   76.348939] serio: i8042 AUX port at 0x60,0x64 irq 12
[   76.349085] serio: i8042 KBD port at 0x60,0x64 irq 1
[   76.350900] mice: PS/2 mouse device common for all mice
[   76.351297] NET: Registered protocol family 1
[   76.351434] Using IPI Shortcut mode
[   76.351560] Time: tsc clocksource has been installed.
[   76.352398] ACPI: (supports S0 S1 S4 S5)
[   76.353382] Freeing unused kernel memory: 160k freed
[   76.353666] Write protecting the kernel read-only data: 312k
[   76.367030] ReiserFS: sdc1: found reiserfs format "3.6" with standard journal
[   76.386846] input: AT Translated Set 2 keyboard as /class/input/input0
[   76.562009] logips2pp: Detected unknown logitech mouse model 0
[   77.082794] input: PS/2 Logitech Mouse as /class/input/input1
[   94.743067] ReiserFS: sdc1: using ordered data mode
[   94.776394] ReiserFS: sdc1: journal params: device sdc1, size 8192,
journal first block 18, max trans len 1024, max batch 900, max commit
age 30, max trans age 30
[   94.779773] ReiserFS: sdc1: checking transaction log (sdc1)
[   94.876353] ReiserFS: sdc1: Using r5 hash to sort names
[  102.593054] Real Time Clock Driver v1.12ac
[  105.344061] Linux Tulip driver version 1.1.13-NAPI (December 15, 2004)
[  105.345362] ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 9
[  105.345473] PCI: setting IRQ 9 as level-triggered
[  105.345483] ACPI: PCI Interrupt 0000:00:0b.0[A] -> Link [LNKC] ->
GSI 9 (level, low) -> IRQ 9
[  105.361941] tulip0:  EEPROM default media type Autosense.
[  105.362049] tulip0:  Index #0 - Media MII (#11) described by a
21142 MII PHY (3) block.
[  105.366477] tulip0:  MII transceiver #1 config 1000 status 782d
advertising 01e1.
[  105.371705] eth0: Digital DS21143 Tulip rev 65 at 0001d000,
00:C0:F0:4A:0C:46, IRQ 9.
[  105.396983] pcnet32.c:v1.32 18.Mar.2006 tsbogend@alpha.franken.de
[  105.495725] NET: Registered protocol family 5
[  105.589618] ns83820.c: National Semiconductor DP83820 10/100/1000 driver.
[  105.590217] ACPI: PCI Interrupt 0000:00:09.0[A] -> Link [LNKA] ->
GSI 10 (level, low) -> IRQ 10
[  105.590542] eth1: ns83820.c: 0x22c: 00000000, subsystem: 0000:0000
[  105.617982] eth1: ns83820 v0.23: DP83820 v1.2: 00:4f:4a:00:13:5a
io=0xefffb000 irq=10 f=sg
[  106.262717] Loading Reiser4. See www.namesys.com for a description
of Reiser4.
[  139.032547] JFS: nTxBlock = 4023, nTxLock = 32185
[  157.143387] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[  158.625829] eth1: link now 1000 mbps, full duplex and up.
[  161.533134] eth0: Setting full-duplex based on MII#1 link partner
capability of cde1.
[  170.556683] NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state
recovery directory
[  170.558038] NFSD: starting 90-second grace period
[ 1637.890434]
[ 1637.890440] ======================================
[ 1637.890641] [ BUG: bad unlock ordering detected! ]
[ 1637.890741] --------------------------------------
[ 1637.890841] mv/935 is trying to release lock (&mgr->tmgr_lock) at:
[ 1637.890996]  [<e098e01b>] try_capture+0x306/0x9b1 [reiser4]
[ 1637.891255] but the next lock to release is:
[ 1637.891344]  (&atom->alock){--..}, at: [<e098dfe2>]
try_capture+0x2cd/0x9b1 [reiser4]
[ 1637.891667]
[ 1637.891670] other info that might help us debug this:
[ 1637.891854] 3 locks held by mv/935:
[ 1637.891951]  #0:  (&inode->i_mutex/1){--..}, at: [<c0160325>]
lock_rename+0xba/0xc1
[ 1637.892297]  #1:  (&mgr->tmgr_lock){--..}, at: [<e098deb5>]
try_capture+0x1a0/0x9b1 [reiser4]
[ 1637.892647]  #2:  (&txnh->hlock){--..}, at: [<e098debd>]
try_capture+0x1a8/0x9b1 [reiser4]
[ 1637.892994]
[ 1637.892996] stack backtrace:
[ 1637.893577]  [<c010311a>] show_trace_log_lvl+0x54/0xfd
[ 1637.893738]  [<c0103709>] show_trace+0xd/0x10
[ 1637.893893]  [<c0103750>] dump_stack+0x19/0x1b
[ 1637.894045]  [<c012d713>] lockdep_release+0x18b/0x350
[ 1637.894407]  [<c02880d9>] _spin_unlock+0x16/0x1f
[ 1637.894777]  [<e098e01b>] try_capture+0x306/0x9b1 [reiser4]
[ 1637.895048]  [<e0988a80>] longterm_lock_znode+0x2e3/0x3e3 [reiser4]
[ 1637.895254]  [<e0995790>] coord_by_handle+0x136/0xaf4 [reiser4]
[ 1637.895515]  [<e09962de>] object_lookup+0x8e/0x96 [reiser4]
[ 1637.895764]  [<e09a9ece>] find_entry+0xbb/0x200 [reiser4]
[ 1637.896134]  [<e099fab1>] rename_common+0x96b/0x9b6 [reiser4]
[ 1637.896440]  [<c0160e96>] vfs_rename+0x1dd/0x315
[ 1637.897098]  [<c0162b84>] sys_renameat+0x1bb/0x22a
[ 1637.897664]  [<c0162c05>] sys_rename+0x12/0x14
[ 1637.898220]  [<c0288283>] syscall_call+0x7/0xb
