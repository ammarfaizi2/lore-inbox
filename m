Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751030AbWEFRlP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751030AbWEFRlP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 May 2006 13:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751015AbWEFRlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 May 2006 13:41:15 -0400
Received: from anchor-post-32.mail.demon.net ([194.217.242.90]:42510 "EHLO
	anchor-post-32.mail.demon.net") by vger.kernel.org with ESMTP
	id S1751028AbWEFRlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 May 2006 13:41:13 -0400
Date: Sat, 06 May 2006 18:34:29 +0100
From: Darren Salt <linux@youmustbejoking.demon.co.uk>
To: akpm@osdl.org, linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: Re: Log flood: "scheduling while atomic" (2.6.15.x, 2.6.16.x) - backtrace captured
Message-ID: <4E22E030C9%linux@youmustbejoking.demon.co.uk>
References: <4E1F56DC10%linux@youmustbejoking.demon.co.uk> <20060429182220.0a306fe2.akpm@osdl.org> <4E227CE734%linux@youmustbejoking.demon.co.uk>
In-Reply-To: <4E227CE734%linux@youmustbejoking.demon.co.uk>
User-Agent: Messenger-Pro/4.09b8 (MsgServe/3.24b1) (RISC-OS/4.02) POPstar/2.06+cvs
Mail-Followup-To: linux@youmustbejoking.demon.co.uk,akpm@osdl.org,linux-kernel@vger.kernel.org,mingo@redhat.com
X-Editor: Zap 1.47 (27 Apr 2006) [TEST], ZapEmail 0.28.3 (25 Mar 2005) (32)
X-SDate: Sat, 4631 Sep 1993 18:34:29 +0100
X-Message-Flag: Outlook Express is broken. Upgrade to mail(1).
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1780299776--70334802--1344100325"
X-SA-Exim-Connect-IP: 192.168.0.2
X-SA-Exim-Mail-From: linux@youmustbejoking.demon.co.uk
X-SA-Exim-Scanned: No (on pentagram.youmustbejoking.demon.co.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format which your mailer apparently does not support.
You either require a newer version of your software which supports MIME, or
a separate MIME decoding utility.  Alternatively, ask the sender of this
message to resend it in a different format.

--1780299776--70334802--1344100325
Content-Type: text/plain; charset=us-ascii

[Cc'ing Ingo just in case]

I demand that I definitely did write...

> I demand that Andrew Morton may or may not have written...
>> Darren Salt <linux@youmustbejoking.demon.co.uk> wrote:
>>> I'm seeing bouts of log flooding caused by something presumably not
>>> releasing a lock. I've looked at some of the messages, but at around
>>> 100/s, I'm not too keen to look through the whole lot :-)
>>>    scheduling while atomic: swapper/0xafbfffff/0
>>>     [show_trace+19/32]
>>>     [dump_stack+30/32]
>>>     [schedule+1278/1472]
>>>     [cpu_idle+88/96]
> [snip]
>> Thanks for the report.

>> The below patch (against 2.6.17-rc3) should, if it still works, tell us
>> which lock didn't get unlocked.
> [snip Ingo's CONFIG_DEBUG_PREEMPT patch]

[snip]
> Since [two previous unrecorded crashes], I've had no problems, and I'd got
> this message queued for sending. With impeccable timing, the bug is
> triggered...

> Unfortunately, all that's been logged by the preempt debug code is this:

>   kernel BUG at lib/preempt.c:32!

WE HAVE A BACKTRACE.

I repeat, WE HAVE A BACKTRACE.

Attached:
  dmesg (with boring routine agpgart/drm me-playing-with-X bits removed)
  post-crash task log (looks truncated?)
  kernel config

The logging was done via netconsole.

Patches applied: CONFIG_DEBUG_PREEMPT, my USB mouse buttons hack, and the FP
exception fix which was posted to lkml. The mouse patch is attached for
completeness.

-- 
| Darren Salt    | linux or ds at              | nr. Ashington, | Toon
| RISC OS, Linux | youmustbejoking,demon,co,uk | Northumberland | Army
| + Use more efficient products. Use less.          BE MORE ENERGY EFFICIENT.

The time is right to make new friends.

--1780299776--70334802--1344100325
Content-Type: text/plain; charset=iso-8859-1; name="dmesg"
Content-Disposition: attachment; filename="dmesg"
Content-Transfer-Encoding: quoted-printable

Linux version 2.6.17-rc3 (root@flibble) (gcc version 4.0.3 (Debian 4.0.3-=
1)) #2 PREEMPT Tue May 2 18:17:40 BST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fff3000 (ACPI NVS)
 BIOS-e820: 000000000fff3000 - 0000000010000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
255MB LOWMEM available.
DMI 2.3 present.
Allocating PCI resources starting at 20000000 (gap: 10000000:efff0000)
Built 1 zonelists
Kernel command line: auto BOOT_IMAGE=3DLinux ro root=3D302 apic=3Dverbose=
 lapic netconsole=3D4444@192.168.0.5/eth0,4444@192.168.0.1/00:00:0e:b8:7e=
:06
netconsole: local port 4444
netconsole: local IP 192.168.0.5
netconsole: interface eth0
netconsole: remote port 4444
netconsole: remote IP 192.168.0.1
netconsole: remote ethernet address 00:00:0e:b8:7e:06
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 1024 (order: 10, 4096 bytes)
Detected 2008.944 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 255452k/262080k available (2550k kernel code, 6136k reserved, 884=
k data, 184k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... =
Ok.
Calibrating delay using timer specific routine.. 4023.75 BogoMIPS (lpj=3D=
8047506)
Security Framework v1.0.0 initialized
Capability LSM initialized
Mount-cache hash table entries: 512
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) XP 2400+ stepping 01
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
Freeing SMP alternatives: 0k freed
ACPI: setting ELCR to 0200 (from 1e00)
enabled ExtINT on CPU#0
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2008.2769 MHz.
..... host bus clock speed is 267.3302 MHz.
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfb470, last bus=3D1
Setting up standard PCI resources
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 13 devices
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=3Drouteirq".  If it helps, post a=
 report
PCI: Bridge: 0000:00:01.0
  IO window: c000-cfff
  MEM window: e4000000-e5ffffff
  PREFETCH window: d0000000-dfffffff
Machine check exception polling timer started.
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 12
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKA] -> GSI 12 (level, low)=
 -> IRQ 12
radeonfb: Found Intel x86 BIOS ROM Image
radeonfb: Retrieved PLL infos from BIOS
radeonfb: Reference=3D27.00 MHz (RefDiv=3D12) Memory=3D200.00 Mhz, System=
=3D166.00 MHz
radeonfb: PLL min 20000 max 40000
radeonfb: Monitor 1 type CRT found
radeonfb: EDID probed
radeonfb: Monitor 2 type no found
Console: switching to colour frame buffer device 160x64
radeonfb (0000:01:00.0): ATI Radeon Yd=20
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Fan [FAN] (on)
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: Thermal Zone [THRM] (33 C)
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected VIA KT266/KY266x/KT333 chipset
agpgart: AGP aperture is 64M @ 0xe0000000
[drm] Initialized drm 1.0.1 20051102
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKA] -> GSI 12 (level, low)=
 -> IRQ 12
[drm] Initialized radeon 1.24.0 20060225 on minor 0
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
8139too Fast Ethernet driver 0.9.27
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNKC] -> GSI 11 (level, low)=
 -> IRQ 11
eth0: RealTek RTL8139 at 0xd080e000, 00:30:bd:27:1c:75, IRQ 11
netconsole: device eth0 not up yet, forcing it
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
netconsole: carrier detect appears untrustworthy, waiting 4 seconds
netconsole: network logging started
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
VP_IDE: IDE controller at PCI slot 0000:00:11.1
ACPI: PCI Interrupt 0000:00:11.1[A] -> Link [LNKA] -> GSI 12 (level, low)=
 -> IRQ 12
PCI: Via IRQ fixup for 0000:00:11.1, from 255 to 12
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8233a (rev 00) IDE UDMA133 controller on pci0000:00:11.1
    ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:DMA, hdd:DMA
hda: ExcelStor Technology J360, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: PIONEER DVD-RW DVR-110D, ATAPI CD/DVD-ROM drive
hdd: SAMSUNG DVD-ROM SD-616Q, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 512KiB
hda: 120103200 sectors (61492 MB) w/1821KiB Cache, CHS=3D16383/255/63, UD=
MA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 hda10 >
hdc: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 2000kB Cache, UDMA(66)
Uniform CD-ROM driver Revision: 3.20
hdd: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
usbmon: debugfs is not available
PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
PNP: PS/2 controller doesn't have AUX irq; using default 12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
input: PC Speaker as /class/input/input0
input: AT Translated Set 2 keyboard as /class/input/input1
i2c /dev entries driver
w83627hf 9191-0290: Enabling temp2, readings might not make sense
Advanced Linux Sound Architecture Driver Version 1.0.11rc4 (Wed Mar 22 10=
:27:24 2006 UTC).
ALSA device list:
  No soundcards found.
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 3, 32768 bytes)
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 8192 bind 4096)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 184k freed
Linux video capture interface: v1.00
Serial: 8250/16550 driver $Revision: 1.90 $ 2 ports, IRQ sharing disabled=

serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
00:08: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
00:09: ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
ACPI: PCI Interrupt 0000:00:11.2[D] -> Link [LNKD] -> GSI 10 (level, low)=
 -> IRQ 10
uhci_hcd 0000:00:11.2: UHCI Host Controller
uhci_hcd 0000:00:11.2: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:11.2: irq 10, io base 0x0000e400
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
cx2388x dvb driver version 0.0.5 loaded
cx2388x v4l2 driver version 0.0.5 loaded
saa7146: register extension 'budget_ci dvb'.
ACPI: PCI Interrupt 0000:00:11.3[D] -> Link [LNKD] -> GSI 10 (level, low)=
 -> IRQ 10
uhci_hcd 0000:00:11.3: UHCI Host Controller
uhci_hcd 0000:00:11.3: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:11.3: irq 10, io base 0x0000e800
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:0c.0[A] -> Link [LNKA] -> GSI 12 (level, low)=
 -> IRQ 12
saa7146: found saa7146 @ mem d1912000 (revision 1, irq 12) (0x13c2,0x1011=
).
saa7146 (0): dma buffer size 192512
DVB: registering new adapter (TT-Budget/WinTV-NOVA-T	 PCI).
adapter has MAC addr =3D 00:d0:5c:22:1e:f2
input: Budget-CI dvb ir receiver saa7146 (0) as /class/input/input2
DVB: registering frontend 0 (Philips TDA10045H DVB-T)...
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:09.0[A] -> Link [LNKB] -> GSI 11 (level, low)=
 -> IRQ 11
CORE cx88[0]: subsystem: 0070:9002, board: Hauppauge Nova-T DVB-T [card=3D=
18,autodetected]
TV tuner 4 at 0x1fe, Radio tuner -1 at 0x1fe
usb 1-1: new low speed USB device using uhci_hcd and address 2
tveeprom 6-0050: Hauppauge model 90002, rev C176, serial# 406682
tveeprom 6-0050: MAC address is 00-0D-FE-06-34-9A
tveeprom 6-0050: tuner model is Thompson DTT7592 (idx 76, type 4)
usb 1-1: configuration #1 chosen from 1 choice
tveeprom 6-0050: TV standards ATSC/DVB Digital (eeprom 0x80)
tveeprom 6-0050: audio processor is None (idx 0)
tveeprom 6-0050: decoder processor is CX882 (idx 25)
tveeprom 6-0050: has no radio, has IR remote
cx88[0]: hauppauge eeprom: model=3D90002
input: cx88 IR (Hauppauge Nova-T DVB-T as /class/input/input3
cx88[0]/0: found at 0000:00:09.0, rev: 5, irq: 11, latency: 32, mmio: 0xe=
6000000
cx88[0]/0: registered device video0 [v4l2]
cx88[0]/0: registered device vbi0
ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [LNKA] -> GSI 12 (level, low)=
 -> IRQ 12
ACPI: PCI Interrupt 0000:00:11.5[C] -> Link [LNKC] -> GSI 11 (level, low)=
 -> IRQ 11
input: Wireless Mouse Wireless Mouse as /class/input/input4
input: USB HID v1.10 Mouse [Wireless Mouse Wireless Mouse] on usb-0000:00=
:11.2-1
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
ACPI: PCI Interrupt 0000:00:09.2[A] -> Link [LNKB] -> GSI 11 (level, low)=
 -> IRQ 11
cx88[0]/2: found at 0000:00:09.2, rev: 5, irq: 11, latency: 32, mmio: 0xe=
7000000
cx88[0]/2: cx2388x based dvb card
DVB: registering new adapter (cx88[0]).
DVB: registering frontend 1 (Conexant CX22702 DVB-T)...
cx2388x blackbird driver version 0.0.5 loaded
Adding 1004052k swap on /dev/hda3.  Priority:-1 extents:1 across:1004052k=

SCSI subsystem initialized
ACPI: PCI Interrupt 0000:00:0b.0[A] -> Link [LNKD] -> GSI 10 (level, low)=
 -> IRQ 10
scsi0 : AdvanSys SCSI 3.3K: PCI Ultra-Wide: PCIMEM 0xD18CA000-0xD18CA03F,=
 IRQ 0xA
NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory=

NFSD: starting 90-second grace period
tda1004x: found firmware revision 0 -- invalid
tda1004x: waiting for firmware upload (dvb-fe-tda10045.fw)...
tda1004x: firmware upload complete
tda1004x: found firmware revision 2c -- ok
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
[drm] Setting GART location based on old memory map
[drm] Loading R200 Microcode
[drm] writeback test succeeded in 1 usecs

[... more agpgart/drm stuff ...]

------------[ cut here ]------------
kernel BUG at lib/preempt.c:32!
invalid opcode: 0000 [#1]
PREEMPT=20
Modules linked in: snd_rtctimer eeprom sr_mod advansys scsi_mod cx88_blac=
kbird snd_emu10k1_synth snd_emux_synth snd_seq_virmidi snd_seq_midi_emul =
snd_seq_oss snd_seq_midi snd_seq_midi_event snd_seq usbhid snd_via82xx sn=
d_emu10k1 budget_ci tda1004x budget_core saa7146 ttpci_eeprom cx8800 cx88=
_dvb cx8802 cx88xx cx88_vp3054_i2c mt352 or51132 video_buf_dvb nxt200x fi=
rmware_class stv0299 dvb_core snd_ac97_codec snd_ac97_bus snd_mpu401_uart=
 uhci_hcd 8250_pnp 8250 serial_core ir_common video_buf tveeprom v4l2_com=
mon compat_ioctl32 v4l1_compat btcx_risc zl10353 cx24123 lgdt330x cx22702=
 dvb_pll stv0297 snd_rawmidi snd_pcm_oss snd_mixer_oss snd_pcm snd_seq_de=
vice snd_timer snd_page_alloc snd_util_mem videodev snd_hwdep
CPU:    0
EIP:    0060:[<c0214090>]    Not tainted VLI
EFLAGS: 00010002   (2.6.17-rc3 #2)=20
EIP is at add_preempt_count+0x50/0x60
eax: 00000001   ebx: c045c000   ecx: 0000007b   edx: afc10000
esi: 000000ff   edi: c0104ba0   ebp: c045de40   esp: c045de38
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=3Dc045c000 task=3Dc03dcac0)
Stack: <0>c045df08 00000000 c045de4c c012743e c045df08 c045df00 c0104c0c =
c048e5e0=20
       00000009 c045dee4 cf3ca298 00000004 00000000 00030002 c0214090 c04=
5dea4=20
       d191cdd7 cf3ca2a8 00ebce00 c6d24f5c c010641b 000002c0 cfe3c1f4 943=
7ded8=20
Call Trace:
 [<c0103f95>] show_stack_log_lvl+0xa5/0xf0
 [<c010420b>] show_registers+0x1bb/0x250
 [<c01044fd>] die+0x11d/0x2e0
 [<c010492f>] do_trap+0x8f/0xd0
 [<c0104c40>] do_invalid_op+0xa0/0xb0
 [<c01038db>] error_code+0x4f/0x54
 [<c012743e>] atomic_notifier_call_chain+0xe/0x50
 [<c0104c0c>] do_invalid_op+0x6c/0xb0
 [<c01038db>] error_code+0x4f/0x54
 [<c010f2d8>] smp_apic_timer_interrupt+0x28/0x50
 [<c0103834>] apic_timer_interrupt+0x1c/0x24
 [<c026153e>] acpi_processor_idle+0x14f/0x351
 [<c0101ab7>] cpu_idle+0x47/0x80
 [<c0100265>] _stext+0x45/0x50
 [<c045e76d>] start_kernel+0x26d/0x2f0
 [<c0100199>] 0xc0100199
---------------------------
| preempt count: afc10001 ]
| 1 level deep critical section nesting:
----------------------------------------
.. [<c0104425>] .... die+0x45/0x2e0
.....[<c010492f>] ..   ( <=3D do_trap+0x8f/0xd0)

Code: 77 29 83 fe 18 77 1b 8b 45 00 8b 13 8b 48 04 8b 45 04 89 84 b2 e8 0=
4 00 00 8b 03 89 8c b0 4c 05 00 00 8b 1c 24 8b 74 24 04 c9 c3 <0f> 0b 20 =
00 79 40 3a c0 eb cd 8d b6 00 00 00 00 55 b8 01 00 00=20
EIP: [<c0214090>] add_preempt_count+0x50/0x60 SS:ESP 0068:c045de38
 <0>Kernel panic - not syncing: Fatal exception in interrupt

--1780299776--70334802--1344100325
Content-Type: text/plain; charset=iso-8859-1; name="post-panic-sysrq-t"
Content-Disposition: attachment; filename="post-panic-sysrq-t"
Content-Transfer-Encoding: quoted-printable

 <6>SysRq : Show State

                                               sibling
  task             PC      pid father child younger older
init          S C013D778     0     1      0     2               (NOTLB)
       cffd5b38 00000002 c037b9fc c013d778 c123ee80 6a8a91cd 0000385f cff=
d4000=20
       00003b26 6abc8778 0000385f cffd3730 6abd50de 0000385f cffd4000 895=
b7e12=20
       00000000 c01234c8 c04984c8 cffd5b4c 00ebceac 0000000b cffd5b6c c03=
7b9fc=20
Call Trace:
 [<c037b9fc>] schedule_timeout+0x4c/0xc0
 [<c017115f>] do_select+0x3df/0x580
 [<c0171511>] core_sys_select+0x211/0x360
 [<c01719ad>] sys_select+0x3d/0x1d0
 [<c0102ddf>] sysenter_past_esp+0x54/0x75
---------------------------
| preempt count: 00000002 ]
| 2 level deep critical section nesting:
----------------------------------------
.. [<c037a9e5>] .... schedule+0x55/0x640
.....[<c037b9fc>] ..   ( <=3D schedule_timeout+0x4c/0xc0)
.. [<c037aa87>] .... schedule+0xf7/0x640
.....[<c037b9fc>] ..   ( <=3D schedule_timeout+0x4c/0xc0)

