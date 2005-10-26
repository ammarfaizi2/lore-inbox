Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932278AbVJZMWU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbVJZMWU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 08:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbVJZMWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 08:22:20 -0400
Received: from xproxy.gmail.com ([66.249.82.205]:20717 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751484AbVJZMWS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 08:22:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=Ta5kdOkbA3IMXp5kbE2dnPvF+Oq/2W5xfYtllXtdT+IxwOHS5TdukQcfQvdc7HaUhZUh+IFhzK6LtyALrSetK6jorZjgu0lu5I8SOInObK7pnvPvndNO7RwAFcqCOqw30tRCWgnURjFFqyU0t7C1XE4WIEhDYC1zFnSIQowUHAE=
Message-ID: <5a4c581d0510260522h3c98d1acsf4715a4d4865121c@mail.gmail.com>
Date: Wed, 26 Oct 2005 14:22:17 +0200
From: Alessandro Suardi <alessandro.suardi@gmail.com>
To: Dave Airlie <airlied@gmail.com>
Subject: Re: X unkillable in R state sometimes on startx , /proc/sysrq-trigger T output attached
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <21d7e9970510260325o2a47e6f5gc64d29eec42de086@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_13915_32800839.1130329337542"
References: <5a4c581d0510251335ke8e7ae6n883e0b44a9920ce4@mail.gmail.com>
	 <21d7e9970510260325o2a47e6f5gc64d29eec42de086@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_13915_32800839.1130329337542
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 10/26/05, Dave Airlie <airlied@gmail.com> wrote:
> > If anyone has an idea on what to do to try and reproduce
> >  and/or debug further, that'd be cool.
> >
> > Box is a Dell Latitude C640 laptop, PIV@1.8Ghz,
> >  1GB RAM, with a USR2210 802.11b wireless
> >  PC Card; video card is a Radeon 7500 M7 LW.
> >
>
> Your getting an X hang which is usually a DRM/AGP or X configuartion prob=
lems..
>
> Please send me your /etc/X11/xorg.conf and /var/log/Xorg.0.log after a ha=
ng..
>
> did it work with any kernel before? and suddenly break recently?

It's intermittent. It looks like more recent kernels have a tendency
 to trigger it more easily - in fact I just happened to have another
 occurrence, this time without even loading the acx driver, just

 1. boot
 2. login as non-root
 3. startx

 but it works most times.

I lied however - the keyboard is _not_ dead, despite not lighting
 the CapsLock led, and I can Alt-SysRQ-<x>.

Luckily, I have both the current working Xorg.0.log and the one
 coming from the hang. I'm attaching both, and my xorg.conf.

Thanks :)

--alessandro

 "All it takes is one decision
  A lot of guts, a little vision to wave
  Your worries, and cares goodbye"

   (Placebo - "Slave To The Wage")

------=_Part_13915_32800839.1130329337542
Content-Type: application/octet-stream; name=xorg.conf
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="xorg.conf"


# XFree86 4 configuration created by pyxf86config

Section "ServerLayout"
	Identifier     "Default Layout"
	Screen      0  "Screen0" 0 0
	InputDevice    "Mouse0" "CorePointer"
	InputDevice    "Keyboard0" "CoreKeyboard"
	InputDevice    "Synaptics" "AlwaysCore"
EndSection

Section "Files"

# RgbPath is the location of the RGB database.  Note, this is the name of the 
# file minus the extension (like ".txt" or ".db").  There is normally
# no need to change the default.
# Multiple FontPath entries are allowed (they are concatenated together)
# By default, Red Hat 6.0 and later now use a font server independent of
# the X server to render fonts.
	RgbPath      "/usr/X11R6/lib/X11/rgb"
	FontPath     "unix/:7100"
EndSection

Section "Module"
	Load  "dbe"
	Load  "extmod"
	Load  "fbdevhw"
	Load  "glx"
	Load  "record"
	Load  "freetype"
	Load  "type1"
	Load  "synaptics"
	Load  "dri"
EndSection

Section "InputDevice"

# Specify which keyboard LEDs can be user-controlled (eg, with xset(1))
#	Option	"Xleds"		"1 2 3"
# To disable the XKEYBOARD extension, uncomment XkbDisable.
#	Option	"XkbDisable"
# To customise the XKB settings to suit your keyboard, modify the
# lines below (which are the defaults).  For example, for a non-U.S.
# keyboard, you will probably want to use:
#	Option	"XkbModel"	"pc102"
# If you have a US Microsoft Natural keyboard, you can use:
#	Option	"XkbModel"	"microsoft"
#
# Then to change the language, change the Layout setting.
# For example, a german layout can be obtained with:
#	Option	"XkbLayout"	"de"
# or:
#	Option	"XkbLayout"	"de"
#	Option	"XkbVariant"	"nodeadkeys"
#
# If you'd like to switch the positions of your capslock and
# control keys, use:
#	Option	"XkbOptions"	"ctrl:swapcaps"
# Or if you just want both to be control, use:
#	Option	"XkbOptions"	"ctrl:nocaps"
#
	Identifier  "Keyboard0"
	Driver      "kbd"
	Option	    "XkbModel" "pc105"
	Option	    "XkbLayout" "us"
EndSection

Section "InputDevice"
	Identifier  "Mouse0"
	Driver      "mouse"
	Option	    "Protocol" "IMPS/2"
	Option	    "Device" "/dev/input/mice"
	Option	    "ZAxisMapping" "4 5"
	Option	    "Emulate3Buttons" "yes"
EndSection

Section "InputDevice"
	Identifier  "Synaptics"
	Driver      "synaptics"
	Option	    "Device" "/dev/input/mice"
	Option	    "Protocol" "auto-dev"
	Option	    "Emulate3Buttons" "yes"
EndSection

Section "Monitor"
	Identifier   "Monitor0"
	VendorName   "Monitor Vendor"
	ModelName    "LCD Panel 1024x768"
	HorizSync    31.5 - 48.5
	VertRefresh  40.0 - 70.0
	Option	    "dpms"
EndSection

Section "Device"
	Identifier  "Videocard0"
	Driver      "radeon"
	VendorName  "Videocard vendor"
	BoardName   "ATI Radeon Mobility 7500"
EndSection

Section "Screen"
	Identifier "Screen0"
	Device     "Videocard0"
	Monitor    "Monitor0"
	DefaultDepth     24
	SubSection "Display"
		Viewport   0 0
		Depth     16
		Modes    "800x600" "640x480"
	EndSubSection
	SubSection "Display"
		Viewport   0 0
		Depth     24
		Modes    "1024x768" "800x600" "640x480"
	EndSubSection
EndSection

Section "DRI"
	Group        0
	Mode         0666
EndSection


------=_Part_13915_32800839.1130329337542
Content-Type: application/octet-stream; name=Xorg.0.log.good
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="Xorg.0.log.good"

_XSERVTransSocketOpenCOTSServer: Unable to open socket for inet6
_XSERVTransOpen: transport open failed for inet6/incident:0
_XSERVTransMakeAllCOTSServerListeners: failed to open listener for inet6

X Window System Version 6.8.2
Release Date: 9 February 2005
X Protocol Version 11, Revision 0, Release 6.8.2
Build Operating System: Linux 2.6.9-22.ELsmp i686 [ELF] 
Current Operating System: Linux incident 2.6.14-rc5-git5 #1 PREEMPT Tue Oct 25 14:32:46 CEST 2005 i686
Build Date: 21 September 2005
Build Host: hs20-bc1-6.build.redhat.com
 
	Before reporting problems, check http://wiki.X.Org
	to make sure that you have the latest version.
Module Loader present
OS Kernel: Linux version 2.6.14-rc5-git5 (asuardi@incident) (gcc version 4.0.2) #1 PREEMPT Tue Oct 25 14:32:46 CEST 2005 
Markers: (--) probed, (**) from config file, (==) default setting,
	(++) from command line, (!!) notice, (II) informational,
	(WW) warning, (EE) error, (NI) not implemented, (??) unknown.
(==) Log file: "/var/log/Xorg.0.log", Time: Wed Oct 26 14:14:51 2005
(==) Using config file: "/etc/X11/xorg.conf"
(==) ServerLayout "Default Layout"
(**) |-->Screen "Screen0" (0)
(**) |   |-->Monitor "Monitor0"
(**) |   |-->Device "Videocard0"
(**) |-->Input Device "Mouse0"
(**) |-->Input Device "Keyboard0"
(**) |-->Input Device "Synaptics"
(**) FontPath set to "unix/:7100"
(**) RgbPath set to "/usr/X11R6/lib/X11/rgb"
(==) ModulePath set to "/usr/X11R6/lib/modules"
(WW) Open APM failed (/dev/apm_bios) (No such file or directory)
(II) Module ABI versions:
	X.Org ANSI C Emulation: 0.2
	X.Org Video Driver: 0.7
	X.Org XInput driver : 0.4
	X.Org Server Extension : 0.2
	X.Org Font Renderer : 0.4
(II) Loader running on linux
(II) LoadModule: "bitmap"
(II) Loading /usr/X11R6/lib/modules/fonts/libbitmap.a
(II) Module bitmap: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 1.0.0
	Module class: X.Org Font Renderer
	ABI class: X.Org Font Renderer, version 0.4
(II) Loading font Bitmap
(II) LoadModule: "pcidata"
(II) Loading /usr/X11R6/lib/modules/libpcidata.a
(II) Module pcidata: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 1.0.0
	ABI class: X.Org Video Driver, version 0.7
(--) using VT number 7

(II) PCI: PCI scan (all values are in hex)
(II) PCI: 00:00:0: chip 8086,1a30 card 0000,0000 rev 04 class 06,00,00 hdr 00
(II) PCI: 00:01:0: chip 8086,1a31 card 0000,0000 rev 04 class 06,04,00 hdr 01
(II) PCI: 00:1d:0: chip 8086,2482 card 8086,4541 rev 02 class 0c,03,00 hdr 00
(II) PCI: 00:1e:0: chip 8086,2448 card 0000,0000 rev 42 class 06,04,00 hdr 01
(II) PCI: 00:1f:0: chip 8086,248c card 0000,0000 rev 02 class 06,01,00 hdr 80
(II) PCI: 00:1f:1: chip 8086,248a card 8086,4541 rev 02 class 01,01,8a hdr 00
(II) PCI: 00:1f:5: chip 8086,2485 card 1013,5959 rev 02 class 04,01,00 hdr 00
(II) PCI: 00:1f:6: chip 8086,2486 card 134d,4c21 rev 02 class 07,03,00 hdr 00
(II) PCI: 01:00:0: chip 1002,4c57 card 1028,012a rev 00 class 03,00,00 hdr 00
(II) PCI: 02:00:0: chip 10b7,9200 card 1028,012a rev 78 class 02,00,00 hdr 00
(II) PCI: 02:01:0: chip 104c,ac51 card e000,0000 rev 00 class 06,07,00 hdr 82
(II) PCI: 02:01:1: chip 104c,ac51 card e800,0000 rev 00 class 06,07,00 hdr 82
(II) PCI: End of PCI scan
(II) Host-to-PCI bridge:
(II) Bus 0: bridge is at (0:0:0), (0,0,7), BCTRL: 0x0008 (VGA_EN is set)
(II) Bus 0 I/O range:
	[0] -1	0	0x00000000 - 0x0000ffff (0x10000) IX[B]
(II) Bus 0 non-prefetchable memory range:
	[0] -1	0	0x00000000 - 0xffffffff (0x0) MX[B]
(II) Bus 0 prefetchable memory range:
	[0] -1	0	0x00000000 - 0xffffffff (0x0) MX[B]
(II) PCI-to-PCI bridge:
(II) Bus 1: bridge is at (0:1:0), (0,1,1), BCTRL: 0x000e (VGA_EN is set)
(II) Bus 1 I/O range:
	[0] -1	0	0x0000c000 - 0x0000c0ff (0x100) IX[B]
	[1] -1	0	0x0000c400 - 0x0000c4ff (0x100) IX[B]
	[2] -1	0	0x0000c800 - 0x0000c8ff (0x100) IX[B]
	[3] -1	0	0x0000cc00 - 0x0000ccff (0x100) IX[B]
(II) Bus 1 non-prefetchable memory range:
	[0] -1	0	0xfc000000 - 0xfdffffff (0x2000000) MX[B]
(II) Bus 1 prefetchable memory range:
	[0] -1	0	0xe0000000 - 0xe7ffffff (0x8000000) MX[B]
