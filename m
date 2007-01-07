Return-Path: <linux-kernel-owner+w=401wt.eu-S964853AbXAGSHw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964853AbXAGSHw (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 13:07:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964842AbXAGSHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 13:07:52 -0500
Received: from mx0.vr-web.de ([195.200.35.198]:58028 "EHLO mx0.vr-web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964826AbXAGSHo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 13:07:44 -0500
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Sun, 07 Jan 2007 13:07:36 EST
From: Andreas Hartmann <andihartmann@01019freenet.de>
X-Newsgroups: linux.kernel
Subject: [2.6.18.2] ide_core bug: kobject_add failed for ide ...
Date: Sun, 07 Jan 2007 18:44:16 +0100
Organization: privat
Message-ID: <enrbhg$1m0$1@p54A18DCE.dip0.t-ipconnect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Complaints-To: abuse@arcor.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.8.1.1) Gecko/20070105 SeaMonkey/1.1
X-Enigmail-Version: 0.94.1.2.0
To: linux-kernel@vger.kernel.org
X-BitDefender-Scanner: Clean, Agent: BitDefender Courier MTA Agent
 1.6.2 on vrwebmail
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

ide_core is loaded (while putting in an USB stick) as module the first
time after reboot - all works fine. The USB stick got mounted and a ls
is done to show the files on the root of the filesystem of the stick.
Afterwards, the stick is securely removed from the system.
Afterwards, ide_core is unloaded with rmmod (after usb-storage has been
unloaded) - ok.

Next step is to load ide_core again. Now, the following error can be
found in /var/log/messages:


Jan  7 11:48:18 notebook1 kernel: Uniform Multi-Platform E-IDE driver
Revision: 7.00alpha2
Jan  7 11:48:18 notebook1 kernel: ide: Assuming 33MHz system bus speed
for PIO modes; override with idebus=xx
Jan  7 11:48:18 notebook1 kernel: kobject_add failed for ide with
-EEXIST, don't try to register things with the same name in the same
directory.
Jan  7 11:48:18 notebook1 kernel:  [<c01c026f>] kobject_add+0x161/0x18a
Jan  7 11:48:18 notebook1 kernel:  [<c01c037e>] kobject_register+0x19/0x30
Jan  7 11:48:18 notebook1 kernel:  [<c0224f19>] bus_add_driver+0x51/0x107
Jan  7 11:48:18 notebook1 kernel:  [<e047b85c>] init_module+0x716/0x72f
[ide_core]
Jan  7 11:48:18 notebook1 kernel:  [<c0137119>] __link_module+0x0/0x1f
Jan  7 11:48:18 notebook1 kernel:  [<c011b951>] __cond_resched+0x16/0x34
Jan  7 11:48:18 notebook1 kernel:  [<c02a44e0>] cond_resched+0x2a/0x31
Jan  7 11:48:18 notebook1 kernel:  [<c02a4515>]
wait_for_completion+0x18/0xa4
Jan  7 11:48:18 notebook1 kernel:  [<c0140466>] do_stop+0x0/0x117
Jan  7 11:48:18 notebook1 kernel:  [<c0137119>] __link_module+0x0/0x1f
Jan  7 11:48:18 notebook1 kernel:  [<c013987f>]
sys_init_module+0x17fe/0x1981
Jan  7 11:48:18 notebook1 kernel:  [<c014ba04>] generic_file_read+0x0/0xb8
Jan  7 11:48:18 notebook1 kernel:  [<c0103d5d>] sysenter_past_esp+0x56/0x79

The module is loaded and seams to work fine afterwards.

notebook1:~ # lspci -v
00:00.0 Host bridge: Intel Corporation Mobile 915GM/PM/GMS/910GML
Express Processor to DRAM Controller (rev 04)
        Subsystem: Mitac Unknown device 8048
        Flags: bus master, fast devsel, latency 0
        Capabilities: [e0] Vendor Specific Information

00:02.0 VGA compatible controller: Intel Corporation Mobile
915GM/GMS/910GML Express Graphics Controller (rev 04) (prog-if 00 [VGA])
        Subsystem: Mitac Unknown device 8048
        Flags: bus master, fast devsel, latency 0, IRQ 11
        Memory at d0000000 (32-bit, non-prefetchable) [size=512K]
        I/O ports at e000 [size=8]
        Memory at a0000000 (32-bit, prefetchable) [size=256M]
        Memory at d0080000 (32-bit, non-prefetchable) [size=256K]
        Capabilities: [d0] Power Management version 2

00:02.1 Display controller: Intel Corporation Mobile 915GM/GMS/910GML
Express Graphics Controller (rev 04)
        Subsystem: Mitac Unknown device 8048
        Flags: bus master, fast devsel, latency 0
        Memory at d0100000 (32-bit, non-prefetchable) [size=512K]
        Capabilities: [d0] Power Management version 2

00:1b.0 Audio device: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) High Definition Audio Controller (rev 04)
        Subsystem: Mitac Unknown device 8048
        Flags: bus master, fast devsel, latency 0, IRQ 217
        Memory at d0180000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: Mask- 64bit+
Queue=0/0 Enable-
        Capabilities: [70] Express Unknown type IRQ 0

00:1d.0 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #1 (rev 04) (prog-if 00 [UHCI])
        Subsystem: Mitac Unknown device 8048
        Flags: bus master, medium devsel, latency 0, IRQ 193
        I/O ports at 1200 [size=32]