ksoftirqd/0   S C011EA1E     0     2      1             3       (L-TLB)
       cff85f9c 00000002 c011ed35 c011ea1e 00000000 1153abe3 00003860 cff=
84000=20
       0000089b ff7eeff9 0000385f cffd3170 1156429a 00003860 cff84000 118=
fe8e4=20
       00000000 cff84000 cffd5f34 cff84000 cff84000 cffd5f34 cff85fb4 c01=
1ed35=20
Call Trace:
 [<c011ed35>] ksoftirqd+0xd5/0xf0
 [<c012de79>] kthread+0xd9/0xe0
 [<c0100d65>] kernel_thread_helper+0x5/0x10
---------------------------
| preempt count: 00000002 ]
| 2 level deep critical section nesting:
----------------------------------------
.. [<c037a9e5>] .... schedule+0x55/0x640
.....[<c011ed35>] ..   ( <=3D ksoftirqd+0xd5/0xf0)
.. [<c037aa87>] .... schedule+0xf7/0x640
.....[<c011ed35>] ..   ( <=3D ksoftirqd+0xd5/0xf0)

watchdog/0    S C0105798     0     3      1             4     2 (L-TLB)
       cff87f98 00000002 c0138bc2 c0105798 cff86000 43c436a2 00003860 cff=
86000=20
       00000989 434a603a 00003860 cffd2bb0 43c44832 00003860 cff86000 090=
e1bb3=20
       00000000 0000007b c04984c8 cff86000 cff86000 cffd5f38 cff87fb4 c01=
38bc2=20
Call Trace:
 [<c0138bc2>] watchdog+0x52/0x70
 [<c012de79>] kthread+0xd9/0xe0
 [<c0100d65>] kernel_thread_helper+0x5/0x10
---------------------------
| preempt count: 00000002 ]
| 2 level deep critical section nesting:
----------------------------------------
.. [<c037a9e5>] .... schedule+0x55/0x640
.....[<c0138bc2>] ..   ( <=3D watchdog+0x52/0x70)
.. [<c037aa87>] .... schedule+0xf7/0x640
.....[<c0138bc2>] ..   ( <=3D watchdog+0x52/0x70)

events/0      R running     0     4      1             5     3 (L-TLB)
khelper       S 00000000     0     5      1             6     4 (L-TLB)
       cff99f64 00000002 c012a84f 00000000 cffe7aec fac8223a 0000382e cff=
98000=20
       00002057 c012a5a8 00000000 cffd2030 facdb25b 0000382e cff98000 019=
fdf32=20
       00000000 cff99f64 c012e2d1 cff98000 cffe7adc cffe7ae4 cff99fb4 c01=
2a84f=20
Call Trace:
 [<c012a84f>] worker_thread+0x13f/0x150
 [<c012de79>] kthread+0xd9/0xe0
 [<c0100d65>] kernel_thread_helper+0x5/0x10
---------------------------
| preempt count: 00000002 ]
| 2 level deep critical section nesting:
----------------------------------------
.. [<c037a9e5>] .... schedule+0x55/0x640
.....[<c012a84f>] ..   ( <=3D worker_thread+0x13f/0x150)
.. [<c037aa87>] .... schedule+0xf7/0x640
.....[<c012a84f>] ..   ( <=3D worker_thread+0x13f/0x150)

kthread       S 00000000     0     6      1     8     138     5 (L-TLB)
       cff9df64 00000002 c012a84f 00000000 cffe7b38 7b885199 000005fe cff=
9c000=20
       00000099 c012a5a8 00000000 cff9b750 7b9dfcb9 000005fe cff9c000 00a=
6ca09=20
       00000000 cff9df64 c012e2d1 cff9c000 cffe7b28 cffe7b30 cff9dfb4 c01=
2a84f=20
Call Trace:
 [<c012a84f>] worker_thread+0x13f/0x150
 [<c012de79>] kthread+0xd9/0xe0
 [<c0100d65>] kernel_thread_helper+0x5/0x10
---------------------------
| preempt count: 00000002 ]
| 2 level deep critical section nesting:
----------------------------------------
.. [<c037a9e5>] .... schedule+0x55/0x640
.....[<c012a84f>] ..   ( <=3D worker_thread+0x13f/0x150)
.. [<c037aa87>] .... schedule+0xf7/0x640
.....[<c012a84f>] ..   ( <=3D worker_thread+0x13f/0x150)