(II) PCI-to-PCI bridge:
(II) Bus 2: bridge is at (0:30:0), (0,2,16), BCTRL: 0x0006 (VGA_EN is cleared)
(II) Bus 2 I/O range:
	[0] -1	0	0x0000e000 - 0x0000e0ff (0x100) IX[B]
	[1] -1	0	0x0000e400 - 0x0000e4ff (0x100) IX[B]
	[2] -1	0	0x0000e800 - 0x0000e8ff (0x100) IX[B]
	[3] -1	0	0x0000ec00 - 0x0000ecff (0x100) IX[B]
	[4] -1	0	0x0000f000 - 0x0000f0ff (0x100) IX[B]
	[5] -1	0	0x0000f400 - 0x0000f4ff (0x100) IX[B]
	[6] -1	0	0x0000f800 - 0x0000f8ff (0x100) IX[B]
	[7] -1	0	0x0000fc00 - 0x0000fcff (0x100) IX[B]
(II) Bus 2 non-prefetchable memory range:
	[0] -1	0	0xf4000000 - 0xfbffffff (0x8000000) MX[B]
(II) Bus 2 prefetchable memory range:
	[0] -1	0	0x50000000 - 0x54ffffff (0x5000000) MX[B]
(II) PCI-to-ISA bridge:
(II) Bus -1: bridge is at (0:31:0), (0,-1,-1), BCTRL: 0x0008 (VGA_EN is set)
(II) PCI-to-CardBus bridge:
(II) Bus 3: bridge is at (2:1:0), (2,3,6), BCTRL: 0x05c0 (VGA_EN is cleared)
(II) Bus 3 I/O range:
	[0] -1	0	0x0000e000 - 0x0000e0ff (0x100) IX[B]
	[1] -1	0	0x0000e400 - 0x0000e4ff (0x100) IX[B]
(II) Bus 3 non-prefetchable memory range:
	[0] -1	0	0xf4000000 - 0xf5ffffff (0x2000000) MX[B]
(II) Bus 3 prefetchable memory range:
	[0] -1	0	0x50000000 - 0x51ffffff (0x2000000) MX[B]
(II) PCI-to-CardBus bridge:
(II) Bus 7: bridge is at (2:1:1), (2,7,10), BCTRL: 0x05c0 (VGA_EN is cleared)
(II) Bus 7 I/O range:
	[0] -1	0	0x0000e800 - 0x0000e8ff (0x100) IX[B]
(II) Bus 7 non-prefetchable memory range:
	[0] -1	0	0xf6000000 - 0xf7ffffff (0x2000000) MX[B]
(II) Bus 7 prefetchable memory range:
	[0] -1	0	0x52000000 - 0x53ffffff (0x2000000) MX[B]
(--) PCI:*(1:0:0) ATI Technologies Inc Radeon Mobility M7 LW [Radeon Mobility 7500] rev 0, Mem @ 0xe0000000/27, 0xfcff0000/16, I/O @ 0xc000/8
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
(II) PCI Memory resource overlap reduced 0xe8000000 from 0xebffffff to 0xe7ffffff
(II) Active PCI resource ranges:
	[0] -1	0	0xf8fffc00 - 0xf8fffc7f (0x80) MX[B]
	[1] -1	0	0x55000000 - 0x550003ff (0x400) MX[B]
	[2] -1	0	0xe8000000 - 0xe7ffffff (0x0) MX[B]O
	[3] -1	0	0xfcff0000 - 0xfcffffff (0x10000) MX[B](B)
	[4] -1	0	0xe0000000 - 0xe7ffffff (0x8000000) MX[B](B)
	[5] -1	0	0x0000ec80 - 0x0000ecff (0x80) IX[B]
	[6] -1	0	0x0000dc00 - 0x0000dc7f (0x80) IX[B]
	[7] -1	0	0x0000d400 - 0x0000d4ff (0x100) IX[B]
	[8] -1	0	0x0000dc80 - 0x0000dcbf (0x40) IX[B]
	[9] -1	0	0x0000d800 - 0x0000d8ff (0x100) IX[B]
	[10] -1	0	0x0000bfa0 - 0x0000bfaf (0x10) IX[B]
	[11] -1	0	0x00000374 - 0x00000374 (0x1) IX[B]
	[12] -1	0	0x00000170 - 0x00000170 (0x1) IX[B]
	[13] -1	0	0x000003f4 - 0x000003f4 (0x1) IX[B]
	[14] -1	0	0x000001f0 - 0x000001f0 (0x1) IX[B]
	[15] -1	0	0x0000bf80 - 0x0000bf9f (0x20) IX[B]
	[16] -1	0	0x0000c000 - 0x0000c0ff (0x100) IX[B](B)
(II) Active PCI resource ranges after removing overlaps:
	[0] -1	0	0xf8fffc00 - 0xf8fffc7f (0x80) MX[B]
	[1] -1	0	0x55000000 - 0x550003ff (0x400) MX[B]
	[2] -1	0	0xe8000000 - 0xe7ffffff (0x0) MX[B]O
	[3] -1	0	0xfcff0000 - 0xfcffffff (0x10000) MX[B](B)
	[4] -1	0	0xe0000000 - 0xe7ffffff (0x8000000) MX[B](B)
	[5] -1	0	0x0000ec80 - 0x0000ecff (0x80) IX[B]
	[6] -1	0	0x0000dc00 - 0x0000dc7f (0x80) IX[B]
	[7] -1	0	0x0000d400 - 0x0000d4ff (0x100) IX[B]
	[8] -1	0	0x0000dc80 - 0x0000dcbf (0x40) IX[B]
	[9] -1	0	0x0000d800 - 0x0000d8ff (0x100) IX[B]
	[10] -1	0	0x0000bfa0 - 0x0000bfaf (0x10) IX[B]
	[11] -1	0	0x00000374 - 0x00000374 (0x1) IX[B]
	[12] -1	0	0x00000170 - 0x00000170 (0x1) IX[B]
	[13] -1	0	0x000003f4 - 0x000003f4 (0x1) IX[B]
	[14] -1	0	0x000001f0 - 0x000001f0 (0x1) IX[B]
	[15] -1	0	0x0000bf80 - 0x0000bf9f (0x20) IX[B]
	[16] -1	0	0x0000c000 - 0x0000c0ff (0x100) IX[B](B)
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
	[5] -1	0	0xf8fffc00 - 0xf8fffc7f (0x80) MX[B]
	[6] -1	0	0x55000000 - 0x550003ff (0x400) MX[B]
	[7] -1	0	0xe8000000 - 0xe7ffffff (0x0) MX[B]O
	[8] -1	0	0xfcff0000 - 0xfcffffff (0x10000) MX[B](B)
	[9] -1	0	0xe0000000 - 0xe7ffffff (0x8000000) MX[B](B)
	[10] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[11] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
	[12] -1	0	0x0000ec80 - 0x0000ecff (0x80) IX[B]
	[13] -1	0	0x0000dc00 - 0x0000dc7f (0x80) IX[B]
	[14] -1	0	0x0000d400 - 0x0000d4ff (0x100) IX[B]
	[15] -1	0	0x0000dc80 - 0x0000dcbf (0x40) IX[B]
	[16] -1	0	0x0000d800 - 0x0000d8ff (0x100) IX[B]
	[17] -1	0	0x0000bfa0 - 0x0000bfaf (0x10) IX[B]
	[18] -1	0	0x00000374 - 0x00000374 (0x1) IX[B]
	[19] -1	0	0x00000170 - 0x00000170 (0x1) IX[B]
	[20] -1	0	0x000003f4 - 0x000003f4 (0x1) IX[B]
	[21] -1	0	0x000001f0 - 0x000001f0 (0x1) IX[B]
	[22] -1	0	0x0000bf80 - 0x0000bf9f (0x20) IX[B]
	[23] -1	0	0x0000c000 - 0x0000c0ff (0x100) IX[B](B)
(II) LoadModule: "dbe"
(II) Loading /usr/X11R6/lib/modules/extensions/libdbe.a
(II) Module dbe: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 1.0.0
	Module class: X.Org Server Extension
	ABI class: X.Org Server Extension, version 0.2
(II) Loading extension DOUBLE-BUFFER
(II) LoadModule: "extmod"
(II) Loading /usr/X11R6/lib/modules/extensions/libextmod.a
(II) Module extmod: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 1.0.0
	Module class: X.Org Server Extension
	ABI class: X.Org Server Extension, version 0.2
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
(II) Loading extension TOG-CUP
(II) Loading extension Extended-Visual-Information
(II) Loading extension XVideo
(II) Loading extension XVideo-MotionCompensation
(II) Loading extension X-Resource
(II) LoadModule: "fbdevhw"
(II) Loading /usr/X11R6/lib/modules/linux/libfbdevhw.a
(II) Module fbdevhw: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 0.0.2
	ABI class: X.Org Video Driver, version 0.7
(II) LoadModule: "glx"
(II) Loading /usr/X11R6/lib/modules/extensions/libglx.a
(II) Module glx: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 1.0.0
	ABI class: X.Org Server Extension, version 0.2
(II) Loading sub module "GLcore"
(II) LoadModule: "GLcore"
(II) Loading /usr/X11R6/lib/modules/extensions/libGLcore.a
(II) Module GLcore: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 1.0.0
	ABI class: X.Org Server Extension, version 0.2
(II) Loading extension GLX
(II) LoadModule: "record"
(II) Loading /usr/X11R6/lib/modules/extensions/librecord.a
(II) Module record: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 1.13.0
	Module class: X.Org Server Extension
	ABI class: X.Org Server Extension, version 0.2
(II) Loading extension RECORD
(II) LoadModule: "freetype"
(II) Loading /usr/X11R6/lib/modules/fonts/libfreetype.so
(II) Module freetype: vendor="X.Org Foundation & the After X-TT Project"
	compiled for 6.8.2, module version = 2.1.0
	Module class: X.Org Font Renderer
	ABI class: X.Org Font Renderer, version 0.4
(II) Loading font FreeType
(II) LoadModule: "type1"
(II) Loading /usr/X11R6/lib/modules/fonts/libtype1.a
(II) Module type1: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 1.0.2
	Module class: X.Org Font Renderer
	ABI class: X.Org Font Renderer, version 0.4
(II) Loading font Type1
(II) Loading font CID
(II) LoadModule: "synaptics"
(II) Loading /usr/X11R6/lib/modules/input/synaptics_drv.o
(II) Module synaptics: vendor="X.Org Foundation"
	compiled for 4.3.99.902, module version = 1.0.0
	Module class: X.Org XInput Driver
	ABI class: X.Org XInput driver, version 0.4
(II) LoadModule: "dri"
(II) Loading /usr/X11R6/lib/modules/extensions/libdri.a
(II) Module dri: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 1.0.0
	ABI class: X.Org Server Extension, version 0.2
(II) Loading sub module "drm"
(II) LoadModule: "drm"
(II) Loading /usr/X11R6/lib/modules/linux/libdrm.a
(II) Module drm: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 1.0.0
	ABI class: X.Org Server Extension, version 0.2
(II) Loading extension XFree86-DRI
(II) LoadModule: "radeon"
(II) Loading /usr/X11R6/lib/modules/drivers/radeon_drv.o
(II) Module radeon: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 4.0.1
	Module class: X.Org Video Driver
	ABI class: X.Org Video Driver, version 0.7
(II) LoadModule: "ati"
(II) Loading /usr/X11R6/lib/modules/drivers/ati_drv.o
(II) Module ati: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 6.5.6
	Module class: X.Org Video Driver
	ABI class: X.Org Video Driver, version 0.7
(II) LoadModule: "mouse"
(II) Loading /usr/X11R6/lib/modules/input/mouse_drv.o
(II) Module mouse: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 1.0.0
	Module class: X.Org XInput Driver
	ABI class: X.Org XInput driver, version 0.4
(II) LoadModule: "kbd"
(II) Loading /usr/X11R6/lib/modules/input/kbd_drv.o
(II) Module kbd: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 1.0.0
	Module class: X.Org XInput Driver
	ABI class: X.Org XInput driver, version 0.4
