Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314433AbSEIWi0>; Thu, 9 May 2002 18:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314442AbSEIWiZ>; Thu, 9 May 2002 18:38:25 -0400
Received: from ahmler2.mail.eds.com ([192.85.154.72]:50403 "EHLO
	ahmler2.mail.eds.com") by vger.kernel.org with ESMTP
	id <S314433AbSEIWiV>; Thu, 9 May 2002 18:38:21 -0400
Message-ID: <564DE4477544D411AD2C00508BDF0B6A0C9DD3C2@usahm018.exmi01.exch.eds.com>
From: "Post, Mark K" <mark.post@eds.com>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
        "'Andries.Brouwer@cwi.nl'" <Andries.Brouwer@cwi.nl>,
        "'linux390@ibm.de'" <linux390@ibm.de>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: PATCH: kernel mount of initrd fails unless mke2fs uses 1024 byte 
	blocks
Date: Thu, 9 May 2002 18:37:38 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2655.51)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C1F7AA.1F6F61BE"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C1F7AA.1F6F61BE
Content-Type: text/plain;
	charset="iso-8859-1"

Alan, Andries, IBMers,

Here are the documentation patches that relate to the initrd problem I
reported previously.  (The mke2fs command had to specify -b 1024, or it
couldn't be mounted at boot time by the kernel.)  This submission is against
the 2.4.18 kernel.  If they're acceptable, I'll do another one for the
2.2.20 version.

There was a little bit of scope creep here.  :)  The instructions in
linux/Documentation/Configure.help said to run a spell-checker against the
file before submitting any patches for it.  Clearly, that hasn't been done
in a while, so my patch also has miscellaneous spelling corrections in it
for things completely unrelated.  After having spent a couple of hours
wading through the spell checking process, I can understand why it doesn't
get done much.  :(

Finally, there were a couple of Linux/390 items that I thought could be a
little clearer, were wrong, or didn't exist at all.  So, I've also submitted
changes for CONFIG_DASD, CONFIG_DASD_FAST_IO, CONFIG_IUCV, and a completely
new entry for CONFIG_LCS.

I tried to make similar modifications to linux/Documentation/initrd.txt, and
to /usr/man/man4/initrd.4, to try to cover all places someone might look if
they were having the same problem I did.

Please let me know if there's anything I need to correct, modify, whatever.

Mark Post



------_=_NextPart_000_01C1F7AA.1F6F61BE
Content-Type: application/octet-stream;
	name="Configure.help.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="Configure.help.diff"

--- linux/Documentation/Configure.help.orig	Mon Feb 25 19:37:51 2002=0A=
+++ linux/Documentation/Configure.help	Thu May  9 22:18:57 2002=0A=
@@ -58,7 +58,7 @@=0A=
 #=0A=
 # Mention all the relevant READMEs and HOWTOs in the help text.=0A=
 # Make them file URLs relative to the top level of the source tree =
so=0A=
-# that help browsers can turn them into hotlinks.  All URLs ahould =
be=0A=
+# that help browsers can turn them into hotlinks.  All URLs should =
be=0A=
 # surrounded by <>.=0A=
 #=0A=
 # Repetitions are fine since the help texts are not meant to be =
read=0A=
@@ -121,7 +121,7 @@=0A=
   If you say N here, the kernel will run on single and =
multiprocessor=0A=
   machines, but will use only one CPU of a multiprocessor machine. =
If=0A=
   you say Y here, the kernel will run on many, but not all,=0A=
-  singleprocessor machines. On a singleprocessor machine, the =
kernel=0A=
+  single processor machines. On a single processor machine, the =
kernel=0A=
   will run faster if you say N here.=0A=
 =0A=
   Note that if you say Y here and choose architecture "586" or=0A=
@@ -437,8 +437,14 @@=0A=
   The initial RAM disk is a RAM disk that is loaded by the boot =
loader=0A=
   (loadlin or lilo) and that is mounted as root before the normal =
boot=0A=
   procedure. It is typically used to load modules needed to mount =
the=0A=
-  "real" root file system, etc. See <file:Documentation/initrd.txt>=0A=
-  for details.=0A=
+  "real" root file system, etc.=0A=
+=0A=
+  Due to a problem elsewhere in the kernel, initial RAM disks =
_must_=0A=
+  have the file system on them created with a 1024 byte block size.=0A=
+  If any other value is used, the kernel will be unable to mount =
the=0A=
+  RAM disk at boot time, causing a kernel panic.=0A=
+=0A=
+  See <file:Documentation/initrd.txt> for details.=0A=
 =0A=
 Loopback device support=0A=
 CONFIG_BLK_DEV_LOOP=0A=
@@ -1122,7 +1128,7 @@=0A=
 =0A=
   It was originally designed for the PDC20246/Ultra33, whose BIOS =
will=0A=
   only setup UDMA on the first two PDC20246 cards.  It has also =
been=0A=
-  used succesfully on a PDC20265/Ultra100, allowing use of UDMA =
modes=0A=
+  used successfully on a PDC20265/Ultra100, allowing use of UDMA =
modes=0A=
   when the PDC20265 BIOS has been disabled (for faster boot up).=0A=
 =0A=
   Please read the comments at the top of=0A=
@@ -1516,7 +1522,7 @@=0A=
   before 1999 were Series 5) Series 5 drives will NOT always have =