kblockd/0     S 00000000     0     8      6             9       (L-TLB)
       c124bf64 00000002 c012a84f 00000000 cffe7ec8 307c406e 0000385f c12=
4a000=20
       00001740 c012a5a8 00000000 699a93aa 000037f3 cc4f2000 54fe0476=20
       00000000 c01234c8 00000282 cc4f3b4c 02339aaf 00000002 cc4f3b6c c03=
7b9fc=20
Call Trace:
 [<c037b9fc>] schedule_timeout+0x4c/0xc0
 [<c017115f>] do_select+0x3df/0x580
 [<c0171511>] core_sys_select+0x211/0x360
 [<c01719ad>] sys_select+0x3d/0x1d0
 [<c0102ddf>] sysenter_past_esp+0x54/0x75
---------------------------
| preempt count: 00000002 ]
| 2 level deep critical section nesting:
----------------------------------------
.. [<c037a9e5>] .... schedule+0x55/0x640
.....[<c037b9fc>] ..   ( <=3D schedule_timeout+0x4c/0xc0)
.. [<c037aa87>] .... schedule+0xf7/0x640
.....[<c037b9fc>] ..   ( <=3D schedule_timeout+0x4c/0xc0)

inetd         S CC4EB578     0  1830      1          1840  1825 (NOTLB)
       cc4e9b38 00000002 c037ba25 cc4eb578 cc4e9b04 c275d748 0000323d cc4=
e8000=20
       00001550 cc4e9c5c cc4eb0bc cff0ec50 SysRq : Resetting

--1780299776--70334802--1344100325
Content-Type: text/plain; charset=iso-8859-1; name=".config"
Content-Disposition: attachment; filename=".config"
Content-Transfer-Encoding: quoted-printable

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.17-rc3
# Tue May  2 18:15:58 2006
#
CONFIG_X86_32=3Dy
CONFIG_SEMAPHORE_SLEEPERS=3Dy
CONFIG_X86=3Dy
CONFIG_MMU=3Dy
CONFIG_GENERIC_ISA_DMA=3Dy
CONFIG_GENERIC_IOMAP=3Dy
CONFIG_GENERIC_HWEIGHT=3Dy
CONFIG_ARCH_MAY_HAVE_PC_FDC=3Dy
CONFIG_DMI=3Dy

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=3Dy
CONFIG_BROKEN_ON_SMP=3Dy
CONFIG_LOCK_KERNEL=3Dy
CONFIG_INIT_ENV_ARG_LIMIT=3D32

#
# General setup
#
CONFIG_LOCALVERSION=3D""
# CONFIG_LOCALVERSION_AUTO is not set
CONFIG_SWAP=3Dy
CONFIG_SYSVIPC=3Dy
CONFIG_POSIX_MQUEUE=3Dy
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=3Dy
# CONFIG_AUDIT is not set
CONFIG_IKCONFIG=3Dy
CONFIG_IKCONFIG_PROC=3Dy
# CONFIG_RELAY is not set
CONFIG_INITRAMFS_SOURCE=3D""
CONFIG_UID16=3Dy
CONFIG_VM86=3Dy
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=3Dy
CONFIG_KALLSYMS_ALL=3Dy
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_HOTPLUG=3Dy
CONFIG_PRINTK=3Dy
CONFIG_BUG=3Dy
CONFIG_ELF_CORE=3Dy
CONFIG_BASE_FULL=3Dy
CONFIG_FUTEX=3Dy
CONFIG_EPOLL=3Dy
CONFIG_SHMEM=3Dy
CONFIG_SLAB=3Dy
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=3D0
# CONFIG_SLOB is not set

#
# Loadable module support
#
CONFIG_MODULES=3Dy
CONFIG_MODULE_UNLOAD=3Dy
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_KMOD=3Dy

#
# Block layer
#
# CONFIG_LBD is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
# CONFIG_LSF is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=3Dy
CONFIG_IOSCHED_AS=3Dy
CONFIG_IOSCHED_DEADLINE=3Dy
CONFIG_IOSCHED_CFQ=3Dy
CONFIG_DEFAULT_AS=3Dy
# CONFIG_DEFAULT_DEADLINE is not set
# CONFIG_DEFAULT_CFQ is not set
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED=3D"anticipatory"

#
# Processor type and features
#
# CONFIG_SMP is not set
CONFIG_X86_PC=3Dy
# CONFIG_X86_ELAN is not set
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
CONFIG_MK7=3Dy
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=3Dy
CONFIG_X86_XADD=3Dy
CONFIG_X86_L1_CACHE_SHIFT=3D6
CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy
CONFIG_GENERIC_CALIBRATE_DELAY=3Dy
CONFIG_X86_WP_WORKS_OK=3Dy
CONFIG_X86_INVLPG=3Dy
CONFIG_X86_BSWAP=3Dy
CONFIG_X86_POPAD_OK=3Dy
CONFIG_X86_CMPXCHG64=3Dy
CONFIG_X86_GOOD_APIC=3Dy
CONFIG_X86_INTEL_USERCOPY=3Dy
CONFIG_X86_USE_PPRO_CHECKSUM=3Dy
CONFIG_X86_USE_3DNOW=3Dy
CONFIG_X86_TSC=3Dy
# CONFIG_HPET_TIMER is not set
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=3Dy
CONFIG_PREEMPT_BKL=3Dy
CONFIG_X86_UP_APIC=3Dy
CONFIG_X86_UP_IOAPIC=3Dy
CONFIG_X86_LOCAL_APIC=3Dy
CONFIG_X86_IO_APIC=3Dy
CONFIG_X86_MCE=3Dy
CONFIG_X86_MCE_NONFATAL=3Dy
# CONFIG_X86_MCE_P4THERMAL is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_X86_REBOOTFIXUPS is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set

#
# Firmware Drivers
#
# CONFIG_EDD is not set
# CONFIG_DELL_RBU is not set
# CONFIG_DCDBAS is not set
CONFIG_NOHIGHMEM=3Dy
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
CONFIG_VMSPLIT_3G=3Dy
# CONFIG_VMSPLIT_3G_OPT is not set
# CONFIG_VMSPLIT_2G is not set
# CONFIG_VMSPLIT_1G is not set
CONFIG_PAGE_OFFSET=3D0xC0000000
CONFIG_ARCH_FLATMEM_ENABLE=3Dy
CONFIG_ARCH_SPARSEMEM_ENABLE=3Dy
CONFIG_ARCH_SELECT_MEMORY_MODEL=3Dy
CONFIG_SELECT_MEMORY_MODEL=3Dy
CONFIG_FLATMEM_MANUAL=3Dy
# CONFIG_DISCONTIGMEM_MANUAL is not set
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=3Dy
CONFIG_FLAT_NODE_MEM_MAP=3Dy
CONFIG_SPARSEMEM_STATIC=3Dy
CONFIG_SPLIT_PTLOCK_CPUS=3D4
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=3Dy
# CONFIG_EFI is not set
# CONFIG_REGPARM is not set
CONFIG_SECCOMP=3Dy
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=3Dy
# CONFIG_HZ_1000 is not set
CONFIG_HZ=3D250
# CONFIG_KEXEC is not set
CONFIG_PHYSICAL_START=3D0x100000

