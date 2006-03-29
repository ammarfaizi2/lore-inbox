Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750796AbWC2UG1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbWC2UG1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 15:06:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbWC2UG1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 15:06:27 -0500
Received: from vms042pub.verizon.net ([206.46.252.42]:9942 "EHLO
	vms042pub.verizon.net") by vger.kernel.org with ESMTP
	id S1750796AbWC2UGZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 15:06:25 -0500
Date: Wed, 29 Mar 2006 15:06:18 -0500 (EST)
From: "Jeremy Johnson" <acj.pllc.law@verizon.net>
Subject: pcmciautils Kyocera KPC650
To: linux-pcmcia@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Message-id: <1303.192.168.1.47.1143662778.squirrel@www.acjlaw.net>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="----=_20060329150618_94345"
Importance: Normal
X-Priority: 3 (Normal)
User-Agent: SquirrelMail/1.4.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_20060329150618_94345
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

I'm trying to get a Kyocera KPC650 pcmcia airmodem card working.
I have an HP SE2000L amd64 Turino laptop running amd64 Gentoo
with kernel-2.6.15-r1 and pcmciautils-013 and for good measure
pcmcia-cs-cis-3.2.8-r1. I also have coldplug-20040920 and
hotplug-20040923-r1 and hotplug-base-20040401

# cat /etc/modules.autoload.d/kernel-2.6
ndiswrapper
fglrx
ohci_hcd
ehci_hcd
#usbserial vendor=3D0x0c88 product=3D0x17da maxSize=3D2048
usbserial vendor=3D0x0c88 product=3D0x17da
ppp_async

# grep YENTA .config
CONFIG_YENTA=3Dy

# grep PCMCIA .config|grep -v "#"
CONFIG_PCMCIA_DEBUG=3Dy
CONFIG_PCMCIA=3Dy
CONFIG_PCMCIA_LOAD_CIS=3Dy
CONFIG_PCMCIA_IOCTL=3Dy
CONFIG_PCMCIA_FDOMAIN=3Dm
CONFIG_PCMCIA_QLOGIC=3Dm
CONFIG_PCMCIA_SYM53C500=3Dm
CONFIG_NET_PCMCIA=3Dy

# grep USB_SERIAL .config|grep -v "#"
CONFIG_USB_SERIAL=3Dm
CONFIG_USB_SERIAL_GENERIC=3Dy


I have activated this card in WindowsXP and connected properly to
Verizon's EVDO VZAccess network. But I can't get the card to be recognize=
d
under linux (The blue led light does not light up)

# pccardctl status
Socket 0:
  3.3V 32-bit PC Card
# pccardctl info
PRODID_1=3D""
PRODID_2=3D""
PRODID_3=3D""
PRODID_4=3D""
MANFID=3D0000,0000
FUNCID=3D255

When I eject the card I get the following error message:
PCMCIA: socket ffff810017ac6048: *** DANGER *** unable to remove socket p=
ower

So I followed the suggestions in the mini-howto
<http:www.kernel.org/pub/linux/utils/kernel/pcmcia/howto.html>
and the suggestions at ~/pcmcia.html#mailinglist

# lspci -v|grep subordinate
        Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D=
64 Bus:
primary=3D00, secondary=3D05, subordinate=3D05, sec-latency=3D64 Bus:
primary=3D05, secondary=3D06, subordinate=3D09, sec-latency=3D176
which looks OK since my yenta_socket is 0000:05:09.0

I also tried the ~/powerbugs.html#2 suggestions
and added reserve=3D0xc020a000,0x5000 to my kernel cmd line.

# lspci -vv
05:09.0 CardBus bridge: Texas Instruments PCIxx21/x515 Cardbus Controller
        Subsystem: Hewlett-Packard Company Unknown device 3091
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort=
-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 168, Cache Line Size 10
        Interrupt: pin A routed to IRQ 185
        Region 0: Memory at c020a000 (32-bit, non-prefetchable) [size=3D4=
K]
Bus: primary=3D05, secondary=3D06, subordinate=3D09, sec-latency=3D176
Memory window 0: 30000000-31fff000 (prefetchable)
        Memory window 1: 32000000-33fff000
        I/O window 0: 0000a400-0000a4ff
        I/O window 1: 0000a800-0000a8ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt-
PostWrite+
        16-bit legacy interface ports at 0001

/proc/iomem reports:
  c0209000-c02090ff : 0000:05:09.4
  c0209400-c02094ff : 0000:05:09.4
  c020a000-c020afff : 0000:05:09.0
  c020a000-c020afff : yenta_socket


At this point I don't know how to proceed next.
Everything I've tried has failed.
But I know others have gotten this card to work on
other linux laptops.

So is this a bug or something that I've neglected to do?
THANKS.




--=20
Anita C. Johnson
c/o Jeremy
P.O. Box 877
23405 Front St.
Accomac, VA 23301
Work: (757)787-8743
Fax:  (757)787-3570
------=_20060329150618_94345
Content-Type: text/plain; name="lsmod.txt"
Content-Disposition: attachment; filename="lsmod.txt"
Content-Transfer-Encoding: quoted-printable

Module                  Size  Used by
ip_conntrack_irc        8144  0=20
ip_conntrack_ftp        8848  0=20
ipt_REJECT              6464  4=20
ipt_LOG                 8000  4=20
ipt_limit               4288  4=20
ipt_state               3904  181=20
ip_conntrack           50236  3 ip_conntrack_irc,ip_conntrack_ftp,ipt_sta=
te
iptable_filter          4800  1=20
ip_tables              20224  5 ipt_REJECT,ipt_LOG,ipt_limit,ipt_state,ip=
table_filter
rfcomm                 35296  6=20
l2cap                  24064  5 rfcomm
snd_pcm_oss            48352  0=20
snd_mixer_oss          16768  1 snd_pcm_oss
snd_seq_dummy           5124  0=20
snd_seq_oss            31616  0=20
snd_seq_midi_event      8704  1 snd_seq_oss
snd_seq                51456  5 snd_seq_dummy,snd_seq_oss,snd_seq_midi_ev=
ent
snd_seq_device          9360  3 snd_seq_dummy,snd_seq_oss,snd_seq
uhci_hcd               31832  0=20
ohci1394               31116  0=20
8139cp                 19968  0=20
snd_atiixp_modem       15116  1=20
snd_atiixp             18772  1=20
snd_ac97_codec         99416  2 snd_atiixp_modem,snd_atiixp
snd_ac97_bus            4480  1 snd_ac97_codec
snd_pcm                82440  4 snd_pcm_oss,snd_atiixp_modem,snd_atiixp,s=
nd_ac97_codec
snd_timer              22472  2 snd_seq,snd_pcm
snd                    50504  14 snd_pcm_oss,snd_mixer_oss,snd_seq_oss,sn=
d_seq,snd_seq_device,snd_atiixp_modem,snd_atiixp,snd_ac97_codec,snd_pcm,s=
nd_timer
snd_page_alloc         11152  3 snd_atiixp_modem,snd_atiixp,snd_pcm
binfmt_misc            11724  1=20
hci_usb                16404  5=20
ppp_async              11200  0=20
ppp_generic            26912  1 ppp_async
slhc                    8000  1 ppp_generic
crc_ccitt               4096  1 ppp_async
usbserial              29232  0=20
ehci_hcd               40712  0=20
ohci_hcd               30788  0=20
fglrx                 501696  36=20
ndiswrapper           194976  0=20
------=_20060329150618_94345
Content-Type: text/plain; name="lshw.txt"
Content-Disposition: attachment; filename="lshw.txt"
Content-Transfer-Encoding: quoted-printable

acj
    description: Notebook
    product: HP Pavilion (EC436AV#ABA)
    vendor: Hewlett-Packard
    version: Rev 1
    serial: CNF6030DRG
    width: 32 bits
    capabilities: smbios-2.31 dmi-2.31
    configuration: boot=3Doem-specific chassis=3Dnotebook uuid=3D60BB13B2=
-9787-DA11-8723-00163613CDAF
  *-core
       description: Motherboard
       product: 3093
       vendor: Quanta
       physical id: 0
       version: 47.0F
       serial: None
     *-firmware
          description: BIOS
          vendor: Hewlett-Packard
          physical id: 0
          version: F.21 (12/09/2005)
          size: 105KB
          capacity: 448KB
          capabilities: pci pcmcia pnp apm upgrade shadowing escd cdboot =
int5printscreen int9keyboard int14serial int17printer int10video acpi usb
     *-cpu
          description: CPU
          product: AMD Turion(tm) 64 Mobile Technology ML-37
          vendor: Advanced Micro Devices [AMD]
          physical id: 4
          bus info: cpu@0
          version: AMD Turion(tm) 64 Mobile ML
          slot: U23
          size: 2GHz
          capacity: 2GHz
          width: 64 bits
          clock: 200MHz
          capabilities: fpu fpu_exception wp vme de pse tsc msr pae mce c=
x8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 syscall=
 nx mmxext fxsr_opt x86-64 3dnowext 3dnow pni lahf_lm cpufreq
        *-cache
             description: L2 cache
             physical id: 5
             slot: L2 Cache
             size: 1MB
             capacity: 1MB
             capabilities: synchronous internal write-back
     *-memory
          description: System Memory
          physical id: 9
          slot: System board or motherboard
          size: 512MB
        *-bank:0
             description: DIMM DRAM Synchronous
             physical id: 0
             slot: U5
             size: 256MB
             width: 32 bits
        *-bank:1
             description: DIMM DRAM Synchronous
             physical id: 1
             slot: U6
             size: 256MB
             width: 32 bits
     *-pci:0
          description: Host bridge
          product: RS480 Host Bridge
          vendor: ATI Technologies Inc
          physical id: 100
          bus info: pci@00:00.0
          version: 10
          width: 32 bits
          clock: 66MHz
        *-pci:0
             description: PCI bridge
             product: ATI Technologies Inc
             vendor: ATI Technologies Inc
             physical id: 1
             bus info: pci@00:01.0
             version: 00
             width: 32 bits
             clock: 66MHz
             capabilities: pci normal_decode bus_master cap_list
           *-display
                description: VGA compatible controller
                product: ATI Radeon XPRESS 200M 5955 (PCIE)
                vendor: ATI Technologies Inc
                physical id: 5
                bus info: pci@01:05.0
                logical name: /dev/fb0
                version: 00
                size: 128MB
                width: 32 bits
                clock: 66MHz
                capabilities: vga bus_master cap_list fb
                configuration: depth=3D24 driver=3Dfglrx_pci frequency=3D=
75.69Hz mode=3D1024x768 visual=3Dtruecolor xres=3D1024 yres=3D768
                resources: iomemory:c8000000-cfffffff ioport:9000-90ff io=
memory:c0100000-c010ffff irq:185
        *-usb:0
             description: USB Controller
             product: IXP SB400 USB Host Controller
             vendor: ATI Technologies Inc
             physical id: 13
             bus info: pci@00:13.0
             version: 80
             width: 32 bits
             clock: 66MHz
             capabilities: ohci bus_master cap_list
             configuration: driver=3Dohci_hcd
             resources: iomemory:c0000000-c0000fff irq:217
           *-usbhost
                product: OHCI Host Controller
                vendor: Linux 2.6.15-gentoo-r1 ohci_hcd
                physical id: 1
                bus info: usb@2
                logical name: usb2
                version: 2.06
                capabilities: usb-1.10
                configuration: driver=3Dhub maxpower=3D0mA slots=3D4 spee=
d=3D12.0MB/s
              *-usb
                   description: Mouse
                   product: F8E842-DL Mouse
                   vendor: Belkin
                   physical id: 1
                   bus info: usb@2:1
                   version: 2.70
                   capabilities: usb-1.10
                   configuration: driver=3Dusbhid maxpower=3D100mA speed=3D=
1.5MB/s
        *-usb:1
             description: USB Controller
             product: IXP SB400 USB Host Controller
             vendor: ATI Technologies Inc
             physical id: 13.1
             bus info: pci@00:13.1
             version: 80
             width: 32 bits
             clock: 66MHz
             capabilities: ohci bus_master cap_list
             configuration: driver=3Dohci_hcd
             resources: iomemory:c0001000-c0001fff irq:217
           *-usbhost
                product: OHCI Host Controller
                vendor: Linux 2.6.15-gentoo-r1 ohci_hcd
                physical id: 1
                bus info: usb@3
                logical name: usb3
                version: 2.06
                capabilities: usb-1.10
                configuration: driver=3Dhub maxpower=3D0mA slots=3D4 spee=
d=3D12.0MB/s
              *-usb
                   description: Bluetooth wireless interface
                   product: HP integrated Bluetooth module
                   vendor: Broadcom
                   physical id: 3
                   bus info: usb@3:3
                   version: 0.17
                   capabilities: bluetooth usb-1.10
                   configuration: driver=3Dhci_usb maxpower=3D0mA speed=3D=
12.0MB/s
        *-usb:2
             description: USB Controller
             product: IXP SB400 USB2 Host Controller
             vendor: ATI Technologies Inc
             physical id: 13.2
             bus info: pci@00:13.2
             version: 80
             width: 32 bits
             clock: 66MHz
             capabilities: ehci bus_master cap_list
             configuration: driver=3Dehci_hcd
             resources: iomemory:c0002000-c0002fff irq:217
           *-usbhost
                product: EHCI Host Controller
                vendor: Linux 2.6.15-gentoo-r1 ehci_hcd
                physical id: 1
                bus info: usb@1
                logical name: usb1
                version: 2.06
                capabilities: usb-2.00
                configuration: driver=3Dhub maxpower=3D0mA slots=3D8 spee=
d=3D480.0MB/s
        *-serial UNCLAIMED
             description: SMBus
             product: IXP SB400 SMBus Controller
             vendor: ATI Technologies Inc
             physical id: 14
             bus info: pci@00:14.0
             version: 81
             width: 32 bits
             clock: 66MHz
             capabilities: cap_list
             resources: ioport:8400-840f iomemory:c0003000-c00033ff
        *-ide
             description: IDE interface
             product: Standard Dual Channel PCI IDE Controller ATI
             vendor: ATI Technologies Inc
             physical id: 14.1
             bus info: pci@00:14.1
             version: 80
             width: 32 bits
             clock: 66MHz
             capabilities: ide bus_master cap_list
             configuration: driver=3DATIIXP_IDE
             resources: ioport:8410-841f irq:201
           *-ide:0
                description: IDE Channel 0
                physical id: 0
                bus info: ide@0
                logical name: ide0
                clock: 66MHz
              *-disk
                   description: ATA Disk
                   product: TOSHIBA MK1031GAS
                   vendor: Toshiba
                   physical id: 0
                   bus info: ide@0.0
                   logical name: /dev/hda
                   version: AA204C
                   serial: X5DM7021S
                   size: 93GB
                   capacity: 93GB
                   capabilities: ata dma lba iordy smart security pm apm
                   configuration: apm=3Doff mode=3Dudma5 smart=3Don
           *-ide:1
                description: IDE Channel 1
                physical id: 1
                bus info: ide@1
                logical name: ide1
                clock: 66MHz
              *-cdrom
                   description: DVD writer
                   product: PIONEER DVDRW DVR-K15
                   vendor: Pioneer
                   physical id: 0
                   bus info: ide@1.0
                   logical name: /dev/hdc
                   version: 1.11
                   capabilities: packet atapi cdrom removable nonmagnetic=
 dma lba iordy pm audio cd-r cd-rw dvd dvd-r
        *-isa UNCLAIMED
             description: ISA bridge
             product: IXP SB400 PCI-ISA Bridge
             vendor: ATI Technologies Inc
             physical id: 14.3
             bus info: pci@00:14.3
             version: 80
             width: 32 bits
             clock: 66MHz
             capabilities: isa bus_master
        *-pci:1
             description: PCI bridge
             product: IXP SB400 PCI-PCI Bridge
             vendor: ATI Technologies Inc
             physical id: 14.4
             bus info: pci@00:14.4
             version: 80
             width: 32 bits
             clock: 66MHz
             capabilities: pci subtractive_decode bus_master
           *-network:0
                description: Ethernet interface
                product: RTL-8139/8139C/8139C+
                vendor: Realtek Semiconductor Co., Ltd.
                physical id: 0
                bus info: pci@05:00.0
                logical name: eth0
                version: 10
                serial: 00:16:36:13:cd:af
                size: 100MB/s
                capacity: 100MB/s
                width: 32 bits
                clock: 33MHz
                capabilities: bus_master cap_list ethernet physical tp mi=
i 10bt 10bt-fd 100bt 100bt-fd autonegociation
                configuration: autonegociation=3Don broadcast=3Dyes drive=
r=3D8139too driverversion=3D0.9.27 duplex=3Dfull ip=3D10.0.0.2 link=3Dyes=
 multicast=3Dyes port=3DMII speed=3D100MB/s
                resources: ioport:a000-a0ff iomemory:c0208000-c02080ff ir=
q:193
           *-network:1 DISABLED
                description: Wireless interface
                product: BCM4318 [AirForce One 54g] 802.11g Wireless LAN =
Controller
                vendor: Broadcom Corporation
                physical id: 2
                bus info: pci@05:02.0
                logical name: wlan0
                version: 02
                serial: 00:14:a5:69:0e:b4
                width: 32 bits
                clock: 33MHz
                capabilities: bus_master ethernet physical wireless
                configuration: broadcast=3Dyes driver=3Dndiswrapper link=3D=
no multicast=3Dyes wireless=3DIEEE 802.11g
                resources: iomemory:c0204000-c0205fff irq:209
           *-pcmcia
                description: CardBus bridge
                product: PCIxx21/x515 Cardbus Controller
                vendor: Texas Instruments
                physical id: 9
                bus info: pci@05:09.0
                version: 00
                width: 32 bits
                clock: 33MHz
                capabilities: pcmcia bus_master cap_list
                configuration: driver=3Dyenta_cardbus
                resources: iomemory:c020a000-c020afff irq:185
           *-firewire
                description: FireWire (IEEE 1394)
                product: OHCI Compliant IEEE 1394 Host Controller
                vendor: Texas Instruments
                physical id: 9.2
                bus info: pci@05:09.2
                version: 00
                width: 32 bits
                clock: 33MHz
                capabilities: ohci bus_master cap_list
                configuration: driver=3Dohci1394
                resources: iomemory:c0208800-c0208fff iomemory:c0200000-c=
0203fff irq:225
           *-storage UNCLAIMED
                description: Mass storage controller
                product: PCIxx21 Integrated FlashMedia Controller
                vendor: Texas Instruments
                physical id: 9.3
                bus info: pci@05:09.3
                version: 00
                width: 32 bits
                clock: 33MHz
                capabilities: storage bus_master cap_list
                resources: iomemory:c0206000-c0207fff irq:10
           *-system UNCLAIMED
                description: Generic system peripheral
                product: PCI6411, PCI6421, PCI6611, PCI6621, PCI7411, PCI=
7421, PCI7611, PCI7621 Secure Digital (SD) Controller
                vendor: Texas Instruments
                physical id: 9.4
                bus info: pci@05:09.4
                version: 00
                width: 32 bits
                clock: 33MHz
                capabilities: bus_master cap_list
                resources: iomemory:c0209400-c02094ff iomemory:c0209000-c=
02090ff iomemory:c0208400-c02084ff irq:10
        *-multimedia
             description: Multimedia audio controller
             product: IXP SB400 AC'97 Audio Controller
             vendor: ATI Technologies Inc
             physical id: 14.5
             bus info: pci@00:14.5
             version: 80
             width: 32 bits
             clock: 66MHz
             capabilities: bus_master cap_list
             configuration: driver=3DATI IXP AC97 controller
             resources: iomemory:c0003400-c00034ff irq:185
        *-communication
             description: Modem
             product: ATI SB400 - AC'97 Modem Controller
             vendor: ATI Technologies Inc
             physical id: 14.6
             bus info: pci@00:14.6
             version: 80
             width: 32 bits
             clock: 66MHz
             capabilities: generic bus_master cap_list
             configuration: driver=3DATI IXP MC97 controller
             resources: iomemory:c0003800-c00038ff irq:185
     *-pci:1
          description: Host bridge
          product: K8 [Athlon64/Opteron] HyperTransport Technology Config=
uration
          vendor: Advanced Micro Devices [AMD]
          physical id: 101
          bus info: pci@00:18.0
          version: 00
          width: 32 bits
          clock: 33MHz
     *-pci:2
          description: Host bridge
          product: K8 [Athlon64/Opteron] Address Map
          vendor: Advanced Micro Devices [AMD]
          physical id: 102
          bus info: pci@00:18.1
          version: 00
          width: 32 bits
          clock: 33MHz
     *-pci:3
          description: Host bridge
          product: K8 [Athlon64/Opteron] DRAM Controller
          vendor: Advanced Micro Devices [AMD]
          physical id: 103
          bus info: pci@00:18.2
          version: 00
          width: 32 bits
          clock: 33MHz
     *-pci:4
          description: Host bridge
          product: K8 [Athlon64/Opteron] Miscellaneous Control
          vendor: Advanced Micro Devices [AMD]
          physical id: 104
          bus info: pci@00:18.3
          version: 00
          width: 32 bits
          clock: 33MHz
------=_20060329150618_94345
Content-Type: text/plain; name="dmesg.txt"
Content-Disposition: attachment; filename="dmesg.txt"
Content-Transfer-Encoding: quoted-printable

Bootdata ok (command line is root=3D/dev/hda5 reserve=3D0xc020a000,0x5000=
 vga=3D0x318 video=3Dvesafb:ywrap,mtrr,1024x768-32@72 splash=3Dsilent,fad=
ein,theme:livecd-2005.1,tty:12 quiet CONSOLE=3D/dev/tty1)
Linux version 2.6.15-gentoo-r1 (root@acj) (gcc version 3.4.4 (Gentoo 3.4.=
4-r1, ssp-3.4.4-1.0, pie-8.7.8)) #19 SMP Wed Mar 29 10:50:39 EST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d2000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000017ef0000 (usable)
 BIOS-e820: 0000000017ef0000 - 0000000017eff000 (ACPI data)
 BIOS-e820: 0000000017eff000 - 0000000017f00000 (ACPI NVS)
 BIOS-e820: 0000000017f00000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
ACPI: RSDP (v000 HP                                    ) @ 0x00000000000f=
8040
ACPI: RSDT (v001 HP     3093     0x20041209  LTP 0x00000000) @ 0x00000000=
17ef8ab7
ACPI: FADT (v001 HP     3093     0x20041209 PTL  0x0000005f) @ 0x00000000=
17efee09
ACPI: SSDT (v001 PTLTD  POWERNOW 0x20041209  LTP 0x00000001) @ 0x00000000=
17efee7d
ACPI: MADT (v001 PTLTD  	 3093   0x20041209  LTP 0x00000000) @ 0x00000000=
17efef74
ACPI: MCFG (v001 PTLTD    MCFG   0x20041209  LTP 0x00000000) @ 0x00000000=
17efefc4
ACPI: DSDT (v001 HP     3091     0x20041209 MSFT 0x0100000e) @ 0x00000000=
00000000
Scanning NUMA topology in Northbridge 24
Number of nodes 1
Node 0 MemBase 0000000000000000 Limit 0000000017ef0000
Using 63 for the hash shift.
Using node hash shift of 63
Bootmem setup node 0 0000000000000000-0000000017ef0000
On node 0 totalpages: 94927
  DMA zone: 2275 pages, LIFO batch:0
  DMA32 zone: 92652 pages, LIFO batch:31
  Normal zone: 0 pages, LIFO batch:0
  HighMem zone: 0 pages, LIFO batch:0
ACPI: PM-Timer IO Port: 0x8008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:4 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 33, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 21 low level)
Setting APIC routing to physical flat
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 30000000 (gap: 20000000:dec00000)
Checking aperture...
CPU 0: aperture @ 9c6000000 size 32 MB
Aperture from northbridge cpu 0 too small (32 MB)
No AGP bridge found
SMP: Allowing 3 CPUs, 2 hotplug CPUs
Built 1 zonelists
Kernel command line: root=3D/dev/hda5 reserve=3D0xc020a000,0x5000 vga=3D0=
x318 video=3Dvesafb:ywrap,mtrr,1024x768-32@72 splash=3Dsilent,fadein,them=
e:livecd-2005.1,tty:12 quiet CONSOLE=3D/dev/tty1
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 65536 bytes)
time.c: Using 3.579545 MHz PM timer.
time.c: Detected 1994.242 MHz processor.
Console: colour dummy device 80x25
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Memory: 377484k/392128k available (4011k kernel code, 14256k reserved, 17=
06k data, 240k init)
Calibrating delay using timer specific routine.. 3996.78 BogoMIPS (lpj=3D=
7993576)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Failure registering Root Plug module with the kernel
selinux_register_security:  There is already a secondary security module =
registered.
Failure registering Root Plug  module with primary security module.
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 0(1) -> Node 0 -> Core 0
mtrr: v2.0 (20020519)
Using local APIC timer interrupts.
Detected 12.464 MHz APIC timer.
Brought up 1 CPUs
time.c: Using PIT/TSC based timekeeping.
testing NMI watchdog ... OK.
checking if image is initramfs... it is
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
PCI: Using MMCONFIG at e0000000
ACPI: Subsystem revision 20050902
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Scanning bus 0000:00
PCI: Found 0000:00:00.0 [1002/5950] 000600 00
PCI: Calling quirk ffffffff80309dcb for 0000:00:00.0
PCI: Calling quirk ffffffff80454d75 for 0000:00:00.0
PCI: Calling quirk ffffffff80454a83 for 0000:00:00.0
PCI: Found 0000:00:01.0 [1002/5a3f] 000604 01
PCI: Calling quirk ffffffff80309dcb for 0000:00:01.0
PCI: Calling quirk ffffffff80454d75 for 0000:00:01.0
PCI: Calling quirk ffffffff80454a83 for 0000:00:01.0
PCI: Found 0000:00:13.0 [1002/4374] 000c03 00
PCI: Calling quirk ffffffff80309dcb for 0000:00:13.0
PCI: Calling quirk ffffffff80454d75 for 0000:00:13.0
PCI: Calling quirk ffffffff80454a83 for 0000:00:13.0
PCI: Found 0000:00:13.1 [1002/4375] 000c03 00
PCI: Calling quirk ffffffff80309dcb for 0000:00:13.1
PCI: Calling quirk ffffffff80454d75 for 0000:00:13.1
PCI: Calling quirk ffffffff80454a83 for 0000:00:13.1
PCI: Found 0000:00:13.2 [1002/4373] 000c03 00
PCI: Calling quirk ffffffff80309dcb for 0000:00:13.2
PCI: Calling quirk ffffffff80454d75 for 0000:00:13.2
PCI: Calling quirk ffffffff80454a83 for 0000:00:13.2
PCI: Found 0000:00:14.0 [1002/4372] 000c05 00
PCI: Calling quirk ffffffff80309dcb for 0000:00:14.0
PCI: Calling quirk ffffffff80454d75 for 0000:00:14.0
PCI: Calling quirk ffffffff80454a83 for 0000:00:14.0
PCI: Found 0000:00:14.1 [1002/4376] 000101 00
PCI: Calling quirk ffffffff80309dcb for 0000:00:14.1
PCI: Ignoring BAR0-3 of IDE controller 0000:00:14.1
PCI: Calling quirk ffffffff80454d75 for 0000:00:14.1
PCI: Calling quirk ffffffff80454a83 for 0000:00:14.1
PCI: Found 0000:00:14.3 [1002/4377] 000601 00
PCI: Calling quirk ffffffff80309dcb for 0000:00:14.3
PCI: Calling quirk ffffffff80454d75 for 0000:00:14.3
PCI: Calling quirk ffffffff80454a83 for 0000:00:14.3
PCI: Found 0000:00:14.4 [1002/4371] 000604 01
PCI: Calling quirk ffffffff80309dcb for 0000:00:14.4
PCI: Calling quirk ffffffff80454d75 for 0000:00:14.4
PCI: Calling quirk ffffffff80454a83 for 0000:00:14.4
PCI: Found 0000:00:14.5 [1002/4370] 000401 00
PCI: Calling quirk ffffffff80309dcb for 0000:00:14.5
PCI: Calling quirk ffffffff80454d75 for 0000:00:14.5
PCI: Calling quirk ffffffff80454a83 for 0000:00:14.5
PCI: Found 0000:00:14.6 [1002/4378] 000703 00
PCI: Calling quirk ffffffff80309dcb for 0000:00:14.6
PCI: Calling quirk ffffffff80454d75 for 0000:00:14.6
PCI: Calling quirk ffffffff80454a83 for 0000:00:14.6
PCI: Found 0000:00:18.0 [1022/1100] 000600 00
PCI: Calling quirk ffffffff80309dcb for 0000:00:18.0
PCI: Calling quirk ffffffff80454d75 for 0000:00:18.0
PCI: Calling quirk ffffffff80454a83 for 0000:00:18.0
PCI: Found 0000:00:18.1 [1022/1101] 000600 00
PCI: Calling quirk ffffffff80309dcb for 0000:00:18.1
PCI: Calling quirk ffffffff80454d75 for 0000:00:18.1
PCI: Calling quirk ffffffff80454a83 for 0000:00:18.1
PCI: Found 0000:00:18.2 [1022/1102] 000600 00
PCI: Calling quirk ffffffff80309dcb for 0000:00:18.2
PCI: Calling quirk ffffffff80454d75 for 0000:00:18.2
PCI: Calling quirk ffffffff80454a83 for 0000:00:18.2
PCI: Found 0000:00:18.3 [1022/1103] 000600 00
PCI: Calling quirk ffffffff80309dcb for 0000:00:18.3
PCI: Calling quirk ffffffff80454d75 for 0000:00:18.3
PCI: Calling quirk ffffffff80454a83 for 0000:00:18.3
PCI: Fixups for bus 0000:00
PCI: Scanning behind PCI bridge 0000:00:01.0, config 010100, pass 0
PCI: Scanning bus 0000:01
PCI: Found 0000:01:05.0 [1002/5955] 000300 00
PCI: Calling quirk ffffffff80309dcb for 0000:01:05.0
PCI: Calling quirk ffffffff80454d75 for 0000:01:05.0
Boot video device is 0000:01:05.0
PCI: Calling quirk ffffffff80454a83 for 0000:01:05.0
PCI: Fixups for bus 0000:01
PCI: Bus scan for 0000:01 returning with max=3D01
PCI: Scanning behind PCI bridge 0000:00:14.4, config 050500, pass 0
PCI: Scanning bus 0000:05
PCI: Found 0000:05:00.0 [10ec/8139] 000200 00
PCI: Calling quirk ffffffff80309dcb for 0000:05:00.0
PCI: Calling quirk ffffffff80454d75 for 0000:05:00.0
PCI: Calling quirk ffffffff80454a83 for 0000:05:00.0
PCI: Found 0000:05:02.0 [14e4/4318] 000280 00
PCI: Calling quirk ffffffff80309dcb for 0000:05:02.0
PCI: Calling quirk ffffffff80454d75 for 0000:05:02.0
PCI: Calling quirk ffffffff80454a83 for 0000:05:02.0
PCI: Found 0000:05:09.0 [104c/8031] 000607 02
PCI: Calling quirk ffffffff80309dcb for 0000:05:09.0
PCI: Calling quirk ffffffff80454d75 for 0000:05:09.0
PCI: Calling quirk ffffffff80454a83 for 0000:05:09.0
PCI: Found 0000:05:09.2 [104c/8032] 000c00 00
PCI: Calling quirk ffffffff80309dcb for 0000:05:09.2
PCI: Calling quirk ffffffff80454dfc for 0000:05:09.2
PCI: Calling quirk ffffffff80454d75 for 0000:05:09.2
PCI: Calling quirk ffffffff80454a83 for 0000:05:09.2
PCI: Found 0000:05:09.3 [104c/8033] 000180 00
PCI: Calling quirk ffffffff80309dcb for 0000:05:09.3
PCI: Calling quirk ffffffff80454d75 for 0000:05:09.3
PCI: Calling quirk ffffffff80454a83 for 0000:05:09.3
PCI: Found 0000:05:09.4 [104c/8034] 000805 00
PCI: Calling quirk ffffffff80309dcb for 0000:05:09.4
PCI: Calling quirk ffffffff80454d75 for 0000:05:09.4
PCI: Calling quirk ffffffff80454a83 for 0000:05:09.4
PCI: Fixups for bus 0000:05
PCI: Transparent bridge - 0000:00:14.4
PCI: Scanning behind PCI bridge 0000:05:09.0, config 000000, pass 0
PCI: Scanning behind PCI bridge 0000:05:09.0, config 000000, pass 1
PCI: Bus scan for 0000:05 returning with max=3D09
PCI: Scanning behind PCI bridge 0000:00:01.0, config 010100, pass 1
PCI: Scanning behind PCI bridge 0000:00:14.4, config 050500, pass 1
PCI: Bus scan for 0000:00 returning with max=3D09
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKB] (IRQs 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKE] (IRQs 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 10 11) *0, disabled.
    ACPI-0339: *** Error: Looking up [UPRS] in namespace, AE_NOT_FOUND
