Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267625AbUJHAMR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267625AbUJHAMR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 20:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269853AbUJHAJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 20:09:40 -0400
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:8362
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S269952AbUJGX7J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 19:59:09 -0400
Date: Thu, 7 Oct 2004 20:06:37 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Adaptec drivers and 2.6.x kernels
Message-ID: <20041008000637.GA24588@animx.eu.org>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <20041007222709.GA24314@animx.eu.org> <20041007224927.GZ9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041007224927.GZ9106@holomorphy.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I've been irritated with this for some time now.  I've seen this with 2.6.7
> > and 2.6.8.1 with both aic7xxx and aic79xx drivers.
> > I have a bad CD (I burned it as fast as my burner could force.  I expected
> > errors).  The scsi drivers do not handle errors very well.  I tried to read
> > this bad cd on an ide cdrom (I have 2 one on hda and one on hdd), it just
> > gives up with a read error.  If I do this on scd0 or scd1 (scd0 is an LG DVD
> > multi burner using an acard u2w scsi to udma66 converter, scd1 is a plextor
> > cdrw 40/12/40 narrow scsi), then the driver offlines the drive and I can't
> > use it anymore.
> > With this problem, the device recovered with scd1.  It was a simple:
> > cd /proc/scsi
> > echo "scsi remove-single-device 2 0 1 0" > scsi
> > echo "scsi add-single-device 2 0 1 0" > scsi
> > And it now works again.  Sometimes it doesn't.  scsi bus 0 and 1 are on the
> > aic79xx [...]
> 
> I have boxen with aic7xxx and aic79xx that don't see issues of this
> kind (granted, with bleeding edge -mm). Could you describe the systems
> in more detail?

What I described was a single system.  See descriptions below, what else will
I need to provide?

Motherboard: Supermicro X5DA8 (Intel E7505 chipset, dual channel adaptec
u320 aic7902B rev10)
Processors: 2x 2.66ghz P4 Xeon (HT disabled)
Memory: 2x 512mb DDR333 ECC memory (Supermicro approved)
Scsi bus 0: Controller AIC-7902B ch0
	    Seagate ST34572W (ID0)
	    Quantum QM39100TD-SW (2x ID8 and 9)
Scsi bus 1: Controller AIC-7902B ch1
	    HL-DT-ST DVDRAM GSA-4160B (ID0, uses an Acard AEC7722)
Scsi bus 2: Controller AHA2940U (AIC-7881U)
            Seagate ST34371N (ID0)
            Plextor CDRW PX-W4012S (ID1)
            Archive Python 4gb 4mm DAT (ID6)
IDE  bus 0: Controller Intel ICH4 (Pri)
            Generic Atapi CDROM 52x (Master)
IDE  bus 1: Controller Intel ICH4 (Sec)
	    Toshiba DVDROM SD-M1202 (Slave, no master)

The AHA2940U is in a standard PCI slot (This board has 1 PCI-X 133, 2 PCI-X
100, 2 PCI 32bit 33mhz, 8x AGP Pro)

/proc/scsi/scsi:
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: SEAGATE  Model: ST34572W         Rev: 0876
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 08 Lun: 00
  Vendor: QUANTUM  Model: QM39100TD-SW     Rev: N491
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 09 Lun: 00
  Vendor: QUANTUM  Model: QM39100TD-SW     Rev: N491
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: HL-DT-ST Model: DVDRAM GSA-4160B Rev: A300
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi2 Channel: 00 Id: 00 Lun: 00
  Vendor: SEAGATE  Model: ST34371N         Rev: 0484
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi2 Channel: 00 Id: 01 Lun: 00
  Vendor: PLEXTOR  Model: CD-R   PX-W4012S Rev: 1.01
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi2 Channel: 00 Id: 06 Lun: 00
  Vendor: ARCHIVE  Model: Python 28388-XXX Rev: 5.AC
  Type:   Sequential-Access                ANSI SCSI revision: 02