(II) LoadModule: "synaptics"
(II) Reloading /usr/X11R6/lib/modules/input/synaptics_drv.o
(II) ATI: ATI driver (version 6.5.6) for chipsets: ati, ativga
(II) R128: Driver for ATI Rage 128 chipsets:
	ATI Rage 128 Mobility M3 LE (PCI), ATI Rage 128 Mobility M3 LF (AGP),
	ATI Rage 128 Mobility M4 MF (AGP), ATI Rage 128 Mobility M4 ML (AGP),
	ATI Rage 128 Pro GL PA (PCI/AGP), ATI Rage 128 Pro GL PB (PCI/AGP),
	ATI Rage 128 Pro GL PC (PCI/AGP), ATI Rage 128 Pro GL PD (PCI),
	ATI Rage 128 Pro GL PE (PCI/AGP), ATI Rage 128 Pro GL PF (AGP),
	ATI Rage 128 Pro VR PG (PCI/AGP), ATI Rage 128 Pro VR PH (PCI/AGP),
	ATI Rage 128 Pro VR PI (PCI/AGP), ATI Rage 128 Pro VR PJ (PCI/AGP),
	ATI Rage 128 Pro VR PK (PCI/AGP), ATI Rage 128 Pro VR PL (PCI/AGP),
	ATI Rage 128 Pro VR PM (PCI/AGP), ATI Rage 128 Pro VR PN (PCI/AGP),
	ATI Rage 128 Pro VR PO (PCI/AGP), ATI Rage 128 Pro VR PP (PCI),
	ATI Rage 128 Pro VR PQ (PCI/AGP), ATI Rage 128 Pro VR PR (PCI),
	ATI Rage 128 Pro VR PS (PCI/AGP), ATI Rage 128 Pro VR PT (PCI/AGP),
	ATI Rage 128 Pro VR PU (PCI/AGP), ATI Rage 128 Pro VR PV (PCI/AGP),
	ATI Rage 128 Pro VR PW (PCI/AGP), ATI Rage 128 Pro VR PX (PCI/AGP),
	ATI Rage 128 GL RE (PCI), ATI Rage 128 GL RF (AGP),
	ATI Rage 128 RG (AGP), ATI Rage 128 VR RK (PCI),
	ATI Rage 128 VR RL (AGP), ATI Rage 128 4X SE (PCI/AGP),
	ATI Rage 128 4X SF (PCI/AGP), ATI Rage 128 4X SG (PCI/AGP),
	ATI Rage 128 4X SH (PCI/AGP), ATI Rage 128 4X SK (PCI/AGP),
	ATI Rage 128 4X SL (PCI/AGP), ATI Rage 128 4X SM (AGP),
	ATI Rage 128 4X SN (PCI/AGP), ATI Rage 128 Pro ULTRA TF (AGP),
	ATI Rage 128 Pro ULTRA TL (AGP), ATI Rage 128 Pro ULTRA TR (AGP),
	ATI Rage 128 Pro ULTRA TS (AGP?), ATI Rage 128 Pro ULTRA TT (AGP?),
	ATI Rage 128 Pro ULTRA TU (AGP?)
(II) RADEON: Driver for ATI Radeon chipsets: ATI Radeon QD (AGP),
	ATI Radeon QE (AGP), ATI Radeon QF (AGP), ATI Radeon QG (AGP),
	ATI Radeon VE/7000 QY (AGP/PCI), ATI Radeon VE/7000 QZ (AGP/PCI),
	ATI Radeon Mobility M7 LW (AGP),
	ATI Mobility FireGL 7800 M7 LX (AGP),
	ATI Radeon Mobility M6 LY (AGP), ATI Radeon Mobility M6 LZ (AGP),
	ATI Radeon IGP320 (A3) 4136, ATI Radeon IGP320M (U1) 4336,
	ATI Radeon IGP330/340/350 (A4) 4137,
	ATI Radeon IGP330M/340M/350M (U2) 4337,
	ATI Radeon 7000 IGP (A4+) 4237, ATI Radeon Mobility 7000 IGP 4437,
	ATI FireGL 8700/8800 QH (AGP), ATI Radeon 8500 QL (AGP),
	ATI Radeon 9100 QM (AGP), ATI Radeon 8500 AIW BB (AGP),
	ATI Radeon 8500 AIW BC (AGP), ATI Radeon 7500 QW (AGP/PCI),
	ATI Radeon 7500 QX (AGP/PCI), ATI Radeon 9000/PRO If (AGP/PCI),
	ATI Radeon 9000 Ig (AGP/PCI), ATI FireGL Mobility 9000 (M9) Ld (AGP),
	ATI Radeon Mobility 9000 (M9) Lf (AGP),
	ATI Radeon Mobility 9000 (M9) Lg (AGP),
	ATI Radeon 9100 IGP (A5) 5834,
	ATI Radeon Mobility 9100 IGP (U3) 5835, ATI Radeon 9100 PRO IGP 7834,
	ATI Radeon Mobility 9200 IGP 7835, ATI Radeon 9200PRO 5960 (AGP),
	ATI Radeon 9200 5961 (AGP), ATI Radeon 9200 5962 (AGP),
	ATI Radeon 9200SE 5964 (AGP),
	ATI Radeon Mobility 9200 (M9+) 5C61 (AGP),
	ATI Radeon Mobility 9200 (M9+) 5C63 (AGP), ATI Radeon 9500 AD (AGP),
	ATI Radeon 9500 AE (AGP), ATI Radeon 9600TX AF (AGP),
	ATI FireGL Z1 AG (AGP), ATI Radeon 9700 Pro ND (AGP),
	ATI Radeon 9700/9500Pro NE (AGP), ATI Radeon 9700 NF (AGP),
	ATI FireGL X1 NG (AGP), ATI Radeon 9600 AP (AGP),
	ATI Radeon 9600SE AQ (AGP), ATI Radeon 9600XT AR (AGP),
	ATI Radeon 9600 AS (AGP), ATI FireGL T2 AT (AGP),
	ATI FireGL RV360 AV (AGP),
	ATI Radeon Mobility 9600/9700 (M10/M11) NP (AGP),
	ATI Radeon Mobility 9600 (M10) NQ (AGP),
	ATI Radeon Mobility 9600 (M11) NR (AGP),
	ATI Radeon Mobility 9600 (M10) NS (AGP),
	ATI FireGL Mobility T2 (M10) NT (AGP),
	ATI FireGL Mobility T2e (M11) NV (AGP), ATI Radeon 9800SE AH (AGP),
	ATI Radeon 9800 AI (AGP), ATI Radeon 9800 AJ (AGP),
	ATI FireGL X2 AK (AGP), ATI Radeon 9800PRO NH (AGP),
	ATI Radeon 9800 NI (AGP), ATI FireGL X2 NK (AGP),
	ATI Radeon 9800XT NJ (AGP), ATI Radeon X600 (RV380) 3E50 (PCIE),
	ATI FireGL V3200 (RV380) 3E54 (PCIE),
	ATI Radeon Mobility X600 (M24) 3150 (PCIE),
	ATI FireGL M24 GL 3154 (PCIE), ATI Radeon X300 (RV370) 5B60 (PCIE),
	ATI Radeon X600 (RV370) 5B62 (PCIE),
	ATI FireGL V3100 (RV370) 5B64 (PCIE),
	ATI FireGL D1100 (RV370) 5B65 (PCIE),
	ATI Radeon Mobility M300 (M22) 5460 (PCIE),
	ATI FireGL M22 GL 5464 (PCIE), ATI Radeon X800 (R420) JH (AGP),
	ATI Radeon X800PRO (R420) JI (AGP),
	ATI Radeon X800SE (R420) JJ (AGP), ATI Radeon X800 (R420) JK (AGP),
	ATI Radeon X800 (R420) JL (AGP), ATI FireGL X3 (R420) JM (AGP),
	ATI Radeon Mobility 9800 (M18) JN (AGP),
	ATI Radeon X800XT (R420) JP (AGP), ATI Radeon X800 (R423) UH (PCIE),
	ATI Radeon X800PRO (R423) UI (PCIE),
	ATI Radeon X800LE (R423) UJ (PCIE),
	ATI Radeon X800SE (R423) UK (PCIE),
	ATI FireGL V7200 (R423) UQ (PCIE), ATI FireGL V5100 (R423) UR (PCIE),
	ATI FireGL V7100 (R423) UT (PCIE),
	ATI Radeon X800XT (R423) 5D57 (PCIE)
(II) Primary Device is: PCI 01:00:0
(--) Assigning device section with no busID to primary device
(--) Chipset ATI Radeon Mobility M7 LW (AGP) found
(II) resource ranges after xf86ClaimFixedResources() call:
	[0] -1	0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1	0	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[2] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1	0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[5] -1	0	0xf8fffc00 - 0xf8fffc7f (0x80) MX[B]
	[6] -1	0	0x55000000 - 0x550003ff (0x400) MX[B]
	[7] -1	0	0xe8000000 - 0xe7ffffff (0x0) MX[B]O
	[8] -1	0	0xfcff0000 - 0xfcffffff (0x10000) MX[B](B)
	[9] -1	0	0xe0000000 - 0xe7ffffff (0x8000000) MX[B](B)
	[10] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[11] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
	[12] -1	0	0x0000ec80 - 0x0000ecff (0x80) IX[B]
	[13] -1	0	0x0000dc00 - 0x0000dc7f (0x80) IX[B]
	[14] -1	0	0x0000d400 - 0x0000d4ff (0x100) IX[B]
	[15] -1	0	0x0000dc80 - 0x0000dcbf (0x40) IX[B]
	[16] -1	0	0x0000d800 - 0x0000d8ff (0x100) IX[B]
	[17] -1	0	0x0000bfa0 - 0x0000bfaf (0x10) IX[B]
	[18] -1	0	0x00000374 - 0x00000374 (0x1) IX[B]
	[19] -1	0	0x00000170 - 0x00000170 (0x1) IX[B]
	[20] -1	0	0x000003f4 - 0x000003f4 (0x1) IX[B]
	[21] -1	0	0x000001f0 - 0x000001f0 (0x1) IX[B]
	[22] -1	0	0x0000bf80 - 0x0000bf9f (0x20) IX[B]
	[23] -1	0	0x0000c000 - 0x0000c0ff (0x100) IX[B](B)
(II) Loading sub module "radeon"
(II) LoadModule: "radeon"
(II) Reloading /usr/X11R6/lib/modules/drivers/radeon_drv.o
(II) resource ranges after probing:
	[0] -1	0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1	0	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[2] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1	0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[5] -1	0	0xf8fffc00 - 0xf8fffc7f (0x80) MX[B]
	[6] -1	0	0x55000000 - 0x550003ff (0x400) MX[B]
	[7] -1	0	0xe8000000 - 0xe7ffffff (0x0) MX[B]O
	[8] -1	0	0xfcff0000 - 0xfcffffff (0x10000) MX[B](B)
	[9] -1	0	0xe0000000 - 0xe7ffffff (0x8000000) MX[B](B)
	[10] 0	0	0x000a0000 - 0x000affff (0x10000) MS[B]
	[11] 0	0	0x000b0000 - 0x000b7fff (0x8000) MS[B]
	[12] 0	0	0x000b8000 - 0x000bffff (0x8000) MS[B]
	[13] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[14] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
	[15] -1	0	0x0000ec80 - 0x0000ecff (0x80) IX[B]
	[16] -1	0	0x0000dc00 - 0x0000dc7f (0x80) IX[B]
	[17] -1	0	0x0000d400 - 0x0000d4ff (0x100) IX[B]
	[18] -1	0	0x0000dc80 - 0x0000dcbf (0x40) IX[B]
	[19] -1	0	0x0000d800 - 0x0000d8ff (0x100) IX[B]
	[20] -1	0	0x0000bfa0 - 0x0000bfaf (0x10) IX[B]
	[21] -1	0	0x00000374 - 0x00000374 (0x1) IX[B]
	[22] -1	0	0x00000170 - 0x00000170 (0x1) IX[B]
	[23] -1	0	0x000003f4 - 0x000003f4 (0x1) IX[B]
	[24] -1	0	0x000001f0 - 0x000001f0 (0x1) IX[B]
	[25] -1	0	0x0000bf80 - 0x0000bf9f (0x20) IX[B]
	[26] -1	0	0x0000c000 - 0x0000c0ff (0x100) IX[B](B)
	[27] 0	0	0x000003b0 - 0x000003bb (0xc) IS[B]
	[28] 0	0	0x000003c0 - 0x000003df (0x20) IS[B]
(II) Setting vga for screen 0.
(II) RADEON(0): MMIO registers at 0xfcff0000
(II) Loading sub module "vgahw"
(II) LoadModule: "vgahw"
(II) Loading /usr/X11R6/lib/modules/libvgahw.a
(II) Module vgahw: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 0.1.0
	ABI class: X.Org Video Driver, version 0.7
(II) RADEON(0): vgaHWGetIOBase: hwp->IOBase is 0x03d0, hwp->PIOOffset is 0x0000
(II) RADEON(0): PCI bus 1 card 0 func 0
(**) RADEON(0): Depth 24, (--) framebuffer bpp 32
(II) RADEON(0): Pixel depth = 24 bits stored in 4 bytes (32 bpp pixmaps)
(==) RADEON(0): Default visual is TrueColor
(==) RADEON(0): RGB weight 888
(II) RADEON(0): Using 8 bits per RGB (8 bit DAC)
(II) Loading sub module "int10"
(II) LoadModule: "int10"
(II) Loading /usr/X11R6/lib/modules/linux/libint10.a
(II) Module int10: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 1.0.0
	ABI class: X.Org Video Driver, version 0.7
