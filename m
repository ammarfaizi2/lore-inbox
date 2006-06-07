Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932185AbWFGKOI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbWFGKOI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 06:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbWFGKOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 06:14:08 -0400
Received: from wx-out-0102.google.com ([66.249.82.200]:48068 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932185AbWFGKOD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 06:14:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:references:x-google-sender-auth;
        b=PhNaDn7SqmqaVlvHWytTtf+4eSP5ixN9dCs3wxYQnvct2xPZhKWhkzgHEgW6vG+Gi2MprVWjtXu4cO9vIGtLL0odEveY9WEELXR5Se5o6zq04VVABejelLnE5q/Ti1z8O93tvroHMp/or8dQ8NJJLzo/UrZaKxZrEjz/2F+u6Ns=
Message-ID: <986ed62e0606070314u442b9e62jda63519bf0826fe2@mail.gmail.com>
Date: Wed, 7 Jun 2006 03:14:02 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.17-rc5-mm3: "BUG: scheduling while atomic" flood when resuming from disk
Cc: mingo@elte.hu, arjan@linux.intel.com, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org, "Brown, Len" <len.brown@intel.com>
In-Reply-To: <20060604225140.cf87519f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_41244_3504762.1149675242844"
References: <986ed62e0606042223l2381d877g4bc798ec64804d43@mail.gmail.com>
	 <20060604225140.cf87519f.akpm@osdl.org>
X-Google-Sender-Auth: 3ff847c4a9207d41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_41244_3504762.1149675242844
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 6/4/06, Andrew Morton <akpm@osdl.org> wrote:
> The interesting thing is that we've done sleepy things like down() just
> prior to this.  Do you have CONFIG_PREEMPT and CONFIG_DEBUG_SPINLOCK_SLEEP
> enabled?  If not, please turn them on, see what happens.
>
> I don't see anything on that code path which would cause this.  Maybe I
> missed it.

Sorry that took so long; I made the mistake of trying to do the kernel
compile on a kernel with lockdep-tracer, and the result was that Ingo
kept coming out with new lockdep-combo patches before the kernel
compiles could finish. I finally rebooted into vanilla 2.6.17-rc5-mm3
and did the compile there.

(Plain lockdep does slow the system down a little, but it's still fast
enough that I may actually put it into production use on most of my
Linux boxes at home. Lockdep-tracer, OTOH, is *real* slow.)

Anyway, I've now compiled a kernel with Ingo's latest lockdep-combo
and with DEBUG_SPINLOCK_SLEEP enabled. I'll attach the dmesg output
from suspending to disk with this kernel (it should just appear as
plain text at the end of this e-mail). Hopefully that will avoid the
word-wrapping problem. If the dmesg is completely unreadable for any
reason, I'll also post it here:
http://members.cox.net/barrykn/linux/trace/dmesg.debugsleep
-- 
-Barry K. Nathan <barryn@pobox.com>

------=_Part_41244_3504762.1149675242844
Content-Type: text/plain; name=dmesg.debugsleep.txt; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-Attachment-Id: f_eo5i316s
Content-Disposition: attachment; filename="dmesg.debugsleep.txt"

[    0.000000] Linux version 2.6.17-rc5-mm3-lockdep (barryn@ubuntu) (gcc ve=
rsion 4.0.3 (Ubuntu 4.0.3-1ubuntu5)) #7 PREEMPT Wed Jun 7 00:31:36 PDT 2006
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] sanitize start
[    0.000000] sanitize end
[    0.000000] copy_e820_map() start: 0000000000000000 size: 000000000009fc=
00 end: 000000000009fc00 type: 1
[    0.000000] copy_e820_map() type is E820_RAM
[    0.000000] add_memory_region(0000000000000000, 000000000009fc00, 1)
[    0.000000] copy_e820_map() start: 000000000009fc00 size: 00000000000004=
00 end: 00000000000a0000 type: 2
[    0.000000] add_memory_region(000000000009fc00, 0000000000000400, 2)
[    0.000000] copy_e820_map() start: 00000000000f0000 size: 00000000000100=
00 end: 0000000000100000 type: 2
[    0.000000] add_memory_region(00000000000f0000, 0000000000010000, 2)
[    0.000000] copy_e820_map() start: 0000000000100000 size: 000000001fef00=
00 end: 000000001fff0000 type: 1
[    0.000000] copy_e820_map() type is E820_RAM
[    0.000000] add_memory_region(0000000000100000, 000000001fef0000, 1)
[    0.000000] copy_e820_map() start: 000000001fff0000 size: 00000000000080=
00 end: 000000001fff8000 type: 3
[    0.000000] add_memory_region(000000001fff0000, 0000000000008000, 3)
[    0.000000] copy_e820_map() start: 000000001fff8000 size: 00000000000080=
00 end: 0000000020000000 type: 4
[    0.000000] add_memory_region(000000001fff8000, 0000000000008000, 4)
[    0.000000] copy_e820_map() start: 00000000fec00000 size: 00000000000010=
00 end: 00000000fec01000 type: 2
[    0.000000] add_memory_region(00000000fec00000, 0000000000001000, 2)
[    0.000000] copy_e820_map() start: 00000000fee00000 size: 00000000000010=
00 end: 00000000fee01000 type: 2
[    0.000000] add_memory_region(00000000fee00000, 0000000000001000, 2)
[    0.000000] copy_e820_map() start: 00000000fff80000 size: 00000000000800=
00 end: 0000000100000000 type: 2
[    0.000000] add_memory_region(00000000fff80000, 0000000000080000, 2)
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[    0.000000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
[    0.000000]  BIOS-e820: 000000001fff0000 - 000000001fff8000 (ACPI data)
[    0.000000]  BIOS-e820: 000000001fff8000 - 0000000020000000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[    0.000000]  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
[    0.000000] 0MB HIGHMEM available.
[    0.000000] 511MB LOWMEM available.
[    0.000000] found SMP MP-table at 000fba70
[    0.000000] On node 0 totalpages: 131056
[    0.000000]   DMA zone: 4096 pages, LIFO batch:0
[    0.000000]   Normal zone: 126960 pages, LIFO batch:31
[    0.000000] DMI 2.3 present.
[    0.000000] ACPI: RSDP (v000 AMI                                   ) @ 0=
x000fa0c0
[    0.000000] ACPI: RSDT (v001 AMIINT VIA_K8   0x00000010 MSFT 0x00000097)=
 @ 0x1fff0000
[    0.000000] ACPI: FADT (v001 AMIINT VIA_K8   0x00000011 MSFT 0x00000097)=
 @ 0x1fff0030
[    0.000000] ACPI: MADT (v001 AMIINT VIA_K8   0x00000009 MSFT 0x00000097)=
 @ 0x1fff00c0
[    0.000000] ACPI: DSDT (v001    VIA   VIA_K8 0x00001000 MSFT 0x0100000d)=
 @ 0x00000000
[    0.000000] ACPI: PM-Timer IO Port: 0x808
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] Processor #0 15:12 APIC version 16
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, version 3, address 0xfec00000, GSI 0-2=
3
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] Allocating PCI resources starting at 30000000 (gap: 20000000=
:dec00000)
[    0.000000] Detected 1800.231 MHz processor.
[   23.943497] Built 1 zonelists
[   23.943499] Kernel command line: root=3D/dev/sda1 ro quiet elevator=3Dcf=
q
[   23.943690] mapped APIC to ffffd000 (fee00000)
[   23.943694] mapped IOAPIC to ffffc000 (fec00000)
[   23.943697] Enabling fast FPU save and restore... done.
[   23.943701] Enabling unmasked SIMD FPU exception support... done.
[   23.943704] Initializing CPU#0
[   23.943789] PID hash table entries: 2048 (order: 11, 8192 bytes)
[   23.945425] Console: colour VGA+ 80x25
[   23.945479] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc.,=
 Ingo Molnar
[   23.945482] ... MAX_LOCKDEP_SUBTYPES:    8
[   23.945485] ... MAX_LOCK_DEPTH:          30
[   23.945487] ... MAX_LOCKDEP_KEYS:        2048
[   23.945489] ... TYPEHASH_SIZE:           1024
[   23.945492] ... MAX_LOCKDEP_ENTRIES:     8192
[   23.945494] ... MAX_LOCKDEP_CHAINS:      8192
[   23.945496] ... CHAINHASH_SIZE:          4096
[   23.945499]  memory used by lock dependency info: 696 kB
[   23.945501]  per task-struct memory footprint: 1200 bytes
[   23.945504] ------------------------
[   23.945506] | Locking API testsuite:
[   23.945509] ------------------------------------------------------------=
----------------
[   23.945512]                                  | spin |wlock |rlock |mutex=
 | wsem | rsem |
[   23.945515]   ----------------------------------------------------------=
----------------
[   23.945528]                      A-A deadlock:  ok  |  ok  |  ok  |  ok =
 |  ok  |  ok  |
[   23.947131]                  A-B-B-A deadlock:  ok  |  ok  |  ok  |  ok =
 |  ok  |  ok  |
[   23.948730]              A-B-B-C-C-A deadlock:  ok  |  ok  |  ok  |  ok =
 |  ok  |  ok  |
[   23.950355]              A-B-C-A-B-C deadlock:  ok  |  ok  |  ok  |  ok =
 |  ok  |  ok  |
[   23.951981]          A-B-B-C-C-D-D-A deadlock:  ok  |  ok  |  ok  |  ok =
 |  ok  |  ok  |
[   23.953616]          A-B-C-D-B-D-D-A deadlock:  ok  |  ok  |  ok  |  ok =
 |  ok  |  ok  |
[   23.955265]          A-B-C-D-B-C-D-A deadlock:  ok  |  ok  |  ok  |  ok =
 |  ok  |  ok  |
[   23.956914]                     double unlock:  ok  |  ok  |  ok  |  ok =
 |  ok  |  ok  |
[   23.958496]                   initialize held:  ok  |  ok  |  ok  |  ok =
 |  ok  |  ok  |
[   23.960087]                  bad unlock order:  ok  |  ok  |  ok  |  ok =
 |  ok  |  ok  |
[   23.961680]   ----------------------------------------------------------=
----------------
[   23.961684]               recursive read-lock:             |  ok  |     =
        |  ok  |
[   23.962224]            recursive read-lock #2:             |  ok  |     =
        |  ok  |
[   23.962752]             mixed read-write-lock:             |  ok  |     =
        |  ok  |
[   23.963290]             mixed write-read-lock:             |  ok  |     =
        |  ok  |
[   23.963830]   ----------------------------------------------------------=
----------------
[   23.963834]                 non-nested unlock:  ok  |  ok  |  ok  |  ok =
 |
[   23.964904]   ----------------------------------------------------------=
--
[   23.964907]      hard-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
[   23.965695]      soft-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
[   23.966496]      hard-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
[   23.967295]      soft-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
[   23.968095]        sirq-safe-A =3D> hirqs-on/12:  ok  |  ok  |  ok  |
[   23.968896]        sirq-safe-A =3D> hirqs-on/21:  ok  |  ok  |  ok  |
[   23.969684]          hard-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
[   23.970484]          soft-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
[   23.971285]          hard-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
[   23.972085]          soft-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
[   23.972886]     hard-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
[   23.973682]     soft-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
[   23.974490]     hard-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
[   23.975297]     soft-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
[   23.976105]     hard-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
[   23.976913]     soft-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
[   23.977710]     hard-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
[   23.978516]     soft-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
[   23.979324]     hard-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
[   23.980126]     soft-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
[   23.980929]     hard-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
[   23.981724]     soft-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
[   23.982532]     hard-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
[   23.983339]     soft-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
[   23.984149]     hard-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
[   23.984956]     soft-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
[   23.985766]     hard-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
[   23.986562]     soft-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
[   23.987372]     hard-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
[   23.988179]     soft-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
[   23.988988]     hard-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
[   23.989795]     soft-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
[   23.990594]     hard-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
[   23.991401]     soft-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
[   23.992211]       hard-irq lock-inversion/123:  ok  |  ok  |  ok  |
[   23.993019]       soft-irq lock-inversion/123:  ok  |  ok  |  ok  |
[   23.993829]       hard-irq lock-inversion/132:  ok  |  ok  |  ok  |
[   23.994625]       soft-irq lock-inversion/132:  ok  |  ok  |  ok  |
[   23.995436]       hard-irq lock-inversion/213:  ok  |  ok  |  ok  |
[   23.996244]       soft-irq lock-inversion/213:  ok  |  ok  |  ok  |
[   23.997055]       hard-irq lock-inversion/231:  ok  |  ok  |  ok  |
[   23.997862]       soft-irq lock-inversion/231:  ok  |  ok  |  ok  |
[   23.998661]       hard-irq lock-inversion/312:  ok  |  ok  |  ok  |
[   23.999469]       soft-irq lock-inversion/312:  ok  |  ok  |  ok  |
[   24.000279]       hard-irq lock-inversion/321:  ok  |  ok  |  ok  |
[   24.001087]       soft-irq lock-inversion/321:  ok  |  ok  |  ok  |
[   24.001897]       hard-irq read-recursion/123:  ok  |
[   24.002165]       soft-irq read-recursion/123:  ok  |
[   24.002433]       hard-irq read-recursion/132:  ok  |
[   24.002712]       soft-irq read-recursion/132:  ok  |
[   24.002981]       hard-irq read-recursion/213:  ok  |
[   24.003249]       soft-irq read-recursion/213:  ok  |
[   24.003517]       hard-irq read-recursion/231:  ok  |
[   24.003796]       soft-irq read-recursion/231:  ok  |
[   24.004065]       hard-irq read-recursion/312:  ok  |
[   24.004332]       soft-irq read-recursion/312:  ok  |
[   24.004600]       hard-irq read-recursion/321:  ok  |
[   24.004880]       soft-irq read-recursion/321:  ok  |
[   24.005148] -------------------------------------------------------
[   24.005151] Good, all 222 testcases passed! |
[   24.005154] ---------------------------------
[   24.005361] Dentry cache hash table entries: 65536 (order: 6, 262144 byt=
es)
[   24.005598] Inode-cache hash table entries: 32768 (order: 5, 131072 byte=
s)
[   24.018408] Memory: 507064k/524224k available (2114k kernel code, 16548k=
 reserved, 1083k data, 324k init, 0k highmem)