#
# Power management options (ACPI, APM)
#
CONFIG_PM=3Dy
CONFIG_PM_LEGACY=3Dy
# CONFIG_PM_DEBUG is not set
# CONFIG_SOFTWARE_SUSPEND is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=3Dy
# CONFIG_ACPI_SLEEP is not set
# CONFIG_ACPI_AC is not set
# CONFIG_ACPI_BATTERY is not set
CONFIG_ACPI_BUTTON=3Dy
CONFIG_ACPI_VIDEO=3Dy
# CONFIG_ACPI_HOTKEY is not set
CONFIG_ACPI_FAN=3Dy
CONFIG_ACPI_PROCESSOR=3Dy
CONFIG_ACPI_THERMAL=3Dy
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_IBM is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_CUSTOM_DSDT is not set
CONFIG_ACPI_BLACKLIST_YEAR=3D0
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_EC=3Dy
CONFIG_ACPI_POWER=3Dy
CONFIG_ACPI_SYSTEM=3Dy
CONFIG_X86_PM_TIMER=3Dy
# CONFIG_ACPI_CONTAINER is not set

#
# APM (Advanced Power Management) BIOS Support
#
# CONFIG_APM is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=3Dy
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=3Dy
CONFIG_PCI_BIOS=3Dy
CONFIG_PCI_DIRECT=3Dy
CONFIG_PCI_MMCONFIG=3Dy
# CONFIG_PCIEPORTBUS is not set
# CONFIG_PCI_MSI is not set
# CONFIG_PCI_DEBUG is not set
CONFIG_ISA_DMA_API=3Dy
# CONFIG_ISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set

#
# PCCARD (PCMCIA/CardBus) support
#
# CONFIG_PCCARD is not set

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=3Dy
# CONFIG_BINFMT_AOUT is not set
CONFIG_BINFMT_MISC=3Dm

#
# Networking
#
CONFIG_NET=3Dy

#
# Networking options
#
# CONFIG_NETDEBUG is not set
CONFIG_PACKET=3Dy
CONFIG_PACKET_MMAP=3Dy
CONFIG_UNIX=3Dy
# CONFIG_NET_KEY is not set
CONFIG_INET=3Dy
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_FIB_HASH=3Dy
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_ARPD is not set
CONFIG_SYN_COOKIES=3Dy
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_XFRM_TUNNEL is not set
# CONFIG_INET_TUNNEL is not set
CONFIG_INET_DIAG=3Dy
CONFIG_INET_TCP_DIAG=3Dy
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_BIC=3Dy
# CONFIG_IPV6 is not set
# CONFIG_INET6_XFRM_TUNNEL is not set
# CONFIG_INET6_TUNNEL is not set
# CONFIG_NETFILTER is not set

#
# DCCP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_DCCP is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set

#
# TIPC Configuration (EXPERIMENTAL)
#
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
# CONFIG_IEEE80211 is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
# CONFIG_STANDALONE is not set
CONFIG_PREVENT_FIRMWARE_BUILD=3Dy
CONFIG_FW_LOADER=3Dm
# CONFIG_DEBUG_DRIVER is not set

#
# Connector - unified userspace <-> kernelspace linker
#
# CONFIG_CONNECTOR is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=3Dy
CONFIG_PARPORT_PC=3Dy
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=3Dy
CONFIG_PARPORT_PC_SUPERIO=3Dy
# CONFIG_PARPORT_GSC is not set
CONFIG_PARPORT_1284=3Dy

#
# Plug and Play support
#
CONFIG_PNP=3Dy
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
CONFIG_PNPACPI=3Dy

#
# Block devices
#
CONFIG_BLK_DEV_FD=3Dy
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=3Dm
CONFIG_BLK_DEV_CRYPTOLOOP=3Dm
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_UB is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_BLK_DEV_INITRD is not set
CONFIG_CDROM_PKTCDVD=3Dy
CONFIG_CDROM_PKTCDVD_BUFFERS=3D8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
# CONFIG_ATA_OVER_ETH is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=3Dy
CONFIG_BLK_DEV_IDE=3Dy

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=3Dy
CONFIG_IDEDISK_MULTI_MODE=3Dy
CONFIG_BLK_DEV_IDECD=3Dy
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
# CONFIG_IDE_GENERIC is not set
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEPCI=3Dy
# CONFIG_IDEPCI_SHARE_IRQ is not set
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_GENERIC is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=3Dy
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=3Dy
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_CS5535 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_IT821X is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=3Dy
# CONFIG_IDE_ARM is not set
CONFIG_BLK_DEV_IDEDMA=3Dy
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=3Dy
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=3Dm
CONFIG_SCSI_PROC_FS=3Dy

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=3Dm
CONFIG_CHR_DEV_ST=3Dm
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=3Dm
CONFIG_BLK_DEV_SR_VENDOR=3Dy
CONFIG_CHR_DEV_SG=3Dm
# CONFIG_CHR_DEV_SCH is not set

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
CONFIG_SCSI_CONSTANTS=3Dy
# CONFIG_SCSI_LOGGING is not set

#
# SCSI Transport Attributes
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
# CONFIG_SCSI_SAS_ATTRS is not set

#
# SCSI low-level drivers
#
# CONFIG_ISCSI_TCP is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_DPT_I2O is not set
CONFIG_SCSI_ADVANSYS=3Dm
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
# CONFIG_SCSI_SATA is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_SPI is not set
# CONFIG_FUSION_FC is not set
# CONFIG_FUSION_SAS is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Network device support
#
CONFIG_NETDEVICES=3Dy
CONFIG_DUMMY=3Dm
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_NET_SB1000 is not set

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# PHY device support
#
# CONFIG_PHYLIB is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=3Dy
CONFIG_MII=3Dy
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NET_VENDOR_3COM is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_HP100 is not set
CONFIG_NET_PCI=3Dy
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_B44 is not set
# CONFIG_FORCEDETH is not set
# CONFIG_DGRS is not set
# CONFIG_EEPRO100 is not set
# CONFIG_E100 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_8139CP is not set
CONFIG_8139TOO=3Dy
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
# CONFIG_8139_OLD_RX_RESET is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SIS190 is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_SK98LIN is not set
# CONFIG_VIA_VELOCITY is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_CHELSIO_T1 is not set
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set
# CONFIG_SHAPER is not set
CONFIG_NETCONSOLE=3Dy
CONFIG_NETPOLL=3Dy
# CONFIG_NETPOLL_RX is not set
# CONFIG_NETPOLL_TRAP is not set
CONFIG_NET_POLL_CONTROLLER=3Dy

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=3Dy

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=3Dy
CONFIG_INPUT_MOUSEDEV_PSAUX=3Dy
CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1280
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D1024
CONFIG_INPUT_JOYDEV=3Dm
# CONFIG_INPUT_TSDEV is not set
CONFIG_INPUT_EVDEV=3Dy
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=3Dy
CONFIG_KEYBOARD_ATKBD=3Dy
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=3Dy
CONFIG_MOUSE_PS2=3Dy
CONFIG_MOUSE_SERIAL=3Dm
# CONFIG_MOUSE_VSXXXAA is not set
CONFIG_INPUT_JOYSTICK=3Dy
# CONFIG_JOYSTICK_ANALOG is not set
# CONFIG_JOYSTICK_A3D is not set
# CONFIG_JOYSTICK_ADI is not set
# CONFIG_JOYSTICK_COBRA is not set
# CONFIG_JOYSTICK_GF2K is not set
# CONFIG_JOYSTICK_GRIP is not set
# CONFIG_JOYSTICK_GRIP_MP is not set
# CONFIG_JOYSTICK_GUILLEMOT is not set
# CONFIG_JOYSTICK_INTERACT is not set
# CONFIG_JOYSTICK_SIDEWINDER is not set
# CONFIG_JOYSTICK_TMDC is not set
# CONFIG_JOYSTICK_IFORCE is not set
# CONFIG_JOYSTICK_WARRIOR is not set
# CONFIG_JOYSTICK_MAGELLAN is not set
# CONFIG_JOYSTICK_SPACEORB is not set
# CONFIG_JOYSTICK_SPACEBALL is not set
# CONFIG_JOYSTICK_STINGER is not set
# CONFIG_JOYSTICK_TWIDJOY is not set
CONFIG_JOYSTICK_DB9=3Dm
# CONFIG_JOYSTICK_GAMECON is not set
# CONFIG_JOYSTICK_TURBOGRAFX is not set
# CONFIG_JOYSTICK_JOYDUMP is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=3Dy
CONFIG_INPUT_PCSPKR=3Dy
# CONFIG_INPUT_WISTRON_BTNS is not set
# CONFIG_INPUT_UINPUT is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=3Dy
CONFIG_SERIO_I8042=3Dy
CONFIG_SERIO_SERPORT=3Dm
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=3Dy
# CONFIG_SERIO_RAW is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_VT=3Dy
CONFIG_VT_CONSOLE=3Dy
CONFIG_HW_CONSOLE=3Dy
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=3Dm
CONFIG_SERIAL_8250_PCI=3Dm
CONFIG_SERIAL_8250_PNP=3Dm
CONFIG_SERIAL_8250_NR_UARTS=3D4
CONFIG_SERIAL_8250_RUNTIME_UARTS=3D2
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=3Dm
# CONFIG_SERIAL_JSM is not set
CONFIG_UNIX98_PTYS=3Dy
# CONFIG_LEGACY_PTYS is not set
CONFIG_PRINTER=3Dm
# CONFIG_LP_CONSOLE is not set
# CONFIG_PPDEV is not set
# CONFIG_TIPAR is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_HW_RANDOM is not set
# CONFIG_NVRAM is not set
CONFIG_RTC=3Dy
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=3Dy
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_ATI is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD64 is not set
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
CONFIG_AGP_VIA=3Dy
# CONFIG_AGP_EFFICEON is not set
CONFIG_DRM=3Dy
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_R128 is not set
CONFIG_DRM_RADEON=3Dy
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_SIS is not set
# CONFIG_DRM_VIA is not set
# CONFIG_DRM_SAVAGE is not set
# CONFIG_MWAVE is not set
# CONFIG_CS5535_GPIO is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HPET is not set
# CONFIG_HANGCHECK_TIMER is not set