the=0A=
   Series noted on the bottom of the drive. Series 6 drivers will.=0A=
 =0A=
-  In other words, if your BACKPACK drive dosen't say "Series 6" on =
the=0A=
+  In other words, if your BACKPACK drive doesn't say "Series 6" on =
the=0A=
   bottom, enable this option.=0A=
 =0A=
   If you chose to build PARIDE support into your kernel, you may=0A=
@@ -1809,7 +1815,7 @@=0A=
   to use its softwareraid feature.  You must also select an=0A=
   appropriate for your board low-level driver below.=0A=
 =0A=
-  Note, that Linux does not use the Raid implemetation in BIOS, and=0A=
+  Note, that Linux does not use the Raid implementation in BIOS, =
and=0A=
   the main purpose for this feature is to retain compatibility and=0A=
   data integrity with other OS-es, using the same disk array. Linux=0A=
   has its own Raid drivers, which you should use if you need better=0A=
@@ -2012,7 +2018,7 @@=0A=
 =0A=
 Kernel floating-point instruction emulation=0A=
 CONFIG_MIPS_FPU_EMULATOR=0A=
-  This option enables the MIPS software floatingpoint support.  Due =
to=0A=
+  This option enables the MIPS software floating point support.  Due =
to=0A=
   the way floating point works you should always enable this option=0A=
   unless you exactly know what you're doing.=0A=
 =0A=
@@ -2171,7 +2177,7 @@=0A=
 =0A=
 Discontiguous Memory Support=0A=
 CONFIG_DISCONTIGMEM=0A=
-  Say Y to upport efficient handling of discontiguous physical =
memory,=0A=
+  Say Y to support efficient handling of discontiguous physical =
memory,=0A=
   for architectures which are either NUMA (Non-Uniform Memory =
Access)=0A=
   or have huge holes in the physical address space for other =
reasons.=0A=
   See <file:Documentation/vm/numa> for more.=0A=
@@ -2180,7 +2186,7 @@=0A=
 CONFIG_MAPPED_KERNEL=0A=
   Change the way a Linux kernel is loaded unto memory on a MIPS64=0A=
   machine.  This is required in order to support text replication =
and=0A=
-  NUMA.  If you need to undersatand it, read the source code.=0A=
+  NUMA.  If you need to understand it, read the source code.=0A=
 =0A=
 Kernel text replication support=0A=
 CONFIG_REPLICATE_KTEXT=0A=
@@ -2315,7 +2321,7 @@=0A=
   are completely invisible to the outside world, even though they =
can=0A=
   reach the outside and can receive replies. It is even possible to=0A=
   run globally visible servers from within a masqueraded local =