[   24.018413] Checking if this processor honours the WP bit even in superv=
isor mode... Ok.
[   24.078574] Calibrating delay using timer specific routine.. 3603.54 Bog=
oMIPS (lpj=3D1801771)
[   24.078664] Security Framework v1.0.0 initialized
[   24.078671] SELinux:  Disabled at boot.
[   24.078696] Mount-cache hash table entries: 512
[   24.079035] CPU: After generic identify, caps: 078bfbff c1d3fbff 0000000=
0 00000000 00000000 00000000 00000001
[   24.079047] CPU: After vendor identify, caps: 078bfbff c1d3fbff 00000000=
 00000000 00000000 00000000 00000001
[   24.079060] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/=
line)
[   24.079063] CPU: L2 Cache: 256K (64 bytes/line)
[   24.079066] CPU: After all inits, caps: 078bfbff c1d3fbff 00000000 00000=
410 00000000 00000000 00000001
[   24.079077] Intel machine check architecture supported.
[   24.079080] Intel machine check reporting enabled on CPU#0.
[   24.079092] CPU: AMD Sempron(tm) Processor 3100+ stepping 00
[   24.079099] Checking 'hlt' instruction... OK.
[   24.082631] SMP alternatives: switching to UP code
[   24.082634] Freeing SMP alternatives: 0k freed
[   24.086049] lockdep: disabled NMI watchdog.
[   24.086562] ENABLING IO-APIC IRQs
[   24.086878] ..TIMER: vector=3D0x31 apic1=3D0 pin1=3D2 apic2=3D0 pin2=3D0
[   24.200123] checking if image is initramfs... it is
[   24.812463] Freeing initrd memory: 6355k freed
[   24.813279] NET: Registered protocol family 16
[   24.813460] EISA bus registered
[   24.813468] ACPI: bus type pci registered
[   24.813839] PCI: PCI BIOS revision 2.10 entry at 0xfdab1, last bus=3D1
[   24.813842] Setting up standard PCI resources
[   24.821991] ACPI: Subsystem revision 20060310
[   24.827718] ACPI: Interpreter enabled
[   24.827722] ACPI: Using IOAPIC for interrupt routing
[   24.828766] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   24.828777] PCI: Probing PCI hardware (bus 00)
[   24.833024] PCI: Quirk-MSI-K8T Soundcard On
[   24.833029] PCI: Unexpected Value in PCI-Register: no Change!
[   24.833524] Boot video device is 0000:01:00.0
[   24.833631] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[   24.860843] ACPI: Power Resource [URP1] (off)
[   24.860971] ACPI: Power Resource [URP2] (off)
[   24.861109] ACPI: Power Resource [FDDP] (off)
[   24.861243] ACPI: Power Resource [LPTP] (off)
[   24.864958] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14=
 15)
[   24.865365] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14=
 15)
[   24.865722] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14=
 15)
[   24.866066] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 11 *12 14=
 15)
[   24.866421] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 =
15) *0, disabled.
[   24.866785] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 =
15) *0, disabled.
[   24.867129] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 =
15) *0, disabled.
[   24.867542] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 11 12 14 =
15) *0, disabled.
[   24.867849] Linux Plug and Play Support v0.97 (c) Adam Belay
[   24.867896] pnp: PnP ACPI init
[   24.871123] pnp: PnP ACPI: found 8 devices
[   24.871128] PnPBIOS: Disabled by ACPI PNP
[   24.871376] PCI: Using ACPI for IRQ routing
[   24.871380] PCI: If a device doesn't work, try "pci=3Drouteirq".  If it =
helps, post a report
[   24.875387] PCI: Bridge: 0000:00:01.0
[   24.875392]   IO window: a000-afff
[   24.875401]   MEM window: cfe00000-cfefffff
[   24.875407]   PREFETCH window: bfd00000-cfcfffff
[   24.875436] PCI: Setting latency timer of device 0000:00:01.0 to 64
[   24.875478] NET: Registered protocol family 2
[   24.885323] IP route cache hash table entries: 4096 (order: 2, 16384 byt=
es)
[   24.885564] TCP established hash table entries: 16384 (order: 8, 1572864=
 bytes)
[   24.889373] TCP bind hash table entries: 8192 (order: 7, 819200 bytes)
[   24.891282] TCP: Hash tables configured (established 16384 bind 8192)
[   24.891306] TCP reno registered
[   24.892210] Machine check exception polling timer started.
[   24.894140] audit: initializing netlink socket (disabled)
[   24.894169] audit(1149646300.143:1): initialized
[   24.894598] VFS: Disk quotas dquot_6.5.1
[   24.894635] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[   24.894794] Initializing Cryptographic API
[   24.894806] io scheduler noop registered
[   24.894818] io scheduler anticipatory registered
[   24.894827] io scheduler deadline registered
[   24.894847] io scheduler cfq registered (default)
[   24.895649] isapnp: Scanning for PnP cards...
[   25.252094] isapnp: No Plug & Play device found
[   25.313988] Real Time Clock Driver v1.12ac
[   25.314096] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sha=
ring enabled
[   25.317661] RAMDISK driver initialized: 16 RAM disks of 65536K size 1024=
 blocksize
[   25.317992] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[   25.317997] ide: Assuming 33MHz system bus speed for PIO modes; override=
 with idebus=3Dxx
[   25.318575] PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
[   25.318578] PNP: PS/2 controller doesn't have AUX irq; using default 12
[   25.318913] serio: i8042 AUX port at 0x60,0x64 irq 12
[   25.319121] serio: i8042 KBD port at 0x60,0x64 irq 1
[   25.319566] mice: PS/2 mouse device common for all mice
[   25.320077] EISA: Probing bus 0 at eisa.0
[   25.320147] EISA: Detected 0 cards.
[   25.320288] TCP bic registered
[   25.320301] NET: Registered protocol family 1
[   25.320311] NET: Registered protocol family 8
[   25.320314] NET: Registered protocol family 20
[   25.320357] Using IPI Shortcut mode
[   25.320482] Time: tsc clocksource has been installed.
[   25.320506] ACPI: (supports S0 S1 S3 S4 S5)
[   25.320886] Freeing unused kernel memory: 324k freed
[   25.320977] Write protecting the kernel read-only data: 325k
[   25.752229] input: AT Translated Set 2 keyboard as /class/input/input0
[   25.789428] input: AT Translated Set 2 keyboard as /class/input/input1
[   26.489884] SCSI subsystem initialized
[   26.494929] libata version 1.30 loaded.
[   26.497434] sata_via 0000:00:0f.0: version 1.2
[   26.497459] ACPI (acpi_bus-0192): Device [IDE1] is not power manageable =
[20060310]
[   26.497478] ACPI: PCI Interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -=
> IRQ 169
[   26.497518] sata_via 0000:00:0f.0: routed to hard irq line 10
[   26.497653] ata1: SATA max UDMA/133 cmd 0xEC00 ctl 0xE802 bmdma 0xDC00 i=
rq 169
[   26.497721] ata2: SATA max UDMA/133 cmd 0xE400 ctl 0xE002 bmdma 0xDC08 i=
rq 169
[   26.698175] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   26.850703] ata1.00: cfg 49:2f00 82:306a 83:4201 84:4000 85:3068 86:0201=
 87:4000 88:203f
