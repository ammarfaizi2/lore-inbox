Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161014AbWBNLlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161014AbWBNLlI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 06:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161019AbWBNLlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 06:41:07 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:47837 "EHLO
	keetweej.vanheusden.com") by vger.kernel.org with ESMTP
	id S1161014AbWBNLlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 06:41:06 -0500
Date: Tue, 14 Feb 2006 12:41:03 +0100
From: Folkert van Heusden <folkert@vanheusden.com>
To: Charles-Edouard Ruault <ce@ruault.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] kernel 2.6.15.4: soft lockup detected on CPU#0!
Message-ID: <20060214114102.GC20975@vanheusden.com>
References: <43EF8388.10202@ruault.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43EF8388.10202@ruault.com>
Organization: www.unixexpert.nl
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
X-Phonenumber: +31-6-41278122
X-URL: http://www.vanheusden.com/
X-PGP-KeyID: 1F28D8AE
X-GPG-fingerprint: AC89 09CE 41F2 00B4 FCF2  B174 3019 0E8C 1F28 D8AE
X-Key: http://pgp.surfnet.nl:11371/pks/lookup?op=get&search=0x1F28D8AE
Read-Receipt-To: <folkert@vanheusden.com>
Reply-By: Wed Feb 15 11:25:21 CET 2006
X-Message-Flag: MultiTail - tail on steroids
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got the same soft lockups, not while cdrom access but when sa-learn
runs (from spamassassin):

[189597.723886] BUG: soft lockup detected on CPU#0!
[189597.723960]
[189597.724007] Pid: 14, comm:            kblockd/0
[189597.724061] EIP: 0060:[<c022dacc>] CPU: 0
[189597.724117] EIP is at ide_pio_sector+0xb2/0xdf
[189597.724169]  EFLAGS: 00200206    Not tainted  (2.6.15.4-pwc-ara)
[189597.724225] EAX: c2188000 EBX: ebdc5600 ECX: 00000000 EDX: 00000005
[189597.724278] ESI: f7cf1000 EDI: c03f2780 EBP: c03f2814 DS: 007b ES: 007b
[189597.724374] CR0: 8005003b CR2: 4d5591e4 CR3: 003b2000 CR4: 000006d0
[189597.724456]  [<c022db2b>] ide_pio_multi+0x32/0x3b
[189597.724616]  [<c022ddd3>] task_out_intr+0xc3/0xe5
[189597.724782]  [<c01231de>] del_timer+0x56/0x58
[189597.725022]  [<c022dd10>] task_out_intr+0x0/0xe5
[189597.725172]  [<c02296df>] ide_intr+0xbe/0x139
[189597.725318]  [<c013a041>] handle_IRQ_event+0x26/0x59
[189597.725461]  [<c013a0f4>] __do_IRQ+0x80/0xe0
[189597.725600]  [<c0104dc6>] do_IRQ+0x36/0x66
[189597.725794]  [<c01034f2>] common_interrupt+0x1a/0x20
[189597.725935]  [<f886b0d4>] ipt_do_table+0xac/0x315 [ip_tables]
[189597.726098]  [<f88d1029>] ipt_hook+0x29/0x31 [iptable_filter]
[189597.726231]  [<c0286ff1>] nf_iterate+0x69/0x83
[189597.726359]  [<c028c893>] ip_local_deliver_finish+0x0/0x1cc
[189597.726568]  [<c028c893>] ip_local_deliver_finish+0x0/0x1cc
[189597.726696]  [<c0287068>] nf_hook_slow+0x5d/0xea
[189597.726831]  [<c028c893>] ip_local_deliver_finish+0x0/0x1cc
[189597.726972]  [<c028c328>] ip_local_deliver+0x220/0x250
[189597.727134]  [<c028c893>] ip_local_deliver_finish+0x0/0x1cc
[189597.727298]  [<c028c5ed>] ip_rcv+0x295/0x53b
[189597.727555]  [<c028ca5f>] ip_rcv_finish+0x0/0x295
[189597.727757]  [<c0273111>] netif_receive_skb+0x283/0x352
[189597.727930]  [<c0273266>] process_backlog+0x86/0x106
[189597.728081]  [<c027336e>] net_rx_action+0x88/0x160
[189597.728229]  [<c011fb34>] __do_softirq+0xbc/0xce
[189597.728443]  [<c011fb78>] do_softirq+0x32/0x34
[189597.728561]  [<c0104dcb>] do_IRQ+0x3b/0x66
[189597.728685]  [<c01034f2>] common_interrupt+0x1a/0x20
[189597.728817]  [<c0228e61>] start_request+0xfc/0x201
[189597.728955]  [<c0229190>] ide_do_request+0x209/0x351
[189597.729163]  [<c01c072a>] as_work_handler+0x40/0x42
[189597.729296]  [<c01297a6>] worker_thread+0x185/0x21a
[189597.729433]  [<c01c06ea>] as_work_handler+0x0/0x42
[189597.729570]  [<c011770a>] default_wake_function+0x0/0xc
[189597.729711]  [<c011770a>] default_wake_function+0x0/0xc
[189597.729856]  [<c0129621>] worker_thread+0x0/0x21a
[189597.730083]  [<c012d2ce>] kthread+0x9c/0xa1
[189597.730239]  [<c012d232>] kthread+0x0/0xa1
[189597.730419]  [<c0101065>] kernel_thread_helper+0x5/0xb


