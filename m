Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbUEJTJY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbUEJTJY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 15:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261248AbUEJTJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 15:09:24 -0400
Received: from pop.gmx.de ([213.165.64.20]:46027 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261232AbUEJTIM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 15:08:12 -0400
X-Authenticated: #21910825
Message-ID: <409FD316.6010506@gmx.net>
Date: Mon, 10 May 2004 21:08:06 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040114
X-Accept-Language: de, en
MIME-Version: 1.0
To: foner+x-forcedeth@media.mit.edu
CC: XFree86@XFree86.Org, Manfred Spraul <manfred@colorfullife.com>,
       debian-user@lists.debian.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: forcedeth breaks X in Debian-testing 2.4.25 on MSI K7N2 Delta-L
 mobo
References: <200405091450.KAA08870@out-of-band.media.mit.edu>
In-Reply-To: <200405091450.KAA08870@out-of-band.media.mit.edu>
Content-Type: multipart/mixed;
 boundary="------------070904050504090709050103"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070904050504090709050103
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

foner+x-forcedeth@media.mit.edu wrote:

[restructured the mail to make it more readable]

> As far as I can tell, this never went out to debbugs or anyone
> named in the X-Debbugs-CC: line, so I'm sending directly.  Thanks!
> 
> [And if anyone receiving this knows either (a) that it -did- get
> redistributed by debbugs, or (b) how to -get- it to go out, please
> tell me and/or do so.]
> 
> - - - Begin forwarded message - - -
> 
> Date: Wed, 5 May 2004 16:39:18 -0400 (EDT)
> From: foner+x-forcedeth@media.mit.edu
> To: debbugs@bugs.debian.org
> X-Debbugs-CC: XFree86@XFree86.Org, andrew@orbital.co.uk, c-d.hailfinger.kernel.2004@gmx.net
> Subject: forcedeth breaks X in Debian-testing 2.4.25 on MSI K7N2 Delta-L mobo
> 
> Summary:  I can either have a network (with forcedeth loaded), or have
> X start up.  I cannot have both---although if I start X first, I can
> then load forcedeth and bring up the network.  What's going on?
> 
> [Please keep me CC'ed on responses!]
> 
> Details:
> 
> [I can't put a useful Package/Version pseudoheader here because this
> is some weird interaction between X and the forcedeth shipped in
> Debian 2.4.25; there are 3 possibilities (kernel, forcedeth, X)
> contending for which package I'm even talking about.  I hope somebody
> can help here.  Note also that I can't even find a reasonable address
> to which to report bugs in forcedeth---the best I could do is an

You could have googled for "forcedeth". The first hit would have given you
all the information you need. Quoting from there:

| Send any reports to linux-kernel or netdev@oss.sgi.com and CC:
| Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net> to get
| the remaining issues fixed.


> obviously short-term address of one of its maintainers and an address
> of another author gleaned a random mailing list.  Doesn't it have its
> own buglist?  Lots of googling has failed to turn one up and its

Forcedeth is integrated into current 2.4 and 2.6, so there is no point in
setting up a dedicated mailing list for it.


> README doesn't say.  This seems weird for something that's important

Forcedeth has a README? Why has nobody told me so or sent it upstream?


> enough to be shipped as part of Debian.]
> 
> [I sent this to debian-user on 4/17 and, even though I see it went
> out, I received zero replies, so I'm resending to debbugs, the XFree86
> buglist, and the maintainers, in the hope that -somebody- has seen
> this before.  Please keep me CC'ed on replies!]
> 
> I just started running Debian-testing 2.4.25 on an MSI K7N2 Delta-L
> motherboard.  The installer ran fine, and then I discovered that the
> network failed to come up when I rebooted.  I quickly discovered bug
> 239076, which pointed out that /etc/modutils/aliases was missing the
> "alias eth0 forcedeth" that the installer originally wrote, but
> putting that back in and running update-modules then made X fail to
> start up.  (In fact, before finding bug 239076, I'd manually done
> "insmod forcedeth", "ifdown eth0", "ifup eth0" and then noticed a
> little while later that X would no longer start up, but wrote it off
> as a coincidence since I'd only booted once since the installer boot.)
> [The installer was debian-sarge-netinst Beta 3 of March 30, 2004.]
> 
> I'm now in the state where I can reliably cause X to not start if
> forcedeth is loaded, and vice versa.  Logfiles for both cases are
> appended below.
> 
> Does anyone know of a workaround?  It looks like forcedeth is doing
> something fishy that's breaking X's VESA handling.  Googling for

forcedeth only accesses the nForce nic. If that confuses the VESA BIOS
code, the bug most probably is in the BIOS itself.

> things mentioning the "vm86() syscall generated signal 4" message
> in the XFree86 logfile hasn't turned up anything useful yet.  And
> I don't know if I should report this individually to the X and/or
> forcedeth maintainers yet (and this version of X explicitly disclaims
> support anyway; see logfile), or if this is fallout from a more
> systemic bug, or if I should go through the pain of installing
> nVidia's drivers instead (and I'd -really- rather not do that).
> 
> [Yes, I know I could start X, then load forcedeth and have a network.
> That's a bit klugier of a workaround than I was hoping for...  Though,
> annoying as it was that the aliases file was miswritten, I'm actually
> very glad that it was!  Otherwise X would simply have been mysteriously
> broken such that it had -never- started on this machine and I'd have
> had a much more enormous debugging space to explore to figure out why.
> For once, I'm happy about an installer bug...]
> 
> [Note also that I'm using the defaults that the installer picked when
> I told it I had a flatpanel display.  They're not quite right (for
> example, it assumed 800x600 or something and this panel does more),
> but I haven't bothered touching the XFree86 config file until the
> forcedeth problem is resolved.  I'm including it at the end, though
> I doubt it has anything to do with the bug I'm reporting.  It's a
> borrowed video card that I won't be using in the real system and I
> know next to nothing about it, hence my stab at just using the
> installer's guessed defaults.]
> 
> Logfiles follow.  First, both versions of the XFree86 log.  Next,
> /var/log/messages -without- forcedeth loaded (e.g., the aliases line
> removed from /etc/modules.conf) and then, so as not to drown people in
> output, a diff of that with the next boot (where the eth0 line -is- in
> modules.conf) [and with some irrelevances in the diff, plus the
> ever-changing timestamps, removed] rather than the entire file again.
> 
Xfree86.0.log (working version) attached, diff against non-working follows:

--- Xfree86.0.log WITHOUT FORCEDETH LOADED:
+++ Xfree86.0.log -WITH- FORCEDETH LOADED:
@@ -65,7 +65,7 @@
        ABI class: XFree86 Video Driver, version 0.6
 (II) PCI: Probing config type using method 1
 (II) PCI: Config type is 1
-(II) PCI: stages = 0x03, oldVal1 = 0x8000110c, mode1Res1 = 0x80000000
+(II) PCI: stages = 0x03, oldVal1 = 0x00000000, mode1Res1 = 0x80000000
 (II) PCI: PCI scan (all values are in hex)
 (II) PCI: 00:00:0: chip 10de,01e0 card 0000,0000 rev c1 class 06,00,00 hdr 80
 (II) PCI: 00:00:1: chip 10de,01eb card 1462,5700 rev c1 class 05,00,00 hdr 80
@@ -346,880 +346,27 @@
 (II) VESA(0): initializing int10
 (II) VESA(0): Primary V_BIOS segment is: 0xc000
 (WW) System lacks support for changing MTRRs
-(II) VESA(0): VESA BIOS detected
-(II) VESA(0): VESA VBE Version 1.2
-(II) VESA(0): VESA VBE Total Mem: 2048 kB
-(II) VESA(0): VESA VBE OEM: STB PowerGraph 64 Video (Trio64V+)
-(**) VESA(0): Depth 24, (--) framebuffer bpp 32
-(==) VESA(0): RGB weight 888
-(==) VESA(0): Default visual is TrueColor
-(==) VESA(0): Using gamma correction (1.0, 1.0, 1.0)
-(II) VESA(0): Searching for matching VESA mode(s):
-[**** massive amounts of output snipped ****]
+(EE) VESA(0): vm86() syscall generated signal 4.
+(II) VESA(0): EAX=0x00004f00, EBX=0x00000000, ECX=0x00000000, EDX=0x00000000
+(II) VESA(0): ESP=0x00000ff8, EBP=0x00000000, ESI=0x00000000, EDI=0x00002000
+(II) VESA(0): CS=0x0001, SS=0x0100, DS=0x0040, ES=0x0000, FS=0x0000,
GS=0x0000
+(II) VESA(0): EIP=0x0000010a, EFLAGS=0x00033202
+(II) VESA(0): code at 0x0000011a:
+ 63 35 01 05 01 04 ff ff ff 00 03 04 c0 a8 00 01
+ 0f 16 6e 65 31 2e 63 6c 69 65 6e 74 32 2e 61 74
+(II) stack at 0x00001ff8:
+ 00 00 00 06 00 00 00 32
+(II) VESA(0): VESA BIOS not detected
+(II) UnloadModule: "vesa"
+(II) UnloadModule: "int10"
+(II) UnloadModule: "vbe"
+(EE) Screen(s) found, but none have a usable configuration.
+
+Fatal server error:
+no screens found
+
+When reporting a problem related to a server crash, please send
+the full server output, not just the last messages.
+This can be found in the log file "/var/log/XFree86.0.log".
+Please report problems to submit@bugs.debian.org.


/var/log/messsages (working version) attached, diff against non-working
follows:

> @@ -3,7 +3,7 @@
>  darkstar kernel: Inspecting /boot/System.map-2.4.25-1-386
>  darkstar kernel: Loaded 18507 symbols from /boot/System.map-2.4.25-1-386.
>  darkstar kernel: Symbols match kernel version 2.4.25.
> -darkstar kernel: Loaded 516 symbols from 19 modules.
> +darkstar kernel: Loaded 520 symbols from 20 modules.
>  darkstar kernel: Linux version 2.4.25-1-386 (herbert@gondolin) (gcc version 3.3.2 (Debian)) #1 Tue Feb 24 08:11:13 EST 2004
>  darkstar kernel: BIOS-provided physical RAM map:
>  darkstar kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
> @@ -144,7 +144,9 @@
>  darkstar kernel: usb-uhci.c: $Revision: 1.275 $ time 09:07:29 Feb 24 2004
>  darkstar kernel: usb-uhci.c: High bandwidth mode enabled
>  darkstar kernel: usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
> -darkstar lpd[570]: restarted
> +darkstar kernel: forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.22.
> +darkstar kernel: eth0: forcedeth.c: subsystem: 01462:570c bound to 00:04.0
> +darkstar lpd[605]: restarted
>  darkstar kernel: Linux Kernel Card Services 3.1.22
>  darkstar kernel:   options:  [pci] [cardbus] [pm]
>  darkstar kernel: isapnp: Scanning for PnP cards...

XF86Config-4 attached.

Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/

--------------070904050504090709050103
Content-Type: text/plain;
 name="XF86Config-4"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="XF86Config-4"

# XF86Config-4 (XFree86 X Window System server configuration file)
#
# This file was generated by dexconf, the Debian X Configuration tool, using
# values from the debconf database.
#
# Edit this file with caution, and see the XF86Config-4 manual page.
# (Type "man XF86Config-4" at the shell prompt.)
#
# This file is automatically updated on xserver-xfree86 package upgrades *only*
# if it has not been modified since the last upgrade of the xserver-xfree86
# package.
#
# If you have edited this file but would like it to be automatically updated
# again, run the following commands as root:
#
#   cp /etc/X11/XF86Config-4 /etc/X11/XF86Config-4.custom
#   md5sum /etc/X11/XF86Config-4 > /var/lib/xfree86/XF86Config-4.md5sum
#   dpkg-reconfigure xserver-xfree86

Section "Files"
	FontPath	"unix/:7100"			# local font server
	# if the local font server has problems, we can fall back on these
	FontPath	"/usr/lib/X11/fonts/misc"
	FontPath	"/usr/lib/X11/fonts/cyrillic"
	FontPath	"/usr/lib/X11/fonts/100dpi/:unscaled"
	FontPath	"/usr/lib/X11/fonts/75dpi/:unscaled"
	FontPath	"/usr/lib/X11/fonts/Type1"
	FontPath	"/usr/lib/X11/fonts/CID"
	FontPath	"/usr/lib/X11/fonts/Speedo"
	FontPath	"/usr/lib/X11/fonts/100dpi"
	FontPath	"/usr/lib/X11/fonts/75dpi"
EndSection

Section "Module"
	Load	"GLcore"
	Load	"bitmap"
	Load	"dbe"
	Load	"ddc"
	Load	"dri"
	Load	"extmod"
	Load	"freetype"
	Load	"glx"
	Load	"int10"
	Load	"record"
	Load	"speedo"
	Load	"type1"
	Load	"vbe"
EndSection

Section "InputDevice"
	Identifier	"Generic Keyboard"
	Driver		"keyboard"
	Option		"CoreKeyboard"
	Option		"XkbRules"	"xfree86"
	Option		"XkbModel"	"pc104"
	Option		"XkbLayout"	"us"
EndSection

Section "InputDevice"
	Identifier	"Configured Mouse"
	Driver		"mouse"
	Option		"CorePointer"
	Option		"Device"		"/dev/psaux"
	Option		"Protocol"		"PS/2"
	Option		"Emulate3Buttons"	"true"
	Option		"ZAxisMapping"		"4 5"
EndSection

Section "InputDevice"
	Identifier	"Generic Mouse"
	Driver		"mouse"
	Option		"SendCoreEvents"	"true"
	Option		"Device"		"/dev/input/mice"
	Option		"Protocol"		"ImPS/2"
	Option		"Emulate3Buttons"	"true"
	Option		"ZAxisMapping"		"4 5"
EndSection

Section "Device"
	Identifier	"Generic Video Card"
	Driver		"vesa"
EndSection

Section "Monitor"
	Identifier	"Generic Monitor"
	HorizSync	28-50
	VertRefresh	43-75
	Option		"DPMS"
EndSection

Section "Screen"
	Identifier	"Default Screen"
	Device		"Generic Video Card"
	Monitor		"Generic Monitor"
	DefaultDepth	24
	SubSection "Display"
		Depth		1
		Modes		"800x600" "640x480"
	EndSubSection
	SubSection "Display"
		Depth		4
		Modes		"800x600" "640x480"
	EndSubSection
	SubSection "Display"
		Depth		8
		Modes		"800x600" "640x480"
	EndSubSection
	SubSection "Display"
		Depth		15
		Modes		"800x600" "640x480"
	EndSubSection
	SubSection "Display"
		Depth		16
		Modes		"800x600" "640x480"
	EndSubSection
	SubSection "Display"
		Depth		24
		Modes		"800x600" "640x480"
	EndSubSection
EndSection

Section "ServerLayout"
	Identifier	"Default Layout"
	Screen		"Default Screen"
	InputDevice	"Generic Keyboard"
	InputDevice	"Configured Mouse"
	InputDevice	"Generic Mouse"
EndSection

Section "DRI"
	Mode	0666
EndSection


--------------070904050504090709050103
Content-Type: text/plain;
 name="XFree86.0.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="XFree86.0.log"

This is a pre-release version of XFree86, and is not supported in any
way.  Bugs may be reported to XFree86@XFree86.Org and patches submitted
to fixes@XFree86.Org.  Before reporting bugs in pre-release versions,
please check the latest version in the XFree86 CVS repository
(http://www.XFree86.Org/cvs).

XFree86 Version 4.3.0.1 (Debian 4.3.0-7 20040318043201 root@cyberhq.internal.cyberhqz.com)
Release Date: 15 August 2003
X Protocol Version 11, Revision 0, Release 6.6
Build Operating System: Linux 2.6.4 i686 [ELF] 
Build Date: 18 March 2004
	Before reporting problems, check http://www.XFree86.Org/
	to make sure that you have the latest version.
Module Loader present
OS Kernel: Linux version 2.4.25-1-386 (herbert@gondolin) (gcc version 3.3.2 (Debian)) #1 Tue Feb 24 08:11:13 EST 2004 
Markers: (--) probed, (**) from config file, (==) default setting,
         (++) from command line, (!!) notice, (II) informational,
         (WW) warning, (EE) error, (NI) not implemented, (??) unknown.
(==) Log file: "/var/log/XFree86.0.log", Time: Sat Apr 17 03:32:56 2004
(==) Using config file: "/etc/X11/XF86Config-4"
(==) ServerLayout "Default Layout"
(**) |-->Screen "Default Screen" (0)
(**) |   |-->Monitor "Generic Monitor"
(**) |   |-->Device "Generic Video Card"
(**) |-->Input Device "Generic Keyboard"
(**) Option "XkbRules" "xfree86"
(**) XKB: rules: "xfree86"
(**) Option "XkbModel" "pc104"
(**) XKB: model: "pc104"
(**) Option "XkbLayout" "us"
(**) XKB: layout: "us"
(==) Keyboard: CustomKeycode disabled
(**) |-->Input Device "Configured Mouse"
(**) |-->Input Device "Generic Mouse"
(WW) The directory "/usr/lib/X11/fonts/cyrillic" does not exist.
	Entry deleted from font path.
(WW) The directory "/usr/lib/X11/fonts/CID" does not exist.
	Entry deleted from font path.
(**) FontPath set to "unix/:7100,/usr/lib/X11/fonts/misc,/usr/lib/X11/fonts/100dpi/:unscaled,/usr/lib/X11/fonts/75dpi/:unscaled,/usr/lib/X11/fonts/Type1,/usr/lib/X11/fonts/Speedo,/usr/lib/X11/fonts/100dpi,/usr/lib/X11/fonts/75dpi"
(==) RgbPath set to "/usr/X11R6/lib/X11/rgb"
(==) ModulePath set to "/usr/X11R6/lib/modules"
(++) using VT number 7

(II) Open APM successful
(II) Module ABI versions:
	XFree86 ANSI C Emulation: 0.2
	XFree86 Video Driver: 0.6
	XFree86 XInput driver : 0.4
	XFree86 Server Extension : 0.2
	XFree86 Font Renderer : 0.4
(II) Loader running on linux
(II) LoadModule: "bitmap"
(II) Loading /usr/X11R6/lib/modules/fonts/libbitmap.a
(II) Module bitmap: vendor="The XFree86 Project"
	compiled for 4.3.0.1, module version = 1.0.0
	Module class: XFree86 Font Renderer
	ABI class: XFree86 Font Renderer, version 0.4
(II) Loading font Bitmap
(II) LoadModule: "pcidata"
(II) Loading /usr/X11R6/lib/modules/libpcidata.a
(II) Module pcidata: vendor="The XFree86 Project"
	compiled for 4.3.0.1, module version = 1.0.0
	ABI class: XFree86 Video Driver, version 0.6
(II) PCI: Probing config type using method 1
(II) PCI: Config type is 1
(II) PCI: stages = 0x03, oldVal1 = 0x8000110c, mode1Res1 = 0x80000000
(II) PCI: PCI scan (all values are in hex)
(II) PCI: 00:00:0: chip 10de,01e0 card 0000,0000 rev c1 class 06,00,00 hdr 80
(II) PCI: 00:00:1: chip 10de,01eb card 1462,5700 rev c1 class 05,00,00 hdr 80
(II) PCI: 00:00:2: chip 10de,01ee card 1462,5700 rev c1 class 05,00,00 hdr 80
(II) PCI: 00:00:3: chip 10de,01ed card 1462,5700 rev c1 class 05,00,00 hdr 80
(II) PCI: 00:00:4: chip 10de,01ec card 1462,5700 rev c1 class 05,00,00 hdr 80
(II) PCI: 00:00:5: chip 10de,01ef card 1462,5700 rev c1 class 05,00,00 hdr 80
(II) PCI: 00:01:0: chip 10de,0060 card 1462,5700 rev a4 class 06,01,00 hdr 80
(II) PCI: 00:01:1: chip 10de,0064 card 1462,5700 rev a2 class 0c,05,00 hdr 80
(II) PCI: 00:02:0: chip 10de,0067 card 1462,5700 rev a4 class 0c,03,10 hdr 80
(II) PCI: 00:02:1: chip 10de,0067 card 1462,5700 rev a4 class 0c,03,10 hdr 80
(II) PCI: 00:02:2: chip 10de,0068 card 1462,5700 rev a4 class 0c,03,20 hdr 80
(II) PCI: 00:04:0: chip 10de,0066 card 1462,570c rev a1 class 02,00,00 hdr 00
(II) PCI: 00:06:0: chip 10de,006a card 1462,5700 rev a1 class 04,01,00 hdr 00
(II) PCI: 00:08:0: chip 10de,006c card 0000,0000 rev a3 class 06,04,00 hdr 01
(II) PCI: 00:09:0: chip 10de,0065 card 1462,5700 rev a2 class 01,01,8a hdr 00
(II) PCI: 00:1e:0: chip 10de,01e8 card 0000,0000 rev c1 class 06,04,00 hdr 01
(II) PCI: 01:06:0: chip 5333,8811 card 0000,0000 rev 43 class 03,00,00 hdr 00
(II) PCI: End of PCI scan
(II) Host-to-PCI bridge:
(II) Bus 0: bridge is at (0:0:0), (0,0,2), BCTRL: 0x0008 (VGA_EN is set)
(II) Bus 0 I/O range:
	[0] -1	0	0x00000000 - 0x0000ffff (0x10000) IX[B]
(II) Bus 0 non-prefetchable memory range:
	[0] -1	0	0x00000000 - 0xffffffff (0x0) MX[B]
(II) Bus 0 prefetchable memory range:
	[0] -1	0	0x00000000 - 0xffffffff (0x0) MX[B]
(II) PCI-to-ISA bridge:
(II) Bus -1: bridge is at (0:1:0), (0,-1,-1), BCTRL: 0x0008 (VGA_EN is set)
(II) PCI-to-PCI bridge:
(II) Bus 1: bridge is at (0:8:0), (0,1,1), BCTRL: 0x000a (VGA_EN is set)
(II) Bus 1 non-prefetchable memory range:
	[0] -1	0	0xe4000000 - 0xebffffff (0x8000000) MX[B]
(II) PCI-to-PCI bridge:
(II) Bus 2: bridge is at (0:30:0), (0,2,2), BCTRL: 0x0002 (VGA_EN is cleared)
(--) PCI:*(1:6:0) S3 Inc. 86c764/765 [Trio32/64/64V+] rev 67, Mem @ 0xe4000000/26
(II) Addressable bus resource ranges are
	[0] -1	0	0x00000000 - 0xffffffff (0x0) MX[B]
	[1] -1	0	0x00000000 - 0x0000ffff (0x10000) IX[B]
(II) OS-reported resource ranges:
	[0] -1	0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1	0	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[2] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1	0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[5] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[6] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
(II) PCI Memory resource overlap reduced 0xe0000000 from 0xe3ffffff to 0xdfffffff
(II) Active PCI resource ranges:
	[0] -1	0	0xec003000 - 0xec003fff (0x1000) MX[B]
	[1] -1	0	0xec002000 - 0xec002fff (0x1000) MX[B]
	[2] -1	0	0xec001000 - 0xec0010ff (0x100) MX[B]
	[3] -1	0	0xec000000 - 0xec000fff (0x1000) MX[B]
	[4] -1	0	0xec005000 - 0xec005fff (0x1000) MX[B]
	[5] -1	0	0xe0000000 - 0xdfffffff (0x0) MX[B]O
	[6] -1	0	0xe4000000 - 0xe7ffffff (0x4000000) MX[B](B)
	[7] -1	0	0x0000f000 - 0x0000f00f (0x10) IX[B]
	[8] -1	0	0x0000dc00 - 0x0000dc7f (0x80) IX[B]
	[9] -1	0	0x0000d800 - 0x0000d8ff (0x100) IX[B]
	[10] -1	0	0x0000d400 - 0x0000d407 (0x8) IX[B]
	[11] -1	0	0x0000d000 - 0x0000d01f (0x20) IX[B]
(II) Active PCI resource ranges after removing overlaps:
	[0] -1	0	0xec003000 - 0xec003fff (0x1000) MX[B]
	[1] -1	0	0xec002000 - 0xec002fff (0x1000) MX[B]
	[2] -1	0	0xec001000 - 0xec0010ff (0x100) MX[B]
	[3] -1	0	0xec000000 - 0xec000fff (0x1000) MX[B]
	[4] -1	0	0xec005000 - 0xec005fff (0x1000) MX[B]
	[5] -1	0	0xe0000000 - 0xdfffffff (0x0) MX[B]O
	[6] -1	0	0xe4000000 - 0xe7ffffff (0x4000000) MX[B](B)
	[7] -1	0	0x0000f000 - 0x0000f00f (0x10) IX[B]
	[8] -1	0	0x0000dc00 - 0x0000dc7f (0x80) IX[B]
	[9] -1	0	0x0000d800 - 0x0000d8ff (0x100) IX[B]
	[10] -1	0	0x0000d400 - 0x0000d407 (0x8) IX[B]
	[11] -1	0	0x0000d000 - 0x0000d01f (0x20) IX[B]
(II) OS-reported resource ranges after removing overlaps with PCI:
	[0] -1	0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1	0	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[2] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1	0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[5] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[6] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
(II) All system resource ranges:
	[0] -1	0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1	0	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[2] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1	0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[5] -1	0	0xec003000 - 0xec003fff (0x1000) MX[B]
	[6] -1	0	0xec002000 - 0xec002fff (0x1000) MX[B]
	[7] -1	0	0xec001000 - 0xec0010ff (0x100) MX[B]
	[8] -1	0	0xec000000 - 0xec000fff (0x1000) MX[B]
	[9] -1	0	0xec005000 - 0xec005fff (0x1000) MX[B]
	[10] -1	0	0xe0000000 - 0xdfffffff (0x0) MX[B]O
	[11] -1	0	0xe4000000 - 0xe7ffffff (0x4000000) MX[B](B)
	[12] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[13] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
	[14] -1	0	0x0000f000 - 0x0000f00f (0x10) IX[B]
	[15] -1	0	0x0000dc00 - 0x0000dc7f (0x80) IX[B]
	[16] -1	0	0x0000d800 - 0x0000d8ff (0x100) IX[B]
	[17] -1	0	0x0000d400 - 0x0000d407 (0x8) IX[B]
	[18] -1	0	0x0000d000 - 0x0000d01f (0x20) IX[B]
(II) LoadModule: "GLcore"
(II) Loading /usr/X11R6/lib/modules/extensions/libGLcore.a
Skipping "/usr/X11R6/lib/modules/extensions/libGLcore.a:m_debug_clip.o":  No symbols found
Skipping "/usr/X11R6/lib/modules/extensions/libGLcore.a:m_debug_norm.o":  No symbols found
Skipping "/usr/X11R6/lib/modules/extensions/libGLcore.a:m_debug_xform.o":  No symbols found
Skipping "/usr/X11R6/lib/modules/extensions/libGLcore.a:m_debug_vertex.o":  No symbols found
(II) Module GLcore: vendor="The XFree86 Project"
	compiled for 4.3.0.1, module version = 1.0.0
	ABI class: XFree86 Server Extension, version 0.2
(II) LoadModule: "bitmap"
(II) Reloading /usr/X11R6/lib/modules/fonts/libbitmap.a
(II) Loading font Bitmap
(II) LoadModule: "dbe"
(II) Loading /usr/X11R6/lib/modules/extensions/libdbe.a
(II) Module dbe: vendor="The XFree86 Project"
	compiled for 4.3.0.1, module version = 1.0.0
	Module class: XFree86 Server Extension
	ABI class: XFree86 Server Extension, version 0.2
(II) Loading extension DOUBLE-BUFFER
(II) LoadModule: "ddc"
(II) Loading /usr/X11R6/lib/modules/libddc.a
(II) Module ddc: vendor="The XFree86 Project"
	compiled for 4.3.0.1, module version = 1.0.0
	ABI class: XFree86 Video Driver, version 0.6
(II) LoadModule: "dri"
(II) Loading /usr/X11R6/lib/modules/extensions/libdri.a
(II) Module dri: vendor="The XFree86 Project"
	compiled for 4.3.0.1, module version = 1.0.0
	ABI class: XFree86 Server Extension, version 0.2
(II) Loading sub module "drm"
(II) LoadModule: "drm"
(II) Loading /usr/X11R6/lib/modules/linux/libdrm.a
(II) Module drm: vendor="The XFree86 Project"
	compiled for 4.3.0.1, module version = 1.0.0
	ABI class: XFree86 Server Extension, version 0.2
(II) Loading extension XFree86-DRI
(II) LoadModule: "extmod"
(II) Loading /usr/X11R6/lib/modules/extensions/libextmod.a
(II) Module extmod: vendor="The XFree86 Project"
	compiled for 4.3.0.1, module version = 1.0.0
	Module class: XFree86 Server Extension
	ABI class: XFree86 Server Extension, version 0.2
(II) Loading extension SHAPE
(II) Loading extension MIT-SUNDRY-NONSTANDARD
(II) Loading extension BIG-REQUESTS
(II) Loading extension SYNC
(II) Loading extension MIT-SCREEN-SAVER
(II) Loading extension XC-MISC
(II) Loading extension XFree86-VidModeExtension
(II) Loading extension XFree86-Misc
(II) Loading extension XFree86-DGA
(II) Loading extension DPMS
(II) Loading extension FontCache
(II) Loading extension TOG-CUP
(II) Loading extension Extended-Visual-Information
(II) Loading extension XVideo
(II) Loading extension XVideo-MotionCompensation
(II) Loading extension X-Resource
(II) LoadModule: "freetype"
(II) Loading /usr/X11R6/lib/modules/fonts/libfreetype.a
(II) Module freetype: vendor="The XFree86 Project"
	compiled for 4.3.0.1, module version = 2.0.2
	Module class: XFree86 Font Renderer
	ABI class: XFree86 Font Renderer, version 0.4
(II) Loading font FreeType
(II) LoadModule: "glx"
(II) Loading /usr/X11R6/lib/modules/extensions/libglx.a
(II) Module glx: vendor="The XFree86 Project"
	compiled for 4.3.0.1, module version = 1.0.0
	ABI class: XFree86 Server Extension, version 0.2
(II) Loading sub module "GLcore"
(II) LoadModule: "GLcore"
(II) Reloading /usr/X11R6/lib/modules/extensions/libGLcore.a
(II) Loading extension GLX
(II) LoadModule: "int10"
(II) Loading /usr/X11R6/lib/modules/linux/libint10.a
(II) Module int10: vendor="The XFree86 Project"
	compiled for 4.3.0.1, module version = 1.0.0
	ABI class: XFree86 Video Driver, version 0.6
(II) LoadModule: "record"
(II) Loading /usr/X11R6/lib/modules/extensions/librecord.a
(II) Module record: vendor="The XFree86 Project"
	compiled for 4.3.0.1, module version = 1.13.0
	Module class: XFree86 Server Extension
	ABI class: XFree86 Server Extension, version 0.2
(II) Loading extension RECORD
(II) LoadModule: "speedo"
(II) Loading /usr/X11R6/lib/modules/fonts/libspeedo.a
Skipping "/usr/X11R6/lib/modules/fonts/libspeedo.a:spencode.o":  No symbols found
(II) Module speedo: vendor="The XFree86 Project"
	compiled for 4.3.0.1, module version = 1.0.1
	Module class: XFree86 Font Renderer
	ABI class: XFree86 Font Renderer, version 0.4
(II) Loading font Speedo
(II) LoadModule: "type1"
(II) Loading /usr/X11R6/lib/modules/fonts/libtype1.a
(II) Module type1: vendor="The XFree86 Project"
	compiled for 4.3.0.1, module version = 1.0.2
	Module class: XFree86 Font Renderer
	ABI class: XFree86 Font Renderer, version 0.4
(II) Loading font Type1
(II) Loading font CID
(II) LoadModule: "vbe"
(II) Loading /usr/X11R6/lib/modules/libvbe.a
(II) Module vbe: vendor="The XFree86 Project"
	compiled for 4.3.0.1, module version = 1.1.0
	ABI class: XFree86 Video Driver, version 0.6
(II) LoadModule: "vesa"
(II) Loading /usr/X11R6/lib/modules/drivers/vesa_drv.o
(II) Module vesa: vendor="The XFree86 Project"
	compiled for 4.3.0.1, module version = 1.0.0
	Module class: XFree86 Video Driver
	ABI class: XFree86 Video Driver, version 0.6
(II) LoadModule: "mouse"
(II) Loading /usr/X11R6/lib/modules/input/mouse_drv.o
(II) Module mouse: vendor="The XFree86 Project"
	compiled for 4.3.0.1, module version = 1.0.0
	Module class: XFree86 XInput Driver
	ABI class: XFree86 XInput driver, version 0.4
(II) VESA: driver for VESA chipsets: vesa
(II) Primary Device is: PCI 01:06:0
(--) Assigning device section with no busID to primary device
(--) Chipset vesa found
(II) resource ranges after xf86ClaimFixedResources() call:
	[0] -1	0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1	0	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[2] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1	0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[5] -1	0	0xec003000 - 0xec003fff (0x1000) MX[B]
	[6] -1	0	0xec002000 - 0xec002fff (0x1000) MX[B]
	[7] -1	0	0xec001000 - 0xec0010ff (0x100) MX[B]
	[8] -1	0	0xec000000 - 0xec000fff (0x1000) MX[B]
	[9] -1	0	0xec005000 - 0xec005fff (0x1000) MX[B]
	[10] -1	0	0xe0000000 - 0xdfffffff (0x0) MX[B]O
	[11] -1	0	0xe4000000 - 0xe7ffffff (0x4000000) MX[B](B)
	[12] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[13] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
	[14] -1	0	0x0000f000 - 0x0000f00f (0x10) IX[B]
	[15] -1	0	0x0000dc00 - 0x0000dc7f (0x80) IX[B]
	[16] -1	0	0x0000d800 - 0x0000d8ff (0x100) IX[B]
	[17] -1	0	0x0000d400 - 0x0000d407 (0x8) IX[B]
	[18] -1	0	0x0000d000 - 0x0000d01f (0x20) IX[B]
(II) resource ranges after probing:
	[0] -1	0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1	0	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[2] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1	0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[5] -1	0	0xec003000 - 0xec003fff (0x1000) MX[B]
	[6] -1	0	0xec002000 - 0xec002fff (0x1000) MX[B]
	[7] -1	0	0xec001000 - 0xec0010ff (0x100) MX[B]
	[8] -1	0	0xec000000 - 0xec000fff (0x1000) MX[B]
	[9] -1	0	0xec005000 - 0xec005fff (0x1000) MX[B]
	[10] -1	0	0xe0000000 - 0xdfffffff (0x0) MX[B]O
	[11] -1	0	0xe4000000 - 0xe7ffffff (0x4000000) MX[B](B)
	[12] 0	0	0x000a0000 - 0x000affff (0x10000) MS[B]
	[13] 0	0	0x000b0000 - 0x000b7fff (0x8000) MS[B]
	[14] 0	0	0x000b8000 - 0x000bffff (0x8000) MS[B]
	[15] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[16] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
	[17] -1	0	0x0000f000 - 0x0000f00f (0x10) IX[B]
	[18] -1	0	0x0000dc00 - 0x0000dc7f (0x80) IX[B]
	[19] -1	0	0x0000d800 - 0x0000d8ff (0x100) IX[B]
	[20] -1	0	0x0000d400 - 0x0000d407 (0x8) IX[B]
	[21] -1	0	0x0000d000 - 0x0000d01f (0x20) IX[B]
	[22] 0	0	0x000003b0 - 0x000003bb (0xc) IS[B]
	[23] 0	0	0x000003c0 - 0x000003df (0x20) IS[B]
(II) Setting vga for screen 0.
(II) Loading sub module "vbe"
(II) LoadModule: "vbe"
(II) Reloading /usr/X11R6/lib/modules/libvbe.a
(II) Loading sub module "int10"
(II) LoadModule: "int10"
(II) Reloading /usr/X11R6/lib/modules/linux/libint10.a
(II) VESA(0): initializing int10
(II) VESA(0): Primary V_BIOS segment is: 0xc000
(WW) System lacks support for changing MTRRs
(II) VESA(0): VESA BIOS detected
(II) VESA(0): VESA VBE Version 1.2
(II) VESA(0): VESA VBE Total Mem: 2048 kB
(II) VESA(0): VESA VBE OEM: STB PowerGraph 64 Video (Trio64V+)
(**) VESA(0): Depth 24, (--) framebuffer bpp 32
(==) VESA(0): RGB weight 888
(==) VESA(0): Default visual is TrueColor
(==) VESA(0): Using gamma correction (1.0, 1.0, 1.0)
(II) VESA(0): Searching for matching VESA mode(s):
Mode: 100 (640x400)
	ModeAttributes: 0x1b
	WinAAttributes: 0x7
	WinBAttributes: 0x0
	WinGranularity: 64
	WinSize: 64
	WinASegment: 0xa000
	WinBSegment: 0xa000
	WinFuncPtr: 0xc0005258
	BytesPerScanline: 640
	XResolution: 640
	YResolution: 400
	XCharSize: 8
	YCharSize: 16
	NumberOfPlanes: 1
	BitsPerPixel: 8
	NumberOfBanks: 1
	MemoryModel: 4
	BankSize: 0
	NumberOfImages: 7
	RedMaskSize: 0
	RedFieldPosition: 0
	GreenMaskSize: 0
	GreenFieldPosition: 0
	BlueMaskSize: 0
	BlueFieldPosition: 0
	RsvdMaskSize: 0
	RsvdFieldPosition: 0
	DirectColorModeInfo: 0
Mode: 101 (640x480)
	ModeAttributes: 0x1b
	WinAAttributes: 0x7
	WinBAttributes: 0x0
	WinGranularity: 64
	WinSize: 64
	WinASegment: 0xa000
	WinBSegment: 0xa000
	WinFuncPtr: 0xc0005258
	BytesPerScanline: 640
	XResolution: 640
	YResolution: 480
	XCharSize: 8
	YCharSize: 16
	NumberOfPlanes: 1
	BitsPerPixel: 8
	NumberOfBanks: 1
	MemoryModel: 4
	BankSize: 0
	NumberOfImages: 5
	RedMaskSize: 0
	RedFieldPosition: 0
	GreenMaskSize: 0
	GreenFieldPosition: 0
	BlueMaskSize: 0
	BlueFieldPosition: 0
	RsvdMaskSize: 0
	RsvdFieldPosition: 0
	DirectColorModeInfo: 0
Mode: 102 (800x600)
	ModeAttributes: 0x1f
	WinAAttributes: 0x7
	WinBAttributes: 0x0
	WinGranularity: 64
	WinSize: 64
	WinASegment: 0xa000
	WinBSegment: 0xa000
	WinFuncPtr: 0xc0005258
	BytesPerScanline: 100
	XResolution: 800
	YResolution: 600
	XCharSize: 8
	YCharSize: 8
	NumberOfPlanes: 4
	BitsPerPixel: 4
	NumberOfBanks: 1
	MemoryModel: 3
	BankSize: 0
	NumberOfImages: 3
	RedMaskSize: 0
	RedFieldPosition: 0
	GreenMaskSize: 0
	GreenFieldPosition: 0
	BlueMaskSize: 0
	BlueFieldPosition: 0
	RsvdMaskSize: 0
	RsvdFieldPosition: 0
	DirectColorModeInfo: 0
Mode: 103 (800x600)
	ModeAttributes: 0x1b
	WinAAttributes: 0x7
	WinBAttributes: 0x0
	WinGranularity: 64
	WinSize: 64
	WinASegment: 0xa000
	WinBSegment: 0xa000
	WinFuncPtr: 0xc0005258
	BytesPerScanline: 800
	XResolution: 800
	YResolution: 600
	XCharSize: 8
	YCharSize: 8
	NumberOfPlanes: 1
	BitsPerPixel: 8
	NumberOfBanks: 1
	MemoryModel: 4
	BankSize: 0
	NumberOfImages: 3
	RedMaskSize: 0
	RedFieldPosition: 0
	GreenMaskSize: 0
	GreenFieldPosition: 0
	BlueMaskSize: 0
	BlueFieldPosition: 0
	RsvdMaskSize: 0
	RsvdFieldPosition: 0
	DirectColorModeInfo: 0
Mode: 104 (1024x768)
	ModeAttributes: 0x1b
	WinAAttributes: 0x7
	WinBAttributes: 0x0
	WinGranularity: 64
	WinSize: 64
	WinASegment: 0xa000
	WinBSegment: 0xa000
	WinFuncPtr: 0xc0005258
	BytesPerScanline: 128
	XResolution: 1024
	YResolution: 768
	XCharSize: 8
	YCharSize: 16
	NumberOfPlanes: 4
	BitsPerPixel: 4
	NumberOfBanks: 1
	MemoryModel: 3
	BankSize: 0
	NumberOfImages: 1
	RedMaskSize: 0
	RedFieldPosition: 0
	GreenMaskSize: 0
	GreenFieldPosition: 0
	BlueMaskSize: 0
	BlueFieldPosition: 0
	RsvdMaskSize: 0
	RsvdFieldPosition: 0
	DirectColorModeInfo: 0
Mode: 105 (1024x768)
	ModeAttributes: 0x1b
	WinAAttributes: 0x7
	WinBAttributes: 0x0
	WinGranularity: 64
	WinSize: 64
	WinASegment: 0xa000
	WinBSegment: 0xa000
	WinFuncPtr: 0xc0005258
	BytesPerScanline: 1024
	XResolution: 1024
	YResolution: 768
	XCharSize: 8
	YCharSize: 16
	NumberOfPlanes: 1
	BitsPerPixel: 8
	NumberOfBanks: 1
	MemoryModel: 4
	BankSize: 0
	NumberOfImages: 1
	RedMaskSize: 0
	RedFieldPosition: 0
	GreenMaskSize: 0
	GreenFieldPosition: 0
	BlueMaskSize: 0
	BlueFieldPosition: 0
	RsvdMaskSize: 0
	RsvdFieldPosition: 0
	DirectColorModeInfo: 0
Mode: 106 (1280x1024)
	ModeAttributes: 0x1b
	WinAAttributes: 0x7
	WinBAttributes: 0x0
	WinGranularity: 64
	WinSize: 64
	WinASegment: 0xa000
	WinBSegment: 0xa000
	WinFuncPtr: 0xc0005258
	BytesPerScanline: 160
	XResolution: 1280
	YResolution: 1024
	XCharSize: 8
	YCharSize: 16
	NumberOfPlanes: 4
	BitsPerPixel: 4
	NumberOfBanks: 1
	MemoryModel: 3
	BankSize: 0
	NumberOfImages: 0
	RedMaskSize: 0
	RedFieldPosition: 0
	GreenMaskSize: 0
	GreenFieldPosition: 0
	BlueMaskSize: 0
	BlueFieldPosition: 0
	RsvdMaskSize: 0
	RsvdFieldPosition: 0
	DirectColorModeInfo: 0
Mode: 107 (1280x1024)
	ModeAttributes: 0x1b
	WinAAttributes: 0x7
	WinBAttributes: 0x0
	WinGranularity: 64
	WinSize: 64
	WinASegment: 0xa000
	WinBSegment: 0xa000
	WinFuncPtr: 0xc0005258
	BytesPerScanline: 1280
	XResolution: 1280
	YResolution: 1024
	XCharSize: 8
	YCharSize: 16
	NumberOfPlanes: 1
	BitsPerPixel: 8
	NumberOfBanks: 1
	MemoryModel: 4
	BankSize: 0
	NumberOfImages: 0
	RedMaskSize: 0
	RedFieldPosition: 0
	GreenMaskSize: 0
	GreenFieldPosition: 0
	BlueMaskSize: 0
	BlueFieldPosition: 0
	RsvdMaskSize: 0
	RsvdFieldPosition: 0
	DirectColorModeInfo: 0
Mode: 109 (132x25)
	ModeAttributes: 0xf
	WinAAttributes: 0x7
	WinBAttributes: 0x0
	WinGranularity: 32
	WinSize: 32
	WinASegment: 0xb800
	WinBSegment: 0xb800
	WinFuncPtr: 0xc0005258
	BytesPerScanline: 528
	XResolution: 132
	YResolution: 25
	XCharSize: 8
	YCharSize: 16
	NumberOfPlanes: 4
	BitsPerPixel: 4
	NumberOfBanks: 1
	MemoryModel: 0
	BankSize: 0
	NumberOfImages: 157
	RedMaskSize: 0
	RedFieldPosition: 0
	GreenMaskSize: 0
	GreenFieldPosition: 0
	BlueMaskSize: 0
	BlueFieldPosition: 0
	RsvdMaskSize: 0
	RsvdFieldPosition: 0
	DirectColorModeInfo: 0
Mode: 10a (132x43)
	ModeAttributes: 0xf
	WinAAttributes: 0x7
	WinBAttributes: 0x0
	WinGranularity: 32
	WinSize: 32
	WinASegment: 0xb800
	WinBSegment: 0xb800
	WinFuncPtr: 0xc0005258
	BytesPerScanline: 528
	XResolution: 132
	YResolution: 43
	XCharSize: 8
	YCharSize: 8
	NumberOfPlanes: 4
	BitsPerPixel: 4
	NumberOfBanks: 1
	MemoryModel: 0
	BankSize: 0
	NumberOfImages: 91
	RedMaskSize: 0
	RedFieldPosition: 0
	GreenMaskSize: 0
	GreenFieldPosition: 0
	BlueMaskSize: 0
	BlueFieldPosition: 0
	RsvdMaskSize: 0
	RsvdFieldPosition: 0
	DirectColorModeInfo: 0
Mode: 10d (320x200)
	ModeAttributes: 0x1b
	WinAAttributes: 0x7
	WinBAttributes: 0x0
	WinGranularity: 64
	WinSize: 64
	WinASegment: 0xa000
	WinBSegment: 0xa000
	WinFuncPtr: 0xc0005258
	BytesPerScanline: 640
	XResolution: 320
	YResolution: 200
	XCharSize: 8
	YCharSize: 8
	NumberOfPlanes: 1
	BitsPerPixel: 15
	NumberOfBanks: 1
	MemoryModel: 6
	BankSize: 0
	NumberOfImages: 15
	RedMaskSize: 5
	RedFieldPosition: 10
	GreenMaskSize: 5
	GreenFieldPosition: 5
	BlueMaskSize: 5
	BlueFieldPosition: 0
	RsvdMaskSize: 1
	RsvdFieldPosition: 15
	DirectColorModeInfo: 0
Mode: 10e (320x200)
	ModeAttributes: 0x1b
	WinAAttributes: 0x7
	WinBAttributes: 0x0
	WinGranularity: 64
	WinSize: 64
	WinASegment: 0xa000
	WinBSegment: 0xa000
	WinFuncPtr: 0xc0005258
	BytesPerScanline: 640
	XResolution: 320
	YResolution: 200
	XCharSize: 8
	YCharSize: 8
	NumberOfPlanes: 1
	BitsPerPixel: 16
	NumberOfBanks: 1
	MemoryModel: 6
	BankSize: 0
	NumberOfImages: 15
	RedMaskSize: 5
	RedFieldPosition: 11
	GreenMaskSize: 6
	GreenFieldPosition: 5
	BlueMaskSize: 5
	BlueFieldPosition: 0
	RsvdMaskSize: 0
	RsvdFieldPosition: 0
	DirectColorModeInfo: 0
*Mode: 10f (320x200)
	ModeAttributes: 0x1b
	WinAAttributes: 0x7
	WinBAttributes: 0x0
	WinGranularity: 64
	WinSize: 64
	WinASegment: 0xa000
	WinBSegment: 0xa000
	WinFuncPtr: 0xc0005258
	BytesPerScanline: 1280
	XResolution: 320
	YResolution: 200
	XCharSize: 8
	YCharSize: 8
	NumberOfPlanes: 1
	BitsPerPixel: 32
	NumberOfBanks: 1
	MemoryModel: 6
	BankSize: 0
	NumberOfImages: 7
	RedMaskSize: 8
	RedFieldPosition: 16
	GreenMaskSize: 8
	GreenFieldPosition: 8
	BlueMaskSize: 8
	BlueFieldPosition: 0
	RsvdMaskSize: 8
	RsvdFieldPosition: 24
	DirectColorModeInfo: 0
Mode: 110 (640x480)
	ModeAttributes: 0x1b
	WinAAttributes: 0x7
	WinBAttributes: 0x0
	WinGranularity: 64
	WinSize: 64
	WinASegment: 0xa000
	WinBSegment: 0xa000
	WinFuncPtr: 0xc0005258
	BytesPerScanline: 1280
	XResolution: 640
	YResolution: 480
	XCharSize: 8
	YCharSize: 16
	NumberOfPlanes: 1
	BitsPerPixel: 15
	NumberOfBanks: 1
	MemoryModel: 6
	BankSize: 0
	NumberOfImages: 2
	RedMaskSize: 5
	RedFieldPosition: 10
	GreenMaskSize: 5
	GreenFieldPosition: 5
	BlueMaskSize: 5
	BlueFieldPosition: 0
	RsvdMaskSize: 1
	RsvdFieldPosition: 15
	DirectColorModeInfo: 0
Mode: 111 (640x480)
	ModeAttributes: 0x1b
	WinAAttributes: 0x7
	WinBAttributes: 0x0
	WinGranularity: 64
	WinSize: 64
	WinASegment: 0xa000
	WinBSegment: 0xa000
	WinFuncPtr: 0xc0005258
	BytesPerScanline: 1280
	XResolution: 640
	YResolution: 480
	XCharSize: 8
	YCharSize: 16
	NumberOfPlanes: 1
	BitsPerPixel: 16
	NumberOfBanks: 1
	MemoryModel: 6
	BankSize: 0
	NumberOfImages: 2
	RedMaskSize: 5
	RedFieldPosition: 11
	GreenMaskSize: 6
	GreenFieldPosition: 5
	BlueMaskSize: 5
	BlueFieldPosition: 0
	RsvdMaskSize: 0
	RsvdFieldPosition: 0
	DirectColorModeInfo: 0
*Mode: 112 (640x480)
	ModeAttributes: 0x1b
	WinAAttributes: 0x7
	WinBAttributes: 0x0
	WinGranularity: 64
	WinSize: 64
	WinASegment: 0xa000
	WinBSegment: 0xa000
	WinFuncPtr: 0xc0005258
	BytesPerScanline: 2560
	XResolution: 640
	YResolution: 480
	XCharSize: 8
	YCharSize: 16
	NumberOfPlanes: 1
	BitsPerPixel: 32
	NumberOfBanks: 1
	MemoryModel: 6
	BankSize: 0
	NumberOfImages: 0
	RedMaskSize: 8
	RedFieldPosition: 16
	GreenMaskSize: 8
	GreenFieldPosition: 8
	BlueMaskSize: 8
	BlueFieldPosition: 0
	RsvdMaskSize: 8
	RsvdFieldPosition: 24
	DirectColorModeInfo: 0
Mode: 113 (800x600)
	ModeAttributes: 0x1b
	WinAAttributes: 0x7
	WinBAttributes: 0x0
	WinGranularity: 64
	WinSize: 64
	WinASegment: 0xa000
	WinBSegment: 0xa000
	WinFuncPtr: 0xc0005258
	BytesPerScanline: 1600
	XResolution: 800
	YResolution: 600
	XCharSize: 8
	YCharSize: 8
	NumberOfPlanes: 1
	BitsPerPixel: 15
	NumberOfBanks: 1
	MemoryModel: 6
	BankSize: 0
	NumberOfImages: 1
	RedMaskSize: 5
	RedFieldPosition: 10
	GreenMaskSize: 5
	GreenFieldPosition: 5
	BlueMaskSize: 5
	BlueFieldPosition: 0
	RsvdMaskSize: 1
	RsvdFieldPosition: 15
	DirectColorModeInfo: 0
Mode: 114 (800x600)
	ModeAttributes: 0x1b
	WinAAttributes: 0x7
	WinBAttributes: 0x0
	WinGranularity: 64
	WinSize: 64
	WinASegment: 0xa000
	WinBSegment: 0xa000
	WinFuncPtr: 0xc0005258
	BytesPerScanline: 1600
	XResolution: 800
	YResolution: 600
	XCharSize: 8
	YCharSize: 8
	NumberOfPlanes: 1
	BitsPerPixel: 16
	NumberOfBanks: 1
	MemoryModel: 6
	BankSize: 0
	NumberOfImages: 1
	RedMaskSize: 5
	RedFieldPosition: 11
	GreenMaskSize: 6
	GreenFieldPosition: 5
	BlueMaskSize: 5
	BlueFieldPosition: 0
	RsvdMaskSize: 0
	RsvdFieldPosition: 0
	DirectColorModeInfo: 0
*Mode: 115 (800x600)
	ModeAttributes: 0x1b
	WinAAttributes: 0x7
	WinBAttributes: 0x0
	WinGranularity: 64
	WinSize: 64
	WinASegment: 0xa000
	WinBSegment: 0xa000
	WinFuncPtr: 0xc0005258
	BytesPerScanline: 3200
	XResolution: 800
	YResolution: 600
	XCharSize: 8
	YCharSize: 8
	NumberOfPlanes: 1
	BitsPerPixel: 32
	NumberOfBanks: 1
	MemoryModel: 6
	BankSize: 0
	NumberOfImages: 0
	RedMaskSize: 8
	RedFieldPosition: 16
	GreenMaskSize: 8
	GreenFieldPosition: 8
	BlueMaskSize: 8
	BlueFieldPosition: 0
	RsvdMaskSize: 8
	RsvdFieldPosition: 24
	DirectColorModeInfo: 0
Mode: 116 (1024x768)
	ModeAttributes: 0x1b
	WinAAttributes: 0x7
	WinBAttributes: 0x0
	WinGranularity: 64
	WinSize: 64
	WinASegment: 0xa000
	WinBSegment: 0xa000
	WinFuncPtr: 0xc0005258
	BytesPerScanline: 2048
	XResolution: 1024
	YResolution: 768
	XCharSize: 8
	YCharSize: 16
	NumberOfPlanes: 1
	BitsPerPixel: 15
	NumberOfBanks: 1
	MemoryModel: 6
	BankSize: 0
	NumberOfImages: 0
	RedMaskSize: 5
	RedFieldPosition: 10
	GreenMaskSize: 5
	GreenFieldPosition: 5
	BlueMaskSize: 5
	BlueFieldPosition: 0
	RsvdMaskSize: 1
	RsvdFieldPosition: 15
	DirectColorModeInfo: 0
Mode: 117 (1024x768)
	ModeAttributes: 0x1b
	WinAAttributes: 0x7
	WinBAttributes: 0x0
	WinGranularity: 64
	WinSize: 64
	WinASegment: 0xa000
	WinBSegment: 0xa000
	WinFuncPtr: 0xc0005258
	BytesPerScanline: 2048
	XResolution: 1024
	YResolution: 768
	XCharSize: 8
	YCharSize: 16
	NumberOfPlanes: 1
	BitsPerPixel: 16
	NumberOfBanks: 1
	MemoryModel: 6
	BankSize: 0
	NumberOfImages: 0
	RedMaskSize: 5
	RedFieldPosition: 11
	GreenMaskSize: 6
	GreenFieldPosition: 5
	BlueMaskSize: 5
	BlueFieldPosition: 0
	RsvdMaskSize: 0
	RsvdFieldPosition: 0
	DirectColorModeInfo: 0
Mode: 120 (1600x1200)
	ModeAttributes: 0x1b
	WinAAttributes: 0x7
	WinBAttributes: 0x0
	WinGranularity: 64
	WinSize: 64
	WinASegment: 0xa000
	WinBSegment: 0xa000
	WinFuncPtr: 0xc0005258
	BytesPerScanline: 1600
	XResolution: 1600
	YResolution: 1200
	XCharSize: 8
	YCharSize: 16
	NumberOfPlanes: 1
	BitsPerPixel: 8
	NumberOfBanks: 1
	MemoryModel: 4
	BankSize: 0
	NumberOfImages: 0
	RedMaskSize: 0
	RedFieldPosition: 0
	GreenMaskSize: 0
	GreenFieldPosition: 0
	BlueMaskSize: 0
	BlueFieldPosition: 0
	RsvdMaskSize: 0
	RsvdFieldPosition: 0
	DirectColorModeInfo: 0
*(II) VESA(0): Not using built-in mode "640x400" (vrefresh out of range)
Mode: 12c (640x400)
	ModeAttributes: 0x1b
	WinAAttributes: 0x7
	WinBAttributes: 0x0
	WinGranularity: 64
	WinSize: 64
	WinASegment: 0xa000
	WinBSegment: 0xa000
	WinFuncPtr: 0xc0005258
	BytesPerScanline: 2560
	XResolution: 640
	YResolution: 400
	XCharSize: 8
	YCharSize: 16
	NumberOfPlanes: 1
	BitsPerPixel: 32
	NumberOfBanks: 1
	MemoryModel: 6
	BankSize: 0
	NumberOfImages: 1
	RedMaskSize: 8
	RedFieldPosition: 16
	GreenMaskSize: 8
	GreenFieldPosition: 8
	BlueMaskSize: 8
	BlueFieldPosition: 0
	RsvdMaskSize: 8
	RsvdFieldPosition: 24
	DirectColorModeInfo: 0
Mode: 12d (1152x864)
	ModeAttributes: 0x1b
	WinAAttributes: 0x7
	WinBAttributes: 0x0
	WinGranularity: 64
	WinSize: 64
	WinASegment: 0xa000
	WinBSegment: 0xa000
	WinFuncPtr: 0xc0005258
	BytesPerScanline: 1152
	XResolution: 1152
	YResolution: 864
	XCharSize: 8
	YCharSize: 16
	NumberOfPlanes: 1
	BitsPerPixel: 8
	NumberOfBanks: 1
	MemoryModel: 4
	BankSize: 0
	NumberOfImages: 1
	RedMaskSize: 0
	RedFieldPosition: 0
	GreenMaskSize: 0
	GreenFieldPosition: 0
	BlueMaskSize: 0
	BlueFieldPosition: 0
	RsvdMaskSize: 0
	RsvdFieldPosition: 0
	DirectColorModeInfo: 0
Mode: 12e (1152x864)
	ModeAttributes: 0x9b
	WinAAttributes: 0x7
	WinBAttributes: 0x0
	WinGranularity: 64
	WinSize: 64
	WinASegment: 0xa000
	WinBSegment: 0xa000
	WinFuncPtr: 0xc0005258
	BytesPerScanline: 2304
	XResolution: 1152
	YResolution: 864
	XCharSize: 8
	YCharSize: 16
	NumberOfPlanes: 1
	BitsPerPixel: 15
	NumberOfBanks: 1
	MemoryModel: 6
	BankSize: 0
	NumberOfImages: 0
	RedMaskSize: 5
	RedFieldPosition: 10
	GreenMaskSize: 5
	GreenFieldPosition: 5
	BlueMaskSize: 5
	BlueFieldPosition: 0
	RsvdMaskSize: 1
	RsvdFieldPosition: 15
	DirectColorModeInfo: 0
Mode: 12f (1152x864)
	ModeAttributes: 0x9b
	WinAAttributes: 0x7
	WinBAttributes: 0x0
	WinGranularity: 64
	WinSize: 64
	WinASegment: 0xa000
	WinBSegment: 0xa000
	WinFuncPtr: 0xc0005258
	BytesPerScanline: 2304
	XResolution: 1152
	YResolution: 864
	XCharSize: 8
	YCharSize: 16
	NumberOfPlanes: 1
	BitsPerPixel: 16
	NumberOfBanks: 1
	MemoryModel: 6
	BankSize: 0
	NumberOfImages: 0
	RedMaskSize: 5
	RedFieldPosition: 11
	GreenMaskSize: 6
	GreenFieldPosition: 5
	BlueMaskSize: 5
	BlueFieldPosition: 0
	RsvdMaskSize: 0
	RsvdFieldPosition: 0
	DirectColorModeInfo: 0

(II) VESA(0): Total Memory: 32 64KB banks (2048kB)
(II) VESA(0): Generic Monitor: Using hsync range of 28.00-50.00 kHz
(II) VESA(0): Generic Monitor: Using vrefresh range of 43.00-75.00 Hz
(--) VESA(0): Virtual size is 800x600 (pitch 800)
(**) VESA(0): *Built-in mode "800x600"
(**) VESA(0): *Built-in mode "640x480"
(==) VESA(0): DPI set to (75, 75)
(II) VESA(0): Attempting to use 72Hz refresh for mode "800x600" (115)
(II) VESA(0): Attempting to use 73Hz refresh for mode "640x480" (112)
(**) VESA(0): Using "Shadow Framebuffer"
(II) Loading sub module "shadow"
(II) LoadModule: "shadow"
(II) Loading /usr/X11R6/lib/modules/libshadow.a
(II) Module shadow: vendor="The XFree86 Project"
	compiled for 4.3.0.1, module version = 1.0.0
	ABI class: XFree86 ANSI C Emulation, version 0.2
(II) Loading sub module "fb"
(II) LoadModule: "fb"
(II) Loading /usr/X11R6/lib/modules/libfb.a
(II) Module fb: vendor="The XFree86 Project"
	compiled for 4.3.0.1, module version = 1.0.0
	ABI class: XFree86 ANSI C Emulation, version 0.2
(--) Depth 24 pixmap format is 32 bpp
(II) do I need RAC?  No, I don't.
(II) resource ranges after preInit:
	[0] -1	0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1	0	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[2] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1	0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[5] -1	0	0xec003000 - 0xec003fff (0x1000) MX[B]
	[6] -1	0	0xec002000 - 0xec002fff (0x1000) MX[B]
	[7] -1	0	0xec001000 - 0xec0010ff (0x100) MX[B]
	[8] -1	0	0xec000000 - 0xec000fff (0x1000) MX[B]
	[9] -1	0	0xec005000 - 0xec005fff (0x1000) MX[B]
	[10] -1	0	0xe0000000 - 0xdfffffff (0x0) MX[B]O
	[11] -1	0	0xe4000000 - 0xe7ffffff (0x4000000) MX[B](B)
	[12] 0	0	0x000a0000 - 0x000affff (0x10000) MS[B]
	[13] 0	0	0x000b0000 - 0x000b7fff (0x8000) MS[B]
	[14] 0	0	0x000b8000 - 0x000bffff (0x8000) MS[B]
	[15] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[16] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
	[17] -1	0	0x0000f000 - 0x0000f00f (0x10) IX[B]
	[18] -1	0	0x0000dc00 - 0x0000dc7f (0x80) IX[B]
	[19] -1	0	0x0000d800 - 0x0000d8ff (0x100) IX[B]
	[20] -1	0	0x0000d400 - 0x0000d407 (0x8) IX[B]
	[21] -1	0	0x0000d000 - 0x0000d01f (0x20) IX[B]
	[22] 0	0	0x000003b0 - 0x000003bb (0xc) IS[B]
	[23] 0	0	0x000003c0 - 0x000003df (0x20) IS[B]
(II) Loading sub module "int10"
(II) LoadModule: "int10"
(II) Reloading /usr/X11R6/lib/modules/linux/libint10.a
(II) VESA(0): initializing int10
(II) VESA(0): Primary V_BIOS segment is: 0xc000
(II) VESA(0): VESA BIOS detected
(II) VESA(0): VESA VBE Version 1.2
(II) VESA(0): VESA VBE Total Mem: 2048 kB
(II) VESA(0): VESA VBE OEM: STB PowerGraph 64 Video (Trio64V+)
(II) VESA(0): virtual address = 0x40280000,
	physical address = 0xa0000, size = 65536
(II) VESA(0): VBESetVBEMode failed...Tried again without customized values.
(==) VESA(0): Default visual is TrueColor
(==) VESA(0): Backing store disabled
(**) Option "dpms"
(**) VESA(0): DPMS enabled
(==) RandR enabled
(II) Setting vga for screen 0.
(II) Initializing built-in extension MIT-SHM
(II) Initializing built-in extension XInputExtension
(II) Initializing built-in extension XTEST
(II) Initializing built-in extension XKEYBOARD
(II) Initializing built-in extension LBX
(II) Initializing built-in extension XC-APPGROUP
(II) Initializing built-in extension SECURITY
(II) Initializing built-in extension XINERAMA
(II) Initializing built-in extension XFree86-Bigfont
(II) Initializing built-in extension RENDER
(II) Initializing built-in extension RANDR
(II) Keyboard "Generic Keyboard" handled by legacy driver
(**) Option "Protocol" "PS/2"
(**) Configured Mouse: Protocol: "PS/2"
(**) Option "CorePointer"
(**) Configured Mouse: Core Pointer
(**) Option "Device" "/dev/psaux"
(**) Option "Emulate3Buttons" "true"
(**) Configured Mouse: Emulate3Buttons, Emulate3Timeout: 50
(**) Option "ZAxisMapping" "4 5"
(**) Configured Mouse: ZAxisMapping: buttons 4 and 5
(**) Configured Mouse: Buttons: 5
(**) Option "Protocol" "ImPS/2"
(**) Generic Mouse: Protocol: "ImPS/2"
(**) Option "SendCoreEvents" "true"
(**) Generic Mouse: always reports core events
(**) Option "Device" "/dev/input/mice"
(EE) xf86OpenSerial: Cannot open device /dev/input/mice
	No such device.
(EE) Generic Mouse: cannot open input device
(EE) PreInit failed for input device "Generic Mouse"
(II) UnloadModule: "mouse"
(II) XINPUT: Adding extended input device "Configured Mouse" (type: MOUSE)
(II) Configured Mouse: ps2EnableDataReporting: succeeded
Warning: font renderer for ".pcf" already registered at priority 0
Warning: font renderer for ".pcf.Z" already registered at priority 0
Warning: font renderer for ".pcf.gz" already registered at priority 0
Warning: font renderer for ".snf" already registered at priority 0
Warning: font renderer for ".snf.Z" already registered at priority 0
Warning: font renderer for ".snf.gz" already registered at priority 0
Warning: font renderer for ".bdf" already registered at priority 0
Warning: font renderer for ".bdf.Z" already registered at priority 0
Warning: font renderer for ".bdf.gz" already registered at priority 0
Warning: font renderer for ".pmf" already registered at priority 0


--------------070904050504090709050103
Content-Type: text/plain;
 name="varlogmessages"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="varlogmessages"

Apr 17 03:32:44 darkstar syslogd 1.4.1#10: restart.
Apr 17 03:32:44 darkstar kernel: klogd 1.4.1#10, log source = /proc/kmsg started.
Apr 17 03:32:44 darkstar kernel: Inspecting /boot/System.map-2.4.25-1-386
Apr 17 03:32:44 darkstar kernel: Loaded 18507 symbols from /boot/System.map-2.4.25-1-386.
Apr 17 03:32:44 darkstar kernel: Symbols match kernel version 2.4.25.
Apr 17 03:32:44 darkstar kernel: Loaded 516 symbols from 19 modules.
Apr 17 03:32:44 darkstar kernel: Linux version 2.4.25-1-386 (herbert@gondolin) (gcc version 3.3.2 (Debian)) #1 Tue Feb 24 08:11:13 EST 2004
Apr 17 03:32:44 darkstar kernel: BIOS-provided physical RAM map:
Apr 17 03:32:44 darkstar kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Apr 17 03:32:44 darkstar kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Apr 17 03:32:44 darkstar kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Apr 17 03:32:44 darkstar kernel:  BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
Apr 17 03:32:44 darkstar kernel:  BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
Apr 17 03:32:44 darkstar kernel:  BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
Apr 17 03:32:44 darkstar kernel: 511MB LOWMEM available.
Apr 17 03:32:44 darkstar kernel: On node 0 totalpages: 131056
Apr 17 03:32:44 darkstar kernel: zone(0): 4096 pages.
Apr 17 03:32:44 darkstar kernel: zone(1): 126960 pages.
Apr 17 03:32:44 darkstar kernel: zone(2): 0 pages.
Apr 17 03:32:44 darkstar kernel: ACPI: RSDP (v000 Nvidia                                    ) @ 0x000f7390
Apr 17 03:32:44 darkstar kernel: ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3000
Apr 17 03:32:44 darkstar kernel: ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3040
Apr 17 03:32:44 darkstar kernel: ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff7700
Apr 17 03:32:44 darkstar kernel: ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x00000000
Apr 17 03:32:44 darkstar kernel: ACPI: Local APIC address 0xfee00000
Apr 17 03:32:44 darkstar kernel: ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Apr 17 03:32:44 darkstar kernel: Processor #0 Pentium(tm) Pro APIC version 16
Apr 17 03:32:44 darkstar kernel: ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
Apr 17 03:32:44 darkstar kernel: Kernel command line: root=/dev/hda2 ro 
Apr 17 03:32:44 darkstar kernel: Found and enabled local APIC!
Apr 17 03:32:44 darkstar kernel: Initializing CPU#0
Apr 17 03:32:44 darkstar kernel: Detected 2079.589 MHz processor.
Apr 17 03:32:44 darkstar kernel: Console: colour VGA+ 80x25
Apr 17 03:32:44 darkstar kernel: Calibrating delay loop... 4141.87 BogoMIPS
Apr 17 03:32:44 darkstar kernel: Memory: 512716k/524224k available (1079k kernel code, 11120k reserved, 465k data, 92k init, 0k highmem)
Apr 17 03:32:44 darkstar kernel: Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Apr 17 03:32:44 darkstar kernel: Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Apr 17 03:32:44 darkstar kernel: Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Apr 17 03:32:44 darkstar kernel: Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
Apr 17 03:32:44 darkstar kernel: Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
Apr 17 03:32:44 darkstar kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Apr 17 03:32:44 darkstar kernel: CPU: L2 Cache: 512K (64 bytes/line)
Apr 17 03:32:44 darkstar kernel: CPU: AMD Athlon(tm) XP 2800+ stepping 00
Apr 17 03:32:44 darkstar kernel: Enabling fast FPU save and restore... done.
Apr 17 03:32:44 darkstar kernel: Enabling unmasked SIMD FPU exception support... done.
Apr 17 03:32:44 darkstar kernel: Checking 'hlt' instruction... OK.
Apr 17 03:32:44 darkstar kernel: Checking for popad bug... OK.
Apr 17 03:32:44 darkstar kernel: POSIX conformance testing by UNIFIX
Apr 17 03:32:44 darkstar kernel: enabled ExtINT on CPU#0
Apr 17 03:32:44 darkstar kernel: ESR value before enabling vector: 00000000
Apr 17 03:32:44 darkstar kernel: ESR value after enabling vector: 00000000
Apr 17 03:32:44 darkstar kernel: Using local APIC timer interrupts.
Apr 17 03:32:44 darkstar kernel: calibrating APIC timer ...
Apr 17 03:32:44 darkstar kernel: ..... CPU clock speed is 2079.5606 MHz.
Apr 17 03:32:44 darkstar kernel: ..... host bus clock speed is 332.7296 MHz.
Apr 17 03:32:44 darkstar kernel: cpu: 0, clocks: 3327296, slice: 1663648
Apr 17 03:32:44 darkstar kernel: CPU0<T0:3327296,T1:1663648,D:0,S:1663648,C:3327296>
Apr 17 03:32:44 darkstar kernel: ACPI: Subsystem revision 20040116
Apr 17 03:32:44 darkstar kernel: ACPI: Interpreter disabled.
Apr 17 03:32:44 darkstar kernel: PCI: PCI BIOS revision 2.10 entry at 0xfbbd0, last bus=2
Apr 17 03:32:44 darkstar kernel: PCI: Using configuration type 1
Apr 17 03:32:44 darkstar kernel: PCI: Probing PCI hardware
Apr 17 03:32:44 darkstar kernel: PCI: ACPI tables contain no PCI IRQ routing entries
Apr 17 03:32:44 darkstar kernel: PCI: Probing PCI hardware (bus 00)
Apr 17 03:32:44 darkstar kernel: PCI: Discovered primary peer bus ff [IRQ]
Apr 17 03:32:44 darkstar kernel: PCI: Using IRQ router default [10de/01e0] at 00:00.0
Apr 17 03:32:44 darkstar kernel: Linux NET4.0 for Linux 2.4
Apr 17 03:32:44 darkstar kernel: Based upon Swansea University Computer Society NET3.039
Apr 17 03:32:44 darkstar kernel: Initializing RT netlink socket
Apr 17 03:32:44 darkstar kernel: Starting kswapd
Apr 17 03:32:44 darkstar kernel: VFS: Disk quotas vdquot_6.5.1
Apr 17 03:32:44 darkstar kernel: devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
Apr 17 03:32:44 darkstar kernel: devfs: boot_options: 0x0
Apr 17 03:32:44 darkstar kernel: pty: 256 Unix98 ptys configured
Apr 17 03:32:44 darkstar kernel: Serial driver version 5.05c (2001-07-08) with HUB-6 MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI enabled
Apr 17 03:32:44 darkstar kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A
Apr 17 03:32:44 darkstar kernel: ttyS01 at 0x02f8 (irq = 3) is a 16550A
Apr 17 03:32:44 darkstar kernel: COMX: driver version 0.85 (C) 1995-1999 ITConsult-Pro Co. <info@itc.hu>
Apr 17 03:32:44 darkstar kernel: RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
Apr 17 03:32:44 darkstar kernel: Initializing Cryptographic API
Apr 17 03:32:44 darkstar kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Apr 17 03:32:44 darkstar kernel: IP: routing cache hash table of 4096 buckets, 32Kbytes
Apr 17 03:32:44 darkstar kernel: TCP: Hash tables configured (established 32768 bind 65536)
Apr 17 03:32:44 darkstar kernel: Linux IP multicast router 0.06 plus PIM-SM
Apr 17 03:32:44 darkstar kernel: RAMDISK: cramfs filesystem found at block 0
Apr 17 03:32:44 darkstar kernel: RAMDISK: Loading 3540 blocks [1 disk] into ram disk... |^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^Hdone.
Apr 17 03:32:44 darkstar kernel: Freeing initrd memory: 3540k freed
Apr 17 03:32:44 darkstar kernel: VFS: Mounted root (cramfs filesystem).
Apr 17 03:32:44 darkstar kernel: Freeing unused kernel memory: 92k freed
Apr 17 03:32:44 darkstar kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Apr 17 03:32:44 darkstar kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
Apr 17 03:32:44 darkstar kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Apr 17 03:32:44 darkstar kernel: NFORCE2: IDE controller at PCI slot 00:09.0
Apr 17 03:32:44 darkstar kernel: NFORCE2: chipset revision 162
Apr 17 03:32:44 darkstar kernel: NFORCE2: not 100%% native mode: will probe irqs later
Apr 17 03:32:44 darkstar kernel: AMD_IDE: Bios didn't set cable bits corectly. Enabling workaround.
Apr 17 03:32:44 darkstar kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Apr 17 03:32:44 darkstar kernel: AMD_IDE: nVidia Corporation nForce2 IDE (rev a2) UDMA100 controller on pci00:09.0
Apr 17 03:32:44 darkstar kernel:     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
Apr 17 03:32:44 darkstar kernel:     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
Apr 17 03:32:44 darkstar kernel: hda: ST3200822A, ATA DISK drive
Apr 17 03:32:44 darkstar kernel: blk: queue e0826520, I/O limit 4095Mb (mask 0xffffffff)
Apr 17 03:32:44 darkstar kernel: hdc: PLEXTOR DVDR PX-708A, ATAPI CD/DVD-ROM drive
Apr 17 03:32:44 darkstar kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Apr 17 03:32:44 darkstar kernel: ide1 at 0x170-0x177,0x376 on irq 15
Apr 17 03:32:44 darkstar kernel: hda: attached ide-disk driver.
Apr 17 03:32:44 darkstar kernel: hda: 390721968 sectors (200050 MB) w/8192KiB Cache, CHS=24321/255/63, UDMA(100)
Apr 17 03:32:44 darkstar kernel: Partition check:
Apr 17 03:32:44 darkstar kernel:  /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 < p5 >
Apr 17 03:32:44 darkstar kernel: Journalled Block Device driver loaded
Apr 17 03:32:44 darkstar kernel: kjournald starting.  Commit interval 5 seconds
Apr 17 03:32:44 darkstar kernel: EXT3-fs: mounted filesystem with ordered data mode.
Apr 17 03:32:44 darkstar kernel: Adding Swap: 497972k swap-space (priority -1)
Apr 17 03:32:44 darkstar kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,2), internal journal
Apr 17 03:32:44 darkstar kernel: Real Time Clock Driver v1.10f
Apr 17 03:32:44 darkstar kernel: spurious 8259A interrupt: IRQ7.
Apr 17 03:32:44 darkstar kernel: hdc: attached ide-cdrom driver.
Apr 17 03:32:44 darkstar kernel: hdc: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Apr 17 03:32:44 darkstar kernel: Uniform CD-ROM driver Revision: 3.12
Apr 17 03:32:44 darkstar kernel: parport0: PC-style at 0x378 [PCSPP,TRISTATE]
Apr 17 03:32:44 darkstar kernel: lp0: using parport0 (polling).
Apr 17 03:32:44 darkstar kernel: SCSI subsystem driver Revision: 1.00
Apr 17 03:32:44 darkstar kernel: scsi0 : SCSI host adapter emulation for IDE ATAPI devices
Apr 17 03:32:44 darkstar kernel: usb.c: registered new driver usbdevfs
Apr 17 03:32:44 darkstar kernel: usb.c: registered new driver hub
Apr 17 03:32:44 darkstar kernel: ehci_hcd 00:02.2: nVidia Corporation nForce2 USB Controller
Apr 17 03:32:44 darkstar kernel: ehci_hcd 00:02.2: irq 11, pci mem e0878000
Apr 17 03:32:44 darkstar kernel: usb.c: new USB bus registered, assigned bus number 1
Apr 17 03:32:44 darkstar kernel: PCI: cache line size of 64 is not supported by device 00:02.2
Apr 17 03:32:44 darkstar kernel: ehci_hcd 00:02.2: USB 2.0 enabled, EHCI 1.00, driver 2003-Dec-29/2.4
Apr 17 03:32:44 darkstar kernel: hub.c: USB hub found
Apr 17 03:32:44 darkstar kernel: hub.c: 6 ports detected
Apr 17 03:32:44 darkstar kernel: usb-ohci.c: USB OHCI at membase 0xe08ee000, IRQ 5
Apr 17 03:32:44 darkstar kernel: usb-ohci.c: usb-00:02.0, nVidia Corporation nForce2 USB Controller
Apr 17 03:32:44 darkstar kernel: usb.c: new USB bus registered, assigned bus number 2
Apr 17 03:32:44 darkstar kernel: hub.c: USB hub found
Apr 17 03:32:44 darkstar kernel: hub.c: 3 ports detected
Apr 17 03:32:44 darkstar kernel: usb-ohci.c: USB OHCI at membase 0xe08f0000, IRQ 10
Apr 17 03:32:44 darkstar kernel: usb-ohci.c: usb-00:02.1, nVidia Corporation nForce2 USB Controller (#2)
Apr 17 03:32:44 darkstar kernel: usb.c: new USB bus registered, assigned bus number 3
Apr 17 03:32:44 darkstar kernel: hub.c: USB hub found
Apr 17 03:32:44 darkstar kernel: hub.c: 3 ports detected
Apr 17 03:32:44 darkstar kernel: uhci.c: USB Universal Host Controller Interface driver v1.1
Apr 17 03:32:44 darkstar kernel: usb-uhci.c: $Revision: 1.275 $ time 09:07:29 Feb 24 2004
Apr 17 03:32:44 darkstar kernel: usb-uhci.c: High bandwidth mode enabled
Apr 17 03:32:44 darkstar kernel: usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
Apr 17 03:32:45 darkstar lpd[570]: restarted
Apr 17 03:32:45 darkstar kernel: Linux Kernel Card Services 3.1.22
Apr 17 03:32:45 darkstar kernel:   options:  [pci] [cardbus] [pm]
Apr 17 03:32:45 darkstar kernel: isapnp: Scanning for PnP cards...
Apr 17 03:32:45 darkstar kernel: isapnp: No Plug & Play device found
Apr 17 03:32:45 darkstar kernel: Intel ISA PCIC probe: not found.
Apr 17 03:32:46 darkstar kernel: isapnp: Scanning for PnP cards...
Apr 17 03:32:46 darkstar kernel: isapnp: No Plug & Play device found
Apr 17 03:32:46 darkstar kernel: Intel ISA PCIC probe: not found.
Apr 17 03:32:47 darkstar postgres[651]: [1-1] LOG:  could not create IPv6 socket: Address family not supported by protocol
Apr 17 03:32:47 darkstar postgres[655]: [2-1] LOG:  database system was shut down at 2004-04-17 03:31:52 EDT
Apr 17 03:32:47 darkstar postgres[655]: [3-1] LOG:  checkpoint record is at 0/9B1218
Apr 17 03:32:47 darkstar postgres[655]: [4-1] LOG:  redo record is at 0/9B1218; undo record is at 0/0; shutdown TRUE
Apr 17 03:32:47 darkstar postgres[655]: [5-1] LOG:  next transaction ID: 1326; next OID: 17142
Apr 17 03:32:47 darkstar postgres[655]: [6-1] LOG:  database system is ready
Apr 17 03:32:50 darkstar usb.agent[304]: ... no modules for USB product 0/0/0
Apr 17 03:32:50 darkstar usb.agent[289]: ... no modules for USB product 0/0/204
Apr 17 03:32:50 darkstar usb.agent[298]: ... no modules for USB product 0/0/0
Apr 17 03:32:51 darkstar postgres[705]: [2-1] LOG:  connection received: host=[local] port=
Apr 17 03:32:51 darkstar postgres[705]: [3-1] LOG:  connection authorized: user=postgres database=template1
Apr 17 03:32:53 darkstar xfs: ignoring font path element /usr/lib/X11/fonts/cyrillic/ (unreadable) 
Apr 17 03:32:53 darkstar xfs: ignoring font path element /usr/lib/X11/fonts/CID (unreadable) 
Apr 17 03:32:56 darkstar kernel: apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16)

--------------070904050504090709050103--