[   26.850708] ata1.00: ATA-4, max UDMA/100, 40011300 sectors: LBA=20
[   26.850711] ata1.00: applying bridge limits
[   26.852428] ata1.00: configured for UDMA/100
[   26.852431] scsi0 : sata_via
[   27.052574] ata2: SATA link down (SStatus 0 SControl 300)
[   27.052579] scsi1 : sata_via
[   27.053200]   Vendor: ATA       Model: ST320413A         Rev: 3.05
[   27.053230]   Type:   Direct-Access                      ANSI SCSI revis=
ion: 05
[   27.069394] SCSI device sda: 40011300 512-byte hdwr sectors (20486 MB)
[   27.069434] sda: Write Protect is off
[   27.069437] sda: Mode Sense: 00 3a 00 00
[   27.069503] SCSI device sda: drive cache: write back
[   27.069778] SCSI device sda: 40011300 512-byte hdwr sectors (20486 MB)
[   27.069818] sda: Write Protect is off
[   27.069821] sda: Mode Sense: 00 3a 00 00
[   27.069894] SCSI device sda: drive cache: write back
[   27.069898]  sda: sda1 sda2 < sda5 >
[   27.122416] sd 0:0:0:0: Attached scsi disk sda
[   27.470549] VP_IDE: IDE controller at PCI slot 0000:00:0f.1
[   27.470574] ACPI (acpi_bus-0192): Device [IDE0] is not power manageable =
[20060310]
[   27.470588] ACPI: PCI Interrupt 0000:00:0f.1[A] -> GSI 20 (level, low) -=
> IRQ 169
[   27.470596] PCI: VIA IRQ fixup for 0000:00:0f.1, from 255 to 9
[   27.470627] VP_IDE: chipset revision 6
[   27.470629] VP_IDE: not 100% native mode: will probe irqs later
[   27.470647] VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci000=
0:00:0f.1
[   27.470659]     ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:pio, h=
db:pio
[   27.470680]     ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, h=
dd:pio
[   27.470698] Probing IDE interface ide0...
[   27.988006] Probing IDE interface ide1...
[   28.780767] hdc: TSSTcorpCD/DVDW SH-W162Z, ATAPI CD/DVD-ROM drive
[   29.392545] ide1 at 0x170-0x177,0x376 on irq 15
[   29.415092] hdc: ATAPI 48X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UD=
MA(33)
[   29.415107] Uniform CD-ROM driver Revision: 3.20
[   29.533131] usbcore: registered new driver usbfs
[   29.533814] usbcore: registered new driver hub
[   29.536057] USB Universal Host Controller Interface driver v3.0
[   29.536149] ACPI (acpi_bus-0192): Device [USB1] is not power manageable =
[20060310]
[   29.536167] ACPI: PCI Interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -=
> IRQ 177
[   29.536175] PCI: VIA IRQ fixup for 0000:00:10.0, from 11 to 1
[   29.536206] uhci_hcd 0000:00:10.0: UHCI Host Controller
[   29.536628] uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus =
number 1
[   29.536671] uhci_hcd 0000:00:10.0: irq 177, io base 0x0000c000
[   29.536807] usb usb1: new device found, idVendor=3D0000, idProduct=3D000=
0
[   29.536810] usb usb1: new device strings: Mfr=3D3, Product=3D2, SerialNu=
mber=3D1
[   29.536814] usb usb1: Product: UHCI Host Controller
[   29.536817] usb usb1: Manufacturer: Linux 2.6.17-rc5-mm3-lockdep uhci_hc=
d
[   29.536820] usb usb1: SerialNumber: 0000:00:10.0
[   29.537040] usb usb1: configuration #1 chosen from 1 choice
[   29.537173] hub 1-0:1.0: USB hub found
[   29.537199] hub 1-0:1.0: 2 ports detected
[   29.637867] ACPI (acpi_bus-0192): Device [USB2] is not power manageable =
[20060310]
[   29.637881] ACPI: PCI Interrupt 0000:00:10.1[A] -> GSI 21 (level, low) -=
> IRQ 177
[   29.637890] PCI: VIA IRQ fixup for 0000:00:10.1, from 11 to 1
[   29.637920] uhci_hcd 0000:00:10.1: UHCI Host Controller
[   29.638263] uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus =
number 2
[   29.638292] uhci_hcd 0000:00:10.1: irq 177, io base 0x0000c400
[   29.638398] usb usb2: new device found, idVendor=3D0000, idProduct=3D000=
0
[   29.638401] usb usb2: new device strings: Mfr=3D3, Product=3D2, SerialNu=
mber=3D1
[   29.638405] usb usb2: Product: UHCI Host Controller
[   29.638408] usb usb2: Manufacturer: Linux 2.6.17-rc5-mm3-lockdep uhci_hc=
d
[   29.638411] usb usb2: SerialNumber: 0000:00:10.1
[   29.638843] usb usb2: configuration #1 chosen from 1 choice
[   29.639170] hub 2-0:1.0: USB hub found
[   29.639188] hub 2-0:1.0: 2 ports detected
[   29.740516] ACPI (acpi_bus-0192): Device [USB3] is not power manageable =
[20060310]
[   29.740528] ACPI: PCI Interrupt 0000:00:10.2[B] -> GSI 21 (level, low) -=
> IRQ 177
[   29.740536] PCI: VIA IRQ fixup for 0000:00:10.2, from 10 to 1
[   29.740564] uhci_hcd 0000:00:10.2: UHCI Host Controller
[   29.740866] uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus =
number 3
[   29.740892] uhci_hcd 0000:00:10.2: irq 177, io base 0x0000c800
[   29.740995] usb usb3: new device found, idVendor=3D0000, idProduct=3D000=
0
[   29.740998] usb usb3: new device strings: Mfr=3D3, Product=3D2, SerialNu=
mber=3D1
[   29.741002] usb usb3: Product: UHCI Host Controller
[   29.741005] usb usb3: Manufacturer: Linux 2.6.17-rc5-mm3-lockdep uhci_hc=
d
[   29.741008] usb usb3: SerialNumber: 0000:00:10.2
[   29.741523] usb usb3: configuration #1 chosen from 1 choice
[   29.741858] hub 3-0:1.0: USB hub found
[   29.741876] hub 3-0:1.0: 2 ports detected
[   29.842373] ACPI (acpi_bus-0192): Device [USB4] is not power manageable =
[20060310]
[   29.842386] ACPI: PCI Interrupt 0000:00:10.3[B] -> GSI 21 (level, low) -=
> IRQ 177
[   29.842394] PCI: VIA IRQ fixup for 0000:00:10.3, from 10 to 1
[   29.842423] uhci_hcd 0000:00:10.3: UHCI Host Controller
[   29.842763] uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus =
number 4
[   29.842790] uhci_hcd 0000:00:10.3: irq 177, io base 0x0000cc00
[   29.842914] usb usb4: new device found, idVendor=3D0000, idProduct=3D000=
0
[   29.842917] usb usb4: new device strings: Mfr=3D3, Product=3D2, SerialNu=
mber=3D1
[   29.842921] usb usb4: Product: UHCI Host Controller
[   29.842923] usb usb4: Manufacturer: Linux 2.6.17-rc5-mm3-lockdep uhci_hc=
d
[   29.842926] usb usb4: SerialNumber: 0000:00:10.3
[   29.843366] usb usb4: configuration #1 chosen from 1 choice
[   29.843679] hub 4-0:1.0: USB hub found
[   29.843697] hub 4-0:1.0: 2 ports detected
[   29.947130] ACPI (acpi_bus-0192): Device [EHCI] is not power manageable =
[20060310]
[   29.947145] ACPI: PCI Interrupt 0000:00:10.4[C] -> GSI 21 (level, low) -=
> IRQ 177
[   29.947165] ehci_hcd 0000:00:10.4: EHCI Host Controller
[   29.947329] ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus =
number 5
[   29.947410] ehci_hcd 0000:00:10.4: irq 177, io mem 0xcfffbd00
[   29.947418] ehci_hcd 0000:00:10.4: USB 2.0 started, EHCI 1.00, driver 10=
 Dec 2004
[   29.947516] usb usb5: new device found, idVendor=3D0000, idProduct=3D000=
0
[   29.947520] usb usb5: new device strings: Mfr=3D3, Product=3D2, SerialNu=
mber=3D1
[   29.947523] usb usb5: Product: EHCI Host Controller
[   29.947526] usb usb5: Manufacturer: Linux 2.6.17-rc5-mm3-lockdep ehci_hc=
d
[   29.947529] usb usb5: SerialNumber: 0000:00:10.4
[   29.947787] usb usb5: configuration #1 chosen from 1 choice
[   29.947917] hub 5-0:1.0: USB hub found
[   29.947936] hub 5-0:1.0: 8 ports detected
[   30.089259] Probing IDE interface ide0...
[   30.722069] Attempting manual resume
[   30.742314] kjournald starting.  Commit interval 5 seconds
[   30.742384] EXT3-fs: mounted filesystem with ordered data mode.
[   30.898138] usb 4-2: new low speed USB device using uhci_hcd and address=
 2
