Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271309AbRH0JHh>; Mon, 27 Aug 2001 05:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271675AbRH0JHa>; Mon, 27 Aug 2001 05:07:30 -0400
Received: from spk42.demon.co.uk ([194.222.181.53]:59119 "EHLO
	charon.troy.versado.net") by vger.kernel.org with ESMTP
	id <S271309AbRH0JHX>; Mon, 27 Aug 2001 05:07:23 -0400
Reply-To: <jamie@versado.net>
From: "Jamie Neil" <jamie@versado.net>
To: "Andre Hedrick" <andre@linux-ide.org>,
        "Edward Tandi" <edtandi@yahoo.co.uk>
Cc: "Mark Hahn" <hahn@coffee.psychology.mcmaster.ca>,
        "Oleg Drokin" <green@linuxhacker.ru>, <linux-kernel@vger.kernel.org>,
        "Jurriaan" <thunder7@xs4all.nl>
Subject: RE: HPT370 driver problems continued...
Date: Mon, 27 Aug 2001 10:06:34 +0100
Message-ID: <CKEAJKBNHMOBPBEDFFPHGEMLCAAA.jamie@versado.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <Pine.LNX.4.10.10108262332250.2888-100000@master.linux-ide.org>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andre,

Is your test output from a single drive on an HPT370? - We have _only_ been
having problems with RAID configurations where reads require a switch
between channels (primary and secondary).

I wonder whether this could be a compatiblity issue between drive and
controller - both Edward and myself are using similar IBM Deskstar models -
anyone else had problems with these drives?

Jamie Neil

-----Original Message-----
From: Andre Hedrick [mailto:andre@linux-ide.org]
Sent: 27 August 2001 07:57
To: Edward Tandi
Cc: Jamie Neil; Mark Hahn; Oleg Drokin; linux-kernel@vger.kernel.org;
Jurriaan
Subject: Re: HPT370 driver problems continued...


On Sun, 26 Aug 2001, Edward Tandi wrote:

> All,
>
> I though I'd e-mail this list an update of my progress. There is only so
> much time one can waste on a card. I have tried every BIOS and  hdparm
> settings and combination under the sun. I am convinced that the HPT370
> simply does not work properly with Linux. Either I have a faulty card, or
> there is a bug in the drivers.


p6dnf:/lsrc/DiskPerf-1.0.5 # ./DiskPerf /dev/hdc
Device: Maxtor 54610H6 Serial Number: F600TBFD
LBA 0 DMA Read Test                      = 31.49 MB/Sec (7.94 Seconds)
Outer Diameter Sequential DMA Read Test  = 27.28 MB/Sec (9.16 Seconds)
Inner Diameter Sequential DMA Read Test  = 19.50 MB/Sec (12.82 Seconds)
LBA 1 DMA Write Test                     = 25.52 MB/Sec (9.79 Seconds)
Outer Diameter Sequential DMA Write Test = 25.02 MB/Sec (9.99 Seconds)
Inner Diameter Sequential DMA Write Test = 19.65 MB/Sec (12.72 Seconds)

p6dnf:/proc/ide/ide1 # cat config
pci bus 00 device 90 vid 1103 did 0004 channel 1
03 11 04 00 07 00 30 02 03 00 80 01 08 78 00 00
91 ef 00 00 8d ef 00 00 81 ef 00 00 89 ef 00 00
01 e4 00 00 00 00 00 00 00 00 00 00 03 11 11 00
01 00 b8 fe 60 00 00 00 00 00 00 00 03 01 08 08
31 4e 45 16 0b f5 d9 0a 31 4e 45 16 0b f5 d9 0a
05 00 00 00 05 00 00 00 1b 00 00 22 24 00 26 00
01 00 22 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 90 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

It works just fine.

There are some possible problems with a new patch being developed, but hte
current drive behaves fine.

> Lacking any positive responses and having the need to now attach more
> drives, I decided to cut my losses and buy a different IDE card. I
> managed to find a local supplier that sold Maxtor's Ultra 100 card. This
> is a re-badged Promise Ultra100 (the PDC20267 chip) without any RAID
> facilities in the BIOS. This is perfect for me, as I use Linux's Software
> RAID capabilities and the simplistic BIOS does not waste any time
> booting. There is nothing to configure in the card's BIOS either.
>
> I attached the drives, booted and hey presto, the card and drives were
> recognised. It took a little while to work out the hdparm settings:
>
> hdparm -u 0 -c 1 -X66 -m 16 -d 1 -W 1 -A 1 /dev/hde

WTH are you doing this for!?!
Let the driver set up the host device settings and cut the hdparm crap.
This is one of the first API's to be deleted in 2.5, because of the abuse
it does to the driver from people not reading or caring about what it
really does to a kernel that does the setup work for you.

Just keep your hands of hdparm and it will work just fine.

Regards,

Andre Hedrick
Linux ATA Development


> ...
>
> A few points to note: You really do need to have the unmasking of
> interrupts turned off because the PDC20267 is designed to share one
> interrupt. The Linux kernel 2.4.7 drivers do not support the UDMA3/4/5
> modes of transfer, so you really do need to use the -X66 option for UDMA2
> -anything else is just too slow.
>
> The only reason I could find for this restriction on UDMA modes was that
> some data corruptions were happening with certain VIA motherboards. I
> think this is a real shame, it would have been good to at least test to
> see if any of the modes would work on my board. UDMA2 is eating away at
> my CPU. Does anyone know how I might be able to re-enable these modes?
>
> I have now been doing continuous tests on a 3 disk stripe for over 24 hrs
> without any sign of data corruption. The 3 IBM drives copy large files
> (over 1.6GB) at about 35MB/s on reiserfs. It more or less proves that the
> problem is in the card or the driver. At 40 notes for a replacement, the
> HPT370 is just not worth the bother.
>
> On a separate point, does anyone know why LVM for Linux is so much slower
> than raidtools?
>
> Thanks for those who responded.
>
> Ed.-T.
>
>       I have forwarded this mail by jamie@versado.net because I
>       think it is really useful information.
>
>
>       Hi Edward,
>
>       You might want to cc this to the other recipients...
>
>       I tried and failed to get a HPT370 card to work properly on
>       my system. Here is my set up:
>
>       P200MMX
>       i430HX chipset
>       96Mb EDO RAM
>       ET6000 PCI VGA
>       Adaptec 2940 PCI SCSI
>       3Com 3x905 PCI NIC
>       "Power Magic" HPT370 PCI RAID
>       30Gb IBM DTLA 307030
>       30Gb Quantum Fireball AS30
>       RedHat 7.1
>
>       "Power Magic" do not have a web site that I could find, so
>       after looking at Highpoint's site I concluded I would have to
>       use software RAID as RH71 (2.4.3 I think) doesn't support the
>       hardware RAID features. So using the RH RAID setup (GUI
>       install) I created 5 RAID 1 partitions (root, boot, var, usr,
>       home) and some swap space. Install went fine (except for
>       Xconfigurator crapping out on my ET6000 :-<) and I had a
>       working system.
>
>       I then proceded to upgrade packages and add Ximian Gnome to
>       the system which is where it started to go wrong. I used
>       Ximian's red carpet installer (causes less problems with
>       dependencies) which I installed first with no problems. I
>       then copied all the updated packages from another machine on
>       my network into red carpet's cache directory (saves it
>       downloading them again - I've only got ISDN). I loaded red
>       carpet and selected all the packages I wanted to upgrade, but
>       when I started the upgrade it complained that one of the
>       packages was corrupted (it uses signatures). I downloaded a
>       fresh copy from Ximian and tried again - sam problem,
>       different package. So I did a diff on the red carpet cache
>       directory and the smb mounted original files, which told me
>       that there were three or four changed files! I recopied the
>       files and did another diff. This time the files I had
>       recopied were OK but another six that were OK before were now
>       different. Another diff showed a different set of files.
>
>       At that point I started searching the net for references to
>       the HPT controller and disk errors (read errors) and I found
>       your posting!
>
>       Since then I have:
>
>       Removed just about every card from the system except NIC,
>       RAID and VGA - same problem.
>
>       Adjusted the PCI timing in the BIOS - no change.
>
>       Changed the cards around in the PCI slots (getting desperate)
>       - no change
>
>       Upgraded the HPT BIOS from 1.03 to the latest version on the
>       Highpoint site (required me to try six different flash
>       programs from different card manufacturers before I found one
>       that recognised the SST flash chip on my card - "Power Magic"
>       do not provide one) - same problem.
>
>       Found the RedHat 7.x _hardware_ RAID drivers on the IWill
>       site and decided to do a reinstall with those. With high
>       hopes I created my RAID volume in the HPT BIOS, booted
>       the RH71 install and HPT driver disks, partitioned the drive
>       (individual drives are still visible, but RAID volume is
>       presented as SDAx), selected required packages, install
>       started........locked up. Tried again...locked up in the same
>       place.
>
>       Gave up and sent the card back for a refund having wasted 2
>       days on it.
>
>       I am now temporarily using the on board PIIX 3 (Triton II)
>       IDE controller and software RAID. It's slow, but I haven't
>       had one problem yet.
>
>       Your questions:
>
>       Q1: Can I use the RedHat compiled modules? I think the module
>       version numbers will clash.
>       These are for hardware RAID, and I couldn't get them to work
>       even on Redhat 7.1.
>
>       Q2: Has anyone seen any problems with the VIA 586/596 chips
>       listed below?
>         No.
>
>       Q3: Does anyone have the 2.4.x version of the 2.2.x kernel
>       patch distributed from the Highpoint WEB site?
>       I think the Highpoint kernel patch is now part of the 2.4
>       kernel tree.
>
>       Q4: Is this a Controller/Card compatibility issue? The drives
>       are IBM Deskstar 60GXPs (IC35L040AVER07-0).
>       I have heard rumours of compatibility problems with the
>       Deskstar GXPs (I think your drives are the same model as one
>       of mine), but ignored it at the time as I wasn't about to
>       chuck out a 30Gb drive for an unproven £30 RAID controller!
>
>       Q5: Are there any other mailing lists I can send this to to
>       help me get the issue resolved?
>       I haven't found any
>
>       Q6: Has anyone successfully used the RedHat patches, or a
>       HPT370 for that matter?
>       No.
>
>       Q7: Does anyone have any clues as to what might be going
>       wrong?
>
>       The only similarities between our systems are the HPT370,
>       3x905 (unlikely), Adaptec 2940 (eliminated from my system),
>       IBM Deskstar (possibly).
>
>       The fact that there IS a Redhat 7.x binary driver (hardware
>       RAID) leads me to think that SOMEONE must have got it to
>       work, and I'd be very suprised if they hadn't tested it with
>       drives on separate cables.
>
>       Good luck and let me know if you solve it - I might try again
>       :-)
>
>       Jamie Neil
>
>
>       Hi Edward,
>       One other thing.
>
>       Th Highpoint web site seems to indicate a close association
>       between driver and BIOS version (for Windows systems). i.e
>       Driver v1.2.0612 should be used with BIOS v1.2.0612. It also
>       says that if you wish to use the non-RAID drivers you should
>       use the non-RAID BIOS (v1.00). They make no mention of linux
>       driver versions. My BIOS was originally v1.03 which didn't
>       work with Software RAID, by the time I tried the Redhat
>       hardware RAID drivers I had upgraded to BIOS v1.2.0612.
>
>       This guy seems to be having problems as well (interestingly
>       also IBM drives):
>
>
http://mailman.real-time.com/pipermail/linux-kernel/Week-of-Mon-20010430/032
987
>       html
>
>       Jamie Neil
>
>
>       -----Original Message-----
>       From: Edward Tandi [ mailto:edtandi@yahoo.co.uk]
>       Sent: 22 August 2001 05:37
>       To: linux-kernel@vger.kernel.org; Andre Hedrick; Jamie Neil;
>       Mark Hahn; Oleg Drokin
>       Subject: HPT370 driver problems continued...
>
>             All,
>
>             This one is really getting on my nerves now.
>             Attached below is my original e-mail about
>             problems with using an IWill HPT370 based IDE
>             RAID card. I have now upgraded my kernel to
>             2.4.7-ac3 but to no avail -I still get data
>             corruption if I simultaneously use disks on both
>             IDE interfaces (cables). I am not using the
>             on-board RAID capabilities. This time I have
>             attached much more info about my system in the
>             hope that someone may spot the problem.
>
>             The boot-up info below indicates that the kernel
>             does not apply any PCI latency work-around (look
>             at the lines around "Unknown bridge resource
>             0:"). But this is probably because this board
>             does not use a VT82C686A. It does NOT say "PCI:
>             Using IRQ router VIA [1106/0686] at 00:07.0. ".
>             The lspci output is attached below -there is no
>             mention of any VIA 686 chip.
>
>             Given that there appears not to be any know VIA
>             board problems, I return to the possibility that
>             there may be a driver problem. Lo and behold, I
>             found some official Linux drivers on
>             <http://www.highpoint-tech.com/370drivers.htm>!!!
>             Unfortunately, the source patch is only for the
>             2.2.x series kernels and the binary packages are
>             for RedHat 7.0 and 7.1 which have earlier
>             versions of the Kernel.
>
>             Q1: Can I use the RedHat compiled modules? I
>             think the module version numbers will clash.
>             Q2: Has anyone seen any problems with the VIA
>             586/596 chips listed below?
>             Q3: Does anyone have the 2.4.x version of the
>             2.2.x kernel patch distributed from the Highpoint
>             WEB site?
>             Q4: Is this a Controller/Card compatibility
>             issue? The drives are IBM Deskstar 60GXPs
>             (IC35L040AVER07-0).
>             Q5: Are there any other mailing lists I can send
>             this to to help me get the issue resolved?
>             Q6: Has anyone successfully used the RedHat
>             patches, or a HPT370 for that matter?
>             Q7: Does anyone have any clues as to what might
>             be going wrong?
>
>             I can provide more info if required, but I don't
>             want to go through the palava of downgrading my
>             kernel to RedHat 7.1 only to find out that it
>             still doesn't work.
>
>             Ed-T.
>
>
>             Boot-up info:
>
>             Aug 20 20:37:14 gate kernel:
>             CPU0<T0:1002224,T1:501104,D:3,S:501117,C:1002235>
>             Aug 20 20:37:14 gate kernel: mtrr: v1.40
>             (20010327) Richard Gooch ( rgooch@atnf.csiro.au)
>             Aug 20 20:37:14 gate kernel: mtrr: detected mtrr
>             type: Intel
>             Aug 20 20:37:14 gate kernel: PCI: PCI BIOS
>             revision 2.10 entry at 0xfb2c0, last bus=1
>             Aug 20 20:37:14 gate kernel: PCI: Using
>             configuration type 1
>             Aug 20 20:37:14 gate kernel: PCI: Probing PCI
>             hardware
>             Aug 20 20:37:14 gate kernel: Unknown bridge
>             resource 0: assuming transparent
>             Aug 20 20:37:14 gate kernel: PCI: Using IRQ
>             router VIA [1106/0596] at 00:07.0
>             Aug 20 20:37:14 gate kernel: Activating ISA DMA
>             hang workarounds.
>             Aug 20 20:37:14 gate kernel: isapnp: Scanning for
>             PnP cards...
>             Aug 20 20:37:14 gate kernel: isapnp: No Plug &
>             Play device found
>
>
>             lspci info:
>
>             The board is a Tyan Tiger 133, dual slot 1.
>
>             00:00.0 Host bridge: VIA Technologies, Inc.
>             VT82C691 [Apollo PRO] (rev c4)
>                     Flags: bus master, medium devsel, latency
>             0
>                     Memory at d0000000 (32-bit, prefetchable)
>             [size=64M]
>                     Capabilities: [a0] AGP version 2.0
>                     Capabilities: [c0] Power Management
>             version 2
>
>             00:01.0 PCI bridge: VIA Technologies, Inc.
>             VT82C598 [Apollo MVP3 AGP] (prog-if 00 [Normal
>             decode])
>                     Flags: bus master, 66Mhz, medium devsel,
>             latency 0
>                     Bus: primary=00, secondary=01,
>             subordinate=01, sec-latency=0
>                     Memory behind bridge: d4000000-d5ffffff
>                     Prefetchable memory behind bridge:
>             d6000000-d6ffffff
>                     Capabilities: [80] Power Management
>             version 2
>
>             00:07.0 ISA bridge: VIA Technologies, Inc.
>             VT82C596 ISA [Apollo PRO] (rev 23)
>                     Subsystem: VIA Technologies, Inc.
>             VT82C596/A/B PCI to ISA Bridge
>                     Flags: bus master, stepping, medium
>             devsel, latency 0
>
>             00:07.1 IDE interface: VIA Technologies, Inc.
>             VT82C586 IDE [Apollo] (rev 10) (prog-if 8a
>             [Master SecP PriP])
>                     Flags: bus master, medium devsel, latency
>             128
>                     I/O ports at c000 [size=16]
>                     Capabilities: [c0] Power Management
>             version 2
>
>             00:07.2 USB Controller: VIA Technologies, Inc.
>             VT82C586B USB (rev 11) (prog-if 00 [UHCI])
>                     Subsystem: Unknown device 0925:1234
>                     Flags: bus master, medium devsel, latency
>             32, IRQ 11
>                     I/O ports at c400 [size=32]
>                     Capabilities: [80] Power Management
>             version 2
>
>             00:07.3 Host bridge: VIA Technologies, Inc.:
>             Unknown device 3050 (rev 30)
>                     Flags: medium devsel
>
>             00:0f.0 SCSI storage controller: Adaptec AHA-294x
>             / AIC-7871
>                     Flags: bus master, medium devsel, latency
>             32, IRQ 11
>                     I/O ports at c800 [disabled] [size=256]
>                     Memory at d8000000 (32-bit,
>             non-prefetchable) [size=4K]
>                     Expansion ROM at <unassigned> [disabled]
>             [size=64K]
>
>             00:11.0 Ethernet controller: 3Com Corporation
>             3c905B 100BaseTX [Cyclone] (rev 30)
>                     Subsystem: 3Com Corporation 3C905B Fast
>             Etherlink XL 10/100
>                     Flags: bus master, medium devsel, latency
>             32, IRQ 9
>                     I/O ports at d000 [size=128]
>                     Memory at d8001000 (32-bit,
>             non-prefetchable) [size=128]
>                     Expansion ROM at <unassigned> [disabled]
>             [size=128K]
>                     Capabilities: [dc] Power Management
>             version 1
>
>             00:12.0 Multimedia video controller: Zoran
>             Corporation ZR36057PQC Video cutting chipset (rev
>             02)
>                     Subsystem: Miro Computer Products AG DC10
>             Plus
>                     Flags: bus master, fast devsel, latency
>             32, IRQ 9
>                     Memory at d8002000 (32-bit,
>             non-prefetchable) [size=4K]
>
>             00:13.0 Unknown mass storage controller: Triones
>             Technologies, Inc. HPT366 (rev 03)
>                     Subsystem: Triones Technologies, Inc.:
>             Unknown device 0005
>                     Flags: bus master, medium devsel, latency
>             120, IRQ 11
>                     I/O ports at d400 [size=8]
>                     I/O ports at d800 [size=4]
>                     I/O ports at dc00 [size=8]
>                     I/O ports at e000 [size=4]
>                     I/O ports at e400 [size=256]
>                     Expansion ROM at <unassigned> [disabled]
>             [size=128K]
>
>             01:00.0 VGA compatible controller: nVidia
>             Corporation Riva TnT 128 [NV04] (rev 04) (prog-if
>             00 [VGA])
>                     Subsystem: STB Systems Inc: Unknown
>             device 273e
>                     Flags: bus master, 66Mhz, medium devsel,
>             latency 32, IRQ 10
>                     Memory at d4000000 (32-bit,
>             non-prefetchable) [size=16M]
>                     Memory at d6000000 (32-bit, prefetchable)
>             [size=16M]
>                     Expansion ROM at <unassigned> [disabled]
>             [size=64K]
>                     Capabilities: [60] Power Management
>             version 1
>                     Capabilities: [44] AGP version 1.0
>
>
>             On the 23rd of June I wrote:
>
>                   I have an IWill IDE Raid card with
>                   the Highpoint HPT370 Chip. I am
>                   running this on a Dual Processor
>                   board (800MHz PIIIs) with a Mandrake
>                   8.0 Disrtibution (2.4.3 Kernel).
>                   200MB of RAM and all slots filled
>                   with lots of cards. I was glad to see
>                   that Linux auto-detected the IDE/Raid
>                   card.
>
>                   The initial hardware configuration
>                   had two 40G IBM drives (7200RPM
>                   UDMA100) each attached as the IDE
>                   Master (using cable select) of the
>                   primary and secondary IDE interfaces
>                   as this is the optimum for two
>                   drives. I then used the md/meta tools
>                   to stripe the two.
>
>                   Then I started to migrate data. This
>                   all went well untill I decided to
>                   check stuff with diff. Well, diff
>                   found many files to be different. I
>                   tried all the hdparm settings to no
>                   avail. I tried reiserfs to no avail.
>                   I tried swithching to LVM to no
>                   avail. I pulled out a processor,
>                   still the same result (I then broke
>                   the slot1 socket trying to put it
>                   back in -ooh my wallet hurts!). So I
>                   then focussed on looking at the type
>                   of corruption. It's approximately 2
>                   bytes in 300 megs -so it's probably a
>                   dreaded off-by-one.
>
>                   The real problem with this one is
>                   that it was hard to re-produce. But I
>                   then decided to isolate the drives
>                   and found that operations on
>                   individual drives were OK, but if you
>                   tried to use the two together,
>                   pa-tang!
>
>                   Now here's the interesting bit; I
>                   connected the two drives onto the
>                   same cable (and therefore interface).
>                   It worked without fault. No
>                   corruptions. So I guess the problem
>                   is at the driver level when
>                   inter-working across the primary and
>                   secondary IDE interfaces.
>
>                   Has anyone else seen this. Any
>                   patches/workarounds? -cos I want to
>                   add another two drives. TIA,
>
>                   Ed-T.
>
>
> _________________________________________________________ Do You Yahoo!?
> Get your free @yahoo.com address at http://mail.yahoo.com
>