(II) RADEON(0): initializing int10
(II) RADEON(0): Primary V_BIOS segment is: 0xc000
(--) RADEON(0): Chipset: "ATI Radeon Mobility M7 LW (AGP)" (ChipID = 0x4c57)
(--) RADEON(0): Linear framebuffer at 0xe0000000
(--) RADEON(0): VideoRAM: 32768 kByte (64 bit DDR SDRAM)
(II) RADEON(0): AGP card detected
(II) Loading sub module "ddc"
(II) LoadModule: "ddc"
(II) Loading /usr/X11R6/lib/modules/libddc.a
(II) Module ddc: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 1.0.0
	ABI class: X.Org Video Driver, version 0.7
(II) Loading sub module "i2c"
(II) LoadModule: "i2c"
(II) Loading /usr/X11R6/lib/modules/libi2c.a
(II) Module i2c: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 1.2.0
	ABI class: X.Org Video Driver, version 0.7
(II) RADEON(0): I2C bus "DDC" initialized.
(II) RADEON(0): Legacy BIOS detected
(II) RADEON(0): LVDS port is not in connector table, added in.
(II) RADEON(0): Connector0: DDCType-0, DACType-1, TMDSType--1, ConnectorType-1
(II) RADEON(0): Connector1: DDCType-3, DACType-0, TMDSType--1, ConnectorType-2
(II) RADEON(0): I2C device "DDC:ddc2" registered at address 0xA0.
(II) RADEON(0): I2C device "DDC:ddc2" removed.
(II) RADEON(0): I2C device "DDC:ddc2" registered at address 0xA0.
(II) RADEON(0): I2C device "DDC:ddc2" removed.
(II) RADEON(0): I2C device "DDC:ddc2" registered at address 0xA0.
(II) RADEON(0): I2C device "DDC:ddc2" removed.
(II) RADEON(0): DDC Type: 3, Detected Type: 0
(II) RADEON(0): 
(II) RADEON(0): Primary:
 Monitor   -- LVDS
 Connector -- VGA
 DAC Type  -- Primary
 TMDS Type -- NONE
 DDC Type  -- VGA_DDC
(II) RADEON(0): Secondary:
 Monitor   -- NONE
 Connector -- Proprietary
 DAC Type  -- TVDAC/ExtDAC
 TMDS Type -- NONE
 DDC Type  -- NONE
(II) RADEON(0): PLL parameters: rf=2700 rd=12 min=12000 max=35000; xclk=16600
(II) RADEON(0): Panel ID string: 1024x768                
(II) RADEON(0): Panel Size from BIOS: 1024x768
(II) RADEON(0): BIOS provided dividers will be used.
(WW) RADEON(0): Failed to detect secondary monitor, MergedFB/Clone mode disabled
(==) RADEON(0): Using gamma correction (1.0, 1.0, 1.0)
(II) RADEON(0): Validating modes on Primary head ---------
(II) RADEON(0): Total number of valid DDC mode(s) found: 0
(II) RADEON(0): Valid mode using on-chip RMX: 1024x768
(II) RADEON(0): Valid mode using on-chip RMX: 800x600
(II) RADEON(0): Valid mode using on-chip RMX: 640x480
(II) RADEON(0): Total number of valid FP mode(s) found: 3
(--) RADEON(0): Virtual size is 1024x768 (pitch 1024)
(**) RADEON(0): *Mode "1024x768": 65.0 MHz (scaled from 0.0 MHz), 48.4 kHz, 60.0 Hz
(II) RADEON(0): Modeline "1024x768"   65.00  1024 1040 1176 1344  768 770 776 806
(**) RADEON(0): *Mode "800x600": 65.0 MHz (scaled from 0.0 MHz), 48.4 kHz, 60.0 Hz
(II) RADEON(0): Modeline "800x600"   65.00  800 1040 1176 1344  600 770 776 806
(**) RADEON(0): *Mode "640x480": 65.0 MHz (scaled from 0.0 MHz), 48.4 kHz, 60.0 Hz
(II) RADEON(0): Modeline "640x480"   65.00  640 1040 1176 1344  480 770 776 806
(**) RADEON(0):  Default mode "640x350": 65.0 MHz (scaled from 0.0 MHz), 48.4 kHz, 60.0 Hz
(II) RADEON(0): Modeline "640x350"   65.00  640 1040 1176 1344  350 770 776 806
(**) RADEON(0):  Default mode "640x400": 65.0 MHz (scaled from 0.0 MHz), 48.4 kHz, 60.0 Hz
(II) RADEON(0): Modeline "640x400"   65.00  640 1040 1176 1344  400 770 776 806
(**) RADEON(0):  Default mode "720x400": 65.0 MHz (scaled from 0.0 MHz), 48.4 kHz, 60.0 Hz
(II) RADEON(0): Modeline "720x400"   65.00  720 1040 1176 1344  400 770 776 806
(**) RADEON(0):  Default mode "832x624": 65.0 MHz (scaled from 0.0 MHz), 48.4 kHz, 60.0 Hz
(II) RADEON(0): Modeline "832x624"   65.00  832 1040 1176 1344  624 770 776 806
(**) RADEON(0):  Default mode "848x480": 65.0 MHz (scaled from 0.0 MHz), 48.4 kHz, 60.0 Hz
(II) RADEON(0): Modeline "848x480"   65.00  848 1040 1176 1344  480 770 776 806
(==) RADEON(0): DPI set to (75, 75)
(II) Loading sub module "fb"
(II) LoadModule: "fb"
(II) Loading /usr/X11R6/lib/modules/libfb.a
(II) Module fb: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 1.0.0
	ABI class: X.Org ANSI C Emulation, version 0.2
(II) Loading sub module "ramdac"
(II) LoadModule: "ramdac"
(II) Loading /usr/X11R6/lib/modules/libramdac.a
(II) Module ramdac: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 0.1.0
	ABI class: X.Org Video Driver, version 0.7
(II) Loading sub module "xaa"
(II) LoadModule: "xaa"
(II) Loading /usr/X11R6/lib/modules/libxaa.a
(II) Module xaa: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 1.2.0
	ABI class: X.Org Video Driver, version 0.7
(II) RADEON(0): AGP Fast Write disabled by default
(II) RADEON(0): Depth moves disabled by default
(II) Loading sub module "shadowfb"
(II) LoadModule: "shadowfb"
(II) Loading /usr/X11R6/lib/modules/libshadowfb.a
(II) Module shadowfb: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 1.0.0
	ABI class: X.Org ANSI C Emulation, version 0.2
(II) RADEON(0): Page flipping disabled
(!!) RADEON(0): For information on using the multimedia capabilities
	of this adapter, please see http://gatos.sf.net.
(--) Depth 24 pixmap format is 32 bpp
(II) do I need RAC?  No, I don't.
(II) resource ranges after preInit:
	[0] 0	0	0xfcff0000 - 0xfcffffff (0x10000) MX[B]
	[1] 0	0	0xe0000000 - 0xe7ffffff (0x8000000) MX[B]
	[2] -1	0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[3] -1	0	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[4] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[5] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[6] -1	0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[7] -1	0	0xf8fffc00 - 0xf8fffc7f (0x80) MX[B]
	[8] -1	0	0x55000000 - 0x550003ff (0x400) MX[B]
	[9] -1	0	0xe8000000 - 0xe7ffffff (0x0) MX[B]O
	[10] -1	0	0xfcff0000 - 0xfcffffff (0x10000) MX[B](B)
	[11] -1	0	0xe0000000 - 0xe7ffffff (0x8000000) MX[B](B)
	[12] 0	0	0x000a0000 - 0x000affff (0x10000) MS[B](OprU)
	[13] 0	0	0x000b0000 - 0x000b7fff (0x8000) MS[B](OprU)
	[14] 0	0	0x000b8000 - 0x000bffff (0x8000) MS[B](OprU)
	[15] 0	0	0x0000c000 - 0x0000c0ff (0x100) IX[B]
	[16] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[17] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
	[18] -1	0	0x0000ec80 - 0x0000ecff (0x80) IX[B]
	[19] -1	0	0x0000dc00 - 0x0000dc7f (0x80) IX[B]
	[20] -1	0	0x0000d400 - 0x0000d4ff (0x100) IX[B]
	[21] -1	0	0x0000dc80 - 0x0000dcbf (0x40) IX[B]
	[22] -1	0	0x0000d800 - 0x0000d8ff (0x100) IX[B]
	[23] -1	0	0x0000bfa0 - 0x0000bfaf (0x10) IX[B]
	[24] -1	0	0x00000374 - 0x00000374 (0x1) IX[B]
	[25] -1	0	0x00000170 - 0x00000170 (0x1) IX[B]
	[26] -1	0	0x000003f4 - 0x000003f4 (0x1) IX[B]
	[27] -1	0	0x000001f0 - 0x000001f0 (0x1) IX[B]
	[28] -1	0	0x0000bf80 - 0x0000bf9f (0x20) IX[B]
	[29] -1	0	0x0000c000 - 0x0000c0ff (0x100) IX[B](B)
	[30] 0	0	0x000003b0 - 0x000003bb (0xc) IS[B](OprU)
	[31] 0	0	0x000003c0 - 0x000003df (0x20) IS[B](OprU)
(==) RADEON(0): Write-combining range (0xe0000000,0x2000000)
(II) RADEON(0): Dynamic Clock Scaling Disabled
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is 7, (OK)
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is 7, (OK)
drmOpenByBusid: Searching for BusID pci:0000:01:00.0
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is 7, (OK)
drmOpenByBusid: drmOpenMinor returns 7
drmOpenByBusid: drmGetBusid reports pci:0000:01:00.0
(II) RADEON(0): [drm] DRM interface version 1.2
(II) RADEON(0): [drm] created "radeon" driver at busid "pci:0000:01:00.0"
(II) RADEON(0): [drm] added 8192 byte SAREA at 0xf8866000
(II) RADEON(0): [drm] mapped SAREA 0xf8866000 to 0xb5e09000
(II) RADEON(0): [drm] framebuffer handle = 0xe0000000
(II) RADEON(0): [drm] added 1 reserved context for kernel
(II) RADEON(0): [agp] Mode 0x1f000201 [AGP 0x8086/0x1a30; Card 0x1002/0x4c57]
(II) RADEON(0): [agp] 8192 kB allocated with handle 0x00000001
(II) RADEON(0): [agp] ring handle = 0xe8000000
(II) RADEON(0): [agp] Ring mapped at 0xb5d08000
(II) RADEON(0): [agp] ring read ptr handle = 0xe8101000
(II) RADEON(0): [agp] Ring read ptr mapped at 0xb5d07000
(II) RADEON(0): [agp] vertex/indirect buffers handle = 0xe8102000
(II) RADEON(0): [agp] Vertex/indirect buffers mapped at 0xb5b07000
(II) RADEON(0): [agp] GART texture map handle = 0xe8302000
(II) RADEON(0): [agp] GART Texture map mapped at 0xb5627000
(II) RADEON(0): [drm] register handle = 0xfcff0000
(II) RADEON(0): [dri] Visual configs initialized
(II) RADEON(0): CP in BM mode
(II) RADEON(0): Using 8 MB GART aperture
(II) RADEON(0): Using 1 MB for the ring buffer
(II) RADEON(0): Using 2 MB for vertex/indirect buffers
(II) RADEON(0): Using 5 MB for GART textures
(II) RADEON(0): Memory manager initialized to (0,0) (1024,8191)
(II) RADEON(0): Reserved area from (0,768) to (1024,770)
(II) RADEON(0): Largest offscreen area available: 1024 x 7421
(II) RADEON(0): Will use back buffer at offset 0x900000
(II) RADEON(0): Will use depth buffer at offset 0xc00000
(II) RADEON(0): Will use 17408 kb for textures at offset 0xf00000
(II) RADEON(0): Render acceleration disabled
(II) RADEON(0): Using XFree86 Acceleration Architecture (XAA)
	Screen to screen bit blits
	Solid filled rectangles
	8x8 mono pattern filled rectangles
	Indirect CPU to Screen color expansion
	Solid Lines
	Scanline Image Writes
	Offscreen Pixmaps
	Setting up tile and stipple cache:
		32 128x128 slots
		32 256x256 slots
		16 512x512 slots