#
# TPM devices
#
# CONFIG_TCG_TPM is not set
# CONFIG_TELCLOCK is not set

#
# I2C support
#
CONFIG_I2C=3Dy
CONFIG_I2C_CHARDEV=3Dy

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=3Dy
# CONFIG_I2C_ALGOPCF is not set
# CONFIG_I2C_ALGOPCA is not set

#
# I2C Hardware Bus support
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_I810 is not set
# CONFIG_I2C_PIIX4 is not set
CONFIG_I2C_ISA=3Dy
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_PARPORT is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_PROSAVAGE is not set
# CONFIG_I2C_SAVAGE4 is not set
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_STUB is not set
# CONFIG_I2C_VIA is not set
CONFIG_I2C_VIAPRO=3Dy
# CONFIG_I2C_VOODOO3 is not set
# CONFIG_I2C_PCA_ISA is not set

#
# Miscellaneous I2C Chip support
#
# CONFIG_SENSORS_DS1337 is not set
# CONFIG_SENSORS_DS1374 is not set
CONFIG_SENSORS_EEPROM=3Dm
# CONFIG_SENSORS_PCF8574 is not set
# CONFIG_SENSORS_PCA9539 is not set
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_SENSORS_MAX6875 is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set

#
# SPI support
#
# CONFIG_SPI is not set
# CONFIG_SPI_MASTER is not set

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

#
# Hardware Monitoring support
#
CONFIG_HWMON=3Dy
CONFIG_HWMON_VID=3Dy
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ADM1025 is not set
# CONFIG_SENSORS_ADM1026 is not set
# CONFIG_SENSORS_ADM1031 is not set
# CONFIG_SENSORS_ADM9240 is not set
# CONFIG_SENSORS_ASB100 is not set
# CONFIG_SENSORS_ATXP1 is not set
# CONFIG_SENSORS_DS1621 is not set
# CONFIG_SENSORS_F71805F is not set
# CONFIG_SENSORS_FSCHER is not set
# CONFIG_SENSORS_FSCPOS is not set
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_GL520SM is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_LM63 is not set
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM77 is not set
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_LM80 is not set
# CONFIG_SENSORS_LM83 is not set
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM87 is not set
# CONFIG_SENSORS_LM90 is not set
# CONFIG_SENSORS_LM92 is not set
# CONFIG_SENSORS_MAX1619 is not set
# CONFIG_SENSORS_PC87360 is not set
# CONFIG_SENSORS_SIS5595 is not set
# CONFIG_SENSORS_SMSC47M1 is not set
# CONFIG_SENSORS_SMSC47B397 is not set
# CONFIG_SENSORS_VIA686A is not set
# CONFIG_SENSORS_VT8231 is not set
# CONFIG_SENSORS_W83781D is not set
# CONFIG_SENSORS_W83792D is not set
# CONFIG_SENSORS_W83L785TS is not set
CONFIG_SENSORS_W83627HF=3Dy
# CONFIG_SENSORS_W83627EHF is not set
# CONFIG_SENSORS_HDAPS is not set
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Misc devices
#
# CONFIG_IBM_ASM is not set

#
# Multimedia devices
#
CONFIG_VIDEO_DEV=3Dm

#
# Video For Linux
#

#
# Video Adapters
#
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_BT848 is not set
# CONFIG_VIDEO_BWQCAM is not set
# CONFIG_VIDEO_CQCAM is not set
# CONFIG_VIDEO_W9966 is not set
# CONFIG_VIDEO_CPIA is not set
# CONFIG_VIDEO_CPIA2 is not set
# CONFIG_VIDEO_SAA5246A is not set
# CONFIG_VIDEO_SAA5249 is not set
# CONFIG_TUNER_3036 is not set
# CONFIG_VIDEO_STRADIS is not set
# CONFIG_VIDEO_ZORAN is not set
# CONFIG_VIDEO_SAA7134 is not set
# CONFIG_VIDEO_MXB is not set
# CONFIG_VIDEO_DPC is not set
# CONFIG_VIDEO_HEXIUM_ORION is not set
# CONFIG_VIDEO_HEXIUM_GEMINI is not set
CONFIG_VIDEO_CX88_VP3054=3Dm
CONFIG_VIDEO_CX88=3Dm
# CONFIG_VIDEO_CX88_ALSA is not set
CONFIG_VIDEO_CX88_DVB=3Dm
CONFIG_VIDEO_CX88_DVB_ALL_FRONTENDS=3Dy
# CONFIG_VIDEO_OVCAMCHIP is not set

#
# Encoders and Decoders
#
# CONFIG_VIDEO_MSP3400 is not set
# CONFIG_VIDEO_CS53L32A is not set
# CONFIG_VIDEO_WM8775 is not set
# CONFIG_VIDEO_WM8739 is not set
# CONFIG_VIDEO_CX25840 is not set
# CONFIG_VIDEO_SAA711X is not set
# CONFIG_VIDEO_SAA7127 is not set
# CONFIG_VIDEO_UPD64031A is not set
# CONFIG_VIDEO_UPD64083 is not set

#
# V4L USB devices
#
# CONFIG_VIDEO_EM28XX is not set
# CONFIG_USB_DSBR is not set
# CONFIG_USB_VICAM is not set
# CONFIG_USB_IBMCAM is not set
# CONFIG_USB_KONICAWC is not set
# CONFIG_USB_ET61X251 is not set
# CONFIG_USB_OV511 is not set
# CONFIG_USB_SE401 is not set
# CONFIG_USB_SN9C102 is not set
# CONFIG_USB_STV680 is not set
# CONFIG_USB_W9968CF is not set
# CONFIG_USB_ZC0301 is not set
# CONFIG_USB_PWC is not set

#
# Radio Adapters
#
# CONFIG_RADIO_GEMTEK_PCI is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_MAESTRO is not set

#
# Digital Video Broadcasting Devices
#
CONFIG_DVB=3Dy
CONFIG_DVB_CORE=3Dm