network=0A=
-  using a mechanism called portforwarding. Masquerading is also =
often=0A=
+  using a mechanism called port forwarding.  Masquerading is also =
often=0A=
   called NAT (Network Address Translation).=0A=
 =0A=
   Another use of Netfilter is in transparent proxying: if a machine =
on=0A=
@@ -2325,7 +2331,7 @@=0A=
 =0A=
   Various modules exist for netfilter which replace the previous=0A=
   masquerading (ipmasqadm), packet filtering (ipchains), =
transparent=0A=
-  proxying, and portforwarding mechanisms. Please see=0A=
+  proxying, and port forwarding mechanisms. Please see=0A=
   <file:Documentation/Changes> under "iptables" for the location of=0A=
   these packages.=0A=
 =0A=
@@ -2594,7 +2600,7 @@=0A=
   connection (usually limiting it to your outgoing interface's MTU=0A=
   minus 40).=0A=
 =0A=
-  This is used to overcome criminally braindead ISPs or servers =
which=0A=
+  This is used to overcome criminally brain dead ISPs or servers =
which=0A=
   block ICMP Fragmentation Needed packets.  The symptoms of this=0A=
   problem are that everything works fine from your Linux=0A=
   firewall/router, but machines behind it can never exchange large=0A=
@@ -2628,7 +2634,7 @@=0A=
   daemon using netlink multicast sockets; unlike the LOG target=0A=
   which can only be viewed through syslog.=0A=
 =0A=
-  The apropriate userspace logging daemon (ulogd) may be obtained =
from=0A=
+  The appropriate userspace logging daemon (ulogd) may be obtained =
from=0A=
   http://www.gnumonks.org/projects/ulogd=0A=
 =0A=
   If you want to compile it as a module, say M here and read=0A=
@@ -5971,7 +5977,7 @@=0A=
   config (or if you simply don't have access to it).=0A=
 =0A=
   The other possible usages of diverting Ethernet Frames are=0A=
-  numberous:=0A=
+  numerous:=0A=
    - reroute smtp traffic to another interface=0A=
    - traffic-shape certain network streams=0A=
    - transparently proxy smtp connections=0A=
@@ -6905,7 +6911,7 @@=0A=
   to be used for any device.  The aic7xxx driver will automatically=0A=
   vary this number based on device behavior.  For devices with a=0A=
   fixed maximum, the driver will eventually lock to this maximum=0A=
-  and display a console message inidicating this value.=0A=
+  and display a console message indicating this value.=0A=
 =0A=
   Note: Unless you experience some type of device failure, the =
default=0A=
 	value, no enforced limit, should work for you.=0A=
@@ -7331,8 +7337,8 @@=0A=
 =0A=
 use normal IO=0A=
 CONFIG_SCSI_SYM53C8XX_IOMAPPED=0A=
-  If you say Y here, the driver will preferently use normal IO rather =
than =0A=
-  memory mapped IO.=0A=
+  If you say Y here, the driver will preferentially use normal IO=0A=
+  rather than memory mapped IO.=0A=
 =0A=
 maximum number of queued commands=0A=
 CONFIG_SCSI_SYM53C8XX_MAX_TAGS=0A=
@@ -8949,7 +8955,7 @@=0A=
   PCI 802.11 wireless cards.=0A=
   It supports the new 802.11b cards from Cisco (Cisco 34X, Cisco =
35X=0A=
   - with or without encryption) as well as card before the Cisco=0A=
-  aquisition (Aironet 4500, Aironet 4800, Aironet 4800B).=0A=
+  acquisition (Aironet 4500, Aironet 4800, Aironet 4800B).=0A=
 =0A=
   This driver support both the standard Linux Wireless Extensions=0A=
   and Cisco proprietary API, so both the Linux Wireless Tools and =
the=0A=
@@ -8964,7 +8970,7 @@=0A=
   driver part of the Linux Pcmcia package.=0A=
   It supports the new 802.11b cards from Cisco (Cisco 34X, Cisco =
35X=0A=
   - with or without encryption) as well as card before the Cisco=0A=
-  aquisition (Aironet 4500, Aironet 4800, Aironet 4800B). It also=0A=
+  acquisition (Aironet 4500, Aironet 4800, Aironet 4800B). It also=0A=
   supports OEM of Cisco such as the DELL TrueMobile 4800 and Xircom=0A=
   802.11b cards.=0A=
 =0A=
@@ -9386,7 +9392,7 @@=0A=
 =0A=
 Diffserv field marker=0A=
 CONFIG_NET_SCH_DSMARK=0A=
-  Say Y if you want to schedule packets avccording to the=0A=
+  Say Y if you want to schedule packets according to the=0A=
   Differentiated Services architecture proposed in RFC 2475.=0A=
   Technical information on this method, with pointers to associated=0A=
   RFCs, is available at <http://www.gta.ufrj.br/diffserv/>.=0A=
@@ -9655,7 +9661,7 @@=0A=
   V.35 or V.36 interface) to your Linux box.=0A=
 =0A=
   LMC 1200 with on board DSU board allows you to connect your Linux=0A=