lsmod:
Module                  Size  Used by
piix                   11808  0 [permanent]
w83781d                32256  0 
eeprom                  6792  0 
adm1021                11400  0 
i2c_sensor              2944  3 w83781d,eeprom,adm1021
i2c_i801                7568  0 
i2c_core               19200  5 w83781d,eeprom,adm1021,i2c_sensor,i2c_i801
sg                     29600  0 
ext2                   55144  0 
nfs                    96428  3 
ide_cd                 38176  0 
ide_core              112612  2 piix,ide_cd
sr_mod                 13860  0 
cdrom                  37020  2 ide_cd,sr_mod
usbhid                 29632  0 
r128                  100308  2 
snd_intel8x0           29448  1 
snd_ac97_codec         64004  1 snd_intel8x0
snd_pcm_oss            48424  0 
snd_mixer_oss          17536  1 snd_pcm_oss
snd_pcm                81156  2 snd_intel8x0,snd_pcm_oss
snd_timer              21380  1 snd_pcm
snd_page_alloc          9480  2 snd_intel8x0,snd_pcm
snd_mpu401_uart         6528  1 snd_intel8x0
snd_rawmidi            20260  1 snd_mpu401_uart
snd_seq_device          7048  1 snd_rawmidi
snd                    43620  11 snd_intel8x0,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device
soundcore               7648  1 snd
nfsd                   89544  8 
exportfs                5376  1 nfsd
lockd                  57928  3 nfs,nfsd
sunrpc                132836  7 nfs,nfsd,lockd
tun                     6912  3 
3c59x                  36136  0 
e1000                  78852  0 
bridge                 44056  0 
uhci_hcd               29072  0 
ohci_hcd               15876  0 
ehci_hcd               25092  0 
usbcore               100580  6 usbhid,uhci_hcd,ohci_hcd,ehci_hcd
reiserfs              239316  3 
iptable_nat            21668  1 
ipt_REJECT              6272  3 
ipt_LOG                 6400  5 
ipt_state               2176  10 
ip_conntrack           29708  2 iptable_nat,ipt_state
iptable_filter          2816  1 
ip_tables              16128  5 iptable_nat,ipt_REJECT,ipt_LOG,ipt_state,iptable_filter
8250                   19936  0 
serial_core            19968  1 8250
dm_mod                 49280  6 
aic7xxx               190648  1 

lspci -v:
0000:00:00.0 Host bridge: Intel Corp. E7505 Memory Controller Hub (rev 03)
        Subsystem: Super Micro Computer Inc: Unknown device 4080
        Flags: bus master, fast devsel, latency 0
        Memory at f2000000 (32-bit, prefetchable) [size=32M]
        Capabilities: [40] #09 [0104]
        Capabilities: [a0] AGP version 3.0

0000:00:00.1 ff00: Intel Corp. E7505/E7205 Series RAS Controller (rev 03)
        Subsystem: Super Micro Computer Inc: Unknown device 4080
        Flags: fast devsel

0000:00:01.0 PCI bridge: Intel Corp. E7505/E7205 PCI-to-AGP Bridge (rev 03) (prog-if 00 [Normal decode])
        Flags: bus master, 66MHz, fast devsel, latency 96
        Memory at f4000000 (32-bit, prefetchable) [size=32M]
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 00003000-00003fff
        Memory behind bridge: f0100000-f01fffff
        Prefetchable memory behind bridge: f8000000-fbffffff
        Capabilities: [60] #0e [0035]

0000:00:02.0 PCI bridge: Intel Corp. E7505 Hub Interface B PCI-to-PCI Bridge (rev 03) (prog-if 00 [Normal decode])
        Flags: bus master, 66MHz, fast devsel, latency 64
        Bus: primary=00, secondary=02, subordinate=04, sec-latency=0
        I/O behind bridge: 00004000-00005fff
        Memory behind bridge: f0200000-f04fffff

0000:00:1d.0 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1 (rev 02) (prog-if 00 [UHCI])
        Subsystem: Super Micro Computer Inc: Unknown device 4080
        Flags: bus master, medium devsel, latency 0, IRQ 16
        I/O ports at 2440 [size=32]

0000:00:1d.1 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2 (rev 02) (prog-if 00 [UHCI])
        Subsystem: Super Micro Computer Inc: Unknown device 4080
        Flags: bus master, medium devsel, latency 0, IRQ 19
        I/O ports at 2460 [size=32]

0000:00:1d.2 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3 (rev 02) (prog-if 00 [UHCI])
        Subsystem: Super Micro Computer Inc: Unknown device 4080
        Flags: bus master, medium devsel, latency 0, IRQ 18
        I/O ports at 2480 [size=32]

0000:00:1d.7 USB Controller: Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB 2.0 EHCI Controller (rev 02) (prog-if 20 [EHCI])
        Subsystem: Super Micro Computer Inc: Unknown device 4080
        Flags: bus master, medium devsel, latency 0, IRQ 23
        Memory at f0000000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] Power Management version 2
        Capabilities: [58] #0a [2080]

0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev 82) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=05, subordinate=05, sec-latency=168
        I/O behind bridge: 00006000-00006fff
        Memory behind bridge: f0500000-f05fffff

0000:00:1f.0 ISA bridge: Intel Corp. 82801DB/DBL (ICH4/ICH4-L) LPC Bridge (rev 02)
        Flags: bus master, medium devsel, latency 0

0000:00:1f.1 IDE interface: Intel Corp. 82801DB/DBL (ICH4/ICH4-L) UltraATA-100 IDE Controller (rev 02) (prog-if 8a [Master SecP PriP])
        Subsystem: Super Micro Computer Inc: Unknown device 4080
        Flags: bus master, medium devsel, latency 0, IRQ 18
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at <ignored>
        I/O ports at 24a0 [size=16]
        Memory at f0000400 (32-bit, non-prefetchable) [size=1K]

