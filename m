Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262419AbTIOAE3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 20:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262421AbTIOAE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 20:04:29 -0400
Received: from dsl093-244-091.ric1.dsl.speakeasy.net ([66.93.244.91]:18414
	"EHLO perl.xsdg.org") by vger.kernel.org with ESMTP id S262419AbTIOAER
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 20:04:17 -0400
Date: Mon, 15 Sep 2003 00:04:11 +0000
From: xsdg <xsdg@freenode.org>
To: linux-kernel@vger.kernel.org
Cc: xsdg@freenode.org
Subject: 2.6.0-test1, -test4 control key "stuck"
Message-Id: <20030915000411.6d35386d.xsdg@freenode.org>
X-Mailer: Sylpheed version 0.9.4claws (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.:X8r9Xa/WTt81Q"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.:X8r9Xa/WTt81Q
Content-Type: multipart/mixed;
 boundary="Multipart_Mon__15_Sep_2003_00:04:11_+0000_08512108"


--Multipart_Mon__15_Sep_2003_00:04:11_+0000_08512108
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi.  I recently got a new Toshiba M15-S405 laptop, on which I installed Debian SID (using the Sarge netinst bootcd).  I installed the debian 2.6.0-test1 kernel and booted into it.  I noticed that often, pressing keys under this kernel would result in messages such as [1] printed to the console.

The Problem Now:
	My current problem is that once in a while, a control key will become "stuck", as interpreted by all applications.  By "stuck," I mean that pressing and releasing the control key will not cause it to become "unstuck."  All keypresses, whether in X or on a VT, are interpreted as if the control key were being pressed.  The only way I have found to unstick the key is by pressing random keys in rapid succession (sometimes holding the control key, and sometimes just making sure I press it a few times during the key-pressing frenzy).  I believe that this problem is related to the messages ([1]) printed to kern.log and the console.  This problem has occurred under 2.6.0-test4*, and may have occurred under 2.6.0-test5-mm1 (I don't remember).

	As I spend most of my time in x-windows, this problem has only occurred while I was using x-windows; I am not sure whether it would or would not occur while in the console or while x-windows is not running at all.  This problem has occurred both while using NVidia's proprietary driver and while using the open-source driver provided with xfree86 4.2.1

	Most recently, this problem manifested itself by (as far as I can tell) switching the keyboard keymap (this, occurred while I was in X, with Mozilla on the current workspace).  After switching to vt2, I am now unable to return to X (vt 7).  Pressing the numeral keys acts as if shift were held down while using an odd alternate keymap (2 -> "^U", 4->"$", [7-0] -> ["{", "[", "]", "}", "\"], e -> Euro symbol).  You can find the physical layout of my keyboard at [2].  While pressing the shift key, no characters are displayed on the console.  Pressing <alt>+Fn or <ctrl>+<alt>+Fn to switch to another VT does not do anything; the same occurs when trying <alt>+left/right


Kernel Version History:
	After installing most of the necessary tools, I compiled a vanilla 2.5.73 which eliminated the problem shown in [1].  A little later, I compiled and booted into 2.6.0-test3, and then dropped back to test1-ac3 (because cardbus/pcmcia hard-locked during boot).  -test1-ac3 did not exhibit the problem.  I moved to -test4 when it was released, which exhibited the problem.  Because swsusp was broken in -test4 (on my system, at least), I dropped back to 2.6.0-test1-ac3 after a few days.  Later, I upgraded to -test4-mm4, -mm6, and -test5-mm1, all of which exhibited the problem.  After running -test5-mm1 for about a day, I dropped back to -test4-mm6 (I don't quite remember why).


Exhibit 1:
Sep 14 20:42:27 cpp kernel: atkbd.c: Unknown key (set 2, scancode 0xb6, on isa0060/serio0) pressed.
Sep 14 20:42:27 cpp kernel: i8042 history: 19 a2 99 0f 8f 0f 8f 1c 9c 04 84 36 09 b6 89 b6 
Sep 14 22:13:00 cpp kernel: atkbd.c: Unknown key (set 2, scancode 0xa5, on isa0060/serio0) pressed.
Sep 14 22:13:00 cpp kernel: i8042 history: a7 20 9e 21 9f 24 25 26 27 a0 a4 a5 a6 a7 a1 a5 
Sep 14 22:13:00 cpp kernel: atkbd.c: Unknown key (set 2, scancode 0xa6, on isa0060/serio0) pressed.
Sep 14 22:13:00 cpp kernel: i8042 history: 20 9e 21 9f 24 25 26 27 a0 a4 a5 a6 a7 a1 a5 a6 
Sep 14 22:13:00 cpp kernel: atkbd.c: Unknown key (set 2, scancode 0xa7, on isa0060/serio0) pressed.
Sep 14 22:13:00 cpp kernel: i8042 history: 9e 21 9f 24 25 26 27 a0 a4 a5 a6 a7 a1 a5 a6 a7 


System Info (please ask if you need more info):

Hardware specs:
http://cdgenp01.csd.toshiba.com/content/product/pdf_files/detailed_specs/satellitepro_M15_S405.pdf

$uname -a
Linux cpp 2.6.0-test4-mm6 #4 Tue Sep 9 03:19:18 UTC 2003 i686 GNU/Linux

$lspci
00:00.0 Host bridge: Intel Corp.: Unknown device 3340 (rev 03)
00:01.0 PCI bridge: Intel Corp.: Unknown device 3341 (rev 03)
00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 03)
00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 03)
00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 03)
00:1d.7 USB Controller: Intel Corp. 82801DB USB EHCI Controller (rev 03)
00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 83)
00:1f.0 ISA bridge: Intel Corp.: Unknown device 24cc (rev 03)
00:1f.1 IDE interface: Intel Corp.: Unknown device 24ca (rev 03)
00:1f.5 Multimedia audio controller: Intel Corp. 82801DB AC'97 Audio (rev 03)
00:1f.6 Modem: Intel Corp. 82801DB AC'97 Modem (rev 03)
01:00.0 VGA compatible controller: nVidia Corporation NV17 [GeForce4 420 Go] (rev a3)
02:07.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A IEEE-1394a-2000 Controller (PHY/Link)
02:08.0 Ethernet controller: Intel Corp. 82801BD PRO/100 VE (MOB) Ethernet Controller (rev 83)
02:0a.0 Network controller: Intel Corp.: Unknown device 1043 (rev 04)
02:0b.0 CardBus bridge: Toshiba America Info Systems ToPIC95 PCI to Cardbus Bridge with ZV Support (rev 32)
02:0b.1 CardBus bridge: Toshiba America Info Systems ToPIC95 PCI to Cardbus Bridge with ZV Support (rev 32)
02:0d.0 System peripheral: Toshiba America Info Systems SD TypA Controller (rev 03)

$cat /proc/cpuinfo    
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 9
model name      : Intel(R) Pentium(R) M processor 1400MHz
stepping        : 5
cpu MHz         : 598.576
cache size      : 1024 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 apic sep mtrr pge mca cmov pat clflush dts acpi mmx fxsr sse sse2 tm pbe tm2 est
bogomips        : 1119.96

$cat /proc/config_build_info 
Kernel:    Linux 2.6.0-test4 #2 Sat Sep 6 17:06:14 UTC 2003 i686
Compiler:  gcc version 3.3.2 20030812 (Debian prerelease)
Version_in_Makefile: 2.6.0-test4-mm6

$cat /proc/interrupts 
           CPU0       
  0:   99529523          XT-PIC  timer
  1:      68790          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  3:     504747          XT-PIC  orinoco_cs
  5:    2490597          XT-PIC  0000:02:0b.0, 0000:02:0b.1, ehci_hcd, uhci-hcd, uhci-hcd, uhci-hcd, Intel 82801DB-ICH4
  8:          4          XT-PIC  rtc
  9:       5060          XT-PIC  acpi
 10:   11275668          XT-PIC  nvidia
 12:     160930          XT-PIC  i8042
 14:     194882          XT-PIC  ide0
 15:        373          XT-PIC  ide1
NMI:          0 
LOC:   95197068 
ERR:          7
MIS:          0

$cat /proc/ioports 
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0100-013f : orinoco_cs
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
1000-101f : 0000:00:1d.2
  1000-101f : uhci-hcd
1040-107f : 0000:00:1f.5
1080-10ff : 0000:00:1f.6
1400-14ff : 0000:00:1f.5
1800-18ff : 0000:00:1f.6
1c00-1cff : PCI CardBus #03
2000-20ff : PCI CardBus #03
2400-24ff : PCI CardBus #07
2800-28ff : PCI CardBus #07
bfa0-bfaf : 0000:00:1f.1
  bfa0-bfa7 : ide0
  bfa8-bfaf : ide1
cf40-cf7f : 0000:02:08.0
  cf40-cf7f : e100
ef80-ef9f : 0000:00:1d.1
  ef80-ef9f : uhci-hcd
efe0-efff : 0000:00:1d.0
  efe0-efff : uhci-hcd

$cat /proc/iomem 
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000e0000-000effff : Extension ROM
000f0000-000fffff : System ROM
00100000-1ffcffff : System RAM
  00100000-00358707 : Kernel code
  00358708-0043c47f : Kernel data
1ffd0000-1ffdffff : ACPI Tables
1ffe0000-1fffffff : reserved
20000000-200003ff : 0000:00:1d.7
  20000000-200003ff : ehci_hcd
20000400-200007ff : 0000:00:1f.1
20000800-200009ff : 0000:00:1f.5
  20000800-200009ff : Intel 82801DB-ICH4 - AC'97
20000a00-20000aff : 0000:00:1f.5
  20000a00-20000aff : Intel 82801DB-ICH4 - Controller
20000c00-20000dff : 0000:02:0d.0
20001000-200017ff : 0000:02:07.0
20002000-20002fff : 0000:02:0b.0
  20002000-20002fff : yenta_socket
20003000-20003fff : 0000:02:0b.1
  20003000-20003fff : yenta_socket
20004000-20007fff : 0000:02:07.0
20400000-207fffff : PCI CardBus #03
20800000-20bfffff : PCI CardBus #03
20c00000-20ffffff : PCI CardBus #07
21000000-213fffff : PCI CardBus #07
a0000000-a0000fff : card services
dbf00000-dfffffff : PCI Bus #01
  dbf80000-dbffffff : 0000:01:00.0
  dc000000-dfffffff : 0000:01:00.0
e0000000-efffffff : 0000:00:00.0
fcefe000-fcefefff : 0000:02:0a.0
fceff000-fcefffff : 0000:02:08.0
  fceff000-fcefffff : e100
fd000000-fdffffff : PCI Bus #01
  fd000000-fdffffff : 0000:01:00.0
feda0000-fedbffff : reserved
ffb80000-ffbfffff : reserved
fff00000-ffffffff : reserved

$COLUMNS=80 dpkg -l xserver-xfree86 console-data console-tools
Desired=Unknown/Install/Remove/Purge/Hold
| Status=Not/Installed/Config-files/Unpacked/Failed-config/Half-installed
|/ Err?=(none)/Hold/Reinst-required/X=both-problems (Status,Err: uppercase=bad)
||/ Name           Version        Description
+++-==============-==============-============================================
ii  xserver-xfree8 4.2.1-9        the XFree86 X server
ii  console-data   2002.12.04dbs- Keymaps, fonts, charset maps, fallback table
ii  console-tools  0.2.3dbs-41    Linux console and font utilities

env output (run via ssh)
$env
TERM=rxvt
SHELL=/bin/bash
SSH_CLIENT=::ffff:192.168.0.76 49126 22
SSH_TTY=/dev/pts/2
USER=xsdg
LS_COLORS=no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:
MAIL=/var/mail/xsdg
PATH=/home/xsdg/usr/bin:/sbin:/usr/sbin:/usr/local/bin:/usr/bin:/bin:/usr/bin/X11:/usr/games:/sbin:/usr/sbin
LD_RUN_PATH=/home/xsdg/usr/lib
PWD=/home/xsdg
EDITOR=aee
PS1=\n\t> [\u{\h}@\w]\n\$
SHLVL=1
HOME=/home/xsdg
LOGNAME=xsdg
SSH_CONNECTION=::ffff:192.168.0.76 49126 ::ffff:192.168.0.38 22
_=/usr/bin/env

$lsmod
Module                  Size  Used by
nls_cp437               5888  0 
vfat                   16384  0 
fat                    46912  1 vfat
nls_utf8                2176  0 
ntfs                   91596  0 
hid                    34560  0 
agpgart                32808  0 
nvidia               1706348  10 
orinoco_cs              8328  1 
orinoco                44556  1 orinoco_cs
hermes                  8832  2 orinoco_cs,orinoco

I have attached /proc/config.gz

Please CC me in any replies.  Thanks in advance for your help.

-- 
| "I'm not sure which upsets me more: that people   |
|   are so unwilling to accept responsibility for   |
|   their own actions, or that they are so eager to |
|   regulate everyone else's."                      |
|   -- Kee Hinckley                                 |
) http://www.cuodan.net/~xsdg/    xsdg@freenode.org (



--Multipart_Mon__15_Sep_2003_00:04:11_+0000_08512108
Content-Type: application/octet-stream;
 name="config.gz"
Content-Disposition: attachment;
 filename="config.gz"
Content-Transfer-Encoding: base64

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

--Multipart_Mon__15_Sep_2003_00:04:11_+0000_08512108--

--=.:X8r9Xa/WTt81Q
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/ZQH/La8oArNOsUERAn6sAJ0ZcvVSBOU6W8AaiOZ9uxk6PvYCnACgggH7
NvaL3SB7kFO2rk4KIc8Ci20=
=PEC0
-----END PGP SIGNATURE-----

--=.:X8r9Xa/WTt81Q--