-  box dirrectly to a T1 or E1 circuit.=0A=
+  box directly to a T1 or E1 circuit.=0A=
 =0A=
   LMC 5200 board provides a HSSI interface capable of running up to=0A=
   52 mbits per second.=0A=
@@ -9772,14 +9778,14 @@=0A=
 CONFIG_WANPIPE_X25=0A=
   Say Y to this option if you are planning to connect a WANPIPE =
card=0A=
   to an X.25 network.  Note, this feature also includes the X.25 =
API=0A=
-  support used to develope custom applications over the X.25 =
protocol.=0A=
+  support used to develop custom applications over the X.25 =
protocol.=0A=
   If you say N, the X.25 support will not be included in the =
driver.=0A=
   The X.25 option is supported on S514-PCI and S508-ISA cards.=0A=
 =0A=
 WANPIPE Frame Relay support=0A=
 CONFIG_WANPIPE_FR=0A=
   Say Y to this option if you are planning to connect a WANPIPE =
card=0A=
-  to a frame relay network, or use frame relay API to develope=0A=
+  to a frame relay network, or use frame relay API to develop=0A=
   custom applications over the Frame  Relay protocol.=0A=
   This feature also contains the Ethernet Bridging over Frame =
Relay,=0A=
   where a WANPIPE frame relay link can be directly connected to the=0A=
@@ -12038,7 +12044,7 @@=0A=
 =0A=
 Write support for NFTL (EXPERIMENTAL)=0A=
 CONFIG_NFTL_RW=0A=
-  If you're lucky, this will actually work. Don't whinge if it=0A=
+  If you're lucky, this will actually work. Don't whine if it=0A=
   doesn't.  Send mail to the MTD mailing list=0A=
   <linux-mtd@lists.infradead.org> if you want to help to make it =
more=0A=
   reliable.=0A=
@@ -12376,7 +12382,7 @@=0A=
   NAND flash device internally checks only bits transitioning=0A=
   from 1 to 0. There is a rare possibility that even though the=0A=
   device thinks the write was successful, a bit could have been=0A=
-  flipped accidentaly due to device wear, gamma rays, whatever.=0A=
+  flipped accidentally due to device wear, gamma rays, whatever.=0A=
   Enable this if you are really paranoid.=0A=
 =0A=
 Support for the SPIA board=0A=
@@ -12563,7 +12569,7 @@=0A=
 CONFIG_MTD_JEDECPROBE=0A=
   This option enables JEDEC-style probing of flash chips which are =
not=0A=
   compatible with the Common Flash Interface, but will use the =
common=0A=
-  CFI-targetted flash drivers for any chips which are identified =
which=0A=
+  CFI-targeted flash drivers for any chips which are identified =
which=0A=
   are in fact compatible in all but the probe method. This actually=0A=
   covers most AMD/Fujitsu-compatible chips, and will shortly cover =