(II) RADEON(0): Acceleration enabled
(==) RADEON(0): Backing store disabled
(==) RADEON(0): Silken mouse enabled
(II) RADEON(0): Using hardware cursor (scanline 770)
(II) RADEON(0): Largest offscreen area available: 1024 x 7417
(**) Option "dpms"
(**) RADEON(0): DPMS enabled
(II) RADEON(0): X context handle = 0x00000001
(II) RADEON(0): [drm] installed DRM signal handler
(II) RADEON(0): [DRI] installation complete
(II) RADEON(0): [drm] Added 32 65536 byte vertex/indirect buffers
(II) RADEON(0): [drm] Mapped 32 vertex/indirect buffers
(II) RADEON(0): [drm] dma control initialized, using IRQ 11
(II) RADEON(0): [drm] Initialized kernel GART heap manager, 5111808
(II) RADEON(0): Direct rendering enabled
(==) RandR enabled
(II) Initializing built-in extension MIT-SHM
(II) Initializing built-in extension XInputExtension
(II) Initializing built-in extension XTEST
(II) Initializing built-in extension XKEYBOARD
(II) Initializing built-in extension LBX
(II) Initializing built-in extension XC-APPGROUP
(II) Initializing built-in extension SECURITY
(II) Initializing built-in extension XINERAMA
(II) Initializing built-in extension XFIXES
(II) Initializing built-in extension XFree86-Bigfont
(II) Initializing built-in extension RENDER
(II) Initializing built-in extension RANDR
(II) Initializing built-in extension COMPOSITE
(II) Initializing built-in extension DAMAGE
(II) Initializing built-in extension XEVIE
(**) Option "Protocol" "IMPS/2"
(**) Mouse0: Device: "/dev/input/mice"
(**) Mouse0: Protocol: "IMPS/2"
(**) Option "CorePointer"
(**) Mouse0: Core Pointer
(**) Option "Device" "/dev/input/mice"
(**) Option "Emulate3Buttons" "yes"
(**) Mouse0: Emulate3Buttons, Emulate3Timeout: 50
(**) Option "ZAxisMapping" "4 5"
(**) Mouse0: ZAxisMapping: buttons 4 and 5
(**) Mouse0: Buttons: 5
(**) Option "CoreKeyboard"
(**) Keyboard0: Core Keyboard
(**) Option "Protocol" "standard"
(**) Keyboard0: Protocol: standard
(**) Option "AutoRepeat" "500 30"
(**) Option "XkbRules" "xorg"
(**) Keyboard0: XkbRules: "xorg"
(**) Option "XkbModel" "pc105"
(**) Keyboard0: XkbModel: "pc105"
(**) Option "XkbLayout" "us"
(**) Keyboard0: XkbLayout: "us"
(**) Option "CustomKeycodes" "off"
(**) Keyboard0: CustomKeycodes disabled
(II) Synaptics touchpad driver version 0.14.0
(--) Synaptics auto-dev sets device to /dev/input/event1
(**) Option "Device" "/dev/input/event1"
(--) Synaptics touchpad found
(**) Option "AlwaysCore"
(**) Synaptics: always reports core events
(II) XINPUT: Adding extended input device "Synaptics" (type: MOUSE)
(II) XINPUT: Adding extended input device "Keyboard0" (type: KEYBOARD)
(II) XINPUT: Adding extended input device "Mouse0" (type: MOUSE)
Synaptics DeviceInit called
SynapticsCtrl called.
(II) Mouse0: ps2EnableDataReporting: succeeded
Synaptics DeviceOn called
(--) Synaptics touchpad found

------=_Part_13915_32800839.1130329337542
Content-Type: application/octet-stream; name=Xorg.0.log.bad
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="Xorg.0.log.bad"

_XSERVTransSocketOpenCOTSServer: Unable to open socket for inet6
_XSERVTransOpen: transport open failed for inet6/incident:0
_XSERVTransMakeAllCOTSServerListeners: failed to open listener for inet6

X Window System Version 6.8.2
Release Date: 9 February 2005
X Protocol Version 11, Revision 0, Release 6.8.2
Build Operating System: Linux 2.6.9-22.ELsmp i686 [ELF] 
Current Operating System: Linux incident 2.6.14-rc5-git5 #1 PREEMPT Tue Oct 25 14:32:46 CEST 2005 i686
Build Date: 21 September 2005
Build Host: hs20-bc1-6.build.redhat.com
 
	Before reporting problems, check http://wiki.X.Org
	to make sure that you have the latest version.
Module Loader present
OS Kernel: Linux version 2.6.14-rc5-git5 (asuardi@incident) (gcc version 4.0.2) #1 PREEMPT Tue Oct 25 14:32:46 CEST 2005 
Markers: (--) probed, (**) from config file, (==) default setting,
	(++) from command line, (!!) notice, (II) informational,
	(WW) warning, (EE) error, (NI) not implemented, (??) unknown.
(==) Log file: "/var/log/Xorg.0.log", Time: Wed Oct 26 14:13:12 2005
(==) Using config file: "/etc/X11/xorg.conf"
(==) ServerLayout "Default Layout"
(**) |-->Screen "Screen0" (0)
(**) |   |-->Monitor "Monitor0"
(**) |   |-->Device "Videocard0"
(**) |-->Input Device "Mouse0"
(**) |-->Input Device "Keyboard0"
(**) |-->Input Device "Synaptics"
(**) FontPath set to "unix/:7100"
(**) RgbPath set to "/usr/X11R6/lib/X11/rgb"
(==) ModulePath set to "/usr/X11R6/lib/modules"
(WW) Open APM failed (/dev/apm_bios) (No such file or directory)
(II) Module ABI versions:
	X.Org ANSI C Emulation: 0.2
	X.Org Video Driver: 0.7
	X.Org XInput driver : 0.4
	X.Org Server Extension : 0.2
	X.Org Font Renderer : 0.4
(II) Loader running on linux
(II) LoadModule: "bitmap"
(II) Loading /usr/X11R6/lib/modules/fonts/libbitmap.a
(II) Module bitmap: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 1.0.0
	Module class: X.Org Font Renderer
	ABI class: X.Org Font Renderer, version 0.4
(II) Loading font Bitmap
(II) LoadModule: "pcidata"
(II) Loading /usr/X11R6/lib/modules/libpcidata.a
(II) Module pcidata: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 1.0.0
	ABI class: X.Org Video Driver, version 0.7
(--) using VT number 7

(II) PCI: PCI scan (all values are in hex)
(II) PCI: 00:00:0: chip 8086,1a30 card 0000,0000 rev 04 class 06,00,00 hdr 00
(II) PCI: 00:01:0: chip 8086,1a31 card 0000,0000 rev 04 class 06,04,00 hdr 01
(II) PCI: 00:1d:0: chip 8086,2482 card 8086,4541 rev 02 class 0c,03,00 hdr 00
(II) PCI: 00:1e:0: chip 8086,2448 card 0000,0000 rev 42 class 06,04,00 hdr 01
(II) PCI: 00:1f:0: chip 8086,248c card 0000,0000 rev 02 class 06,01,00 hdr 80
(II) PCI: 00:1f:1: chip 8086,248a card 8086,4541 rev 02 class 01,01,8a hdr 00
(II) PCI: 00:1f:5: chip 8086,2485 card 1013,5959 rev 02 class 04,01,00 hdr 00
(II) PCI: 00:1f:6: chip 8086,2486 card 134d,4c21 rev 02 class 07,03,00 hdr 00
(II) PCI: 01:00:0: chip 1002,4c57 card 1028,012a rev 00 class 03,00,00 hdr 00
(II) PCI: 02:00:0: chip 10b7,9200 card 1028,012a rev 78 class 02,00,00 hdr 00
(II) PCI: 02:01:0: chip 104c,ac51 card e000,0000 rev 00 class 06,07,00 hdr 82
(II) PCI: 02:01:1: chip 104c,ac51 card e800,0000 rev 00 class 06,07,00 hdr 82
(II) PCI: End of PCI scan
(II) Host-to-PCI bridge:
(II) Bus 0: bridge is at (0:0:0), (0,0,7), BCTRL: 0x0008 (VGA_EN is set)
(II) Bus 0 I/O range:
	[0] -1	0	0x00000000 - 0x0000ffff (0x10000) IX[B]
(II) Bus 0 non-prefetchable memory range:
	[0] -1	0	0x00000000 - 0xffffffff (0x0) MX[B]
(II) Bus 0 prefetchable memory range:
	[0] -1	0	0x00000000 - 0xffffffff (0x0) MX[B]
(II) PCI-to-PCI bridge:
(II) Bus 1: bridge is at (0:1:0), (0,1,1), BCTRL: 0x000e (VGA_EN is set)
(II) Bus 1 I/O range:
	[0] -1	0	0x0000c000 - 0x0000c0ff (0x100) IX[B]
	[1] -1	0	0x0000c400 - 0x0000c4ff (0x100) IX[B]
	[2] -1	0	0x0000c800 - 0x0000c8ff (0x100) IX[B]
	[3] -1	0	0x0000cc00 - 0x0000ccff (0x100) IX[B]
(II) Bus 1 non-prefetchable memory range:
	[0] -1	0	0xfc000000 - 0xfdffffff (0x2000000) MX[B]
(II) Bus 1 prefetchable memory range:
	[0] -1	0	0xe0000000 - 0xe7ffffff (0x8000000) MX[B]
(II) PCI-to-PCI bridge:
(II) Bus 2: bridge is at (0:30:0), (0,2,16), BCTRL: 0x0006 (VGA_EN is cleared)
(II) Bus 2 I/O range:
	[0] -1	0	0x0000e000 - 0x0000e0ff (0x100) IX[B]
	[1] -1	0	0x0000e400 - 0x0000e4ff (0x100) IX[B]
	[2] -1	0	0x0000e800 - 0x0000e8ff (0x100) IX[B]
	[3] -1	0	0x0000ec00 - 0x0000ecff (0x100) IX[B]
	[4] -1	0	0x0000f000 - 0x0000f0ff (0x100) IX[B]
	[5] -1	0	0x0000f400 - 0x0000f4ff (0x100) IX[B]
	[6] -1	0	0x0000f800 - 0x0000f8ff (0x100) IX[B]
	[7] -1	0	0x0000fc00 - 0x0000fcff (0x100) IX[B]
(II) Bus 2 non-prefetchable memory range:
	[0] -1	0	0xf4000000 - 0xfbffffff (0x8000000) MX[B]
(II) Bus 2 prefetchable memory range:
	[0] -1	0	0x50000000 - 0x54ffffff (0x5000000) MX[B]
(II) PCI-to-ISA bridge:
(II) Bus -1: bridge is at (0:31:0), (0,-1,-1), BCTRL: 0x0008 (VGA_EN is set)
(II) PCI-to-CardBus bridge:
(II) Bus 3: bridge is at (2:1:0), (2,3,6), BCTRL: 0x05c0 (VGA_EN is cleared)
(II) Bus 3 I/O range:
	[0] -1	0	0x0000e000 - 0x0000e0ff (0x100) IX[B]
	[1] -1	0	0x0000e400 - 0x0000e4ff (0x100) IX[B]
(II) Bus 3 non-prefetchable memory range:
	[0] -1	0	0xf4000000 - 0xf5ffffff (0x2000000) MX[B]
(II) Bus 3 prefetchable memory range:
	[0] -1	0	0x50000000 - 0x51ffffff (0x2000000) MX[B]
(II) PCI-to-CardBus bridge:
(II) Bus 7: bridge is at (2:1:1), (2,7,10), BCTRL: 0x05c0 (VGA_EN is cleared)
(II) Bus 7 I/O range:
	[0] -1	0	0x0000e800 - 0x0000e8ff (0x100) IX[B]
(II) Bus 7 non-prefetchable memory range:
	[0] -1	0	0xf6000000 - 0xf7ffffff (0x2000000) MX[B]
(II) Bus 7 prefetchable memory range:
	[0] -1	0	0x52000000 - 0x53ffffff (0x2000000) MX[B]