0000:00:1f.3 SMBus: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) SMBus Controller (rev 02)
        Subsystem: Super Micro Computer Inc: Unknown device 4080
        Flags: medium devsel, IRQ 17
        I/O ports at 1100 [size=32]

0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 02)
        Subsystem: Super Micro Computer Inc: Unknown device 4080
        Flags: bus master, medium devsel, latency 0, IRQ 17
        I/O ports at 2000 [size=256]
        I/O ports at 2400 [size=64]
        Memory at f0000c00 (32-bit, non-prefetchable) [size=512]
        Memory at f0000800 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2

0000:01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 Pro Ultra TF (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc Rage Fury Pro/Xpert 2000 Pro
        Flags: bus master, stepping, fast Back2Back, 66MHz, medium devsel, latency 66, IRQ 21
        Memory at f8000000 (32-bit, prefetchable) [size=64M]
        I/O ports at 3000 [size=256]
        Memory at f0100000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [50] AGP version 2.0
        Capabilities: [5c] Power Management version 2

0000:02:1c.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 04) (prog-if 20 [IO(X)-APIC])
        Subsystem: Super Micro Computer Inc: Unknown device 4080
        Flags: bus master, 66MHz, fast devsel, latency 0
        Memory at f0200000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [50] PCI-X non-bridge device.

0000:02:1d.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 04) (prog-if 00 [Normal decode])
        Flags: bus master, 66MHz, fast devsel, latency 64
        Bus: primary=02, secondary=03, subordinate=03, sec-latency=64
        I/O behind bridge: 00004000-00004fff
        Memory behind bridge: f0300000-f03fffff
        Capabilities: [50] PCI-X bridge device.

0000:02:1e.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 04) (prog-if 20 [IO(X)-APIC])
        Subsystem: Super Micro Computer Inc: Unknown device 4080
        Flags: bus master, 66MHz, fast devsel, latency 0
        Memory at f0201000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [50] PCI-X non-bridge device.

0000:02:1f.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 04) (prog-if 00 [Normal decode])
        Flags: bus master, 66MHz, fast devsel, latency 64
        Bus: primary=02, secondary=04, subordinate=04, sec-latency=64
        I/O behind bridge: 00005000-00005fff
        Memory behind bridge: f0400000-f04fffff
        Capabilities: [50] PCI-X bridge device.

0000:03:03.0 Ethernet controller: Intel Corp. 82545EM Gigabit Ethernet Controller (Copper) (rev 01)
        Subsystem: Intel Corp.: Unknown device 1011
        Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 54
        Memory at f0300000 (64-bit, non-prefetchable) [size=128K]
        I/O ports at 4000 [size=64]
        Capabilities: [dc] Power Management version 2
        Capabilities: [e4] PCI-X non-bridge device.
        Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-

0000:04:03.0 SCSI storage controller: Adaptec AIC-7902B U320 (rev 10)
        Subsystem: Adaptec: Unknown device 005e
        Flags: bus master, 66MHz, slow devsel, latency 64, IRQ 32
        I/O ports at 5400 [disabled] [size=256]
        Memory at f0400000 (64-bit, non-prefetchable) [size=8K]
        I/O ports at 5000 [disabled] [size=256]
        Capabilities: [dc] Power Management version 2
        Capabilities: [a0] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable-
        Capabilities: [94] 
0000:04:03.1 SCSI storage controller: Adaptec AIC-7902B U320 (rev 10)
        Subsystem: Adaptec: Unknown device 005e
        Flags: bus master, 66MHz, slow devsel, latency 64, IRQ 33
        I/O ports at 5c00 [disabled] [size=256]
        Memory at f0402000 (64-bit, non-prefetchable) [size=8K]
        I/O ports at 5800 [disabled] [size=256]
        Capabilities: [dc] Power Management version 2
        Capabilities: [a0] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable-
        Capabilities: [94] 
0000:05:01.0 Ethernet controller: 3Com Corporation 3c900B-TPC Etherlink XL [Cyclone] (rev 04)
        Subsystem: 3Com Corporation 3c900B-TPC Etherlink XL [Cyclone]
        Flags: bus master, medium devsel, latency 80, IRQ 16
        I/O ports at 6400 [size=128]
        Memory at f0501000 (32-bit, non-prefetchable) [size=128]
        Capabilities: [dc] Power Management version 1

0000:05:02.0 SCSI storage controller: Adaptec AHA-2940U/UW/D / AIC-7881U (rev 01)
        Subsystem: Adaptec AHA-2940UW SCSI Host Adapter
        Flags: bus master, medium devsel, latency 64, IRQ 17
        I/O ports at 6000 [disabled] [size=256]
        Memory at f0500000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [dc] Power Management version 1

ACPI is enabled, Pre-empt is disabled.

I have one other machine using 2.6 on a regular basis, however, I have no
cdroms installed in it.  I do occasionally see scsi errors on it (It has 3
IDE Disks, 2 of which are using an acard ide-scsi converter on seperate
busses)

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