search_node ffff81000165b400 start_node ffff81000165b400 return_node 0000=
000000000000
    ACPI-0508: *** Error: Method execution failed [\_SB_.PCI0.LPC0.LNKU._=
PRS] (Node ffff81000165b400), AE_NOT_FOUND
ACPI: Embedded Controller [EC0] (gpe 24)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P2P_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: ACPI device : hid PNP0C02
pnp: ACPI device : hid PNP0200
pnp: ACPI device : hid PNP0C04
pnp: ACPI device : hid PNP0B00
pnp: ACPI device : hid PNP0800
pnp: ACPI device : hid PNP0303
pnp: ACPI device : hid SYN011C
pnp: ACPI device : hid PNP0C02
pnp: ACPI device : hid PNP0C01
pnp: ACPI device : hid PNP0C14
pnp: PnP ACPI: found 10 devices
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=3Drouteirq".  If it helps, post a=
 report
Bluetooth: Core ver 2.8
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
PCI-DMA: Disabling IOMMU.
pnp: the driver 'system' has been registered
pnp: match found with the PnP device '00:00' and the driver 'system'
pnp: match found with the PnP device '00:07' and the driver 'system'
pnp: 00:07: ioport range 0x1080-0x1080 has been reserved
pnp: 00:07: ioport range 0x220-0x22f has been reserved
pnp: 00:07: ioport range 0x40b-0x40b has been reserved
pnp: 00:07: ioport range 0x4d0-0x4d1 has been reserved
pnp: match found with the PnP device '00:08' and the driver 'system'
  got res [c0120000:c013ffff] bus [c0120000:c013ffff] flags 7202 for BAR =