On Sun, Feb 12, 2006 at 07:50:48PM +0100, Charles-Edouard Ruault wrote:
> Hi All,
> i was trying to rip a CD when the whole machine started to freeze
> periodicaly, i then looked at the logs and found the following :
> 
> Feb 12 19:23:39 ruault kernel: hdc: irq timeout: status=0x80 { Busy }
> Feb 12 19:23:39 ruault kernel: ide: failed opcode was: unknown
> Feb 12 19:23:39 ruault kernel: hdd: status timeout: status=0x80 { Busy }
> Feb 12 19:23:39 ruault kernel: ide: failed opcode was: unknown
> Feb 12 19:23:39 ruault kernel: hdd: drive not ready for command
> Feb 12 19:23:39 ruault kernel: BUG: soft lockup detected on CPU#0!
> Feb 12 19:23:39 ruault kernel:
> Feb 12 19:23:39 ruault kernel: Pid: 0, comm:              swapper
> Feb 12 19:23:39 ruault kernel: EIP: 0060:[<c0272b75>] CPU: 0
> Feb 12 19:23:39 ruault kernel: EIP is at ide_inb+0x5/0x10
> Feb 12 19:23:39 ruault kernel:  EFLAGS: 00000216    Tainted: P      
> (2.6.15.4)
> Feb 12 19:23:39 ruault kernel: EAX: 00000180 EBX: 01aefc21 ECX: cfd3beae
> EDX: 00000177
> Feb 12 19:23:39 ruault kernel: ESI: 00000088 EDI: c0419e30 EBP: c0419ec4
> DS: 007b ES: 007b
> Feb 12 19:23:39 ruault kernel: CR0: 8005003b CR2: b7274c4c CR3: 2086e000
> CR4: 000006d0
> Feb 12 19:23:39 ruault kernel:  [<c0273656>] ide_wait_stat+0xf6/0x140
> Feb 12 19:23:39 ruault kernel:  [<c0271cf6>] start_request+0xe6/0x2e0
> Feb 12 19:23:39 ruault kernel:  [<c027220b>] ide_do_request+0x2eb/0x400
> Feb 12 19:23:39 ruault kernel:  [<c0280ff0>] cdrom_newpc_intr+0x0/0x470
> Feb 12 19:23:39 ruault kernel:  [<c027255c>] ide_timer_expiry+0xec/0x290
> Feb 12 19:23:39 ruault kernel:  [<c0272470>] ide_timer_expiry+0x0/0x290
> Feb 12 19:23:39 ruault kernel:  [<c0128afc>] run_timer_softirq+0xbc/0x210
> Feb 12 19:23:39 ruault kernel:  [<c0123f12>] __do_softirq+0x52/0xa0
> Feb 12 19:23:39 ruault kernel:  [<c0123f8d>] do_softirq+0x2d/0x40
> Feb 12 19:23:39 ruault kernel:  [<c0124068>] irq_exit+0x38/0x40
> Feb 12 19:23:39 ruault kernel:  [<c0105a77>] do_IRQ+0x37/0x70
> Feb 12 19:23:39 ruault kernel:  [<c0103d4e>] common_interrupt+0x1a/0x20
> Feb 12 19:23:39 ruault kernel:  [<c010105b>] default_idle+0x2b/0x60
> Feb 12 19:23:39 ruault kernel:  [<c01010f5>] cpu_idle+0x45/0x80
> Feb 12 19:23:39 ruault kernel:  [<c03b084f>] start_kernel+0x17f/0x1e0
> Feb 12 19:23:39 ruault kernel:  [<c03b0390>] unknown_bootoption+0x0/0x1e0
> Feb 12 19:23:39 ruault kernel: hdc: status timeout: status=0x80 { Busy }
> Feb 12 19:23:39 ruault kernel: ide: failed opcode was: unknown
> Feb 12 19:23:39 ruault kernel: hdc: drive not ready for command
> Feb 12 19:23:39 ruault kernel: hdd: status timeout: status=0x80 { Busy }
> Feb 12 19:23:39 ruault kernel: ide: failed opcode was: unknown
> Feb 12 19:23:39 ruault kernel: hdd: drive not ready for command
> Feb 12 19:23:39 ruault kernel: hdd: ATAPI reset complete
> Feb 12 19:23:49 ruault kernel: hdc: irq timeout: status=0x80 { Busy }
> Feb 12 19:23:49 ruault kernel: ide: failed opcode was: unknown
> Feb 12 19:23:49 ruault kernel: hdd: status timeout: status=0x80 { Busy }
> Feb 12 19:24:09 ruault kernel: hdc: irq timeout: status=0x80 { Busy }
> 
> After a few seconds, the whole machine was totally locked up and the
> only option i had was a hard reset.
> I was able to reproduce it once more.
> 
> I'm running vanilla kernel 2.6.15.4 on an athlon 32 bits. here's generic
> info about my configuration :
> 
> processor       : 0
> vendor_id       : AuthenticAMD
> cpu family      : 6
> model           : 8
> model name      : AMD Athlon(TM) XP 2400+
> stepping        : 1
> cpu MHz         : 2000.448
> cache size      : 256 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 1
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
> mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
> bogomips        : 4004.40
> 
> /sbin/lspci -v
> 00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400/KT600 AGP]
> Host Bridge
>         Subsystem: ASUSTeK Computer Inc. A7V8X motherboard
>         Flags: bus master, 66Mhz, medium devsel, latency 0
>         Memory at f0000000 (32-bit, prefetchable) [size=128M]
>         Capabilities: <available only to root>
> 
> 00:01.0 PCI bridge: VIA Technologies, Inc. VT8235 PCI Bridge (prog-if 00
> [Normal decode])
>         Flags: bus master, 66Mhz, medium devsel, latency 0
>         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
>         I/O behind bridge: 0000d000-0000dfff
>         Memory behind bridge: d6800000-d7dfffff
>         Prefetchable memory behind bridge: d8000000-efffffff
>         Capabilities: <available only to root>
> 
> 00:07.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host
> Controller (rev 46) (prog-if 10 [OHCI])
>         Subsystem: VIA Technologies, Inc. IEEE 1394 Host Controller
>         Flags: bus master, stepping, medium devsel, latency 32, IRQ 20
>         Memory at d6000000 (32-bit, non-prefetchable) [size=2K]
>         I/O ports at b800 [size=128]
>         Capabilities: <available only to root>
> 
> 00:08.0 RAID bus controller: Promise Technology, Inc. PDC20376 (FastTrak
> 376) (rev 02)
>         Subsystem: ASUSTeK Computer Inc. A7V8X motherboard
>         Flags: bus master, 66Mhz, medium devsel, latency 96, IRQ 10
>         I/O ports at b400 [size=64]
>         I/O ports at b000 [size=16]
>         I/O ports at a800 [size=128]
>         Memory at d5800000 (32-bit, non-prefetchable) [size=4K]
>         Memory at d5000000 (32-bit, non-prefetchable) [size=128K]
>         Capabilities: <available only to root>
> 
> 00:09.0 Ethernet controller: Broadcom Corporation BCM4401 100Base-T (rev 01)
>         Subsystem: ASUSTeK Computer Inc. A7V8X motherboard
>         Flags: bus master, fast devsel, latency 32, IRQ 16
>         Memory at d4800000 (32-bit, non-prefetchable) [size=8K]
>         Expansion ROM at d7ff0000 [disabled] [size=16K]
>         Capabilities: <available only to root>
> 
> 00:0d.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro
> 100] (rev 08)
>         Subsystem: Intel Corporation EtherExpress PRO/100+ Management
> Adapter
>         Flags: bus master, medium devsel, latency 32, IRQ 17
>         Memory at d4000000 (32-bit, non-prefetchable) [size=4K]
>         I/O ports at a400 [size=64]
>         Memory at d3800000 (32-bit, non-prefetchable) [size=1M]
>         [virtual] Expansion ROM at 50000000 [disabled] [size=1M]
>         Capabilities: <available only to root>
> 
> 00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
> Controller (rev 80) (prog-if 00 [UHCI])
>         Subsystem: ASUSTeK Computer Inc. VT6202 USB2.0 4 port controller
>         Flags: bus master, medium devsel, latency 32, IRQ 19
>         I/O ports at a000 [size=32]
>         Capabilities: <available only to root>
> 
> 00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
> Controller (rev 80) (prog-if 00 [UHCI])
>         Subsystem: ASUSTeK Computer Inc. VT6202 USB2.0 4 port controller
>         Flags: bus master, medium devsel, latency 32, IRQ 19
>         I/O ports at 9800 [size=32]
>         Capabilities: <available only to root>
> 
> 00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
> Controller (rev 80) (prog-if 00 [UHCI])
>         Subsystem: ASUSTeK Computer Inc. VT6202 USB2.0 4 port controller
>         Flags: bus master, medium devsel, latency 32, IRQ 19
>         I/O ports at 9400 [size=32]
>         Capabilities: <available only to root>
> 
> 00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82) (prog-if
> 20 [EHCI])
>         Subsystem: ASUSTeK Computer Inc. A7V8X motherboard
>         Flags: bus master, medium devsel, latency 32, IRQ 19
>         Memory at d3000000 (32-bit, non-prefetchable) [size=256]
>         Capabilities: <available only to root>
> 
> 00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
>         Subsystem: ASUSTeK Computer Inc. A7V8X motherboard
>         Flags: bus master, stepping, medium devsel, latency 0
>         Capabilities: <available only to root>
> 
> 00:11.1 IDE interface: VIA Technologies, Inc.
> VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
> (prog-if 8a [Master SecP PriP])
>         Subsystem: ASUSTeK Computer Inc. A7V8X / A7V333 motherboard
>         Flags: bus master, medium devsel, latency 32, IRQ 255
>         I/O ports at 9000 [size=16]
>         Capabilities: <available only to root>
> 
> 00:11.5 Multimedia audio controller: VIA Technologies, Inc.
> VT8233/A/8235/8237 AC97 Audio Controller (rev 50)
>         Subsystem: ASUSTeK Computer Inc. A7V8X Motherboard (Realtek
> ALC650 codec)
>         Flags: medium devsel, IRQ 18
>         I/O ports at e000 [size=256]
>         Capabilities: <available only to root>
> 
> 01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R300 NE
> [Radeon 9500 Pro] (prog-if 00 [VGA])
>         Subsystem: ATI Technologies Inc Radeon R300 NE [Radeon 9500 Pro]
>         Flags: bus master, stepping, 66Mhz, medium devsel, latency 255,
> IRQ 17
>         Memory at e8000000 (32-bit, prefetchable) [size=128M]
>         I/O ports at d800 [size=256]
>         Memory at d7000000 (32-bit, non-prefetchable) [size=64K]
>         Expansion ROM at e7fe0000 [disabled] [size=128K]
>         Capabilities: <available only to root>
> 
> 01:00.1 Display controller: ATI Technologies Inc Radeon R300 [Radeon
> 9500 Pro] (Secondary)
>         Subsystem: ATI Technologies Inc Radeon R300 NE [Radeon 9500 Pro]
>         Flags: bus master, stepping, 66Mhz, medium devsel, latency 64
>         Memory at d8000000 (32-bit, prefetchable) [size=128M]
>         Memory at d6800000 (32-bit, non-prefetchable) [size=64K]
>         Capabilities: <available only to root>
> 
> /sbin/lsmod
> Module                  Size  Used by
> rfcomm                 36504  0
> l2cap                  24196  5 rfcomm
> bluetooth              44900  4 rfcomm,l2cap
> deflate                 3328  0
> zlib_deflate           23576  1 deflate
> twofish                47104  0
> serpent                20224  0
> aes_i586               38272  0
> blowfish                8192  0
> des                    16384  0
> lp                     10696  0
> sha256                 10880  0
> sha1                    2816  0
> crypto_null             2560  0
> xfrm4_tunnel            3204  0
> ipcomp                  7176  0
> esp4                    7168  0
> ah4                     5632  0
> af_key                 31248  0
> autofs4                18052  1
> vmnet                  35748  3
> parport_pc             38852  1
> parport                35528  2 lp,parport_pc
> vmmon                 111468  0
> sunrpc                139836  1
> ipt_MARK                2432  1
> iptable_mangle          2560  1
> ipt_MASQUERADE          3072  1
> iptable_nat             6916  1
> ip_nat                 17068  2 ipt_MASQUERADE,iptable_nat
> ipt_LOG                 6656  1
> ipt_limit               2432  1
> ipt_mark                1664  1
> ipt_state               1920  1
> ip_conntrack           48556  4 ipt_MASQUERADE,iptable_nat,ip_nat,ipt_state
> nfnetlink               5272  2 ip_nat,ip_conntrack
> iptable_filter          2560  1
> ip_tables              21120  9
> ipt_MARK,iptable_mangle,ipt_MASQUERADE,iptable_nat,ipt_LOG,ipt_limit,ipt_mark,ipt_state,iptable_filter
> binfmt_misc             9864  1
> fglrx                 454604  7
> ipv6                  259840  23
> sd_mod                 17296  0
> dm_mod                 54072  0
> video                  14468  0
> button                  5264  0
> ac                      3716  0
> quickcam               77348  0
> videodev                7936  1 quickcam
> usbhid                 37344  0
> usb_storage            32516  0
> scsi_mod              126824  2 sd_mod,usb_storage
> ohci1394               33460  0
> ieee1394               92600  1 ohci1394
> uhci_hcd               31888  0
> ehci_hcd               33416  0
> via_agp                 8320  1
> agpgart                29768  2 fglrx,via_agp
> shpchp                 44224  0
> i2c_viapro              7828  0
> i2c_core               18192  1 i2c_viapro
> snd_via82xx            24468  4
> snd_ac97_codec         94112  1 snd_via82xx
> snd_ac97_bus            2176  1 snd_ac97_codec
> snd_seq_dummy           3076  0
> snd_seq_oss            34176  0
> snd_seq_midi_event      6784  1 snd_seq_oss
> snd_seq                52112  5 snd_seq_dummy,snd_seq_oss,snd_seq_midi_event
> snd_pcm_oss            50848  0
> snd_mixer_oss          18048  1 snd_pcm_oss
> snd_pcm                85128  5 snd_via82xx,snd_ac97_codec,snd_pcm_oss
> snd_timer              22788  3 snd_seq,snd_pcm
> snd_page_alloc          8968  2 snd_via82xx,snd_pcm
> snd_mpu401_uart         6784  1 snd_via82xx
> snd_rawmidi            22176  1 snd_mpu401_uart
> snd_seq_device          7436  4
> snd_seq_dummy,snd_seq_oss,snd_seq,snd_rawmidi
> snd                    49252  16
> snd_via82xx,snd_ac97_codec,snd_seq_oss,snd_seq,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device
> soundcore               8416  1 snd
> eepro100               27920  0
> b44                    23948  0
> mii                     5376  2 eepro100,b44
> floppy                 60100  0
> usbcore               120836  6
> quickcam,usbhid,usb_storage,uhci_hcd,ehci_hcd
> 
> relevant info regarding drives etc :
> 
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> Feb 12 19:37:12 ruault kernel: VP_IDE: IDE controller at PCI slot
> 0000:00:11.1
> Feb 12 19:37:12 ruault kernel: ACPI: PCI Interrupt 0000:00:11.1[A]: no GSI
> Feb 12 19:37:12 ruault kernel: PCI: Via IRQ fixup for 0000:00:11.1, from
> 255 to 15
> Feb 12 19:37:12 ruault kernel: VP_IDE: chipset revision 6
> Feb 12 19:37:12 ruault kernel: VP_IDE: not 100% native mode: will probe
> irqs later
> Feb 12 19:37:12 ruault kernel: VP_IDE: VIA vt8235 (rev 00) IDE UDMA133
> controller on pci0000:00:11.1
> Feb 12 19:37:12 ruault kernel:     ide0: BM-DMA at 0x9000-0x9007, BIOS
> settings: hda:DMA, hdb:pio
> Feb 12 19:37:12 ruault kernel:     ide1: BM-DMA at 0x9008-0x900f, BIOS
> settings: hdc:DMA, hdd:DMA
> Feb 12 19:37:12 ruault kernel: hda: Maxtor 6Y080L0, ATA DISK drive
> Feb 12 19:37:12 ruault kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> Feb 12 19:37:12 ruault kernel: hdc: PLEXTOR CD-R PX-W1610A, ATAPI
> CD/DVD-ROM drive
> Feb 12 19:37:12 ruault kernel: hdd: _NEC DVD_RW ND-3500AG, ATAPI
> CD/DVD-ROM drive
> Feb 12 19:37:12 ruault kernel: ide1 at 0x170-0x177,0x376 on irq 15
> Feb 12 19:37:12 ruault kernel: hda: max request size: 128KiB
> Feb 12 19:37:12 ruault kernel: hda: 160086528 sectors (81964 MB)
> w/2048KiB Cache, CHS=65535/16/63, UDMA(133)
> Feb 12 19:37:12 ruault kernel: hda: cache flushes supported
> Feb 12 19:37:12 ruault kernel:  hda: hda1 hda2 hda3 hda4 < hda5 hda6
> hda7 hda8 hda9 hda10 >
> Feb 12 19:37:12 ruault kernel: hdc: ATAPI 40X CD-ROM CD-R/RW drive,
> 2048kB Cache, DMA
> Feb 12 19:37:12 ruault kernel: Uniform CD-ROM driver Revision: 3.20
> Feb 12 19:37:12 ruault kernel: hdd: ATAPI 32X DVD-ROM DVD-R CD-R/RW
> drive, 2048kB Cache, UDMA(33)
> Feb 12 19:37:12 ruault kernel: ide-floppy driver 0.99.newide
> 
> 
> I'm also attaching my kernel config.
> 
> Let me know if you need anything else to troobleshoot the problem.
> Regards.
> 
> PS: i'm not on the list so please CC me when answering !
> Thanks
> 
> -- 
> Charles-Edouard Ruault
> PGP Key ID E4D2B80C
> 




Folkert van Heusden

-- 
www.vanheusden.com/multitail - multitail is tail on steroids. multiple
               windows, filtering, coloring, anything you can think of
----------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com