(--) PCI:*(1:0:0) ATI Technologies Inc Radeon Mobility M7 LW [Radeon Mobility 7500] rev 0, Mem @ 0xe0000000/27, 0xfcff0000/16, I/O @ 0xc000/8
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
(II) PCI Memory resource overlap reduced 0xe8000000 from 0xebffffff to 0xe7ffffff
(II) Active PCI resource ranges:
	[0] -1	0	0xf8fffc00 - 0xf8fffc7f (0x80) MX[B]
	[1] -1	0	0x55000000 - 0x550003ff (0x400) MX[B]
	[2] -1	0	0xe8000000 - 0xe7ffffff (0x0) MX[B]O
	[3] -1	0	0xfcff0000 - 0xfcffffff (0x10000) MX[B](B)
	[4] -1	0	0xe0000000 - 0xe7ffffff (0x8000000) MX[B](B)
	[5] -1	0	0x0000ec80 - 0x0000ecff (0x80) IX[B]
	[6] -1	0	0x0000dc00 - 0x0000dc7f (0x80) IX[B]
	[7] -1	0	0x0000d400 - 0x0000d4ff (0x100) IX[B]
	[8] -1	0	0x0000dc80 - 0x0000dcbf (0x40) IX[B]
	[9] -1	0	0x0000d800 - 0x0000d8ff (0x100) IX[B]
	[10] -1	0	0x0000bfa0 - 0x0000bfaf (0x10) IX[B]
	[11] -1	0	0x00000374 - 0x00000374 (0x1) IX[B]
	[12] -1	0	0x00000170 - 0x00000170 (0x1) IX[B]
	[13] -1	0	0x000003f4 - 0x000003f4 (0x1) IX[B]
	[14] -1	0	0x000001f0 - 0x000001f0 (0x1) IX[B]
	[15] -1	0	0x0000bf80 - 0x0000bf9f (0x20) IX[B]
	[16] -1	0	0x0000c000 - 0x0000c0ff (0x100) IX[B](B)
(II) Active PCI resource ranges after removing overlaps:
	[0] -1	0	0xf8fffc00 - 0xf8fffc7f (0x80) MX[B]
	[1] -1	0	0x55000000 - 0x550003ff (0x400) MX[B]
	[2] -1	0	0xe8000000 - 0xe7ffffff (0x0) MX[B]O
	[3] -1	0	0xfcff0000 - 0xfcffffff (0x10000) MX[B](B)
	[4] -1	0	0xe0000000 - 0xe7ffffff (0x8000000) MX[B](B)
	[5] -1	0	0x0000ec80 - 0x0000ecff (0x80) IX[B]
	[6] -1	0	0x0000dc00 - 0x0000dc7f (0x80) IX[B]
	[7] -1	0	0x0000d400 - 0x0000d4ff (0x100) IX[B]
	[8] -1	0	0x0000dc80 - 0x0000dcbf (0x40) IX[B]
	[9] -1	0	0x0000d800 - 0x0000d8ff (0x100) IX[B]
	[10] -1	0	0x0000bfa0 - 0x0000bfaf (0x10) IX[B]
	[11] -1	0	0x00000374 - 0x00000374 (0x1) IX[B]
	[12] -1	0	0x00000170 - 0x00000170 (0x1) IX[B]
	[13] -1	0	0x000003f4 - 0x000003f4 (0x1) IX[B]
	[14] -1	0	0x000001f0 - 0x000001f0 (0x1) IX[B]
	[15] -1	0	0x0000bf80 - 0x0000bf9f (0x20) IX[B]
	[16] -1	0	0x0000c000 - 0x0000c0ff (0x100) IX[B](B)
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
	[5] -1	0	0xf8fffc00 - 0xf8fffc7f (0x80) MX[B]
	[6] -1	0	0x55000000 - 0x550003ff (0x400) MX[B]
	[7] -1	0	0xe8000000 - 0xe7ffffff (0x0) MX[B]O
	[8] -1	0	0xfcff0000 - 0xfcffffff (0x10000) MX[B](B)
	[9] -1	0	0xe0000000 - 0xe7ffffff (0x8000000) MX[B](B)
	[10] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[11] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
	[12] -1	0	0x0000ec80 - 0x0000ecff (0x80) IX[B]
	[13] -1	0	0x0000dc00 - 0x0000dc7f (0x80) IX[B]
	[14] -1	0	0x0000d400 - 0x0000d4ff (0x100) IX[B]
	[15] -1	0	0x0000dc80 - 0x0000dcbf (0x40) IX[B]
	[16] -1	0	0x0000d800 - 0x0000d8ff (0x100) IX[B]
	[17] -1	0	0x0000bfa0 - 0x0000bfaf (0x10) IX[B]
	[18] -1	0	0x00000374 - 0x00000374 (0x1) IX[B]
	[19] -1	0	0x00000170 - 0x00000170 (0x1) IX[B]
	[20] -1	0	0x000003f4 - 0x000003f4 (0x1) IX[B]
	[21] -1	0	0x000001f0 - 0x000001f0 (0x1) IX[B]
	[22] -1	0	0x0000bf80 - 0x0000bf9f (0x20) IX[B]
	[23] -1	0	0x0000c000 - 0x0000c0ff (0x100) IX[B](B)
(II) LoadModule: "dbe"
(II) Loading /usr/X11R6/lib/modules/extensions/libdbe.a
(II) Module dbe: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 1.0.0
	Module class: X.Org Server Extension
	ABI class: X.Org Server Extension, version 0.2
(II) Loading extension DOUBLE-BUFFER
(II) LoadModule: "extmod"
(II) Loading /usr/X11R6/lib/modules/extensions/libextmod.a
(II) Module extmod: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 1.0.0
	Module class: X.Org Server Extension
	ABI class: X.Org Server Extension, version 0.2
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
(II) Loading extension TOG-CUP
(II) Loading extension Extended-Visual-Information
(II) Loading extension XVideo
(II) Loading extension XVideo-MotionCompensation
(II) Loading extension X-Resource
(II) LoadModule: "fbdevhw"
(II) Loading /usr/X11R6/lib/modules/linux/libfbdevhw.a
(II) Module fbdevhw: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 0.0.2
	ABI class: X.Org Video Driver, version 0.7
(II) LoadModule: "glx"
(II) Loading /usr/X11R6/lib/modules/extensions/libglx.a
(II) Module glx: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 1.0.0
	ABI class: X.Org Server Extension, version 0.2
(II) Loading sub module "GLcore"
(II) LoadModule: "GLcore"
(II) Loading /usr/X11R6/lib/modules/extensions/libGLcore.a
(II) Module GLcore: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 1.0.0
	ABI class: X.Org Server Extension, version 0.2
(II) Loading extension GLX
(II) LoadModule: "record"
(II) Loading /usr/X11R6/lib/modules/extensions/librecord.a
(II) Module record: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 1.13.0
	Module class: X.Org Server Extension
	ABI class: X.Org Server Extension, version 0.2
(II) Loading extension RECORD
(II) LoadModule: "freetype"
(II) Loading /usr/X11R6/lib/modules/fonts/libfreetype.so
(II) Module freetype: vendor="X.Org Foundation & the After X-TT Project"
	compiled for 6.8.2, module version = 2.1.0
	Module class: X.Org Font Renderer
	ABI class: X.Org Font Renderer, version 0.4
(II) Loading font FreeType
(II) LoadModule: "type1"
(II) Loading /usr/X11R6/lib/modules/fonts/libtype1.a
(II) Module type1: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 1.0.2
	Module class: X.Org Font Renderer
	ABI class: X.Org Font Renderer, version 0.4
(II) Loading font Type1
(II) Loading font CID
(II) LoadModule: "synaptics"
(II) Loading /usr/X11R6/lib/modules/input/synaptics_drv.o
(II) Module synaptics: vendor="X.Org Foundation"
	compiled for 4.3.99.902, module version = 1.0.0
	Module class: X.Org XInput Driver
	ABI class: X.Org XInput driver, version 0.4
(II) LoadModule: "dri"
(II) Loading /usr/X11R6/lib/modules/extensions/libdri.a
(II) Module dri: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 1.0.0
	ABI class: X.Org Server Extension, version 0.2
(II) Loading sub module "drm"
(II) LoadModule: "drm"
(II) Loading /usr/X11R6/lib/modules/linux/libdrm.a
(II) Module drm: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 1.0.0
	ABI class: X.Org Server Extension, version 0.2
(II) Loading extension XFree86-DRI
(II) LoadModule: "radeon"
(II) Loading /usr/X11R6/lib/modules/drivers/radeon_drv.o
(II) Module radeon: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 4.0.1
	Module class: X.Org Video Driver
	ABI class: X.Org Video Driver, version 0.7
(II) LoadModule: "ati"
(II) Loading /usr/X11R6/lib/modules/drivers/ati_drv.o
(II) Module ati: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 6.5.6
	Module class: X.Org Video Driver
	ABI class: X.Org Video Driver, version 0.7
(II) LoadModule: "mouse"
(II) Loading /usr/X11R6/lib/modules/input/mouse_drv.o
(II) Module mouse: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 1.0.0
	Module class: X.Org XInput Driver
	ABI class: X.Org XInput driver, version 0.4
(II) LoadModule: "kbd"
(II) Loading /usr/X11R6/lib/modules/input/kbd_drv.o
(II) Module kbd: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 1.0.0
	Module class: X.Org XInput Driver
	ABI class: X.Org XInput driver, version 0.4
(II) LoadModule: "synaptics"
(II) Reloading /usr/X11R6/lib/modules/input/synaptics_drv.o
(II) ATI: ATI driver (version 6.5.6) for chipsets: ati, ativga
(II) R128: Driver for ATI Rage 128 chipsets:
	ATI Rage 128 Mobility M3 LE (PCI), ATI Rage 128 Mobility M3 LF (AGP),
	ATI Rage 128 Mobility M4 MF (AGP), ATI Rage 128 Mobility M4 ML (AGP),
	ATI Rage 128 Pro GL PA (PCI/AGP), ATI Rage 128 Pro GL PB (PCI/AGP),
	ATI Rage 128 Pro GL PC (PCI/AGP), ATI Rage 128 Pro GL PD (PCI),
	ATI Rage 128 Pro GL PE (PCI/AGP), ATI Rage 128 Pro GL PF (AGP),
	ATI Rage 128 Pro VR PG (PCI/AGP), ATI Rage 128 Pro VR PH (PCI/AGP),
	ATI Rage 128 Pro VR PI (PCI/AGP), ATI Rage 128 Pro VR PJ (PCI/AGP),
	ATI Rage 128 Pro VR PK (PCI/AGP), ATI Rage 128 Pro VR PL (PCI/AGP),
	ATI Rage 128 Pro VR PM (PCI/AGP), ATI Rage 128 Pro VR PN (PCI/AGP),
	ATI Rage 128 Pro VR PO (PCI/AGP), ATI Rage 128 Pro VR PP (PCI),
	ATI Rage 128 Pro VR PQ (PCI/AGP), ATI Rage 128 Pro VR PR (PCI),
	ATI Rage 128 Pro VR PS (PCI/AGP), ATI Rage 128 Pro VR PT (PCI/AGP),
	ATI Rage 128 Pro VR PU (PCI/AGP), ATI Rage 128 Pro VR PV (PCI/AGP),
	ATI Rage 128 Pro VR PW (PCI/AGP), ATI Rage 128 Pro VR PX (PCI/AGP),
	ATI Rage 128 GL RE (PCI), ATI Rage 128 GL RF (AGP),
	ATI Rage 128 RG (AGP), ATI Rage 128 VR RK (PCI),
	ATI Rage 128 VR RL (AGP), ATI Rage 128 4X SE (PCI/AGP),
	ATI Rage 128 4X SF (PCI/AGP), ATI Rage 128 4X SG (PCI/AGP),
	ATI Rage 128 4X SH (PCI/AGP), ATI Rage 128 4X SK (PCI/AGP),
	ATI Rage 128 4X SL (PCI/AGP), ATI Rage 128 4X SM (AGP),
	ATI Rage 128 4X SN (PCI/AGP), ATI Rage 128 Pro ULTRA TF (AGP),
	ATI Rage 128 Pro ULTRA TL (AGP), ATI Rage 128 Pro ULTRA TR (AGP),
	ATI Rage 128 Pro ULTRA TS (AGP?), ATI Rage 128 Pro ULTRA TT (AGP?),
	ATI Rage 128 Pro ULTRA TU (AGP?)