6 of 0000:01:05.0
PCI: Bridge: 0000:00:01.0
  IO window: 9000-9fff
  MEM window: c0100000-c01fffff
  PREFETCH window: c8000000-cfffffff
  got res [c020a000:c020afff] bus [c020a000:c020afff] flags 200 for BAR 0=
 of 0000:05:09.0
PCI: moved device 0000:05:09.0 resource 0 (200) to c020a000
PCI: Bus 6, cardbus bridge: 0000:05:09.0
  IO window: 0000a400-0000a4ff
  IO window: 0000a800-0000a8ff
  PREFETCH window: 30000000-31ffffff
  MEM window: 32000000-33ffffff
PCI: Bridge: 0000:00:14.4
  IO window: a000-afff
  MEM window: c0200000-c02fffff
  PREFETCH window: 30000000-31ffffff
GSI 16 sharing vector 0xB9 and IRQ 16
ACPI: PCI Interrupt 0000:05:09.0[A] -> GSI 17 (level, low) -> IRQ 185
PCI: Setting latency timer of device 0000:05:09.0 to 64
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver 2.1.25 [Flags: R/W].
JFS: nTxBlock =3D 2949, nTxLock =3D 23592
SGI XFS with large block/inode numbers, no debug enabled
SELinux:  Registering netfilter hooks
seclvl: seclvl_init: seclvl: Failure registering with the kernel.
selinux_register_security:  There is already a secondary security module =
registered.
seclvl: seclvl_init: seclvl: Failure registering with primary security mo=
dule.
seclvl: Error during initialization: rc =3D [-22]
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
PCI: Calling quirk ffffffff80309cff for 0000:00:00.0
PCI: Calling quirk ffffffff8043292b for 0000:00:00.0
PCI: Calling quirk ffffffff80309cff for 0000:00:01.0
PCI: Calling quirk ffffffff8043292b for 0000:00:01.0
PCI: Calling quirk ffffffff80309cff for 0000:00:13.0
PCI: Calling quirk ffffffff8043292b for 0000:00:13.0
PCI: Calling quirk ffffffff80309cff for 0000:00:13.1
PCI: Calling quirk ffffffff8043292b for 0000:00:13.1
PCI: Calling quirk ffffffff80309cff for 0000:00:13.2
PCI: Calling quirk ffffffff8043292b for 0000:00:13.2
PCI: Calling quirk ffffffff80309cff for 0000:00:14.0
PCI: Calling quirk ffffffff8043292b for 0000:00:14.0
PCI: Calling quirk ffffffff80309cff for 0000:00:14.1
PCI: Calling quirk ffffffff8043292b for 0000:00:14.1
PCI: Calling quirk ffffffff80309cff for 0000:00:14.3
PCI: Calling quirk ffffffff8043292b for 0000:00:14.3
PCI: Calling quirk ffffffff80309cff for 0000:00:14.4
PCI: Calling quirk ffffffff8043292b for 0000:00:14.4
PCI: Calling quirk ffffffff80309cff for 0000:00:14.5
PCI: Calling quirk ffffffff8043292b for 0000:00:14.5
PCI: Calling quirk ffffffff80309cff for 0000:00:14.6
PCI: Calling quirk ffffffff8043292b for 0000:00:14.6
PCI: Calling quirk ffffffff80309cff for 0000:00:18.0
PCI: Calling quirk ffffffff8043292b for 0000:00:18.0
PCI: Calling quirk ffffffff80309cff for 0000:00:18.1
PCI: Calling quirk ffffffff8043292b for 0000:00:18.1
PCI: Calling quirk ffffffff80309cff for 0000:00:18.2
PCI: Calling quirk ffffffff8043292b for 0000:00:18.2
PCI: Calling quirk ffffffff80309cff for 0000:00:18.3
PCI: Calling quirk ffffffff8043292b for 0000:00:18.3
PCI: Calling quirk ffffffff80309cff for 0000:01:05.0
PCI: Calling quirk ffffffff8043292b for 0000:01:05.0
PCI: Calling quirk ffffffff80309cff for 0000:05:00.0
PCI: Calling quirk ffffffff8043292b for 0000:05:00.0
PCI: Calling quirk ffffffff80309cff for 0000:05:02.0
PCI: Calling quirk ffffffff8043292b for 0000:05:02.0
PCI: Calling quirk ffffffff80309cff for 0000:05:09.0
PCI: Calling quirk ffffffff8043292b for 0000:05:09.0
PCI: Calling quirk ffffffff80309cff for 0000:05:09.2
PCI: Calling quirk ffffffff8043292b for 0000:05:09.2
PCI: Calling quirk ffffffff80309cff for 0000:05:09.3
PCI: Calling quirk ffffffff8043292b for 0000:05:09.3
PCI: Calling quirk ffffffff80309cff for 0000:05:09.4
PCI: Calling quirk ffffffff8043292b for 0000:05:09.4
vesafb: framebuffer at 0xc8000000, mapped to 0xffffc20010300000, using 46=
08k, total 131072k
vesafb: mode is 1024x768x24, linelength=3D3072, pages=3D55
vesafb: scrolling: redraw
vesafb: Truecolor: size=3D0:8:8:8, shift=3D0:16:8:0
vesafb: Mode is not VGA compatible
Console: switching to colour frame buffer device 128x48
fbsplash: console 0 using theme 'livecd-2005.1'
fb0: VESA VGA frame buffer device
vga16fb: initializing
vga16fb: mapped to 0xffff8100000a0000
fb1: VGA16 VGA frame buffer device
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Lid Switch [LID]
ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI: Thermal Zone [THRM] (70 C)
Real Time Clock Driver v1.12
Software Watchdog Timer: 0.07 initialized. soft_noboot=3D0 soft_margin=3D=
60 sec (nowayout=3D 0)
Linux agpgart interface v0.101 (c) Dave Jones
pnp: the driver 'i8042 kbd' has been registered
pnp: match found with the PnP device '00:05' and the driver 'i8042 kbd'
pnp: the driver 'i8042 aux' has been registered
pnp: match found with the PnP device '00:06' and the driver 'i8042 aux'
PNP: PS/2 Controller [PNP0303:KBC0,PNP0f13:MSE0] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
pnp: the driver 'serial' has been registered
ACPI: PCI Interrupt 0000:00:14.6[B] -> GSI 17 (level, low) -> IRQ 185
ACPI: PCI interrupt for device 0000:00:14.6 disabled
mice: PS/2 mouse device common for all mice
input: PC Speaker as /class/input/input0
input: AT Translated Set 2 keyboard as /class/input/input1
Synaptics Touchpad, model: 1, fw: 5.10, id: 0x258eb1, caps: 0xa04713/0x0
input: SynPS/2 Synaptics TouchPad as /class/input/input2
floppy0: no floppy controllers found
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Intel(R) PRO/1000 Network Driver - version 6.1.16-k2
Copyright (c) 1999-2005 Intel Corporation.
e100: Intel(R) PRO/100 Network Driver, 3.4.14-k4-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.48.
8139too Fast Ethernet driver 0.9.27
GSI 17 sharing vector 0xC1 and IRQ 17
ACPI: PCI Interrupt 0000:05:00.0[A] -> GSI 18 (level, low) -> IRQ 193
eth0: RealTek RTL8139 at 0xffffc20000022000, 00:16:36:13:cd:af, IRQ 193
eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
netconsole: not configured, aborting
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
ATIIXP: IDE controller at PCI slot 0000:00:14.1
GSI 18 sharing vector 0xC9 and IRQ 18
ACPI: PCI Interrupt 0000:00:14.1[A] -> GSI 16 (level, low) -> IRQ 201
ATIIXP: chipset revision 128
ATIIXP: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x8410-0x8417, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x8418-0x841f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: TOSHIBA MK1031GAS, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: PIONEER DVDRW DVR-K15, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
pnp: the driver 'ide' has been registered
hda: max request size: 128KiB
hda: 195371568 sectors (100030 MB), CHS=3D65535/16/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 hda12 hd=
a13 hda14 >
hdc: ATAPI 24X DVD-ROM DVD-R CD-R/RW drive, 2000kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
libata version 1.20 loaded.
Fusion MPT base driver 3.03.04
Copyright (c) 1999-2005 LSI Logic Corporation
Fusion MPT SPI Host driver 3.03.04
ACPI: PCI Interrupt 0000:05:09.0[A] -> GSI 17 (level, low) -> IRQ 185
Yenta: CardBus bridge found at 0000:05:09.0 [103c:3091]
Yenta: Enabling burst memory read transactions
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:05:09.0, mfunc 0x01a01b22, devctl 0x64
Yenta: ISA IRQ mask 0x0ef8, PCI irq 185
Socket status: 30000820
pcmcia: parent PCI bridge I/O window: 0xa000 - 0xafff
pcmcia: parent PCI bridge Memory window: 0xc0200000 - 0xc02fffff
pcmcia: parent PCI bridge Memory window: 0x30000000 - 0x31ffffff
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
i2c /dev entries driver
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
Intel 810 + AC97 Audio, version 1.01, 15:18:30 Feb  1 2006
oprofile: using NMI interrupt.
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 3, 32768 bytes)
TCP established hash table entries: 16384 (order: 6, 262144 bytes)
TCP bind hash table entries: 16384 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version 1.50.4)
powernow-k8:    0 : fid 0xc (2000 MHz), vid 0x4 (1450 mV)
powernow-k8:    1 : fid 0xa (1800 MHz), vid 0x6 (1400 mV)
powernow-k8:    2 : fid 0x8 (1600 MHz), vid 0x8 (1350 mV)
powernow-k8:    3 : fid 0x0 (800 MHz), vid 0x16 (1000 mV)
cpu_init done, current fid 0xc, vid 0x4
ACPI wakeup devices:=20
KBC0 MSE0  P2P AUDO=20
ACPI: (supports S0 S3 S4 S5)
ReiserFS: hda5: found reiserfs format "3.6" with standard journal
ReiserFS: hda5: using ordered data mode
ReiserFS: hda5: journal params: device hda5, size 8192, journal first blo=
ck 18, max trans len 1024, max batch 900, max commit age 30, max trans ag=
e 30
ReiserFS: hda5: checking transaction log (hda5)
ReiserFS: hda5: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 240k freed
pccard: CardBus card inserted into slot 0
Adding 979956k swap on /dev/hda3.  Priority:-1 extents:1 across:979956k
fbsplash: switched splash state to 'on' on console 0
ndiswrapper version 1.8 loaded (preempt=3Dno,smp=3Dyes)
ndiswrapper (load_pe_images:571): fixing KI_USER_SHARED_DATA address in t=
he driver
ndiswrapper: driver bcmwl5 (Broadcom,02/11/2005, 3.100.64.0) loaded
GSI 19 sharing vector 0xD1 and IRQ 19
ACPI: PCI Interrupt 0000:05:02.0[A] -> GSI 20 (level, low) -> IRQ 209
ndiswrapper: using irq 209
wlan0: vendor: ''
wlan0: ndiswrapper ethernet device 00:14:a5:69:0e:b4 using driver bcmwl5,=
 14E4:4318.5.conf