also=0A=
   non-CFI Intel chips (that code is in MTD CVS and should shortly be =
sent=0A=
@@ -13766,7 +13772,7 @@=0A=
   kernels can talk to each other, the host, and with the host's =
help,=0A=
   machines on the outside world.=0A=
 =0A=
-  For more information, including explations of the networking and=0A=
+  For more information, including explanations of the networking =
and=0A=
   sample configurations, see=0A=
   <http://user-mode-linux.sourceforge.net/networking.html>.=0A=
 =0A=
@@ -14177,7 +14183,7 @@=0A=
   Ramfs is a file system which keeps all files in RAM. It allows=0A=
   read and write access.=0A=
 =0A=
-  It is more of an programming example than a useable file system.  =
If=0A=
+  It is more of an programming example than a usable file system.  =
If=0A=
   you need a file system which lives in RAM with limit checking use=0A=
   tmpfs.=0A=
 =0A=
@@ -14767,7 +14773,7 @@=0A=
 CONFIG_JFFS2_FS=0A=
   JFFS2 is the second generation of the Journalling Flash File =
System=0A=
   for use on diskless embedded devices. It provides improved wear=0A=
-  levelling, compression and support for hard links. You cannot use=0A=
+  leveling, compression and support for hard links. You cannot use=0A=
   this on normal block devices, only on 'MTD' devices.=0A=
 =0A=
   Further information should be made available soon at=0A=
@@ -14884,7 +14890,7 @@=0A=
 =0A=
   Windows 2000 introduced the concept of Dynamic Disks to get =
around=0A=
   the limitations of the PC's partitioning scheme.  The Logical =
Disk=0A=
-  Manager allows the user to repartion a disk and create spanned,=0A=
+  Manager allows the user to repartition a disk and create spanned,=0A=
   mirrored, striped or RAID volumes, all without the need for=0A=
   rebooting.=0A=
 =0A=
@@ -15083,7 +15089,7 @@=0A=
   Note: if you just want your box to act as an SMB *server* and =
make=0A=
   files and printing services available to Windows clients (which =
need=0A=
   to have a TCP/IP stack), you don't need to say Y here; you can =
use=0A=
-  the program SAMBA (available from =
<ftp://ftp.samba.org/pub/samba/>)=0A=
+  the program Samba (available from =
<ftp://ftp.samba.org/pub/samba/>)=0A=
   for that.=0A=
 =0A=
   General information about how to connect Linux, Windows machines =
and=0A=
@@ -15728,7 +15734,7 @@=0A=
 CPM SCC Ethernet=0A=
 CONFIG_SCC_ENET=0A=
   Enable Ethernet support via the Motorola MPC8xx serial=0A=
-  commmunications controller.=0A=
+  communications controller.=0A=
 =0A=
 # Choice: scc_ethernet=0A=
 Ethernet on SCC1=0A=
@@ -15746,7 +15752,7 @@=0A=
 =0A=
 Use Big CPM Ethernet Buffers=0A=
 CONFIG_ENET_BIG_BUFFERS=0A=
-  Allocate large buffers for MPC8xx Etherenet.  Increases =
throughput=0A=
+  Allocate large buffers for MPC8xx Ethernet.  Increases throughput=0A=
   and decreases the likelihood of dropped packets, but costs =
memory.=0A=
 =0A=
 Apple Desktop Bus (ADB) support=0A=
@@ -15793,7 +15799,7 @@=0A=
 HIL keyboard support=0A=
 CONFIG_HIL=0A=
   The "Human Interface Loop" is a older, 8-channel USB-like =
controller=0A=
-  used in Hewlette Packard PA-RISC based machines.  There are a few=0A=
+  used in Hewlett Packard PA-RISC based machines.  There are a few=0A=
   cases where it is seen on PC/MAC architectures as well, usually =
also=0A=
   manufactured by HP.  This driver is based off MACH and BSD =
drivers,=0A=
   and implements support for a keyboard attached to the HIL port.=0A=
@@ -17607,7 +17613,7 @@=0A=
 CONFIG_TOSHIBA=0A=
   This adds a driver to safely access the System Management Mode of=0A=
   the CPU on Toshiba portables with a genuine Toshiba BIOS. It does=0A=
-  not work on models with a Pheonix BIOS. The System Management =
Mode=0A=
+  not work on models with a Phoenix BIOS. The System Management =
Mode=0A=
   is used to set the BIOS and power saving options on Toshiba =
portables.=0A=
 =0A=
   For information on utilities to make use of this driver see the=0A=
@@ -17902,7 +17908,7 @@=0A=
 =0A=
 InterAct digital joysticks and gamepads=0A=
 CONFIG_INPUT_INTERACT=0A=
-  Say Y hereif you have an InterAct gameport or joystick=0A=
+  Say Y here if you have an InterAct gameport or joystick=0A=
   communicating digitally over the gameport.  For more information =
on=0A=
   how to use the driver please read =
<file:Documentation/input/joystick.txt>.=0A=
 =0A=
@@ -18535,7 +18541,7 @@=0A=
 =0A=
 MSND Pinnacle MPU IRQ=0A=
 CONFIG_MSNDPIN_MPU_IRQ=0A=
-  Iinterrupt request number for the Kurzweil daughterboard=0A=
+  Interrupt request number for the Kurzweil daughterboard=0A=
   synthesizer on MultiSound Pinnacle and Fiji sound cards.=0A=
 =0A=
 MSND Pinnacle IRQ=0A=
@@ -20189,8 +20195,8 @@=0A=
 =0A=
 Support for ST-RAM as swap space=0A=
 CONFIG_STRAM_SWAP=0A=
-  Some Atari 68k macines (including the 520STF and 1020STE) divide=0A=
-  their addressible memory into ST and TT sections.  The TT section=0A=
+  Some Atari 68k machines (including the 520STF and 1020STE) divide=0A=
+  their addressable memory into ST and TT sections.  The TT section=0A=
   (up to 512MB) is the main memory; the ST section (up to 4MB) is=0A=
   accessible to the built-in graphics board, runs slower, and is=0A=
   present mainly for backward compatibility with older machines.=0A=
@@ -21484,7 +21490,7 @@=0A=
 CONFIG_RADIO_MIROPCM20_RDS=0A=
   Choose Y here if you want to see RDS/RBDS information like=0A=
   RadioText, Programme Service name, Clock Time and date, Programme=0A=
-  TYpe and Traffic Announcement/Programme identification.  You also=0A=
+  Type and Traffic Announcement/Programme identification.  You also=0A=
   need to say Y to "miroSOUND PCM20 radio" and devfs!=0A=
 =0A=
   It's not possible to read the raw RDS packets from the device, so=0A=
@@ -21790,9 +21796,20 @@=0A=
 =0A=
 Support for DASD hard disks=0A=
 CONFIG_DASD=0A=
-  Enable this option if you want to access DASDs directly utilizing=0A=
-  S/390s channel subsystem commands. This is necessary for running=0A=
-  natively on a single image or an LPAR.=0A=
+  Enable this option if you want to access DASD (Direct Access =
Storage=0A=
+  Devices, or disks) directly utilizing S/390 channel subsystem=0A=
+  commands.  This is necessary for running on S/390 systems, =
whether=0A=
+  under VM, in an LPAR, or natively.  The only exception to this =
would=0A=
+  be if you use RAM disks for network-mounted devices for all your=0A=
+  file systems.=0A=
+=0A=
+  This driver can be built as a module, but that is normally only =
used=0A=
+  for creating installation kernels where the device numbers of the=0A=
+  disks are not yet known.  You cannot do this if the DASD module =
is=0A=
+  actually going to be on a DASD volume, and not in a RAM disk or =
on=0A=
+  a network-mounted device.=0A=
+=0A=
+  If in doubt, specify "Y" here.=0A=
 =0A=
 Enable DASD fast write=0A=
 CONFIG_DASD_FAST_IO=0A=
@@ -21827,7 +21844,7 @@=0A=
   device, you have to merge a bootsector specific to the device=0A=
   into the first bytes of the kernel. You will have to select the=0A=
   IPL device on another question, that pops up, when you select=0A=
-  CONFIG_IPLABE.=0A=
+  CONFIG_IPLABLE.=0A=
 =0A=
 Support for 3215 line mode terminal=0A=
 CONFIG_TN3215=0A=
@@ -21931,7 +21948,7 @@=0A=
 CONFIG_IUCV=0A=
   Select this option if you want to use inter-user communication=0A=
   vehicle networking under VM or VIF.  This option is also =
available=0A=
-  as a module which will be called iucv.o. If unsure, say "Y".=0A=
+  as a module which will be called netiucv.o. If unsure, say "Y".=0A=
 =0A=
 Kernel support for 31 bit ELF binaries=0A=
 CONFIG_S390_SUPPORT=0A=
@@ -21976,6 +21993,15 @@=0A=
   For more info see the chandev manpage usually distributed in=0A=
   <file:Documentation/s390/chandev.8> in the Linux source tree.=0A=
 =0A=
+Lan Channel Station Interface=0A=
+CONFIG_LCS=0A=
+  If you are using an OSA card (Open Systems Adapter) in LCS mode =
on=0A=
+  an S/390 system, you should select this option.  This driver can =
be=0A=
+  built as a module, which will require that the driver parameters =
be=0A=
+  supplied via an entry in /etc/modules.conf, or through the =
chandev=0A=
+  interface if that has been enabled in your kernel.  See=0A=
+  <file:Documentation/s390/chandev.8> for details.=0A=
+=0A=
 SAB3036 tuner support=0A=
 CONFIG_TUNER_3036=0A=
   Say Y here to include support for Philips SAB3036 compatible =
tuners.=0A=
@@ -22719,7 +22745,7 @@=0A=
   will also need a working PPP subsystem (driver, daemon and=0A=
   config)...=0A=
 =0A=
-  IrNET is an alternate way to tranfer TCP/IP traffic over IrDA.  =
It=0A=
+  IrNET is an alternate way to transfer TCP/IP traffic over IrDA.  =
It=0A=
   uses synchronous PPP over a set of point to point IrDA sockets.  =
You=0A=
   can use it between Linux machine or with W2k.=0A=
 =0A=
@@ -22767,7 +22793,7 @@=0A=
   device driver.  If you want to compile it as a module =
(irda-usb.o),=0A=
   say M here and read <file:Documentation/modules.txt>.  IrDA-USB=0A=
   support the various IrDA USB dongles available and most of their=0A=
-  pecularities.  Those dongles plug in the USB port of your =
computer,=0A=
+  peculiarities.  Those dongles plug in the USB port of your =
computer,=0A=
   are plug and play, and support SIR and FIR (4Mbps) speeds.  On =
the=0A=
   other hand, those dongles tend to be less efficient than a FIR=0A=
   chipset.=0A=
@@ -23279,7 +23305,7 @@=0A=
 =0A=
 Etrax bus waitstates=0A=
 CONFIG_ETRAX_DEF_R_WAITSTATES=0A=
-  Waitstates for SRAM, Flash and peripherials (not DRAM).  95f8 is =
a=0A=
+  Waitstates for SRAM, Flash and peripherals (not DRAM).  95f8 is a=0A=
   good choice for most Axis products...=0A=
 =0A=
 Etrax bus configuration=0A=
@@ -23443,13 +23469,13 @@=0A=
 =0A=
 Etrax100 RS-485 mode on PA=0A=
 CONFIG_ETRAX_RS485_ON_PA=0A=
-  Control Driver Output Enable on RS485 tranceiver using a pin on =
PA=0A=
+  Control Driver Output Enable on RS485 transceiver using a pin on =
PA=0A=
   port:=0A=
           Axis 2400/2401 uses PA 3.=0A=
 =0A=
 Etrax100 RS-485 mode on PA bit=0A=
 CONFIG_ETRAX_RS485_ON_PA_BIT=0A=
-  Control Driver Output Enable on RS485 tranceiver using a this bit=0A=
+  Control Driver Output Enable on RS485 transceiver using a this =
bit=0A=
   on PA port.=0A=
 =0A=
 Ser0 DTR on PB bit=0A=
@@ -24114,7 +24140,7 @@=0A=
   each of the machines below is described by a machine vector.=0A=
 =0A=
   Select SolutionEngine if configuring for a Hitachi SH7709=0A=
-  or SH7750/7750S evalutation board.=0A=
+  or SH7750/7750S evaluation board.=0A=
 =0A=
   Select Overdrive if configuring for a ST407750 Overdrive board.=0A=
   More information at=0A=
@@ -24162,12 +24188,12 @@=0A=
 SolutionEngine=0A=
 CONFIG_SH_SOLUTION_ENGINE=0A=
   Select SolutionEngine if configuring for a Hitachi SH7709=0A=
-  or SH7750 evalutation board.=0A=
+  or SH7750 evaluation board.=0A=
 =0A=
 7751 SolutionEngine=0A=
 CONFIG_SH_7751_SOLUTION_ENGINE=0A=
   Select 7751 SolutionEngine if configuring for a Hitachi SH7751=0A=
-  evalutation board.=0A=
+  evaluation board.=0A=
 =0A=
 Overdrive=0A=
 CONFIG_SH_OVERDRIVE=0A=

------_=_NextPart_000_01C1F7AA.1F6F61BE
Content-Type: application/octet-stream;
	name="initrd.4.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="initrd.4.diff"

--- /usr/man/man4/initrd.4.orig	Thu May  9 22:22:21 2002=0A=
+++ /usr/man/man4/initrd.4	Thu May  9 22:22:34 2002=0A=
@@ -408,6 +408,15 @@=0A=
 .BR /dev/initrd =0A=
 should not depend on the behavior give in the above notes.  =0A=
 The behavior may change in future versions of the Linux kernel.=0A=
+=0A=
+.\"=0A=
+.\"=0A=
+.\"=0A=
+.SH BUGS=0A=
+Due to a bug elsewhere in the kernel,=0A=
+.BR initrd =0A=
+files that use ext2 file systems must use a 1024-byte block size.  =
This=0A=
+is ensured by specifying a "-b 1024" parameter on the mkfs or mke2fs =
command.=0A=
 .\"   =0A=
 .\"   =0A=
 .\"   =0A=

------_=_NextPart_000_01C1F7AA.1F6F61BE
Content-Type: application/octet-stream;
	name="initrd.txt.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="initrd.txt.diff"

--- linux/Documentation/initrd.txt.orig	Mon Dec  4 01:48:18 2000=0A=
+++ linux/Documentation/initrd.txt	Thu May  9 21:51:57 2002=0A=
@@ -115,8 +115,12 @@=0A=
  1) make sure loopback block devices are configured into the kernel=0A=
  2) create an empty file system of the appropriate size, e.g.=0A=
     # dd if=3D/dev/zero of=3Dinitrd bs=3D300k count=3D1=0A=
-    # mke2fs -F -m0 initrd=0A=
+    # mke2fs -F -m0 -b 1024 initrd=0A=
     (if space is critical, you may want to use the Minix FS instead of =
Ext2)=0A=
+    (Note that due to a problem elsewhere in the kernel, you _must_ =
use a=0A=
+     1024-byte blocksize when creating your file system.  If any =
other=0A=
+     value is used, the kernel will be unable to mount the initrd at =
boot=0A=
+     time, causing a kernel panic.)=0A=
  3) mount the file system, e.g.=0A=
     # mount -t ext2 -o loop initrd /mnt=0A=
  4) create the console device (not necessary if using devfs, but it =
can't=0A=

------_=_NextPart_000_01C1F7AA.1F6F61BE--