[   31.064791] usb 4-2: new device found, idVendor=3D0a81, idProduct=3D0205
[   31.064796] usb 4-2: new device strings: Mfr=3D1, Product=3D2, SerialNum=
ber=3D0
[   31.064800] usb 4-2: Product: PS2 to USB Converter
[   31.064802] usb 4-2: Manufacturer: CHESEN
[   31.064994] usb 4-2: configuration #1 chosen from 1 choice
[   43.604058] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   50.100834] r8169 Gigabit Ethernet driver 2.2LK loaded
[   50.100871] ACPI: PCI Interrupt 0000:00:0b.0[A] -> GSI 16 (level, low) -=
> IRQ 185
[   50.101289] eth0: Identified chip type is 'RTL8169s/8110s'.
[   50.101294] eth0: RTL8169 at 0xe0846f00, 00:0c:76:e6:28:b2, IRQ 185
[   50.212759] Linux agpgart interface v0.101 (c) Dave Jones
[   50.315890] agpgart: Detected AGP bridge 0
[   50.321571] agpgart: AGP aperture is 128M @ 0xd0000000
[   50.528965] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[   50.592414] input: PC Speaker as /class/input/input2
[   50.780008] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   50.966424] Floppy drive(s): fd0 is 1.44M
[   50.982236] FDC 0 is a post-1991 82077
[   51.580754] ACPI: PCI Interrupt 0000:00:06.0[A] -> GSI 17 (level, low) -=
> IRQ 193
[   52.069325] usbcore: registered new driver hiddev
[   52.084918] input: CHESEN PS2 to USB Converter as /class/input/input3
[   52.085387] input: USB HID v1.10 Keyboard [CHESEN PS2 to USB Converter] =
on usb-0000:00:10.3-2
[   52.110901] input: CHESEN PS2 to USB Converter as /class/input/input4
[   52.111861] input: USB HID v1.10 Mouse [CHESEN PS2 to USB Converter] on =
usb-0000:00:10.3-2
[   52.111884] usbcore: registered new driver usbhid
[   52.111890] drivers/usb/input/hid-core.c: v2.6:USB HID core driver
[   52.295840] r8169: eth0: link up
[   52.339958] ts: Compaq touchscreen protocol output
[   53.422912] lp: driver loaded but no devices found
[   53.524405] NET: Registered protocol family 17
[   53.630473] Adding 843372k swap on /dev/sda5.  Priority:-1 extents:1 acr=
oss:843372k
[   54.042370] EXT3 FS on sda1, internal journal
[   54.524193] md: md driver 0.90.3 MAX_MD_DEVS=3D256, MD_SB_DISKS=3D27
[   54.524198] md: bitmap version 4.39
[   55.186135] device-mapper: 4.6.0-ioctl (2006-02-17) initialised: dm-deve=
l@redhat.com
[   56.067365] device-mapper: dm-linear: Device lookup failed
[   56.067503] device-mapper: error adding target to table
[   56.072310] device-mapper: dm-linear: Device lookup failed
[   56.072401] device-mapper: error adding target to table
[   56.077188] device-mapper: dm-linear: Device lookup failed
[   56.077280] device-mapper: error adding target to table
[   56.082229] device-mapper: dm-linear: Device lookup failed
[   56.082320] device-mapper: error adding target to table
[   56.087299] device-mapper: dm-linear: Device lookup failed
[   56.087390] device-mapper: error adding target to table
[   56.092158] device-mapper: dm-linear: Device lookup failed
[   56.092250] device-mapper: error adding target to table
[   56.097046] device-mapper: dm-linear: Device lookup failed
[   56.097137] device-mapper: error adding target to table
[   56.102064] device-mapper: dm-linear: Device lookup failed
[   56.102155] device-mapper: error adding target to table
[   60.484550] ACPI: Power Button (FF) [PWRF]
[   60.484565] ACPI: Power Button (CM) [PWRB]
[   60.484596] ACPI: Sleep Button (CM) [SLPB]
[   60.574818] Using specific hotkey driver
[   60.701806] ibm_acpi: ec object not found
[   60.990037] toshiba_acpi: Unknown parameter `hotkeys_over_acpi'
[   61.563550] powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (ver=
sion 1.60.2)
[   61.563785] ACPI Warning (acpi_utils-0063): Invalid package argument [20=
060310]
[   61.563793] ACPI Exception (acpi_processor-0269): AE_BAD_PARAMETER, Inva=
lid _PSS data [20060310]
[   61.567410] powernow-k8:    0 : fid 0x2 (1000 MHz), vid 0x12 (1100 mV)
[   61.567414] powernow-k8:    1 : fid 0xa (1800 MHz), vid 0x6 (1400 mV)
[   61.567418] cpu_init done, current fid 0xa, vid 0x6
[   61.841154] NET: Registered protocol family 10
[   61.841393] lo: Disabled Privacy Extensions
[   61.841974] IPv6 over IPv4 tunneling driver
[   67.903149] ppdev: user-space parallel port driver
[   70.834220] apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
[   70.835140] apm: overridden by ACPI.
[   71.935765] Bluetooth: Core ver 2.8
[   71.936028] NET: Registered protocol family 31
[   71.936032] Bluetooth: HCI device and connection manager initialized
[   71.936140] Bluetooth: HCI socket layer initialized
[   71.996319] Bluetooth: L2CAP ver 2.8
[   71.996585] Bluetooth: L2CAP socket layer initialized
[   72.027075] Bluetooth: RFCOMM socket layer initialized
[   72.027447] Bluetooth: RFCOMM TTY layer initialized
[   72.027451] Bluetooth: RFCOMM ver 1.7
[   72.711772] eth0: no IPv6 routers present
[   50.224000] Time: acpi_pm clocksource has been installed.
[  129.500000] ACPI: PCI interrupt for device 0000:00:0b.0 disabled
[  132.131000] Stopping tasks: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D|
[  132.234000] Shrinking memory...  =08-=08\=08done (17633 pages freed)
[  132.392000] Suspending device floppy.0
[  132.392000] Suspending device i2c-0
[  132.392000] Suspending device 4-2:1.1
[  132.394000] Suspending device 4-2:1.0
[  132.395000] Suspending device 4-2
[  132.395000] Suspending device 5-0:1.0
[  132.395000] Suspending device usb5
[  132.395000] Suspending device 4-0:1.0
[  132.395000] Suspending device usb4
[  132.395000] Suspending device 3-0:1.0
[  132.395000] Suspending device usb3
[  132.395000] Suspending device 2-0:1.0
[  132.395000] Suspending device usb2
[  132.395000] Suspending device 1-0:1.0
[  132.395000] Suspending device usb1
[  132.395000] Suspending device 1.0
[  132.395000] Suspending device ide1
[  132.395000] Suspending device 0:0:0:0
[  132.395000] Suspending device target0:0:0
[  132.395000] Suspending device host1
[  132.395000] Suspending device host0
[  132.395000] Suspending device eisa.0
[  132.395000] Suspending device serio1
[  132.395000] Suspending device serio0
[  132.395000] Suspending device i8042
[  132.395000] Suspending device serial8250
[  132.395000] Suspending device pnp1
[  132.395000] Suspending device vesafb.0
[  132.395000] Suspending device pcspkr
[  132.395000] Suspending device 00:07
[  132.395000] Suspending device 00:06
[  132.395000] Suspending device 00:05
[  132.395000] Suspending device 00:04
[  132.395000] Suspending device 00:03
[  132.395000] Suspending device 00:02
[  132.395000] Suspending device 00:01
[  132.395000] Suspending device 00:00
[  132.395000] Suspending device pnp0
[  132.395000] Suspending device 0000:01:00.0
[  132.395000] Suspending device 0000:00:18.3
[  132.395000] Suspending device 0000:00:18.2
[  132.395000] Suspending device 0000:00:18.1
[  132.395000] Suspending device 0000:00:18.0
[  132.395000] Suspending device 0000:00:11.0
[  132.395000] Suspending device 0000:00:10.4
[  132.406000] ACPI: PCI interrupt for device 0000:00:10.4 disabled
[  132.417000] ACPI (acpi_bus-0192): Device [EHCI] is not power manageable =
[20060310]
[  132.417000] Suspending device 0000:00:10.3
[  132.417000] ACPI: PCI interrupt for device 0000:00:10.3 disabled
[  132.428000] ACPI (acpi_bus-0192): Device [USB4] is not power manageable =
[20060310]
[  132.428000] Suspending device 0000:00:10.2
[  132.428000] ACPI: PCI interrupt for device 0000:00:10.2 disabled
[  132.439000] ACPI (acpi_bus-0192): Device [USB3] is not power manageable =
[20060310]
[  132.439000] Suspending device 0000:00:10.1
[  132.439000] ACPI: PCI interrupt for device 0000:00:10.1 disabled
[  132.450000] ACPI (acpi_bus-0192): Device [USB2] is not power manageable =
[20060310]
[  132.450000] Suspending device 0000:00:10.0
[  132.450000] ACPI: PCI interrupt for device 0000:00:10.0 disabled
[  132.461000] ACPI (acpi_bus-0192): Device [USB1] is not power manageable =
[20060310]
[  132.461000] Suspending device 0000:00:0f.1
[  132.461000] Suspending device 0000:00:0f.0
[  132.461000] Suspending device 0000:00:0b.0
[  132.461000] Suspending device 0000:00:06.0
[  132.472000] ACPI: PCI interrupt for device 0000:00:06.0 disabled
[  132.472000] Suspending device 0000:00:01.0
[  132.472000] Suspending device 0000:00:00.0
[  132.472000] pci_set_power_state(): 0000:00:00.0: state=3D3, current stat=
e=3D5
[  132.472000] Suspending device pci0000:00
[  132.472000] Suspending device acpi
[  132.472000] Suspending device platform
[  132.472000]=20
[  132.472000] swsusp: Need to copy 57517 pages
[  132.472000] Intel machine check architecture supported.
[  132.472000] Intel machine check reporting enabled on CPU#0.
[  132.472000] swsusp: Restoring Highmem
[  132.472000] BUG: sleeping function called from invalid context at includ=
e/linux/rwsem.h:53
[  132.472000] in_atomic():1, irqs_disabled():1
[  132.472000]  [<c01042a0>] show_trace_log_lvl+0x120/0x140
[  132.472000]  [<c01056e2>] show_trace+0x12/0x20
[  132.472000]  [<c0105709>] dump_stack+0x19/0x20
[  132.472000]  [<c011851b>] __might_sleep+0xbb/0xd0
[  132.472000]  [<c012d558>] blocking_notifier_call_chain+0x28/0xa0
[  132.472000]  [<c0287dac>] cpufreq_resume+0x11c/0x140
[  132.472000]  [<c026871b>] __sysdev_resume+0x2b/0x80
[  132.472000]  [<c02687b7>] sysdev_resume+0x47/0x70
[  132.472000]  [<c026dd58>] device_power_up+0x8/0x10
[  132.472000]  [<c0146eab>] swsusp_suspend+0x4b/0xc0
[  132.472000]  [<c01474b2>] pm_suspend_disk+0x52/0xf2
[  132.472000]  [<c0146277>] enter_state+0x137/0x180
[  132.472000]  [<c0146350>] state_store+0x90/0xa0
[  132.472000]  [<c01bd73b>] subsys_attr_store+0x2b/0x40
[  132.472000]  [<c01bdf66>] sysfs_write_file+0xa6/0x100
[  132.472000]  [<c0174c36>] vfs_write+0xd6/0x1a0
[  132.472000]  [<c01756ed>] sys_write+0x3d/0x80
[  132.472000]  [<c030fad5>] sysenter_past_esp+0x56/0x8d
[  132.472000]  [<b7ffd410>] 0xb7ffd410
[  235.472000] APIC error on CPU0: 00(00)
[  235.502000] BUG: sleeping function called from invalid context at includ=
e/asm/semaphore.h:99
[  235.502000] in_atomic():1, irqs_disabled():0
[  235.502000]  [<c01042a0>] show_trace_log_lvl+0x120/0x140
[  235.502000]  [<c01056e2>] show_trace+0x12/0x20
[  235.502000]  [<c0105709>] dump_stack+0x19/0x20
[  235.502000]  [<c011851b>] __might_sleep+0xbb/0xd0
[  235.502000]  [<c026de32>] device_resume+0x12/0x29
[  235.502000]  [<c0147505>] pm_suspend_disk+0xa5/0xf2
[  235.502000]  [<c0146277>] enter_state+0x137/0x180
[  235.503000]  [<c0146350>] state_store+0x90/0xa0
[  235.503000]  [<c01bd73b>] subsys_attr_store+0x2b/0x40
[  235.503000]  [<c01bdf66>] sysfs_write_file+0xa6/0x100
[  235.503000]  [<c0174c36>] vfs_write+0xd6/0x1a0
[  235.503000]  [<c01756ed>] sys_write+0x3d/0x80
[  235.503000]  [<c030fad5>] sysenter_past_esp+0x56/0x8d
[  235.503000]  [<b7ffd410>] 0xb7ffd410
[  235.503000] ACPI Exception (acpi_bus-0070): AE_NOT_FOUND, No context for=
 object [c1492620] [20060310]
[  235.503000] PM: Writing back config space on device 0000:00:00.0 at offs=
et 1 (was 22300006, writing 32300006)
[  235.504000] PCI: Setting latency timer of device 0000:00:01.0 to 64
[  235.504000] PM: Writing back config space on device 0000:00:06.0 at offs=
et 1 (was 2100005, writing 2100000)
[  235.504000] BUG: scheduling while atomic: hibernate.sh/0x00000001/4692
[  235.504000]  [<c01042a0>] show_trace_log_lvl+0x120/0x140
[  235.504000]  [<c01056e2>] show_trace+0x12/0x20
[  235.504000]  [<c0105709>] dump_stack+0x19/0x20
[  235.504000]  [<c030bb41>] schedule+0x611/0x8f0
[  235.504000]  [<c030c639>] schedule_timeout+0x49/0xc0
[  235.504000]  [<c030c6c7>] schedule_timeout_uninterruptible+0x17/0x20
[  235.504000]  [<c0127915>] msleep+0x25/0x40
[  235.504000]  [<c0212bb7>] pci_set_power_state+0x197/0x230
[  235.504000]  [<c0212c68>] pci_enable_device_bars+0x18/0x70
[  235.505000]  [<c0212cdb>] pci_enable_device+0x1b/0x30
[  235.505000]  [<e0a24a38>] snd_cmipci_resume+0x28/0xf0 [snd_cmipci]
[  235.505000]  [<c02145b2>] pci_device_resume+0x22/0x80
[  235.505000]  [<c026dc69>] resume_device+0x69/0xf0
[  235.506000]  [<c026de0d>] dpm_resume+0xad/0xc0
[  235.506000]  [<c026de3f>] device_resume+0x1f/0x29
[  235.506000]  [<c0147505>] pm_suspend_disk+0xa5/0xf2
[  235.507000]  [<c0146277>] enter_state+0x137/0x180
[  235.507000]  [<c0146350>] state_store+0x90/0xa0
[  235.507000]  [<c01bd73b>] subsys_attr_store+0x2b/0x40
[  235.507000]  [<c01bdf66>] sysfs_write_file+0xa6/0x100
[  235.507000]  [<c0174c36>] vfs_write+0xd6/0x1a0
[  235.507000]  [<c01756ed>] sys_write+0x3d/0x80
[  235.507000]  [<c030fad5>] sysenter_past_esp+0x56/0x8d
[  235.507000]  [<b7ffd410>] 0xb7ffd410
[  235.515000] PCI: Enabling device 0000:00:06.0 (0000 -> 0001)
[  235.515000] ACPI: PCI Interrupt 0000:00:06.0[A] -> GSI 17 (level, low) -=
> IRQ 193
[  235.515000] PM: Writing back config space on device 0000:00:0b.0 at offs=
et 3 (was 2008, writing 2010)
[  235.515000] PM: Writing back config space on device 0000:00:0b.0 at offs=
et 1 (was 2b00017, writing 2b00010)
[  235.515000] ACPI: PCI Interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -=
> IRQ 169
[  235.515000] ACPI: PCI Interrupt 0000:00:0f.1[A] -> GSI 20 (level, low) -=
> IRQ 169
[  235.515000] BUG: scheduling while atomic: hibernate.sh/0x00000001/4692
[  235.515000]  [<c01042a0>] show_trace_log_lvl+0x120/0x140
[  235.515000]  [<c01056e2>] show_trace+0x12/0x20
[  235.515000]  [<c0105709>] dump_stack+0x19/0x20
[  235.515000]  [<c030bb41>] schedule+0x611/0x8f0
[  235.515000]  [<c030c639>] schedule_timeout+0x49/0xc0
[  235.517000]  [<c030c6c7>] schedule_timeout_uninterruptible+0x17/0x20
[  235.517000]  [<c0127915>] msleep+0x25/0x40
[  235.517000]  [<c0212bb7>] pci_set_power_state+0x197/0x230
[  235.517000]  [<c0212c68>] pci_enable_device_bars+0x18/0x70
[  235.518000]  [<c0212cdb>] pci_enable_device+0x1b/0x30
[  235.518000]  [<e08e3da2>] usb_hcd_pci_resume+0x42/0x120 [usbcore]
[  235.518000]  [<c02145b2>] pci_device_resume+0x22/0x80
[  235.519000]  [<c026dc69>] resume_device+0x69/0xf0
[  235.520000]  [<c026de0d>] dpm_resume+0xad/0xc0
[  235.521000]  [<c026de3f>] device_resume+0x1f/0x29
[  235.521000]  [<c0147505>] pm_suspend_disk+0xa5/0xf2
[  235.521000]  [<c0146277>] enter_state+0x137/0x180
[  235.522000]  [<c0146350>] state_store+0x90/0xa0
[  235.522000]  [<c01bd73b>] subsys_attr_store+0x2b/0x40
[  235.522000]  [<c01bdf66>] sysfs_write_file+0xa6/0x100
[  235.523000]  [<c0174c36>] vfs_write+0xd6/0x1a0
[  235.523000]  [<c01756ed>] sys_write+0x3d/0x80
[  235.523000]  [<c030fad5>] sysenter_past_esp+0x56/0x8d
[  235.523000]  [<b7ffd410>] 0xb7ffd410
[  235.526000] ACPI (acpi_bus-0192): Device [USB1] is not power manageable =
[20060310]
[  235.526000] PCI: Enabling device 0000:00:10.0 (0010 -> 0011)
[  235.526000] ACPI: PCI Interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -=
> IRQ 177
[  235.526000] PM: Writing back config space on device 0000:00:10.0 at offs=
et 1 (was 2100015, writing 2100017)
[  235.526000] BUG: scheduling while atomic: hibernate.sh/0x00000001/4692
[  235.526000]  [<c01042a0>] show_trace_log_lvl+0x120/0x140
[  235.526000]  [<c01056e2>] show_trace+0x12/0x20
[  235.526000]  [<c0105709>] dump_stack+0x19/0x20
[  235.526000]  [<c030bb41>] schedule+0x611/0x8f0
[  235.526000]  [<c030c639>] schedule_timeout+0x49/0xc0
[  235.526000]  [<c030c6c7>] schedule_timeout_uninterruptible+0x17/0x20
[  235.526000]  [<c0127915>] msleep+0x25/0x40
[  235.526000]  [<c0212bb7>] pci_set_power_state+0x197/0x230
[  235.527000]  [<c0212c68>] pci_enable_device_bars+0x18/0x70
[  235.528000]  [<c0212cdb>] pci_enable_device+0x1b/0x30
[  235.528000]  [<e08e3da2>] usb_hcd_pci_resume+0x42/0x120 [usbcore]
[  235.528000]  [<c02145b2>] pci_device_resume+0x22/0x80
[  235.529000]  [<c026dc69>] resume_device+0x69/0xf0
[  235.529000]  [<c026de0d>] dpm_resume+0xad/0xc0
[  235.530000]  [<c026de3f>] device_resume+0x1f/0x29
[  235.531000]  [<c0147505>] pm_suspend_disk+0xa5/0xf2
[  235.531000]  [<c0146277>] enter_state+0x137/0x180
[  235.531000]  [<c0146350>] state_store+0x90/0xa0
[  235.531000]  [<c01bd73b>] subsys_attr_store+0x2b/0x40
[  235.532000]  [<c01bdf66>] sysfs_write_file+0xa6/0x100
[  235.532000]  [<c0174c36>] vfs_write+0xd6/0x1a0
[  235.532000]  [<c01756ed>] sys_write+0x3d/0x80
[  235.533000]  [<c030fad5>] sysenter_past_esp+0x56/0x8d
[  235.533000]  [<b7ffd410>] 0xb7ffd410
[  235.537000] ACPI (acpi_bus-0192): Device [USB2] is not power manageable =
[20060310]
[  235.537000] PCI: Enabling device 0000:00:10.1 (0010 -> 0011)
[  235.537000] ACPI: PCI Interrupt 0000:00:10.1[A] -> GSI 21 (level, low) -=
> IRQ 177
[  235.537000] PM: Writing back config space on device 0000:00:10.1 at offs=
et 1 (was 2100015, writing 2100017)
[  235.537000] BUG: scheduling while atomic: hibernate.sh/0x00000001/4692
[  235.537000]  [<c01042a0>] show_trace_log_lvl+0x120/0x140
[  235.537000]  [<c01056e2>] show_trace+0x12/0x20
[  235.537000]  [<c0105709>] dump_stack+0x19/0x20
[  235.537000]  [<c030bb41>] schedule+0x611/0x8f0
[  235.537000]  [<c030c639>] schedule_timeout+0x49/0xc0
[  235.537000]  [<c030c6c7>] schedule_timeout_uninterruptible+0x17/0x20
[  235.537000]  [<c0127915>] msleep+0x25/0x40
[  235.537000]  [<c0212bb7>] pci_set_power_state+0x197/0x230
[  235.538000]  [<c0212c68>] pci_enable_device_bars+0x18/0x70
[  235.539000]  [<c0212cdb>] pci_enable_device+0x1b/0x30
[  235.539000]  [<e08e3da2>] usb_hcd_pci_resume+0x42/0x120 [usbcore]
[  235.539000]  [<c02145b2>] pci_device_resume+0x22/0x80
[  235.540000]  [<c026dc69>] resume_device+0x69/0xf0
[  235.540000]  [<c026de0d>] dpm_resume+0xad/0xc0
[  235.541000]  [<c026de3f>] device_resume+0x1f/0x29
[  235.542000]  [<c0147505>] pm_suspend_disk+0xa5/0xf2
[  235.542000]  [<c0146277>] enter_state+0x137/0x180
[  235.542000]  [<c0146350>] state_store+0x90/0xa0
[  235.542000]  [<c01bd73b>] subsys_attr_store+0x2b/0x40
[  235.543000]  [<c01bdf66>] sysfs_write_file+0xa6/0x100
[  235.543000]  [<c0174c36>] vfs_write+0xd6/0x1a0
[  235.543000]  [<c01756ed>] sys_write+0x3d/0x80
[  235.544000]  [<c030fad5>] sysenter_past_esp+0x56/0x8d
[  235.544000]  [<b7ffd410>] 0xb7ffd410
[  235.548000] ACPI (acpi_bus-0192): Device [USB3] is not power manageable =
[20060310]
[  235.548000] PCI: Enabling device 0000:00:10.2 (0010 -> 0011)
[  235.548000] ACPI: PCI Interrupt 0000:00:10.2[B] -> GSI 21 (level, low) -=
> IRQ 177
[  235.548000] PM: Writing back config space on device 0000:00:10.2 at offs=
et 1 (was 2100015, writing 2100017)
[  235.548000] BUG: scheduling while atomic: hibernate.sh/0x00000001/4692
[  235.548000]  [<c01042a0>] show_trace_log_lvl+0x120/0x140
[  235.548000]  [<c01056e2>] show_trace+0x12/0x20
[  235.548000]  [<c0105709>] dump_stack+0x19/0x20
[  235.548000]  [<c030bb41>] schedule+0x611/0x8f0
[  235.548000]  [<c030c639>] schedule_timeout+0x49/0xc0
[  235.548000]  [<c030c6c7>] schedule_timeout_uninterruptible+0x17/0x20
[  235.548000]  [<c0127915>] msleep+0x25/0x40
[  235.548000]  [<c0212bb7>] pci_set_power_state+0x197/0x230
[  235.549000]  [<c0212c68>] pci_enable_device_bars+0x18/0x70
[  235.550000]  [<c0212cdb>] pci_enable_device+0x1b/0x30
[  235.550000]  [<e08e3da2>] usb_hcd_pci_resume+0x42/0x120 [usbcore]
[  235.550000]  [<c02145b2>] pci_device_resume+0x22/0x80
[  235.551000]  [<c026dc69>] resume_device+0x69/0xf0
[  235.551000]  [<c026de0d>] dpm_resume+0xad/0xc0
[  235.552000]  [<c026de3f>] device_resume+0x1f/0x29
[  235.553000]  [<c0147505>] pm_suspend_disk+0xa5/0xf2
[  235.553000]  [<c0146277>] enter_state+0x137/0x180
[  235.553000]  [<c0146350>] state_store+0x90/0xa0
[  235.553000]  [<c01bd73b>] subsys_attr_store+0x2b/0x40
[  235.554000]  [<c01bdf66>] sysfs_write_file+0xa6/0x100
[  235.554000]  [<c0174c36>] vfs_write+0xd6/0x1a0
[  235.554000]  [<c01756ed>] sys_write+0x3d/0x80
[  235.555000]  [<c030fad5>] sysenter_past_esp+0x56/0x8d
[  235.555000]  [<b7ffd410>] 0xb7ffd410
[  235.559000] ACPI (acpi_bus-0192): Device [USB4] is not power manageable =
[20060310]
[  235.559000] PCI: Enabling device 0000:00:10.3 (0010 -> 0011)
[  235.559000] ACPI: PCI Interrupt 0000:00:10.3[B] -> GSI 21 (level, low) -=
> IRQ 177
[  235.559000] PM: Writing back config space on device 0000:00:10.3 at offs=
et 1 (was 2100015, writing 2100017)
[  235.559000] BUG: scheduling while atomic: hibernate.sh/0x00000001/4692
[  235.559000]  [<c01042a0>] show_trace_log_lvl+0x120/0x140
[  235.559000]  [<c01056e2>] show_trace+0x12/0x20
[  235.559000]  [<c0105709>] dump_stack+0x19/0x20
[  235.559000]  [<c030bb41>] schedule+0x611/0x8f0
[  235.559000]  [<c030c639>] schedule_timeout+0x49/0xc0
[  235.559000]  [<c030c6c7>] schedule_timeout_uninterruptible+0x17/0x20
[  235.559000]  [<c0127915>] msleep+0x25/0x40
[  235.559000]  [<c0212bb7>] pci_set_power_state+0x197/0x230
[  235.560000]  [<c0212c68>] pci_enable_device_bars+0x18/0x70
[  235.561000]  [<c0212cdb>] pci_enable_device+0x1b/0x30
[  235.561000]  [<e08e3da2>] usb_hcd_pci_resume+0x42/0x120 [usbcore]
[  235.561000]  [<c02145b2>] pci_device_resume+0x22/0x80
[  235.562000]  [<c026dc69>] resume_device+0x69/0xf0
[  235.562000]  [<c026de0d>] dpm_resume+0xad/0xc0
[  235.563000]  [<c026de3f>] device_resume+0x1f/0x29
[  235.564000]  [<c0147505>] pm_suspend_disk+0xa5/0xf2
[  235.564000]  [<c0146277>] enter_state+0x137/0x180
[  235.564000]  [<c0146350>] state_store+0x90/0xa0
[  235.564000]  [<c01bd73b>] subsys_attr_store+0x2b/0x40
[  235.565000]  [<c01bdf66>] sysfs_write_file+0xa6/0x100
[  235.565000]  [<c0174c36>] vfs_write+0xd6/0x1a0
[  235.565000]  [<c01756ed>] sys_write+0x3d/0x80
[  235.566000]  [<c030fad5>] sysenter_past_esp+0x56/0x8d
[  235.566000]  [<b7ffd410>] 0xb7ffd410
[  235.570000] ACPI (acpi_bus-0192): Device [EHCI] is not power manageable =
[20060310]
[  235.570000] PCI: Enabling device 0000:00:10.4 (0010 -> 0012)
[  235.570000] ACPI: PCI Interrupt 0000:00:10.4[C] -> GSI 21 (level, low) -=
> IRQ 177
[  235.570000] PM: Writing back config space on device 0000:00:10.4 at offs=
et 1 (was 2100016, writing 2100017)
[  235.570000] pnp: Failed to activate device 00:07.
[  235.570000] BUG: scheduling while atomic: hibernate.sh/0x00000001/4692
[  235.570000]  [<c01042a0>] show_trace_log_lvl+0x120/0x140
[  235.570000]  [<c01056e2>] show_trace+0x12/0x20
[  235.571000]  [<c0105709>] dump_stack+0x19/0x20
[  235.571000]  [<c030bb41>] schedule+0x611/0x8f0
[  235.571000]  [<c030c639>] schedule_timeout+0x49/0xc0
[  235.571000]  [<c028012f>] ps2_sendbyte+0xcf/0x120
[  235.572000]  [<c0280393>] ps2_command+0xf3/0x3e0
[  235.572000]  [<c0285090>] atkbd_probe+0x30/0x120
[  235.573000]  [<c02868cf>] atkbd_reconnect+0xaf/0x120
[  235.574000]  [<c027d13b>] serio_reconnect_driver+0x4b/0x60
[  235.575000]  [<c027e071>] serio_resume+0x11/0x30
[  235.575000]  [<c026dc69>] resume_device+0x69/0xf0
[  235.576000]  [<c026de0d>] dpm_resume+0xad/0xc0
[  235.577000]  [<c026de3f>] device_resume+0x1f/0x29
[  235.578000]  [<c0147505>] pm_suspend_disk+0xa5/0xf2
[  235.578000]  [<c0146277>] enter_state+0x137/0x180
[  235.578000]  [<c0146350>] state_store+0x90/0xa0
[  235.578000]  [<c01bd73b>] subsys_attr_store+0x2b/0x40
[  235.579000]  [<c01bdf66>] sysfs_write_file+0xa6/0x100
[  235.579000]  [<c0174c36>] vfs_write+0xd6/0x1a0
[  235.579000]  [<c01756ed>] sys_write+0x3d/0x80
[  235.580000]  [<c030fad5>] sysenter_past_esp+0x56/0x8d
[  235.580000]  [<b7ffd410>] 0xb7ffd410
[  235.580000] BUG: scheduling while atomic: hibernate.sh/0x00000001/4692
[  235.580000]  [<c01042a0>] show_trace_log_lvl+0x120/0x140
[  235.580000]  [<c01056e2>] show_trace+0x12/0x20
[  235.580000]  [<c0105709>] dump_stack+0x19/0x20
[  235.580000]  [<c030bb41>] schedule+0x611/0x8f0
[  235.580000]  [<c030c639>] schedule_timeout+0x49/0xc0
[  235.580000]  [<c02804f7>] ps2_command+0x257/0x3e0
[  235.581000]  [<c0285090>] atkbd_probe+0x30/0x120
[  235.582000]  [<c02868cf>] atkbd_reconnect+0xaf/0x120
[  235.582000]  [<c027d13b>] serio_reconnect_driver+0x4b/0x60
[  235.583000]  [<c027e071>] serio_resume+0x11/0x30
[  235.584000]  [<c026dc69>] resume_device+0x69/0xf0
[  235.585000]  [<c026de0d>] dpm_resume+0xad/0xc0
[  235.585000]  [<c026de3f>] device_resume+0x1f/0x29
[  235.586000]  [<c0147505>] pm_suspend_disk+0xa5/0xf2
[  235.586000]  [<c0146277>] enter_state+0x137/0x180
[  235.587000]  [<c0146350>] state_store+0x90/0xa0
[  235.587000]  [<c01bd73b>] subsys_attr_store+0x2b/0x40
[  235.587000]  [<c01bdf66>] sysfs_write_file+0xa6/0x100
[  235.587000]  [<c0174c36>] vfs_write+0xd6/0x1a0
[  235.588000]  [<c01756ed>] sys_write+0x3d/0x80
[  235.588000]  [<c030fad5>] sysenter_past_esp+0x56/0x8d
[  235.588000]  [<b7ffd410>] 0xb7ffd410
[  235.588000] BUG: scheduling while atomic: hibernate.sh/0x00000001/4692
[  235.588000]  [<c01042a0>] show_trace_log_lvl+0x120/0x140
[  235.588000]  [<c01056e2>] show_trace+0x12/0x20
[  235.588000]  [<c0105709>] dump_stack+0x19/0x20
[  235.588000]  [<c030bb41>] schedule+0x611/0x8f0
[  235.588000]  [<c030c639>] schedule_timeout+0x49/0xc0
[  235.589000]  [<c028012f>] ps2_sendbyte+0xcf/0x120
[  235.589000]  [<c0280393>] ps2_command+0xf3/0x3e0
[  235.590000]  [<c02852c1>] atkbd_activate+0x21/0x80
[  235.591000]  [<c02868fc>] atkbd_reconnect+0xdc/0x120
[  235.592000]  [<c027d13b>] serio_reconnect_driver+0x4b/0x60
[  235.593000]  [<c027e071>] serio_resume+0x11/0x30
[  235.593000]  [<c026dc69>] resume_device+0x69/0xf0
[  235.594000]  [<c026de0d>] dpm_resume+0xad/0xc0
[  235.595000]  [<c026de3f>] device_resume+0x1f/0x29
[  235.596000]  [<c0147505>] pm_suspend_disk+0xa5/0xf2
[  235.596000]  [<c0146277>] enter_state+0x137/0x180
[  235.596000]  [<c0146350>] state_store+0x90/0xa0
[  235.596000]  [<c01bd73b>] subsys_attr_store+0x2b/0x40
[  235.596000]  [<c01bdf66>] sysfs_write_file+0xa6/0x100
[  235.597000]  [<c0174c36>] vfs_write+0xd6/0x1a0
[  235.597000]  [<c01756ed>] sys_write+0x3d/0x80
[  235.597000]  [<c030fad5>] sysenter_past_esp+0x56/0x8d
[  235.597000]  [<b7ffd410>] 0xb7ffd410
[  235.597000] BUG: scheduling while atomic: hibernate.sh/0x00000001/4692
[  235.598000]  [<c01042a0>] show_trace_log_lvl+0x120/0x140
[  235.598000]  [<c01056e2>] show_trace+0x12/0x20
[  235.598000]  [<c0105709>] dump_stack+0x19/0x20
[  235.598000]  [<c030bb41>] schedule+0x611/0x8f0
[  235.598000]  [<c030c639>] schedule_timeout+0x49/0xc0
[  235.598000]  [<c028012f>] ps2_sendbyte+0xcf/0x120
[  235.599000]  [<c0280623>] ps2_command+0x383/0x3e0
[  235.599000]  [<c02852c1>] atkbd_activate+0x21/0x80
[  235.600000]  [<c02868fc>] atkbd_reconnect+0xdc/0x120
[  235.601000]  [<c027d13b>] serio_reconnect_driver+0x4b/0x60
[  235.602000]  [<c027e071>] serio_resume+0x11/0x30
[  235.603000]  [<c026dc69>] resume_device+0x69/0xf0
[  235.603000]  [<c026de0d>] dpm_resume+0xad/0xc0
[  235.604000]  [<c026de3f>] device_resume+0x1f/0x29
[  235.605000]  [<c0147505>] pm_suspend_disk+0xa5/0xf2
[  235.605000]  [<c0146277>] enter_state+0x137/0x180
[  235.605000]  [<c0146350>] state_store+0x90/0xa0
[  235.605000]  [<c01bd73b>] subsys_attr_store+0x2b/0x40
[  235.606000]  [<c01bdf66>] sysfs_write_file+0xa6/0x100
[  235.606000]  [<c0174c36>] vfs_write+0xd6/0x1a0
[  235.606000]  [<c01756ed>] sys_write+0x3d/0x80
[  235.607000]  [<c030fad5>] sysenter_past_esp+0x56/0x8d
[  235.607000]  [<b7ffd410>] 0xb7ffd410
[  235.607000] BUG: scheduling while atomic: hibernate.sh/0x00000001/4692
[  235.607000]  [<c01042a0>] show_trace_log_lvl+0x120/0x140
[  235.607000]  [<c01056e2>] show_trace+0x12/0x20
[  235.607000]  [<c0105709>] dump_stack+0x19/0x20
[  235.607000]  [<c030bb41>] schedule+0x611/0x8f0
[  235.607000]  [<c030c639>] schedule_timeout+0x49/0xc0
[  235.607000]  [<c028012f>] ps2_sendbyte+0xcf/0x120
[  235.608000]  [<c0280393>] ps2_command+0xf3/0x3e0
[  235.609000]  [<c02852e6>] atkbd_activate+0x46/0x80
[  235.610000]  [<c02868fc>] atkbd_reconnect+0xdc/0x120
[  235.610000]  [<c027d13b>] serio_reconnect_driver+0x4b/0x60
[  235.611000]  [<c027e071>] serio_resume+0x11/0x30
[  235.612000]  [<c026dc69>] resume_device+0x69/0xf0
[  235.613000]  [<c026de0d>] dpm_resume+0xad/0xc0
[  235.613000]  [<c026de3f>] device_resume+0x1f/0x29
[  235.614000]  [<c0147505>] pm_suspend_disk+0xa5/0xf2
[  235.614000]  [<c0146277>] enter_state+0x137/0x180
[  235.614000]  [<c0146350>] state_store+0x90/0xa0
[  235.615000]  [<c01bd73b>] subsys_attr_store+0x2b/0x40
[  235.615000]  [<c01bdf66>] sysfs_write_file+0xa6/0x100
[  235.615000]  [<c0174c36>] vfs_write+0xd6/0x1a0
[  235.616000]  [<c01756ed>] sys_write+0x3d/0x80
[  235.616000]  [<c030fad5>] sysenter_past_esp+0x56/0x8d
[  235.616000]  [<b7ffd410>] 0xb7ffd410
[  235.616000] BUG: scheduling while atomic: hibernate.sh/0x00000001/4692
[  235.616000]  [<c01042a0>] show_trace_log_lvl+0x120/0x140
[  235.616000]  [<c01056e2>] show_trace+0x12/0x20
[  235.616000]  [<c0105709>] dump_stack+0x19/0x20
[  235.616000]  [<c030bb41>] schedule+0x611/0x8f0
[  235.616000]  [<c030c639>] schedule_timeout+0x49/0xc0
[  235.616000]  [<c028012f>] ps2_sendbyte+0xcf/0x120
[  235.617000]  [<c0280623>] ps2_command+0x383/0x3e0
[  235.618000]  [<c02852e6>] atkbd_activate+0x46/0x80
[  235.619000]  [<c02868fc>] atkbd_reconnect+0xdc/0x120
[  235.620000]  [<c027d13b>] serio_reconnect_driver+0x4b/0x60
[  235.620000]  [<c027e071>] serio_resume+0x11/0x30
[  235.621000]  [<c026dc69>] resume_device+0x69/0xf0
[  235.622000]  [<c026de0d>] dpm_resume+0xad/0xc0
[  235.623000]  [<c026de3f>] device_resume+0x1f/0x29
[  235.623000]  [<c0147505>] pm_suspend_disk+0xa5/0xf2
[  235.624000]  [<c0146277>] enter_state+0x137/0x180
[  235.624000]  [<c0146350>] state_store+0x90/0xa0
[  235.624000]  [<c01bd73b>] subsys_attr_store+0x2b/0x40
[  235.624000]  [<c01bdf66>] sysfs_write_file+0xa6/0x100
[  235.625000]  [<c0174c36>] vfs_write+0xd6/0x1a0
[  235.625000]  [<c01756ed>] sys_write+0x3d/0x80
[  235.625000]  [<c030fad5>] sysenter_past_esp+0x56/0x8d
[  235.625000]  [<b7ffd410>] 0xb7ffd410
[  235.625000] BUG: scheduling while atomic: hibernate.sh/0x00000001/4692
[  235.626000]  [<c01042a0>] show_trace_log_lvl+0x120/0x140
[  235.626000]  [<c01056e2>] show_trace+0x12/0x20
[  235.626000]  [<c0105709>] dump_stack+0x19/0x20
[  235.626000]  [<c030bb41>] schedule+0x611/0x8f0
[  235.626000]  [<c030c639>] schedule_timeout+0x49/0xc0
[  235.626000]  [<c028012f>] ps2_sendbyte+0xcf/0x120
[  235.627000]  [<c0280393>] ps2_command+0xf3/0x3e0
[  235.627000]  [<c02852f8>] atkbd_activate+0x58/0x80
[  235.628000]  [<c02868fc>] atkbd_reconnect+0xdc/0x120
[  235.629000]  [<c027d13b>] serio_reconnect_driver+0x4b/0x60
[  235.630000]  [<c027e071>] serio_resume+0x11/0x30
[  235.630000]  [<c026dc69>] resume_device+0x69/0xf0
[  235.631000]  [<c026de0d>] dpm_resume+0xad/0xc0
[  235.632000]  [<c026de3f>] device_resume+0x1f/0x29
[  235.633000]  [<c0147505>] pm_suspend_disk+0xa5/0xf2
[  235.633000]  [<c0146277>] enter_state+0x137/0x180
[  235.633000]  [<c0146350>] state_store+0x90/0xa0
[  235.633000]  [<c01bd73b>] subsys_attr_store+0x2b/0x40
[  235.634000]  [<c01bdf66>] sysfs_write_file+0xa6/0x100
[  235.634000]  [<c0174c36>] vfs_write+0xd6/0x1a0
[  235.634000]  [<c01756ed>] sys_write+0x3d/0x80
[  235.635000]  [<c030fad5>] sysenter_past_esp+0x56/0x8d
[  235.635000]  [<b7ffd410>] 0xb7ffd410
[  235.635000] BUG: scheduling while atomic: hibernate.sh/0x00000001/4692
[  235.635000]  [<c01042a0>] show_trace_log_lvl+0x120/0x140
[  235.635000]  [<c01056e2>] show_trace+0x12/0x20
[  235.635000]  [<c0105709>] dump_stack+0x19/0x20
[  235.635000]  [<c030bb41>] schedule+0x611/0x8f0
[  235.635000]  [<c030c639>] schedule_timeout+0x49/0xc0
[  235.635000]  [<c028012f>] ps2_sendbyte+0xcf/0x120
[  235.636000]  [<c0280393>] ps2_command+0xf3/0x3e0
[  235.637000]  [<c028690b>] atkbd_reconnect+0xeb/0x120
[  235.638000]  [<c027d13b>] serio_reconnect_driver+0x4b/0x60
[  235.638000]  [<c027e071>] serio_resume+0x11/0x30
[  235.639000]  [<c026dc69>] resume_device+0x69/0xf0
[  235.640000]  [<c026de0d>] dpm_resume+0xad/0xc0
[  235.641000]  [<c026de3f>] device_resume+0x1f/0x29
[  235.641000]  [<c0147505>] pm_suspend_disk+0xa5/0xf2
[  235.642000]  [<c0146277>] enter_state+0x137/0x180
[  235.642000]  [<c0146350>] state_store+0x90/0xa0
[  235.642000]  [<c01bd73b>] subsys_attr_store+0x2b/0x40
[  235.642000]  [<c01bdf66>] sysfs_write_file+0xa6/0x100
[  235.643000]  [<c0174c36>] vfs_write+0xd6/0x1a0
[  235.643000]  [<c01756ed>] sys_write+0x3d/0x80
[  235.643000]  [<c030fad5>] sysenter_past_esp+0x56/0x8d
[  235.643000]  [<b7ffd410>] 0xb7ffd410
[  235.643000] BUG: scheduling while atomic: hibernate.sh/0x00000001/4692
[  235.644000]  [<c01042a0>] show_trace_log_lvl+0x120/0x140
[  235.644000]  [<c01056e2>] show_trace+0x12/0x20
[  235.644000]  [<c0105709>] dump_stack+0x19/0x20
[  235.644000]  [<c030bb41>] schedule+0x611/0x8f0
[  235.644000]  [<c030c639>] schedule_timeout+0x49/0xc0
[  235.644000]  [<c028012f>] ps2_sendbyte+0xcf/0x120
[  235.645000]  [<c0280623>] ps2_command+0x383/0x3e0
[  235.645000]  [<c028690b>] atkbd_reconnect+0xeb/0x120
[  235.646000]  [<c027d13b>] serio_reconnect_driver+0x4b/0x60
[  235.647000]  [<c027e071>] serio_resume+0x11/0x30
[  235.648000]  [<c026dc69>] resume_device+0x69/0xf0
[  235.649000]  [<c026de0d>] dpm_resume+0xad/0xc0
[  235.649000]  [<c026de3f>] device_resume+0x1f/0x29
[  235.650000]  [<c0147505>] pm_suspend_disk+0xa5/0xf2
[  235.650000]  [<c0146277>] enter_state+0x137/0x180
[  235.650000]  [<c0146350>] state_store+0x90/0xa0
[  235.651000]  [<c01bd73b>] subsys_attr_store+0x2b/0x40
[  235.651000]  [<c01bdf66>] sysfs_write_file+0xa6/0x100
[  235.651000]  [<c0174c36>] vfs_write+0xd6/0x1a0
[  235.652000]  [<c01756ed>] sys_write+0x3d/0x80
[  235.652000]  [<c030fad5>] sysenter_past_esp+0x56/0x8d
[  235.652000]  [<b7ffd410>] 0xb7ffd410
[  235.653000] BUG: scheduling while atomic: hibernate.sh/0x00000001/4692
[  235.653000]  [<c01042a0>] show_trace_log_lvl+0x120/0x140
[  235.653000]  [<c01056e2>] show_trace+0x12/0x20
[  235.653000]  [<c0105709>] dump_stack+0x19/0x20
[  235.653000]  [<c030bb41>] schedule+0x611/0x8f0
[  235.653000]  [<c030c639>] schedule_timeout+0x49/0xc0
[  235.653000]  [<c030c6c7>] schedule_timeout_uninterruptible+0x17/0x20
[  235.653000]  [<c0127915>] msleep+0x25/0x40
[  235.653000]  [<e0831688>] wakeup_rh+0x68/0xe0 [uhci_hcd]
[  235.653000]  [<e0831759>] uhci_rh_resume+0x59/0xb0 [uhci_hcd]
[  235.653000]  [<e08d9dab>] hcd_bus_resume+0x3b/0x70 [usbcore]
[  235.653000]  [<e08d67a9>] hub_resume+0x39/0x50 [usbcore]
[  235.653000]  [<e08d57b5>] usb_generic_resume+0x75/0x120 [usbcore]
[  235.654000]  [<e08d6910>] usb_resume_device+0x150/0x1a0 [usbcore]
[  235.654000]  [<e08d5833>] usb_generic_resume+0xf3/0x120 [usbcore]
[  235.654000]  [<c026dc69>] resume_device+0x69/0xf0
[  235.654000]  [<c026de0d>] dpm_resume+0xad/0xc0
[  235.655000]  [<c026de3f>] device_resume+0x1f/0x29
[  235.656000]  [<c0147505>] pm_suspend_disk+0xa5/0xf2
[  235.656000]  [<c0146277>] enter_state+0x137/0x180
[  235.656000]  [<c0146350>] state_store+0x90/0xa0
[  235.656000]  [<c01bd73b>] subsys_attr_store+0x2b/0x40
[  235.657000]  [<c01bdf66>] sysfs_write_file+0xa6/0x100
[  235.657000]  [<c0174c36>] vfs_write+0xd6/0x1a0
[  235.657000]  [<c01756ed>] sys_write+0x3d/0x80
[  235.658000]  [<c030fad5>] sysenter_past_esp+0x56/0x8d
[  235.658000]  [<b7ffd410>] 0xb7ffd410
[  235.674000] BUG: scheduling while atomic: hibernate.sh/0x00000001/4692
[  235.674000]  [<c01042a0>] show_trace_log_lvl+0x120/0x140
[  235.674000]  [<c01056e2>] show_trace+0x12/0x20
[  235.674000]  [<c0105709>] dump_stack+0x19/0x20
[  235.674000]  [<c030bb41>] schedule+0x611/0x8f0
[  235.674000]  [<c030c639>] schedule_timeout+0x49/0xc0
[  235.674000]  [<c030c6c7>] schedule_timeout_uninterruptible+0x17/0x20
[  235.674000]  [<c0127915>] msleep+0x25/0x40
[  235.674000]  [<e08d67b4>] hub_resume+0x44/0x50 [usbcore]
[  235.674000]  [<e08d57b5>] usb_generic_resume+0x75/0x120 [usbcore]
[  235.674000]  [<e08d6910>] usb_resume_device+0x150/0x1a0 [usbcore]
[  235.674000]  [<e08d5833>] usb_generic_resume+0xf3/0x120 [usbcore]
[  235.674000]  [<c026dc69>] resume_device+0x69/0xf0
[  235.675000]  [<c026de0d>] dpm_resume+0xad/0xc0
[  235.676000]  [<c026de3f>] device_resume+0x1f/0x29
[  235.677000]  [<c0147505>] pm_suspend_disk+0xa5/0xf2
[  235.677000]  [<c0146277>] enter_state+0x137/0x180
[  235.677000]  [<c0146350>] state_store+0x90/0xa0
[  235.677000]  [<c01bd73b>] subsys_attr_store+0x2b/0x40
[  235.678000]  [<c01bdf66>] sysfs_write_file+0xa6/0x100
[  235.678000]  [<c0174c36>] vfs_write+0xd6/0x1a0
[  235.678000]  [<c01756ed>] sys_write+0x3d/0x80
[  235.678000]  [<c030fad5>] sysenter_past_esp+0x56/0x8d
[  235.678000]  [<b7ffd410>] 0xb7ffd410
[  235.685000] BUG: scheduling while atomic: hibernate.sh/0x00000001/4692
[  235.685000]  [<c01042a0>] show_trace_log_lvl+0x120/0x140
[  235.685000]  [<c01056e2>] show_trace+0x12/0x20
[  235.685000]  [<c0105709>] dump_stack+0x19/0x20
[  235.685000]  [<c030bb41>] schedule+0x611/0x8f0
[  235.685000]  [<c030c639>] schedule_timeout+0x49/0xc0
[  235.685000]  [<c030c6c7>] schedule_timeout_uninterruptible+0x17/0x20
[  235.685000]  [<c0127915>] msleep+0x25/0x40
[  235.685000]  [<e0831688>] wakeup_rh+0x68/0xe0 [uhci_hcd]
[  235.685000]  [<e0831759>] uhci_rh_resume+0x59/0xb0 [uhci_hcd]
[  235.685000]  [<e08d9dab>] hcd_bus_resume+0x3b/0x70 [usbcore]
[  235.685000]  [<e08d67a9>] hub_resume+0x39/0x50 [usbcore]
[  235.685000]  [<e08d57b5>] usb_generic_resume+0x75/0x120 [usbcore]
[  235.685000]  [<e08d6910>] usb_resume_device+0x150/0x1a0 [usbcore]
[  235.686000]  [<e08d5833>] usb_generic_resume+0xf3/0x120 [usbcore]
[  235.686000]  [<c026dc69>] resume_device+0x69/0xf0
[  235.686000]  [<c026de0d>] dpm_resume+0xad/0xc0
[  235.687000]  [<c026de3f>] device_resume+0x1f/0x29
[  235.688000]  [<c0147505>] pm_suspend_disk+0xa5/0xf2
[  235.688000]  [<c0146277>] enter_state+0x137/0x180
[  235.688000]  [<c0146350>] state_store+0x90/0xa0
[  235.688000]  [<c01bd73b>] subsys_attr_store+0x2b/0x40
[  235.689000]  [<c01bdf66>] sysfs_write_file+0xa6/0x100
[  235.689000]  [<c0174c36>] vfs_write+0xd6/0x1a0
[  235.689000]  [<c01756ed>] sys_write+0x3d/0x80
[  235.690000]  [<c030fad5>] sysenter_past_esp+0x56/0x8d
[  235.690000]  [<b7ffd410>] 0xb7ffd410
[  235.706000] BUG: scheduling while atomic: hibernate.sh/0x00000001/4692
[  235.706000]  [<c01042a0>] show_trace_log_lvl+0x120/0x140
[  235.706000]  [<c01056e2>] show_trace+0x12/0x20
[  235.706000]  [<c0105709>] dump_stack+0x19/0x20
[  235.706000]  [<c030bb41>] schedule+0x611/0x8f0
[  235.706000]  [<c030c639>] schedule_timeout+0x49/0xc0
[  235.706000]  [<c030c6c7>] schedule_timeout_uninterruptible+0x17/0x20
[  235.706000]  [<c0127915>] msleep+0x25/0x40
[  235.706000]  [<e08d67b4>] hub_resume+0x44/0x50 [usbcore]
[  235.706000]  [<e08d57b5>] usb_generic_resume+0x75/0x120 [usbcore]
[  235.706000]  [<e08d6910>] usb_resume_device+0x150/0x1a0 [usbcore]
[  235.706000]  [<e08d5833>] usb_generic_resume+0xf3/0x120 [usbcore]
[  235.706000]  [<c026dc69>] resume_device+0x69/0xf0
[  235.707000]  [<c026de0d>] dpm_resume+0xad/0xc0
[  235.708000]  [<c026de3f>] device_resume+0x1f/0x29
[  235.709000]  [<c0147505>] pm_suspend_disk+0xa5/0xf2
[  235.709000]  [<c0146277>] enter_state+0x137/0x180
[  235.709000]  [<c0146350>] state_store+0x90/0xa0
[  235.709000]  [<c01bd73b>] subsys_attr_store+0x2b/0x40
[  235.710000]  [<c01bdf66>] sysfs_write_file+0xa6/0x100
[  235.710000]  [<c0174c36>] vfs_write+0xd6/0x1a0
[  235.710000]  [<c01756ed>] sys_write+0x3d/0x80
[  235.710000]  [<c030fad5>] sysenter_past_esp+0x56/0x8d
[  235.710000]  [<b7ffd410>] 0xb7ffd410
[  235.717000] BUG: scheduling while atomic: hibernate.sh/0x00000001/4692
[  235.717000]  [<c01042a0>] show_trace_log_lvl+0x120/0x140
[  235.717000]  [<c01056e2>] show_trace+0x12/0x20
[  235.717000]  [<c0105709>] dump_stack+0x19/0x20
[  235.717000]  [<c030bb41>] schedule+0x611/0x8f0
[  235.717000]  [<c030c639>] schedule_timeout+0x49/0xc0
[  235.717000]  [<c030c6c7>] schedule_timeout_uninterruptible+0x17/0x20
[  235.717000]  [<c0127915>] msleep+0x25/0x40
[  235.717000]  [<e0831688>] wakeup_rh+0x68/0xe0 [uhci_hcd]
[  235.717000]  [<e0831759>] uhci_rh_resume+0x59/0xb0 [uhci_hcd]
[  235.717000]  [<e08d9dab>] hcd_bus_resume+0x3b/0x70 [usbcore]
[  235.717000]  [<e08d67a9>] hub_resume+0x39/0x50 [usbcore]
[  235.717000]  [<e08d57b5>] usb_generic_resume+0x75/0x120 [usbcore]
[  235.718000]  [<e08d6910>] usb_resume_device+0x150/0x1a0 [usbcore]
[  235.718000]  [<e08d5833>] usb_generic_resume+0xf3/0x120 [usbcore]
[  235.718000]  [<c026dc69>] resume_device+0x69/0xf0
[  235.718000]  [<c026de0d>] dpm_resume+0xad/0xc0
[  235.719000]  [<c026de3f>] device_resume+0x1f/0x29
[  235.720000]  [<c0147505>] pm_suspend_disk+0xa5/0xf2
[  235.720000]  [<c0146277>] enter_state+0x137/0x180
[  235.720000]  [<c0146350>] state_store+0x90/0xa0
[  235.720000]  [<c01bd73b>] subsys_attr_store+0x2b/0x40
[  235.721000]  [<c01bdf66>] sysfs_write_file+0xa6/0x100
[  235.721000]  [<c0174c36>] vfs_write+0xd6/0x1a0
[  235.721000]  [<c01756ed>] sys_write+0x3d/0x80
[  235.722000]  [<c030fad5>] sysenter_past_esp+0x56/0x8d
[  235.722000]  [<b7ffd410>] 0xb7ffd410
[  235.738000] BUG: scheduling while atomic: hibernate.sh/0x00000001/4692
[  235.738000]  [<c01042a0>] show_trace_log_lvl+0x120/0x140
[  235.738000]  [<c01056e2>] show_trace+0x12/0x20
[  235.738000]  [<c0105709>] dump_stack+0x19/0x20
[  235.738000]  [<c030bb41>] schedule+0x611/0x8f0
[  235.738000]  [<c030c639>] schedule_timeout+0x49/0xc0
[  235.738000]  [<c030c6c7>] schedule_timeout_uninterruptible+0x17/0x20
[  235.738000]  [<c0127915>] msleep+0x25/0x40
[  235.738000]  [<e08d67b4>] hub_resume+0x44/0x50 [usbcore]
[  235.738000]  [<e08d57b5>] usb_generic_resume+0x75/0x120 [usbcore]
[  235.738000]  [<e08d6910>] usb_resume_device+0x150/0x1a0 [usbcore]
[  235.738000]  [<e08d5833>] usb_generic_resume+0xf3/0x120 [usbcore]
[  235.738000]  [<c026dc69>] resume_device+0x69/0xf0
[  235.739000]  [<c026de0d>] dpm_resume+0xad/0xc0
[  235.740000]  [<c026de3f>] device_resume+0x1f/0x29
[  235.741000]  [<c0147505>] pm_suspend_disk+0xa5/0xf2
[  235.741000]  [<c0146277>] enter_state+0x137/0x180
[  235.741000]  [<c0146350>] state_store+0x90/0xa0
[  235.741000]  [<c01bd73b>] subsys_attr_store+0x2b/0x40
[  235.742000]  [<c01bdf66>] sysfs_write_file+0xa6/0x100
[  235.742000]  [<c0174c36>] vfs_write+0xd6/0x1a0
[  235.742000]  [<c01756ed>] sys_write+0x3d/0x80
[  235.742000]  [<c030fad5>] sysenter_past_esp+0x56/0x8d
[  235.742000]  [<b7ffd410>] 0xb7ffd410
[  235.749000] BUG: scheduling while atomic: hibernate.sh/0x00000001/4692
[  235.749000]  [<c01042a0>] show_trace_log_lvl+0x120/0x140
[  235.749000]  [<c01056e2>] show_trace+0x12/0x20
[  235.749000]  [<c0105709>] dump_stack+0x19/0x20
[  235.749000]  [<c030bb41>] schedule+0x611/0x8f0
[  235.749000]  [<c030c639>] schedule_timeout+0x49/0xc0
[  235.749000]  [<c030c6c7>] schedule_timeout_uninterruptible+0x17/0x20
[  235.749000]  [<c0127915>] msleep+0x25/0x40
[  235.749000]  [<e0831688>] wakeup_rh+0x68/0xe0 [uhci_hcd]
[  235.749000]  [<e0831759>] uhci_rh_resume+0x59/0xb0 [uhci_hcd]
[  235.749000]  [<e08d9dab>] hcd_bus_resume+0x3b/0x70 [usbcore]
[  235.749000]  [<e08d67a9>] hub_resume+0x39/0x50 [usbcore]
[  235.749000]  [<e08d57b5>] usb_generic_resume+0x75/0x120 [usbcore]
[  235.750000]  [<e08d6910>] usb_resume_device+0x150/0x1a0 [usbcore]
[  235.750000]  [<e08d5833>] usb_generic_resume+0xf3/0x120 [usbcore]
[  235.750000]  [<c026dc69>] resume_device+0x69/0xf0
[  235.750000]  [<c026de0d>] dpm_resume+0xad/0xc0
[  235.751000]  [<c026de3f>] device_resume+0x1f/0x29
[  235.752000]  [<c0147505>] pm_suspend_disk+0xa5/0xf2
[  235.752000]  [<c0146277>] enter_state+0x137/0x180
[  235.752000]  [<c0146350>] state_store+0x90/0xa0
[  235.752000]  [<c01bd73b>] subsys_attr_store+0x2b/0x40
[  235.753000]  [<c01bdf66>] sysfs_write_file+0xa6/0x100
[  235.753000]  [<c0174c36>] vfs_write+0xd6/0x1a0
[  235.753000]  [<c01756ed>] sys_write+0x3d/0x80
[  235.754000]  [<c030fad5>] sysenter_past_esp+0x56/0x8d
[  235.754000]  [<b7ffd410>] 0xb7ffd410
[  235.770000] BUG: scheduling while atomic: hibernate.sh/0x00000001/4692
[  235.770000]  [<c01042a0>] show_trace_log_lvl+0x120/0x140
[  235.770000]  [<c01056e2>] show_trace+0x12/0x20
[  235.770000]  [<c0105709>] dump_stack+0x19/0x20
[  235.770000]  [<c030bb41>] schedule+0x611/0x8f0
[  235.770000]  [<c030c639>] schedule_timeout+0x49/0xc0
[  235.770000]  [<c030c6c7>] schedule_timeout_uninterruptible+0x17/0x20
[  235.770000]  [<c0127915>] msleep+0x25/0x40
[  235.770000]  [<e08d67b4>] hub_resume+0x44/0x50 [usbcore]
[  235.770000]  [<e08d57b5>] usb_generic_resume+0x75/0x120 [usbcore]
[  235.770000]  [<e08d6910>] usb_resume_device+0x150/0x1a0 [usbcore]
[  235.770000]  [<e08d5833>] usb_generic_resume+0xf3/0x120 [usbcore]
[  235.770000]  [<c026dc69>] resume_device+0x69/0xf0
[  235.771000]  [<c026de0d>] dpm_resume+0xad/0xc0
[  235.772000]  [<c026de3f>] device_resume+0x1f/0x29
[  235.773000]  [<c0147505>] pm_suspend_disk+0xa5/0xf2
[  235.773000]  [<c0146277>] enter_state+0x137/0x180
[  235.773000]  [<c0146350>] state_store+0x90/0xa0
[  235.773000]  [<c01bd73b>] subsys_attr_store+0x2b/0x40
[  235.774000]  [<c01bdf66>] sysfs_write_file+0xa6/0x100
[  235.774000]  [<c0174c36>] vfs_write+0xd6/0x1a0
[  235.774000]  [<c01756ed>] sys_write+0x3d/0x80
[  235.774000]  [<c030fad5>] sysenter_past_esp+0x56/0x8d
[  235.774000]  [<b7ffd410>] 0xb7ffd410
[  235.782000] BUG: scheduling while atomic: hibernate.sh/0x00000001/4692
[  235.782000]  [<c01042a0>] show_trace_log_lvl+0x120/0x140
[  235.782000]  [<c01056e2>] show_trace+0x12/0x20
[  235.782000]  [<c0105709>] dump_stack+0x19/0x20
[  235.782000]  [<c030bb41>] schedule+0x611/0x8f0
[  235.782000]  [<c030c639>] schedule_timeout+0x49/0xc0
[  235.782000]  [<c030c6c7>] schedule_timeout_uninterruptible+0x17/0x20
[  235.782000]  [<c0127915>] msleep+0x25/0x40
[  235.782000]  [<e08d67b4>] hub_resume+0x44/0x50 [usbcore]
[  235.782000]  [<e08d57b5>] usb_generic_resume+0x75/0x120 [usbcore]
[  235.782000]  [<e08d6910>] usb_resume_device+0x150/0x1a0 [usbcore]
[  235.783000]  [<e08d5833>] usb_generic_resume+0xf3/0x120 [usbcore]
[  235.783000]  [<c026dc69>] resume_device+0x69/0xf0
[  235.783000]  [<c026de0d>] dpm_resume+0xad/0xc0
[  235.784000]  [<c026de3f>] device_resume+0x1f/0x29
[  235.785000]  [<c0147505>] pm_suspend_disk+0xa5/0xf2
[  235.785000]  [<c0146277>] enter_state+0x137/0x180
[  235.785000]  [<c0146350>] state_store+0x90/0xa0
[  235.785000]  [<c01bd73b>] subsys_attr_store+0x2b/0x40
[  235.786000]  [<c01bdf66>] sysfs_write_file+0xa6/0x100
[  235.786000]  [<c0174c36>] vfs_write+0xd6/0x1a0
[  235.786000]  [<c01756ed>] sys_write+0x3d/0x80
[  235.787000]  [<c030fad5>] sysenter_past_esp+0x56/0x8d
[  235.787000]  [<b7ffd410>] 0xb7ffd410
[  235.793000] Restarting tasks...<3>BUG: scheduling while atomic: hibernat=
e.sh/0x00000001/4692
[  235.793000]  [<c01042a0>] show_trace_log_lvl+0x120/0x140
[  235.793000]  [<c01056e2>] show_trace+0x12/0x20
[  235.793000]  [<c0105709>] dump_stack+0x19/0x20
[  235.793000]  [<c030bb41>] schedule+0x611/0x8f0
[  235.793000]  [<c0146522>] thaw_processes+0xb2/0xe0
[  235.793000]  [<c01472f1>] unprepare_processes+0x11/0x40
[  235.793000]  [<c014750a>] pm_suspend_disk+0xaa/0xf2
[  235.794000]  [<c0146277>] enter_state+0x137/0x180
[  235.794000]  [<c0146350>] state_store+0x90/0xa0
[  235.794000]  [<c01bd73b>] subsys_attr_store+0x2b/0x40
[  235.794000]  [<c01bdf66>] sysfs_write_file+0xa6/0x100
[  235.795000]  [<c0174c36>] vfs_write+0xd6/0x1a0
[  235.795000]  [<c01756ed>] sys_write+0x3d/0x80
[  235.795000]  [<c030fad5>] sysenter_past_esp+0x56/0x8d
[  235.795000]  [<b7ffd410>] 0xb7ffd410
[  236.559000]  done
[  236.559000] BUG: sleeping function called from invalid context at includ=
e/asm/semaphore.h:99
[  236.559000] in_atomic():1, irqs_disabled():0
[  236.559000]  [<c01042a0>] show_trace_log_lvl+0x120/0x140
[  236.559000]  [<c01056e2>] show_trace+0x12/0x20
[  236.559000]  [<c0105709>] dump_stack+0x19/0x20
[  236.560000]  [<c011851b>] __might_sleep+0xbb/0xd0
[  236.560000]  [<c011d7cb>] acquire_console_sem+0x3b/0x60
[  236.560000]  [<c01469b8>] pm_restore_console+0x8/0x30
[  236.560000]  [<c01472f6>] unprepare_processes+0x16/0x40
[  236.560000]  [<c014750a>] pm_suspend_disk+0xaa/0xf2
[  236.560000]  [<c0146277>] enter_state+0x137/0x180
[  236.560000]  [<c0146350>] state_store+0x90/0xa0
[  236.561000]  [<c01bd73b>] subsys_attr_store+0x2b/0x40
[  236.561000]  [<c01bdf66>] sysfs_write_file+0xa6/0x100
[  236.561000]  [<c0174c36>] vfs_write+0xd6/0x1a0
[  236.562000]  [<c01756ed>] sys_write+0x3d/0x80
[  236.562000]  [<c030fad5>] sysenter_past_esp+0x56/0x8d
[  236.562000]  [<b7ffd410>] 0xb7ffd410
[  236.562000] BUG: scheduling while atomic: hibernate.sh/0x00000001/4692
[  236.562000]  [<c01042a0>] show_trace_log_lvl+0x120/0x140
[  236.562000]  [<c01056e2>] show_trace+0x12/0x20
[  236.562000]  [<c0105709>] dump_stack+0x19/0x20
[  236.562000]  [<c030bb41>] schedule+0x611/0x8f0
[  236.562000]  [<c030fbfe>] work_resched+0x5/0x25
[  236.562000]  [<b7ffd410>] 0xb7ffd410
[  236.589000] BUG: scheduling while atomic: hibernate.sh/0x00000001/4692
[  236.589000]  [<c01042a0>] show_trace_log_lvl+0x120/0x140
[  236.589000]  [<c01056e2>] show_trace+0x12/0x20
[  236.589000]  [<c0105709>] dump_stack+0x19/0x20
[  236.589000]  [<c030bb41>] schedule+0x611/0x8f0
[  236.589000]  [<c030fbfe>] work_resched+0x5/0x25
[  236.589000]  [<b7ffd410>] 0xb7ffd410
[  236.597000] note: hibernate.sh[4692] exited with preempt_count 1
[  237.801000] hdc: drive_cmd: status=3D0x51 { DriveReady SeekComplete Erro=
r }
[  237.801000] hdc: drive_cmd: error=3D0x04 { AbortedCommand }
[  237.801000] ide: failed opcode was: 0xec













------=_Part_41244_3504762.1149675242844--