(II) RADEON: Driver for ATI Radeon chipsets: ATI Radeon QD (AGP),
	ATI Radeon QE (AGP), ATI Radeon QF (AGP), ATI Radeon QG (AGP),
	ATI Radeon VE/7000 QY (AGP/PCI), ATI Radeon VE/7000 QZ (AGP/PCI),
	ATI Radeon Mobility M7 LW (AGP),
	ATI Mobility FireGL 7800 M7 LX (AGP),
	ATI Radeon Mobility M6 LY (AGP), ATI Radeon Mobility M6 LZ (AGP),
	ATI Radeon IGP320 (A3) 4136, ATI Radeon IGP320M (U1) 4336,
	ATI Radeon IGP330/340/350 (A4) 4137,
	ATI Radeon IGP330M/340M/350M (U2) 4337,
	ATI Radeon 7000 IGP (A4+) 4237, ATI Radeon Mobility 7000 IGP 4437,
	ATI FireGL 8700/8800 QH (AGP), ATI Radeon 8500 QL (AGP),
	ATI Radeon 9100 QM (AGP), ATI Radeon 8500 AIW BB (AGP),
	ATI Radeon 8500 AIW BC (AGP), ATI Radeon 7500 QW (AGP/PCI),
	ATI Radeon 7500 QX (AGP/PCI), ATI Radeon 9000/PRO If (AGP/PCI),
	ATI Radeon 9000 Ig (AGP/PCI), ATI FireGL Mobility 9000 (M9) Ld (AGP),
	ATI Radeon Mobility 9000 (M9) Lf (AGP),
	ATI Radeon Mobility 9000 (M9) Lg (AGP),
	ATI Radeon 9100 IGP (A5) 5834,
	ATI Radeon Mobility 9100 IGP (U3) 5835, ATI Radeon 9100 PRO IGP 7834,
	ATI Radeon Mobility 9200 IGP 7835, ATI Radeon 9200PRO 5960 (AGP),
	ATI Radeon 9200 5961 (AGP), ATI Radeon 9200 5962 (AGP),
	ATI Radeon 9200SE 5964 (AGP),
	ATI Radeon Mobility 9200 (M9+) 5C61 (AGP),
	ATI Radeon Mobility 9200 (M9+) 5C63 (AGP), ATI Radeon 9500 AD (AGP),
	ATI Radeon 9500 AE (AGP), ATI Radeon 9600TX AF (AGP),
	ATI FireGL Z1 AG (AGP), ATI Radeon 9700 Pro ND (AGP),
	ATI Radeon 9700/9500Pro NE (AGP), ATI Radeon 9700 NF (AGP),
	ATI FireGL X1 NG (AGP), ATI Radeon 9600 AP (AGP),
	ATI Radeon 9600SE AQ (AGP), ATI Radeon 9600XT AR (AGP),
	ATI Radeon 9600 AS (AGP), ATI FireGL T2 AT (AGP),
	ATI FireGL RV360 AV (AGP),
	ATI Radeon Mobility 9600/9700 (M10/M11) NP (AGP),
	ATI Radeon Mobility 9600 (M10) NQ (AGP),
	ATI Radeon Mobility 9600 (M11) NR (AGP),
	ATI Radeon Mobility 9600 (M10) NS (AGP),
	ATI FireGL Mobility T2 (M10) NT (AGP),
	ATI FireGL Mobility T2e (M11) NV (AGP), ATI Radeon 9800SE AH (AGP),
	ATI Radeon 9800 AI (AGP), ATI Radeon 9800 AJ (AGP),
	ATI FireGL X2 AK (AGP), ATI Radeon 9800PRO NH (AGP),
	ATI Radeon 9800 NI (AGP), ATI FireGL X2 NK (AGP),
	ATI Radeon 9800XT NJ (AGP), ATI Radeon X600 (RV380) 3E50 (PCIE),
	ATI FireGL V3200 (RV380) 3E54 (PCIE),
	ATI Radeon Mobility X600 (M24) 3150 (PCIE),
	ATI FireGL M24 GL 3154 (PCIE), ATI Radeon X300 (RV370) 5B60 (PCIE),
	ATI Radeon X600 (RV370) 5B62 (PCIE),
	ATI FireGL V3100 (RV370) 5B64 (PCIE),
	ATI FireGL D1100 (RV370) 5B65 (PCIE),
	ATI Radeon Mobility M300 (M22) 5460 (PCIE),
	ATI FireGL M22 GL 5464 (PCIE), ATI Radeon X800 (R420) JH (AGP),
	ATI Radeon X800PRO (R420) JI (AGP),
	ATI Radeon X800SE (R420) JJ (AGP), ATI Radeon X800 (R420) JK (AGP),
	ATI Radeon X800 (R420) JL (AGP), ATI FireGL X3 (R420) JM (AGP),
	ATI Radeon Mobility 9800 (M18) JN (AGP),
	ATI Radeon X800XT (R420) JP (AGP), ATI Radeon X800 (R423) UH (PCIE),
	ATI Radeon X800PRO (R423) UI (PCIE),
	ATI Radeon X800LE (R423) UJ (PCIE),
	ATI Radeon X800SE (R423) UK (PCIE),
	ATI FireGL V7200 (R423) UQ (PCIE), ATI FireGL V5100 (R423) UR (PCIE),
	ATI FireGL V7100 (R423) UT (PCIE),
	ATI Radeon X800XT (R423) 5D57 (PCIE)
(II) Primary Device is: PCI 01:00:0
(--) Assigning device section with no busID to primary device
(--) Chipset ATI Radeon Mobility M7 LW (AGP) found
(II) resource ranges after xf86ClaimFixedResources() call:
	[0] -1	0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1	0	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[2] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1	0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[5] -1	0	0xf8fffc00 - 0xf8fffc7f (0x80) MX[B]
	[6] -1	0	0x55000000 - 0x550003ff (0x400) MX[B]
	[7] -1	0	0xe8000000 - 0xe7ffffff (0x0) MX[B]O
	[8] -1	0	0xfcff0000 - 0xfcffffff (0x10000) MX[B](B)
	[9] -1	0	0xe0000000 - 0xe7ffffff (0x8000000) MX[B](B)
	[10] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[11] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
	[12] -1	0	0x0000ec80 - 0x0000ecff (0x80) IX[B]
	[13] -1	0	0x0000dc00 - 0x0000dc7f (0x80) IX[B]
	[14] -1	0	0x0000d400 - 0x0000d4ff (0x100) IX[B]
	[15] -1	0	0x0000dc80 - 0x0000dcbf (0x40) IX[B]
	[16] -1	0	0x0000d800 - 0x0000d8ff (0x100) IX[B]
	[17] -1	0	0x0000bfa0 - 0x0000bfaf (0x10) IX[B]
	[18] -1	0	0x00000374 - 0x00000374 (0x1) IX[B]
	[19] -1	0	0x00000170 - 0x00000170 (0x1) IX[B]
	[20] -1	0	0x000003f4 - 0x000003f4 (0x1) IX[B]
	[21] -1	0	0x000001f0 - 0x000001f0 (0x1) IX[B]
	[22] -1	0	0x0000bf80 - 0x0000bf9f (0x20) IX[B]
	[23] -1	0	0x0000c000 - 0x0000c0ff (0x100) IX[B](B)
(II) Loading sub module "radeon"
(II) LoadModule: "radeon"
(II) Reloading /usr/X11R6/lib/modules/drivers/radeon_drv.o
(II) resource ranges after probing:
	[0] -1	0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1	0	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[2] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1	0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[5] -1	0	0xf8fffc00 - 0xf8fffc7f (0x80) MX[B]
	[6] -1	0	0x55000000 - 0x550003ff (0x400) MX[B]
	[7] -1	0	0xe8000000 - 0xe7ffffff (0x0) MX[B]O
	[8] -1	0	0xfcff0000 - 0xfcffffff (0x10000) MX[B](B)
	[9] -1	0	0xe0000000 - 0xe7ffffff (0x8000000) MX[B](B)
	[10] 0	0	0x000a0000 - 0x000affff (0x10000) MS[B]
	[11] 0	0	0x000b0000 - 0x000b7fff (0x8000) MS[B]
	[12] 0	0	0x000b8000 - 0x000bffff (0x8000) MS[B]
	[13] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[14] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
	[15] -1	0	0x0000ec80 - 0x0000ecff (0x80) IX[B]
	[16] -1	0	0x0000dc00 - 0x0000dc7f (0x80) IX[B]
	[17] -1	0	0x0000d400 - 0x0000d4ff (0x100) IX[B]
	[18] -1	0	0x0000dc80 - 0x0000dcbf (0x40) IX[B]
	[19] -1	0	0x0000d800 - 0x0000d8ff (0x100) IX[B]
	[20] -1	0	0x0000bfa0 - 0x0000bfaf (0x10) IX[B]
	[21] -1	0	0x00000374 - 0x00000374 (0x1) IX[B]
	[22] -1	0	0x00000170 - 0x00000170 (0x1) IX[B]
	[23] -1	0	0x000003f4 - 0x000003f4 (0x1) IX[B]
	[24] -1	0	0x000001f0 - 0x000001f0 (0x1) IX[B]
	[25] -1	0	0x0000bf80 - 0x0000bf9f (0x20) IX[B]
	[26] -1	0	0x0000c000 - 0x0000c0ff (0x100) IX[B](B)
	[27] 0	0	0x000003b0 - 0x000003bb (0xc) IS[B]
	[28] 0	0	0x000003c0 - 0x000003df (0x20) IS[B]
(II) Setting vga for screen 0.
(II) RADEON(0): MMIO registers at 0xfcff0000
(II) Loading sub module "vgahw"
(II) LoadModule: "vgahw"
(II) Loading /usr/X11R6/lib/modules/libvgahw.a
(II) Module vgahw: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 0.1.0
	ABI class: X.Org Video Driver, version 0.7
(II) RADEON(0): vgaHWGetIOBase: hwp->IOBase is 0x03d0, hwp->PIOOffset is 0x0000
(II) RADEON(0): PCI bus 1 card 0 func 0
(**) RADEON(0): Depth 24, (--) framebuffer bpp 32
(II) RADEON(0): Pixel depth = 24 bits stored in 4 bytes (32 bpp pixmaps)
(==) RADEON(0): Default visual is TrueColor
(==) RADEON(0): RGB weight 888
(II) RADEON(0): Using 8 bits per RGB (8 bit DAC)
(II) Loading sub module "int10"
(II) LoadModule: "int10"
(II) Loading /usr/X11R6/lib/modules/linux/libint10.a
(II) Module int10: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 1.0.0
	ABI class: X.Org Video Driver, version 0.7
(II) RADEON(0): initializing int10
(II) RADEON(0): Primary V_BIOS segment is: 0xc000
(--) RADEON(0): Chipset: "ATI Radeon Mobility M7 LW (AGP)" (ChipID = 0x4c57)
(--) RADEON(0): Linear framebuffer at 0xe0000000
(--) RADEON(0): VideoRAM: 32768 kByte (64 bit DDR SDRAM)
(II) RADEON(0): AGP card detected
(II) Loading sub module "ddc"
(II) LoadModule: "ddc"
(II) Loading /usr/X11R6/lib/modules/libddc.a
(II) Module ddc: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 1.0.0
	ABI class: X.Org Video Driver, version 0.7
(II) Loading sub module "i2c"
(II) LoadModule: "i2c"
(II) Loading /usr/X11R6/lib/modules/libi2c.a
(II) Module i2c: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 1.2.0
	ABI class: X.Org Video Driver, version 0.7
(II) RADEON(0): I2C bus "DDC" initialized.
(II) RADEON(0): Legacy BIOS detected
(II) RADEON(0): LVDS port is not in connector table, added in.
(II) RADEON(0): Connector0: DDCType-0, DACType-1, TMDSType--1, ConnectorType-1
(II) RADEON(0): Connector1: DDCType-3, DACType-0, TMDSType--1, ConnectorType-2
(II) RADEON(0): I2C device "DDC:ddc2" registered at address 0xA0.
(II) RADEON(0): I2C device "DDC:ddc2" removed.
(II) RADEON(0): I2C device "DDC:ddc2" registered at address 0xA0.
(II) RADEON(0): I2C device "DDC:ddc2" removed.
(II) RADEON(0): I2C device "DDC:ddc2" registered at address 0xA0.
(II) RADEON(0): I2C device "DDC:ddc2" removed.
(II) RADEON(0): DDC Type: 3, Detected Type: 0
(II) RADEON(0): 
(II) RADEON(0): Primary:
 Monitor   -- LVDS
 Connector -- VGA
 DAC Type  -- Primary
 TMDS Type -- NONE
 DDC Type  -- VGA_DDC
(II) RADEON(0): Secondary:
 Monitor   -- NONE
 Connector -- Proprietary
 DAC Type  -- TVDAC/ExtDAC
 TMDS Type -- NONE
 DDC Type  -- NONE