wlan0: encryption modes supported: WEP; TKIP with WPA, WPA2, WPA2PSK; AES=
/CCMP with WPA, WPA2, WPA2PSK
[fglrx] Maximum main memory to use for locked dma buffers: 307 MBytes.
ACPI: PCI Interrupt 0000:01:05.0[A] -> GSI 17 (level, low) -> IRQ 185
[fglrx] module loaded - fglrx 8.22.5 [Feb  7 2006] on minor 0
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI=
)
ohci_hcd: block sizes: ed 80 td 96
GSI 20 sharing vector 0xD9 and IRQ 20
ACPI: PCI Interrupt 0000:00:13.0[A] -> GSI 19 (level, low) -> IRQ 217
ohci_hcd 0000:00:13.0: OHCI Host Controller
drivers/usb/core/inode.c: creating file 'devices'
drivers/usb/core/inode.c: creating file '001'
ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:13.0: irq 217, io mem 0xc0000000
ohci_hcd 0000:00:13.0: resetting from state 'reset', control =3D 0x0
ohci_hcd 0000:00:13.0: OHCI controller state
ohci_hcd 0000:00:13.0: OHCI 1.0, NO legacy support registers
ohci_hcd 0000:00:13.0: control 0x083 HCFS=3Doperational CBSR=3D3
ohci_hcd 0000:00:13.0: cmdstatus 0x00000 SOC=3D0
ohci_hcd 0000:00:13.0: intrstatus 0x00000044 RHSC SF
ohci_hcd 0000:00:13.0: intrenable 0x8000001a MIE UE RD WDH
ohci_hcd 0000:00:13.0: hcca frame #0005
ohci_hcd 0000:00:13.0: roothub.a 02000204 POTPGT=3D2 NPS NDP=3D4(4)
ohci_hcd 0000:00:13.0: roothub.b 00000000 PPCM=3D0000 DR=3D0000
ohci_hcd 0000:00:13.0: roothub.status 00008000 DRWE
ohci_hcd 0000:00:13.0: roothub.portstatus [0] 0x00010301 CSC LSDA PPS CCS
ohci_hcd 0000:00:13.0: roothub.portstatus [1] 0x00000100 PPS
ohci_hcd 0000:00:13.0: roothub.portstatus [2] 0x00000100 PPS
ohci_hcd 0000:00:13.0: roothub.portstatus [3] 0x00000100 PPS
ohci_hcd 0000:00:13.0: created debug files
usb usb1: default language 0x0409
usb usb1: new device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
usb usb1: Product: OHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.15-gentoo-r1 ohci_hcd
usb usb1: SerialNumber: 0000:00:13.0
usb usb1: hotplug
usb usb1: adding 1-0:1.0 (config #1, interface 0)
usb 1-0:1.0: hotplug
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 4 ports detected
hub 1-0:1.0: standalone hub
hub 1-0:1.0: no power switching (usb 1.0)
hub 1-0:1.0: global over-current protection
hub 1-0:1.0: power on to power good time: 4ms
hub 1-0:1.0: local power source is good
hub 1-0:1.0: no over-current condition exists
hub 1-0:1.0: state 5 ports 4 chg 0000 evt 0000
drivers/usb/core/inode.c: creating file '001'
ohci_hcd 0000:00:13.0: GetStatus roothub.portstatus [0] =3D 0x00010301 CS=
C LSDA PPS CCS
hub 1-0:1.0: port 1, status 0301, change 0001, 1.5 Mb/s
ACPI: PCI Interrupt 0000:00:13.1[A] -> GSI 19 (level, low) -> IRQ 217
ohci_hcd 0000:00:13.1: OHCI Host Controller
drivers/usb/core/inode.c: creating file '002'
ohci_hcd 0000:00:13.1: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:13.1: irq 217, io mem 0xc0001000
ohci_hcd 0000:00:13.1: resetting from state 'reset', control =3D 0x0
ohci_hcd 0000:00:13.1: OHCI controller state
ohci_hcd 0000:00:13.1: OHCI 1.0, NO legacy support registers
ohci_hcd 0000:00:13.1: control 0x083 HCFS=3Doperational CBSR=3D3
ohci_hcd 0000:00:13.1: cmdstatus 0x00000 SOC=3D0
ohci_hcd 0000:00:13.1: intrstatus 0x00000044 RHSC SF
ohci_hcd 0000:00:13.1: intrenable 0x8000001a MIE UE RD WDH
ohci_hcd 0000:00:13.1: hcca frame #0005
ohci_hcd 0000:00:13.1: roothub.a 02000204 POTPGT=3D2 NPS NDP=3D4(4)
ohci_hcd 0000:00:13.1: roothub.b 00000000 PPCM=3D0000 DR=3D0000
ohci_hcd 0000:00:13.1: roothub.status 00008000 DRWE
ohci_hcd 0000:00:13.1: roothub.portstatus [0] 0x00000100 PPS
ohci_hcd 0000:00:13.1: roothub.portstatus [1] 0x00000100 PPS
ohci_hcd 0000:00:13.1: roothub.portstatus [2] 0x00010101 CSC PPS CCS
ohci_hcd 0000:00:13.1: roothub.portstatus [3] 0x00000100 PPS
ohci_hcd 0000:00:13.1: created debug files
usb usb2: default language 0x0409
usb usb2: new device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
usb usb2: Product: OHCI Host Controller
usb usb2: Manufacturer: Linux 2.6.15-gentoo-r1 ohci_hcd
usb usb2: SerialNumber: 0000:00:13.1
usb usb2: hotplug
usb usb2: adding 2-0:1.0 (config #1, interface 0)
usb 2-0:1.0: hotplug
hub 2-0:1.0: usb_probe_interface
hub 2-0:1.0: usb_probe_interface - got id
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 4 ports detected
hub 2-0:1.0: standalone hub
hub 2-0:1.0: no power switching (usb 1.0)
hub 2-0:1.0: global over-current protection
hub 2-0:1.0: power on to power good time: 4ms
hub 2-0:1.0: local power source is good
hub 2-0:1.0: no over-current condition exists
hub 1-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x301
drivers/usb/core/inode.c: creating file '001'
ohci_hcd 0000:00:13.0: GetStatus roothub.portstatus [0] =3D 0x00100303 PR=
SC LSDA PPS PES CCS
ehci_hcd: block sizes: qh 160 qtd 96 itd 192 sitd 96
ACPI: PCI Interrupt 0000:00:13.2[A] -> GSI 19 (level, low) -> IRQ 217
ehci_hcd 0000:00:13.2: EHCI Host Controller
ehci_hcd 0000:00:13.2: reset hcs_params 0x2408 dbg=3D0 cc=3D2 pcc=3D4 ord=
ered !ppc ports=3D8
ehci_hcd 0000:00:13.2: reset hcc_params a012 thresh 1 uframes 256/512/102=
4
ehci_hcd 0000:00:13.2: capability 0001 at a0
ehci_hcd 0000:00:13.2: MWI active
drivers/usb/core/inode.c: creating file '003'
ehci_hcd 0000:00:13.2: new USB bus registered, assigned bus number 3
ehci_hcd 0000:00:13.2: irq 217, io mem 0xc0002000
ehci_hcd 0000:00:13.2: reset command 080002 (park)=3D0 ithresh=3D8 period=
=3D1024 Reset HALT
ehci_hcd 0000:00:13.2: init command 010009 (park)=3D0 ithresh=3D1 period=3D=
256 RUN
ehci_hcd 0000:00:13.2: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb3: default language 0x0409
usb usb3: new device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
usb usb3: Product: EHCI Host Controller
usb usb3: Manufacturer: Linux 2.6.15-gentoo-r1 ehci_hcd
usb usb3: SerialNumber: 0000:00:13.2
usb usb3: hotplug
usb usb3: adding 3-0:1.0 (config #1, interface 0)
usb 3-0:1.0: hotplug
hub 3-0:1.0: usb_probe_interface
hub 3-0:1.0: usb_probe_interface - got id
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 8 ports detected
hub 3-0:1.0: standalone hub
hub 3-0:1.0: no power switching (usb 1.0)
hub 3-0:1.0: individual port over-current protection
hub 3-0:1.0: Single TT
hub 3-0:1.0: TT requires at most 8 FS bit times (666 ns)
hub 3-0:1.0: power on to power good time: 20ms
hub 3-0:1.0: local power source is good
usb 1-1: new low speed USB device using ohci_hcd and address 2
ohci_hcd 0000:00:13.0: urb ffff810012cd60c0 path 1 ep0in 5ec20000 cc 5 --=
> status -110
ohci_hcd 0000:00:13.0: urb ffff810012cd60c0 path 1 ep0in 5ec20000 cc 5 --=
> status -110
ohci_hcd 0000:00:13.0: urb ffff810012cd60c0 path 1 ep0in 5ec20000 cc 5 --=
> status -110
ohci_hcd 0000:00:13.0: GetStatus roothub.portstatus [0] =3D 0x00030100 PE=
SC CSC PPS
hub 2-0:1.0: state 5 ports 4 chg 0000 evt 0000
ohci_hcd 0000:00:13.1: GetStatus roothub.portstatus [2] =3D 0x00010100 CS=
C PPS
hub 2-0:1.0: port 3, status 0100, change 0001, 12 Mb/s
drivers/usb/core/inode.c: creating file '001'
hub 2-0:1.0: debounce: port 3: total 100ms stable 100ms status 0x100
hub 1-0:1.0: state 5 ports 4 chg 0000 evt 0002
usbcore: registered new driver usbserial
ohci_hcd 0000:00:13.0: GetStatus roothub.portstatus [0] =3D 0x00030100 PE=
SC CSC PPS
hub 1-0:1.0: port 1, status 0100, change 0003, 12 Mb/s
drivers/usb/serial/usb-serial.c: USB Serial support registered for generi=
c
hub 1-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x100
hub 3-0:1.0: state 5 ports 8 chg 0000 evt 0042
usbcore: registered new driver usbserial_generic
drivers/usb/serial/usb-serial.c: USB Serial Driver core
ehci_hcd 0000:00:13.2: GetStatus port 1 status 001403 POWER sig=3Dk CSC C=
ONNECT
hub 3-0:1.0: port 1, status 0501, change 0001, 480 Mb/s
CSLIP: code copyright 1989 Regents of the University of California
PPP generic driver version 2.4.2
hub 3-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x501
ehci_hcd 0000:00:13.2: port 1 low speed --> companion
ehci_hcd 0000:00:13.2: GetStatus port 6 status 001803 POWER sig=3Dj CSC C=
ONNECT
hub 3-0:1.0: port 6, status 0501, change 0001, 480 Mb/s
hub 3-0:1.0: debounce: port 6: total 100ms stable 100ms status 0x501
ehci_hcd 0000:00:13.2: port 6 full speed --> companion
ehci_hcd 0000:00:13.2: GetStatus port 6 status 003801 POWER OWNER sig=3Dj=
 CONNECT
hub 1-0:1.0: state 5 ports 4 chg 0000 evt 0002
ohci_hcd 0000:00:13.0: GetStatus roothub.portstatus [0] =3D 0x00010301 CS=
C LSDA PPS CCS
hub 1-0:1.0: port 1, status 0301, change 0001, 1.5 Mb/s
hub 1-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x301
ohci_hcd 0000:00:13.0: GetStatus roothub.portstatus [0] =3D 0x00100303 PR=
SC LSDA PPS PES CCS
usb 1-1: new low speed USB device using ohci_hcd and address 3
ohci_hcd 0000:00:13.0: GetStatus roothub.portstatus [0] =3D 0x00100303 PR=
SC LSDA PPS PES CCS
usb 1-1: skipped 1 descriptor after interface
usb 1-1: new device strings: Mfr=3D0, Product=3D0, SerialNumber=3D0
usb 1-1: hotplug
usb 1-1: adding 1-1:1.0 (config #1, interface 0)
usb 1-1:1.0: hotplug
usbhid 1-1:1.0: usb_probe_interface
usbhid 1-1:1.0: usb_probe_interface - got id
input: HID 1241:1177 as /class/input/input3
input: USB HID v1.10 Mouse [HID 1241:1177] on usb-0000:00:13.0-1
drivers/usb/core/inode.c: creating file '003'
hub 3-0:1.0: state 5 ports 8 chg 0000 evt 0000
hub 2-0:1.0: state 5 ports 4 chg 0000 evt 0008
ohci_hcd 0000:00:13.1: GetStatus roothub.portstatus [2] =3D 0x00010101 CS=
C PPS CCS
hub 2-0:1.0: port 3, status 0101, change 0001, 12 Mb/s
hub 2-0:1.0: debounce: port 3: total 100ms stable 100ms status 0x101
ohci_hcd 0000:00:13.1: GetStatus roothub.portstatus [2] =3D 0x00100103 PR=
SC PPS PES CCS
usb 2-3: new full speed USB device using ohci_hcd and address 2
ohci_hcd 0000:00:13.1: GetStatus roothub.portstatus [2] =3D 0x00100103 PR=
SC PPS PES CCS
usb 2-3: skipped 1 descriptor after interface
usb 2-3: default language 0x0409
usb 2-3: new device strings: Mfr=3D1, Product=3D2, SerialNumber=3D0
usb 2-3: Product: HP integrated Bluetooth module
usb 2-3: Manufacturer: Broadcom
usb 2-3: hotplug
usb 2-3: adding 2-3:1.0 (config #1, interface 0)
usb 2-3:1.0: hotplug
usbserial_generic 2-3:1.0: usb_probe_interface
usbserial_generic 2-3:1.0: usb_probe_interface - got id
usb 2-3: adding 2-3:1.1 (config #1, interface 1)
usb 2-3:1.1: hotplug
usbserial_generic 2-3:1.1: usb_probe_interface
usbserial_generic 2-3:1.1: usb_probe_interface - got id
usb 2-3: adding 2-3:1.2 (config #1, interface 2)
usb 2-3:1.2: hotplug
usbserial_generic 2-3:1.2: usb_probe_interface
usbserial_generic 2-3:1.2: usb_probe_interface - got id
usb 2-3: adding 2-3:1.3 (config #1, interface 3)
usb 2-3:1.3: hotplug
usbserial_generic 2-3:1.3: usb_probe_interface
usbserial_generic 2-3:1.3: usb_probe_interface - got id
drivers/usb/core/inode.c: creating file '002'
hub 1-0:1.0: state 5 ports 4 chg 0000 evt 0002
Bluetooth: HCI USB driver ver 2.9
hci_usb 2-3:1.0: usb_probe_interface
hci_usb 2-3:1.0: usb_probe_interface - got id
hci_usb 2-3:1.2: usb_probe_interface
hci_usb 2-3:1.2: usb_probe_interface - got id
hci_usb 2-3:1.3: usb_probe_interface
hci_usb 2-3:1.3: usb_probe_interface - got id
usbcore: registered new driver hci_usb
ReiserFS: hda6: found reiserfs format "3.6" with standard journal
ReiserFS: hda6: using ordered data mode
ReiserFS: hda6: journal params: device hda6, size 8192, journal first blo=
ck 18, max trans len 1024, max batch 900, max commit age 30, max trans ag=
e 30
ReiserFS: hda6: checking transaction log (hda6)
ReiserFS: hda6: Using r5 hash to sort names
ReiserFS: hda7: found reiserfs format "3.6" with standard journal
ReiserFS: hda7: using ordered data mode
ReiserFS: hda7: journal params: device hda7, size 8192, journal first blo=
ck 18, max trans len 1024, max batch 900, max commit age 30, max trans ag=
e 30
ReiserFS: hda7: checking transaction log (hda7)
ReiserFS: hda7: Using r5 hash to sort names
ReiserFS: hda8: found reiserfs format "3.6" with standard journal
ReiserFS: hda8: using ordered data mode
ReiserFS: hda8: journal params: device hda8, size 8192, journal first blo=
ck 18, max trans len 1024, max batch 900, max commit age 30, max trans ag=
e 30
ReiserFS: hda8: checking transaction log (hda8)
ReiserFS: hda8: Using r5 hash to sort names
ReiserFS: hda9: found reiserfs format "3.6" with standard journal
ReiserFS: hda9: using ordered data mode
ReiserFS: hda9: journal params: device hda9, size 8192, journal first blo=
ck 18, max trans len 1024, max batch 900, max commit age 30, max trans ag=
e 30
ReiserFS: hda9: checking transaction log (hda9)
ReiserFS: hda9: Using r5 hash to sort names
ReiserFS: hda10: found reiserfs format "3.6" with standard journal
ReiserFS: hda10: using ordered data mode
ReiserFS: hda10: journal params: device hda10, size 8192, journal first b=
lock 18, max trans len 1024, max batch 900, max commit age 30, max trans =
age 30
ReiserFS: hda10: checking transaction log (hda10)
ReiserFS: hda10: Using r5 hash to sort names
ReiserFS: hda11: found reiserfs format "3.6" with standard journal
ReiserFS: hda11: using ordered data mode
ReiserFS: hda11: journal params: device hda11, size 8192, journal first b=
lock 18, max trans len 1024, max batch 900, max commit age 30, max trans =
age 30
ReiserFS: hda11: checking transaction log (hda11)
ReiserFS: hda11: Using r5 hash to sort names
NTFS volume version 3.1.
NTFS-fs error (device hda1): load_system_files(): Volume is dirty.  Mount=
ing read-only.  Run chkdsk and mount in Windows.
NTFS volume version 3.1.
NTFS-fs error (device hda12): load_system_files(): Volume is dirty.  Moun=
ting read-only.  Run chkdsk and mount in Windows.
ReiserFS: hda14: found reiserfs format "3.6" with standard journal
ReiserFS: hda14: using ordered data mode
ReiserFS: hda14: journal params: device hda14, size 8192, journal first b=
lock 18, max trans len 1024, max batch 900, max commit age 30, max trans =
age 30
ReiserFS: hda14: checking transaction log (hda14)
ReiserFS: hda14: Using r5 hash to sort names
ACPI: PCI Interrupt 0000:00:14.5[B] -> GSI 17 (level, low) -> IRQ 185
ACPI: PCI Interrupt 0000:00:14.6[B] -> GSI 17 (level, low) -> IRQ 185
PCI: Enabling bus mastering for device 0000:00:14.6
MC'97 0 converters and GPIO not ready (0x1)
8139cp: 10/100 PCI Ethernet driver v1.2 (Mar 22, 2004)
ohci1394: $Rev: 1313 $ Ben Collins <bcollins@debian.org>
GSI 22 sharing vector 0xE1 and IRQ 22
ACPI: PCI Interrupt 0000:05:09.2[C] -> GSI 22 (level, low) -> IRQ 225
PCI: Calling quirk ffffffff80454dfd for 0000:05:09.2
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=3D[225]  MMIO=3D[c0208800-c0=
208fff]  Max Packet=3D[2048]
USB Universal Host Controller Interface driver v2.3
hcid[11335]: segfault at 0000000000000008 rip 00002aaaaabcd2f0 rsp 00007f=
ffffcf2b10 error 4
Bluetooth: L2CAP ver 2.8
Bluetooth: L2CAP socket layer initialized
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM ver 1.6
wlan0: no IPv6 routers present
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.4 (1531 buckets, 12248 max) - 312 bytes per conntr=
ack
fbsplash: console 1 using theme 'livecd-2005.1'
fbsplash: switched splash state to 'on' on console 1
fbsplash: console 2 using theme 'livecd-2005.1'
fbsplash: switched splash state to 'on' on console 2
fbsplash: console 3 using theme 'livecd-2005.1'
fbsplash: switched splash state to 'on' on console 3
fbsplash: console 4 using theme 'livecd-2005.1'
fbsplash: switched splash state to 'on' on console 4
fbsplash: console 5 using theme 'livecd-2005.1'
fbsplash: switched splash state to 'on' on console 5
fbsplash: console 6 using theme 'livecd-2005.1'
fbsplash: switched splash state to 'on' on console 6
fbsplash: console 7 using theme 'livecd-2005.1'
fbsplash: switched splash state to 'on' on console 7
fbsplash: console 8 using theme 'livecd-2005.1'
fbsplash: switched splash state to 'on' on console 8
fbsplash: console 9 using theme 'livecd-2005.1'
fbsplash: switched splash state to 'on' on console 9
fbsplash: console 10 using theme 'livecd-2005.1'
fbsplash: switched splash state to 'on' on console 10
[fglrx] free  PCIe =3D 54804480
[fglrx] max   PCIe =3D 54804480
[fglrx] free  LFB =3D 119468032
[fglrx] max   LFB =3D 119468032
[fglrx] free  Inv =3D 0
[fglrx] max   Inv =3D 0
[fglrx] total Inv =3D 0
[fglrx] total TIM =3D 0
[fglrx] total FB  =3D 0
[fglrx] total PCIe =3D 16384
[fglrx:firegl_lock] *ERROR* Process 14238 is using illegal context 0x0000=
0005
[fglrx] free  PCIe =3D 54804480
[fglrx] max   PCIe =3D 54804480
[fglrx] free  LFB =3D 119468032
[fglrx] max   LFB =3D 119468032
[fglrx] free  Inv =3D 0
[fglrx] max   Inv =3D 0
[fglrx] total Inv =3D 0
[fglrx] total TIM =3D 0
[fglrx] total FB  =3D 0
[fglrx] total PCIe =3D 16384
APIC error on CPU0: 00(40)
APIC error on CPU0: 40(40)
APIC error on CPU0: 40(40)
ohci_hcd 0000:00:13.0: urb ffff810012c70c80 path 1 ep1in 5c160000 cc 5 --=
> status -110
ohci_hcd 0000:00:13.0: urb ffff810012c70c80 path 1 ep1in 5c160000 cc 5 --=
> status -110
ohci_hcd 0000:00:13.0: urb ffff810012c70c80 path 1 ep1in 5c160000 cc 5 --=
> status -110
ohci_hcd 0000:00:13.0: urb ffff810012c70c80 path 1 ep1in 5c160000 cc 5 --=
> status -110
ohci_hcd 0000:00:13.0: urb ffff810012c70c80 path 1 ep1in 5c160000 cc 5 --=
> status -110
hub 1-0:1.0: state 5 ports 4 chg 0000 evt 0002
ohci_hcd 0000:00:13.0: GetStatus roothub.portstatus [0] =3D 0x00030100 PE=
SC CSC PPS
hub 1-0:1.0: port 1, status 0100, change 0003, 12 Mb/s
usb 1-1: USB disconnect, address 3
usb 1-1: usb_disable_device nuking all URBs
ohci_hcd 0000:00:13.0: shutdown urb ffff810012c70c80 pipe 40408380 ep1in-=
intr
usb 1-1: unregistering interface 1-1:1.0
usb 1-1:1.0: hotplug
usb 1-1: unregistering device
usb 1-1: hotplug
hub 1-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x100
APIC error on CPU0: 40(40)
hub 3-0:1.0: state 5 ports 8 chg 0000 evt 0008
ehci_hcd 0000:00:13.2: GetStatus port 3 status 001403 POWER sig=3Dk CSC C=
ONNECT
hub 3-0:1.0: port 3, status 0501, change 0001, 480 Mb/s
hub 3-0:1.0: debounce: port 3: total 100ms stable 100ms status 0x501
ehci_hcd 0000:00:13.2: port 3 low speed --> companion
ehci_hcd 0000:00:13.2: GetStatus port 3 status 003002 POWER OWNER sig=3Ds=
e0 CSC
hub 1-0:1.0: state 5 ports 4 chg 0000 evt 0004
ohci_hcd 0000:00:13.0: GetStatus roothub.portstatus [1] =3D 0x00010301 CS=
C LSDA PPS CCS
hub 1-0:1.0: port 2, status 0301, change 0001, 1.5 Mb/s
hub 1-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x301
ohci_hcd 0000:00:13.0: GetStatus roothub.portstatus [1] =3D 0x00100303 PR=
SC LSDA PPS PES CCS
usb 1-2: new low speed USB device using ohci_hcd and address 4
ohci_hcd 0000:00:13.0: GetStatus roothub.portstatus [1] =3D 0x00100303 PR=
SC LSDA PPS PES CCS
usb 1-2: skipped 1 descriptor after interface
usb 1-2: new device strings: Mfr=3D0, Product=3D0, SerialNumber=3D0
usb 1-2: hotplug
usb 1-2: adding 1-2:1.0 (config #1, interface 0)
usb 1-2:1.0: hotplug
usbhid 1-2:1.0: usb_probe_interface
usbhid 1-2:1.0: usb_probe_interface - got id
input: HID 1241:1177 as /class/input/input4
input: USB HID v1.10 Mouse [HID 1241:1177] on usb-0000:00:13.0-2
drivers/usb/core/inode.c: creating file '004'
hub 1-0:1.0: state 5 ports 4 chg 0000 evt 0004
pccard: card ejected from slot 0
PCMCIA: socket ffff810017029048: *** DANGER *** unable to remove socket p=
ower
APIC error on CPU0: 40(40)
pccard: CardBus card inserted into slot 0
APIC error on CPU0: 40(40)
APIC error on CPU0: 40(40)
APIC error on CPU0: 40(40)
APIC error on CPU0: 40(40)
APIC error on CPU0: 40(40)
APIC error on CPU0: 40(40)
APIC error on CPU0: 40(40)
------=_20060329150618_94345--