#
# Supported SAA7146 based PCI Adapters
#
# CONFIG_DVB_AV7110 is not set
# CONFIG_DVB_BUDGET is not set
CONFIG_DVB_BUDGET_CI=3Dm
# CONFIG_DVB_BUDGET_AV is not set

#
# Supported USB Adapters
#
# CONFIG_DVB_USB is not set
# CONFIG_DVB_TTUSB_BUDGET is not set
# CONFIG_DVB_TTUSB_DEC is not set
# CONFIG_DVB_CINERGYT2 is not set

#
# Supported FlexCopII (B2C2) Adapters
#
# CONFIG_DVB_B2C2_FLEXCOP is not set

#
# Supported BT878 Adapters
#

#
# Supported Pluto2 Adapters
#
# CONFIG_DVB_PLUTO2 is not set

#
# Supported DVB Frontends
#

#
# Customise DVB Frontends
#

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_STV0299=3Dm
# CONFIG_DVB_CX24110 is not set
CONFIG_DVB_CX24123=3Dm
# CONFIG_DVB_TDA8083 is not set
# CONFIG_DVB_MT312 is not set
# CONFIG_DVB_VES1X93 is not set
# CONFIG_DVB_S5H1420 is not set

#
# DVB-T (terrestrial) frontends
#
# CONFIG_DVB_SP8870 is not set
# CONFIG_DVB_SP887X is not set
# CONFIG_DVB_CX22700 is not set
CONFIG_DVB_CX22702=3Dm
# CONFIG_DVB_L64781 is not set
CONFIG_DVB_TDA1004X=3Dm
# CONFIG_DVB_NXT6000 is not set
CONFIG_DVB_MT352=3Dm
CONFIG_DVB_ZL10353=3Dm
# CONFIG_DVB_DIB3000MB is not set
# CONFIG_DVB_DIB3000MC is not set

#
# DVB-C (cable) frontends
#
# CONFIG_DVB_VES1820 is not set
# CONFIG_DVB_TDA10021 is not set
CONFIG_DVB_STV0297=3Dm

#
# ATSC (North American/Korean Terresterial DTV) frontends
#
CONFIG_DVB_NXT200X=3Dm
# CONFIG_DVB_OR51211 is not set
CONFIG_DVB_OR51132=3Dm
# CONFIG_DVB_BCM3510 is not set
CONFIG_DVB_LGDT330X=3Dm
CONFIG_VIDEO_SAA7146=3Dm
CONFIG_VIDEO_TUNER=3Dm
CONFIG_VIDEO_BUF=3Dm
CONFIG_VIDEO_BUF_DVB=3Dm
CONFIG_VIDEO_BTCX=3Dm
CONFIG_VIDEO_IR=3Dm
CONFIG_VIDEO_TVEEPROM=3Dm
# CONFIG_USB_DABUSB is not set

#
# Graphics support
#
CONFIG_FB=3Dy
CONFIG_FB_CFB_FILLRECT=3Dy
CONFIG_FB_CFB_COPYAREA=3Dy
CONFIG_FB_CFB_IMAGEBLIT=3Dy
# CONFIG_FB_MACMODES is not set
# CONFIG_FB_FIRMWARE_EDID is not set
CONFIG_FB_MODE_HELPERS=3Dy
# CONFIG_FB_TILEBLITTING is not set
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_VESA is not set
CONFIG_VIDEO_SELECT=3Dy
# CONFIG_FB_HGA is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I810 is not set
# CONFIG_FB_INTEL is not set
# CONFIG_FB_MATROX is not set
CONFIG_FB_RADEON=3Dy
CONFIG_FB_RADEON_I2C=3Dy
# CONFIG_FB_RADEON_DEBUG is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_CYBLA is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_GEODE is not set
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=3Dy
# CONFIG_VGACON_SOFT_SCROLLBACK is not set
CONFIG_DUMMY_CONSOLE=3Dy
CONFIG_FRAMEBUFFER_CONSOLE=3Dy
# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
CONFIG_FONTS=3Dy
CONFIG_FONT_8x8=3Dy
CONFIG_FONT_8x16=3Dy
# CONFIG_FONT_6x11 is not set
# CONFIG_FONT_7x14 is not set
# CONFIG_FONT_PEARL_8x8 is not set
# CONFIG_FONT_ACORN_8x8 is not set
# CONFIG_FONT_MINI_4x6 is not set
# CONFIG_FONT_SUN8x16 is not set
# CONFIG_FONT_SUN12x22 is not set
# CONFIG_FONT_10x18 is not set

#
# Logo configuration
#
CONFIG_LOGO=3Dy
CONFIG_LOGO_LINUX_MONO=3Dy
CONFIG_LOGO_LINUX_VGA16=3Dy
CONFIG_LOGO_LINUX_CLUT224=3Dy
# CONFIG_BACKLIGHT_LCD_SUPPORT is not set

#
# Sound
#
CONFIG_SOUND=3Dy

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=3Dy
CONFIG_SND_TIMER=3Dm
CONFIG_SND_PCM=3Dm
CONFIG_SND_HWDEP=3Dm
CONFIG_SND_RAWMIDI=3Dm
CONFIG_SND_SEQUENCER=3Dm
# CONFIG_SND_SEQ_DUMMY is not set
CONFIG_SND_OSSEMUL=3Dy
CONFIG_SND_MIXER_OSS=3Dm
CONFIG_SND_PCM_OSS=3Dm
CONFIG_SND_PCM_OSS_PLUGINS=3Dy
CONFIG_SND_SEQUENCER_OSS=3Dy
CONFIG_SND_RTCTIMER=3Dm
CONFIG_SND_SEQ_RTCTIMER_DEFAULT=3Dy
# CONFIG_SND_DYNAMIC_MINORS is not set
CONFIG_SND_SUPPORT_OLD_API=3Dy
# CONFIG_SND_VERBOSE_PROCFS is not set
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
CONFIG_SND_MPU401_UART=3Dm
CONFIG_SND_AC97_CODEC=3Dm
CONFIG_SND_AC97_BUS=3Dm
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_VIRMIDI is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set

#
# PCI devices
#
# CONFIG_SND_AD1889 is not set
# CONFIG_SND_ALS300 is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CA0106 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS5535AUDIO is not set
CONFIG_SND_EMU10K1=3Dm
# CONFIG_SND_EMU10K1X is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_HDA_INTEL is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_HDSPM is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_INTEL8X0M is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_PCXHR is not set
# CONFIG_SND_RIPTIDE is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_TRIDENT is not set
CONFIG_SND_VIA82XX=3Dm
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VX222 is not set
# CONFIG_SND_YMFPCI is not set

#
# USB devices
#
# CONFIG_SND_USB_AUDIO is not set
# CONFIG_SND_USB_USX2Y is not set

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
CONFIG_USB_ARCH_HAS_HCD=3Dy
CONFIG_USB_ARCH_HAS_OHCI=3Dy
CONFIG_USB_ARCH_HAS_EHCI=3Dy
CONFIG_USB=3Dy
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=3Dy
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_SUSPEND is not set
# CONFIG_USB_OTG is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_EHCI_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_UHCI_HCD=3Dm
# CONFIG_USB_SL811_HCD is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
#

#
# may also be needed; see USB_STORAGE Help for more information
#
CONFIG_USB_STORAGE=3Dm
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_USBAT is not set
CONFIG_USB_STORAGE_SDDR09=3Dy
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_LIBUSUAL is not set

#
# USB Input Devices
#
CONFIG_USB_HID=3Dm
CONFIG_USB_HIDINPUT=3Dy
# CONFIG_USB_HIDINPUT_POWERBOOK is not set
# CONFIG_HID_FF is not set
# CONFIG_USB_HIDDEV is not set