(II) RADEON(0): PLL parameters: rf=2700 rd=12 min=12000 max=35000; xclk=16600
(II) RADEON(0): Panel ID string: 1024x768                
(II) RADEON(0): Panel Size from BIOS: 1024x768
(II) RADEON(0): BIOS provided dividers will be used.
(WW) RADEON(0): Failed to detect secondary monitor, MergedFB/Clone mode disabled
(==) RADEON(0): Using gamma correction (1.0, 1.0, 1.0)
(II) RADEON(0): Validating modes on Primary head ---------
(II) RADEON(0): Total number of valid DDC mode(s) found: 0
(II) RADEON(0): Valid mode using on-chip RMX: 1024x768
(II) RADEON(0): Valid mode using on-chip RMX: 800x600
(II) RADEON(0): Valid mode using on-chip RMX: 640x480
(II) RADEON(0): Total number of valid FP mode(s) found: 3
(--) RADEON(0): Virtual size is 1024x768 (pitch 1024)
(**) RADEON(0): *Mode "1024x768": 65.0 MHz (scaled from 0.0 MHz), 48.4 kHz, 60.0 Hz
(II) RADEON(0): Modeline "1024x768"   65.00  1024 1040 1176 1344  768 770 776 806
(**) RADEON(0): *Mode "800x600": 65.0 MHz (scaled from 0.0 MHz), 48.4 kHz, 60.0 Hz
(II) RADEON(0): Modeline "800x600"   65.00  800 1040 1176 1344  600 770 776 806
(**) RADEON(0): *Mode "640x480": 65.0 MHz (scaled from 0.0 MHz), 48.4 kHz, 60.0 Hz
(II) RADEON(0): Modeline "640x480"   65.00  640 1040 1176 1344  480 770 776 806
(**) RADEON(0):  Default mode "640x350": 65.0 MHz (scaled from 0.0 MHz), 48.4 kHz, 60.0 Hz
(II) RADEON(0): Modeline "640x350"   65.00  640 1040 1176 1344  350 770 776 806
(**) RADEON(0):  Default mode "640x400": 65.0 MHz (scaled from 0.0 MHz), 48.4 kHz, 60.0 Hz
(II) RADEON(0): Modeline "640x400"   65.00  640 1040 1176 1344  400 770 776 806
(**) RADEON(0):  Default mode "720x400": 65.0 MHz (scaled from 0.0 MHz), 48.4 kHz, 60.0 Hz
(II) RADEON(0): Modeline "720x400"   65.00  720 1040 1176 1344  400 770 776 806
(**) RADEON(0):  Default mode "832x624": 65.0 MHz (scaled from 0.0 MHz), 48.4 kHz, 60.0 Hz
(II) RADEON(0): Modeline "832x624"   65.00  832 1040 1176 1344  624 770 776 806
(**) RADEON(0):  Default mode "848x480": 65.0 MHz (scaled from 0.0 MHz), 48.4 kHz, 60.0 Hz
(II) RADEON(0): Modeline "848x480"   65.00  848 1040 1176 1344  480 770 776 806
(==) RADEON(0): DPI set to (75, 75)
(II) Loading sub module "fb"
(II) LoadModule: "fb"
(II) Loading /usr/X11R6/lib/modules/libfb.a
(II) Module fb: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 1.0.0
	ABI class: X.Org ANSI C Emulation, version 0.2
(II) Loading sub module "ramdac"
(II) LoadModule: "ramdac"
(II) Loading /usr/X11R6/lib/modules/libramdac.a
(II) Module ramdac: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 0.1.0
	ABI class: X.Org Video Driver, version 0.7
(II) Loading sub module "xaa"
(II) LoadModule: "xaa"
(II) Loading /usr/X11R6/lib/modules/libxaa.a
(II) Module xaa: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 1.2.0
	ABI class: X.Org Video Driver, version 0.7
(II) RADEON(0): AGP Fast Write disabled by default
(II) RADEON(0): Depth moves disabled by default
(II) Loading sub module "shadowfb"
(II) LoadModule: "shadowfb"
(II) Loading /usr/X11R6/lib/modules/libshadowfb.a
(II) Module shadowfb: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 1.0.0
	ABI class: X.Org ANSI C Emulation, version 0.2
(II) RADEON(0): Page flipping disabled
(!!) RADEON(0): For information on using the multimedia capabilities
	of this adapter, please see http://gatos.sf.net.
(--) Depth 24 pixmap format is 32 bpp
(II) do I need RAC?  No, I don't.
(II) resource ranges after preInit:
	[0] 0	0	0xfcff0000 - 0xfcffffff (0x10000) MX[B]
	[1] 0	0	0xe0000000 - 0xe7ffffff (0x8000000) MX[B]
	[2] -1	0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[3] -1	0	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[4] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[5] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[6] -1	0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[7] -1	0	0xf8fffc00 - 0xf8fffc7f (0x80) MX[B]
	[8] -1	0	0x55000000 - 0x550003ff (0x400) MX[B]
	[9] -1	0	0xe8000000 - 0xe7ffffff (0x0) MX[B]O
	[10] -1	0	0xfcff0000 - 0xfcffffff (0x10000) MX[B](B)
	[11] -1	0	0xe0000000 - 0xe7ffffff (0x8000000) MX[B](B)
	[12] 0	0	0x000a0000 - 0x000affff (0x10000) MS[B](OprU)
	[13] 0	0	0x000b0000 - 0x000b7fff (0x8000) MS[B](OprU)
	[14] 0	0	0x000b8000 - 0x000bffff (0x8000) MS[B](OprU)
	[15] 0	0	0x0000c000 - 0x0000c0ff (0x100) IX[B]
	[16] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[17] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
	[18] -1	0	0x0000ec80 - 0x0000ecff (0x80) IX[B]
	[19] -1	0	0x0000dc00 - 0x0000dc7f (0x80) IX[B]
	[20] -1	0	0x0000d400 - 0x0000d4ff (0x100) IX[B]
	[21] -1	0	0x0000dc80 - 0x0000dcbf (0x40) IX[B]
	[22] -1	0	0x0000d800 - 0x0000d8ff (0x100) IX[B]
	[23] -1	0	0x0000bfa0 - 0x0000bfaf (0x10) IX[B]
	[24] -1	0	0x00000374 - 0x00000374 (0x1) IX[B]
	[25] -1	0	0x00000170 - 0x00000170 (0x1) IX[B]
	[26] -1	0	0x000003f4 - 0x000003f4 (0x1) IX[B]
	[27] -1	0	0x000001f0 - 0x000001f0 (0x1) IX[B]
	[28] -1	0	0x0000bf80 - 0x0000bf9f (0x20) IX[B]
	[29] -1	0	0x0000c000 - 0x0000c0ff (0x100) IX[B](B)
	[30] 0	0	0x000003b0 - 0x000003bb (0xc) IS[B](OprU)
	[31] 0	0	0x000003c0 - 0x000003df (0x20) IS[B](OprU)
(==) RADEON(0): Write-combining range (0xe0000000,0x2000000)
(II) RADEON(0): Dynamic Clock Scaling Disabled
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is 7, (OK)
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is 7, (OK)
drmOpenByBusid: Searching for BusID pci:0000:01:00.0
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is 7, (OK)
drmOpenByBusid: drmOpenMinor returns 7
drmOpenByBusid: drmGetBusid reports pci:0000:01:00.0
(II) RADEON(0): [drm] DRM interface version 1.2
(II) RADEON(0): [drm] created "radeon" driver at busid "pci:0000:01:00.0"
(II) RADEON(0): [drm] added 8192 byte SAREA at 0xf8866000
(II) RADEON(0): [drm] mapped SAREA 0xf8866000 to 0xb5e68000
(II) RADEON(0): [drm] framebuffer handle = 0xe0000000
(II) RADEON(0): [drm] added 1 reserved context for kernel
(II) RADEON(0): [agp] Mode 0x1f000201 [AGP 0x8086/0x1a30; Card 0x1002/0x4c57]
(II) RADEON(0): [agp] 8192 kB allocated with handle 0x00000001
(II) RADEON(0): [agp] ring handle = 0xe8000000
(II) RADEON(0): [agp] Ring mapped at 0xb5d67000
(II) RADEON(0): [agp] ring read ptr handle = 0xe8101000
(II) RADEON(0): [agp] Ring read ptr mapped at 0xb5d66000
(II) RADEON(0): [agp] vertex/indirect buffers handle = 0xe8102000
(II) RADEON(0): [agp] Vertex/indirect buffers mapped at 0xb5b66000
(II) RADEON(0): [agp] GART texture map handle = 0xe8302000
(II) RADEON(0): [agp] GART Texture map mapped at 0xb5686000
(II) RADEON(0): [drm] register handle = 0xfcff0000
(II) RADEON(0): [dri] Visual configs initialized
(II) RADEON(0): CP in BM mode
(II) RADEON(0): Using 8 MB GART aperture
(II) RADEON(0): Using 1 MB for the ring buffer
(II) RADEON(0): Using 2 MB for vertex/indirect buffers
(II) RADEON(0): Using 5 MB for GART textures
(II) RADEON(0): Memory manager initialized to (0,0) (1024,8191)
(II) RADEON(0): Reserved area from (0,768) to (1024,770)
(II) RADEON(0): Largest offscreen area available: 1024 x 7421
(II) RADEON(0): Will use back buffer at offset 0x900000
(II) RADEON(0): Will use depth buffer at offset 0xc00000
(II) RADEON(0): Will use 17408 kb for textures at offset 0xf00000
(II) RADEON(0): Render acceleration disabled
(II) RADEON(0): Using XFree86 Acceleration Architecture (XAA)
	Screen to screen bit blits
	Solid filled rectangles
	8x8 mono pattern filled rectangles
	Indirect CPU to Screen color expansion
	Solid Lines
	Scanline Image Writes
	Offscreen Pixmaps
	Setting up tile and stipple cache:
		32 128x128 slots
		32 256x256 slots
		16 512x512 slots
(II) RADEON(0): Acceleration enabled
(==) RADEON(0): Backing store disabled
(==) RADEON(0): Silken mouse enabled
(II) RADEON(0): Using hardware cursor (scanline 770)
(II) RADEON(0): Largest offscreen area available: 1024 x 7417
(**) Option "dpms"
(**) RADEON(0): DPMS enabled
(II) RADEON(0): X context handle = 0x00000001
(II) RADEON(0): [drm] installed DRM signal handler
(II) RADEON(0): [DRI] installation complete
(II) RADEON(0): [drm] Added 32 65536 byte vertex/indirect buffers
(II) RADEON(0): [drm] Mapped 32 vertex/indirect buffers
(II) RADEON(0): [drm] dma control initialized, using IRQ 11
(II) RADEON(0): [drm] Initialized kernel GART heap manager, 5111808
(II) RADEON(0): Direct rendering enabled
(==) RandR enabled
(II) Initializing built-in extension MIT-SHM
(II) Initializing built-in extension XInputExtension
(II) Initializing built-in extension XTEST
(II) Initializing built-in extension XKEYBOARD
(II) Initializing built-in extension LBX
(II) Initializing built-in extension XC-APPGROUP
(II) Initializing built-in extension SECURITY
(II) Initializing built-in extension XINERAMA
(II) Initializing built-in extension XFIXES
(II) Initializing built-in extension XFree86-Bigfont
(II) Initializing built-in extension RENDER
(II) Initializing built-in extension RANDR
(II) Initializing built-in extension COMPOSITE
(II) Initializing built-in extension DAMAGE
(II) Initializing built-in extension XEVIE
(**) Option "Protocol" "IMPS/2"
(**) Mouse0: Device: "/dev/input/mice"
(**) Mouse0: Protocol: "IMPS/2"
(**) Option "CorePointer"
(**) Mouse0: Core Pointer
(**) Option "Device" "/dev/input/mice"
(**) Option "Emulate3Buttons" "yes"
(**) Mouse0: Emulate3Buttons, Emulate3Timeout: 50
(**) Option "ZAxisMapping" "4 5"
(**) Mouse0: ZAxisMapping: buttons 4 and 5
(**) Mouse0: Buttons: 5
(**) Option "CoreKeyboard"
(**) Keyboard0: Core Keyboard
(**) Option "Protocol" "standard"
(**) Keyboard0: Protocol: standard
(**) Option "AutoRepeat" "500 30"
(**) Option "XkbRules" "xorg"
(**) Keyboard0: XkbRules: "xorg"
(**) Option "XkbModel" "pc105"
(**) Keyboard0: XkbModel: "pc105"
(**) Option "XkbLayout" "us"
(**) Keyboard0: XkbLayout: "us"
(**) Option "CustomKeycodes" "off"
(**) Keyboard0: CustomKeycodes disabled
(II) Synaptics touchpad driver version 0.14.0
(--) Synaptics auto-dev sets device to /dev/input/event1
(**) Option "Device" "/dev/input/event1"
(--) Synaptics touchpad found
(**) Option "AlwaysCore"
(**) Synaptics: always reports core events
(II) XINPUT: Adding extended input device "Synaptics" (type: MOUSE)
(II) XINPUT: Adding extended input device "Keyboard0" (type: KEYBOARD)
(II) XINPUT: Adding extended input device "Mouse0" (type: MOUSE)
Synaptics DeviceInit called
SynapticsCtrl called.
(II) Mouse0: ps2EnableDataReporting: succeeded
Synaptics DeviceOn called
(--) Synaptics touchpad found

------=_Part_13915_32800839.1130329337542--