00:1d.1 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #2 (rev 04) (prog-if 00 [UHCI])
        Subsystem: Mitac Unknown device 8048
        Flags: bus master, medium devsel, latency 0, IRQ 177
        I/O ports at 1220 [size=32]

00:1d.2 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #3 (rev 04) (prog-if 00 [UHCI])
        Subsystem: Mitac Unknown device 8048
        Flags: bus master, medium devsel, latency 0, IRQ 201
        I/O ports at 1240 [size=32]

00:1d.7 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB2 EHCI Controller (rev 04) (prog-if 20 [EHCI])
        Subsystem: Mitac Unknown device 8048
        Flags: bus master, medium devsel, latency 0, IRQ 193
        Memory at 20000000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] Power Management version 2
        Capabilities: [58] Debug port

00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev d4)
(prog-if 01 [Subtractive decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=05, sec-latency=32
        I/O behind bridge: 0000c000-0000dfff
        Memory behind bridge: cc000000-cfffffff
        Prefetchable memory behind bridge: 000000009c000000-000000009fffffff
        Capabilities: [50] Subsystem: Mitac Unknown device 8048

00:1f.0 ISA bridge: Intel Corporation 82801FBM (ICH6M) LPC Interface
Bridge (rev 04)
        Subsystem: Mitac Unknown device 8048
        Flags: bus master, medium devsel, latency 0

00:1f.2 IDE interface: Intel Corporation 82801FBM (ICH6M) SATA
Controller (rev 04) (prog-if 80 [Master])
        Subsystem: Mitac Unknown device 8048
        Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 177
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at 1100 [size=16]
        Capabilities: [70] Power Management version 2

00:1f.3 SMBus: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family)
SMBus Controller (rev 04)
        Subsystem: Mitac Unknown device 8048
        Flags: medium devsel, IRQ 177
        I/O ports at 1400 [size=32]

01:02.0 CardBus bridge: Texas Instruments PCIxx21/x515 Cardbus Controller
        Subsystem: Mitac Unknown device 8048
        Flags: bus master, medium devsel, latency 168, IRQ 169
        Memory at cc009000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=01, secondary=02, subordinate=05, sec-latency=176
        Memory window 0: 9c000000-9dfff000 (prefetchable)
        Memory window 1: ce000000-cffff000
        I/O window 0: 0000c400-0000c4ff
        I/O window 1: 0000c800-0000c8ff
        16-bit legacy interface ports at 0001

01:02.2 FireWire (IEEE 1394): Texas Instruments OHCI Compliant IEEE 1394
Host Controller (prog-if 10 [OHCI])
        Subsystem: Mitac Unknown device 8048
        Flags: bus master, medium devsel, latency 128, IRQ 177
        Memory at fedff800 (32-bit, non-prefetchable) [size=2K]
        Memory at cc00c000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [44] Power Management version 2

01:04.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
        Subsystem: Mitac Unknown device 8048
        Flags: bus master, medium devsel, latency 128, IRQ 209
        I/O ports at c000 [size=256]
        Memory at cc008000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2

01:05.0 Network controller: RaLink RT2561/RT61 rev B 802.11g
        Subsystem: Micro-Star International Co., Ltd. Unknown device b833
        Flags: bus master, slow devsel, latency 128, IRQ 11
        Memory at cc000000 (32-bit, non-prefetchable) [size=32K]
        Capabilities: [40] Power Management version 2

notebook1:~ # lsmod
Module                  Size  Used by
ide_core              129992  0
af_packet              29320  2
ipv6                  263584  12
button                 10896  0
battery                14340  0
ac                      9476  0
twofish                47488  3
cryptoloop              7680  3
ohci_hcd               23428  0
apparmor               55572  0
aamatch_pcre           18304  1 apparmor
loop                   20488  7 cryptoloop
dm_mod                 60184  13
pcmcia                 40892  0
firmware_class         14080  1 pcmcia
usbhid                 52192  0
yenta_socket           30348  1
ohci1394               37040  0
rsrc_nonstatic         17024  1 yenta_socket
pcmcia_core            43412  3 pcmcia,yenta_socket,rsrc_nonstatic
ieee1394              102584  1 ohci1394
snd_hda_intel          23060  1
snd_hda_codec         164352  1 snd_hda_intel
snd_pcm                86916  2 snd_hda_intel,snd_hda_codec
snd_timer              27908  1 snd_pcm
snd                    61188  6
snd_hda_intel,snd_hda_codec,snd_pcm,snd_timer
8139too                30592  0
soundcore              13792  1 snd
intel_agp              27804  1
snd_page_alloc         14472  2 snd_hda_intel,snd_pcm
mii                     9600  1 8139too
agpgart                35528  2 intel_agp
ehci_hcd               34696  0
uhci_hcd               26892  0
i2c_i801               11660  0
usbcore               114896  4 ohci_hcd,usbhid,ehci_hcd,uhci_hcd
i2c_core               25216  1 i2c_i801
reiserfs              237312  7
sr_mod                 20132  0
cdrom                  38432  1 sr_mod
edd                    13892  0
fan                     8964  1
sg                     38044  0
ata_piix               19332  3
ahci                   25860  0
libata                119188  2 ata_piix,ahci
thermal                18568  1
processor              34664  1 thermal
sd_mod                 24576  4
scsi_mod              136712  5 sr_mod,sg,ahci,libata,sd_mod



Kind regards,
Andreas Hartmann