#
# USB HID Boot Protocol drivers
#
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_ACECAD is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_TOUCHSCREEN is not set
# CONFIG_USB_YEALINK is not set
# CONFIG_USB_XPAD is not set
# CONFIG_USB_ATI_REMOTE is not set
# CONFIG_USB_ATI_REMOTE2 is not set
# CONFIG_USB_KEYSPAN_REMOTE is not set
# CONFIG_USB_APPLETOUCH is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set

#
# USB Network Adapters
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set
CONFIG_USB_MON=3Dy

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_PHIDGETKIT is not set
# CONFIG_USB_PHIDGETSERVO is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TEST is not set

#
# USB DSL modem support
#

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# MMC/SD Card support
#
# CONFIG_MMC is not set

#
# LED devices
#
# CONFIG_NEW_LEDS is not set

#
# LED drivers
#

#
# LED Triggers
#

#
# InfiniBand support
#
# CONFIG_INFINIBAND is not set

#
# EDAC - error detection and reporting (RAS) (EXPERIMENTAL)
#
# CONFIG_EDAC is not set

#
# Real Time Clock
#
# CONFIG_RTC_CLASS is not set

#
# File systems
#
CONFIG_EXT2_FS=3Dy
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT2_FS_XIP is not set
# CONFIG_EXT3_FS is not set
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_FS_POSIX_ACL=3Dy
# CONFIG_XFS_FS is not set
# CONFIG_OCFS2_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_INOTIFY=3Dy
# CONFIG_QUOTA is not set
CONFIG_DNOTIFY=3Dy
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
# CONFIG_FUSE_FS is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=3Dm
CONFIG_JOLIET=3Dy
# CONFIG_ZISOFS is not set
CONFIG_UDF_FS=3Dm
CONFIG_UDF_NLS=3Dy

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=3Dm
CONFIG_MSDOS_FS=3Dm
CONFIG_VFAT_FS=3Dm
CONFIG_FAT_DEFAULT_CODEPAGE=3D437
CONFIG_FAT_DEFAULT_IOCHARSET=3D"iso8859-1"
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=3Dy
CONFIG_PROC_KCORE=3Dy
CONFIG_SYSFS=3Dy
CONFIG_TMPFS=3Dy
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=3Dy
# CONFIG_CONFIGFS_FS is not set

#
# Miscellaneous filesystems
#
CONFIG_ADFS_FS=3Dm
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
CONFIG_NFS_FS=3Dy
CONFIG_NFS_V3=3Dy
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=3Dy
# CONFIG_NFS_DIRECTIO is not set
CONFIG_NFSD=3Dy
CONFIG_NFSD_V3=3Dy
# CONFIG_NFSD_V3_ACL is not set
CONFIG_NFSD_V4=3Dy
CONFIG_NFSD_TCP=3Dy
CONFIG_LOCKD=3Dy
CONFIG_LOCKD_V4=3Dy
CONFIG_EXPORTFS=3Dy
CONFIG_NFS_COMMON=3Dy
CONFIG_SUNRPC=3Dy
CONFIG_SUNRPC_GSS=3Dy
CONFIG_RPCSEC_GSS_KRB5=3Dy
# CONFIG_RPCSEC_GSS_SPKM3 is not set
CONFIG_SMB_FS=3Dm
CONFIG_SMB_NLS_DEFAULT=3Dy
CONFIG_SMB_NLS_REMOTE=3D"iso8859-1"
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=3Dy

#
# Native Language Support
#
CONFIG_NLS=3Dy
CONFIG_NLS_DEFAULT=3D"iso8859-1"
CONFIG_NLS_CODEPAGE_437=3Dm
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=3Dm
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
# CONFIG_NLS_ASCII is not set
CONFIG_NLS_ISO8859_1=3Dy
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=3Dy

#
# Instrumentation Support
#
# CONFIG_PROFILING is not set
# CONFIG_KPROBES is not set

#
# Kernel hacking
#
# CONFIG_PRINTK_TIME is not set
CONFIG_MAGIC_SYSRQ=3Dy
CONFIG_DEBUG_KERNEL=3Dy
CONFIG_LOG_BUF_SHIFT=3D14
CONFIG_DETECT_SOFTLOCKUP=3Dy
# CONFIG_SCHEDSTATS is not set
CONFIG_DEBUG_SLAB=3Dy
# CONFIG_DEBUG_SLAB_LEAK is not set
CONFIG_DEBUG_PREEMPT=3Dy
CONFIG_DEBUG_MUTEXES=3Dy
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=3Dy
# CONFIG_DEBUG_INFO is not set
# CONFIG_DEBUG_FS is not set
# CONFIG_DEBUG_VM is not set
CONFIG_FRAME_POINTER=3Dy
# CONFIG_UNWIND_INFO is not set
CONFIG_FORCED_INLINING=3Dy
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_EARLY_PRINTK=3Dy
CONFIG_DEBUG_STACKOVERFLOW=3Dy
# CONFIG_DEBUG_STACK_USAGE is not set
CONFIG_STACK_BACKTRACE_COLS=3D1
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_DEBUG_RODATA is not set
# CONFIG_4KSTACKS is not set
CONFIG_X86_FIND_SMP_CONFIG=3Dy
CONFIG_X86_MPPARSE=3Dy
CONFIG_DOUBLEFAULT=3Dy

#
# Security options
#
# CONFIG_KEYS is not set
CONFIG_SECURITY=3Dy
# CONFIG_SECURITY_NETWORK is not set
CONFIG_SECURITY_CAPABILITIES=3Dy
# CONFIG_SECURITY_ROOTPLUG is not set
# CONFIG_SECURITY_SECLVL is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=3Dy
CONFIG_CRYPTO_HMAC=3Dy
CONFIG_CRYPTO_NULL=3Dm
CONFIG_CRYPTO_MD4=3Dm
CONFIG_CRYPTO_MD5=3Dy
CONFIG_CRYPTO_SHA1=3Dm
CONFIG_CRYPTO_SHA256=3Dm
CONFIG_CRYPTO_SHA512=3Dm
CONFIG_CRYPTO_WP512=3Dm
CONFIG_CRYPTO_TGR192=3Dm
CONFIG_CRYPTO_DES=3Dy
CONFIG_CRYPTO_BLOWFISH=3Dm
CONFIG_CRYPTO_TWOFISH=3Dm
CONFIG_CRYPTO_SERPENT=3Dm
CONFIG_CRYPTO_AES=3Dm
CONFIG_CRYPTO_AES_586=3Dm
CONFIG_CRYPTO_CAST5=3Dm
CONFIG_CRYPTO_CAST6=3Dm
CONFIG_CRYPTO_TEA=3Dm
CONFIG_CRYPTO_ARC4=3Dm
CONFIG_CRYPTO_KHAZAD=3Dm
CONFIG_CRYPTO_ANUBIS=3Dm
CONFIG_CRYPTO_DEFLATE=3Dm
CONFIG_CRYPTO_MICHAEL_MIC=3Dm
CONFIG_CRYPTO_CRC32C=3Dm
# CONFIG_CRYPTO_TEST is not set

#
# Hardware crypto devices
#
# CONFIG_CRYPTO_DEV_PADLOCK is not set

#
# Library routines
#
CONFIG_CRC_CCITT=3Dm
# CONFIG_CRC16 is not set
CONFIG_CRC32=3Dy
CONFIG_LIBCRC32C=3Dm
CONFIG_ZLIB_INFLATE=3Dm
CONFIG_ZLIB_DEFLATE=3Dm
CONFIG_GENERIC_HARDIRQS=3Dy
CONFIG_GENERIC_IRQ_PROBE=3Dy
CONFIG_X86_BIOS_REBOOT=3Dy
CONFIG_KTIME_SCALAR=3Dy

--1780299776--70334802--1344100325
Content-Type: application/gzip; name="chic-browser-mouse-buttons-hack.patch.gz"
Content-Disposition: attachment; filename="chic-browser-mouse-buttons-hack.patch.gz"
Content-Transfer-Encoding: base64

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
AA==

--1780299776--70334802--1344100325--
