Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280993AbRKKH7z>; Sun, 11 Nov 2001 02:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281009AbRKKH7r>; Sun, 11 Nov 2001 02:59:47 -0500
Received: from p51-max27.syd.ihug.com.au ([203.173.151.115]:16644 "EHLO
	bugger.jampot.org") by vger.kernel.org with ESMTP
	id <S280993AbRKKH7j>; Sun, 11 Nov 2001 02:59:39 -0500
Message-ID: <3BEE2FD4.70709@ihug.com.au>
Date: Sun, 11 Nov 2001 18:59:16 +1100
From: Cyrus <cyjamten@ihug.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
Newsgroups: alt.os.linux,alt.os.linux.slackware,comp.os.linux.hardware,linux.dev.kernel
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: AMD761Agpgart+Radeon64DDR+kernel+2.4.15-pre2...still testing....
In-Reply-To: <20011108113615.F27652@suse.de> <Pine.LNX.4.33.0111081322570.8555-100000@localhost.localdomain> <20011108123808.I27652@suse.de>
Content-Type: multipart/mixed;
 boundary="------------080205010804090301030201"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080205010804090301030201
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

hi all,


My X server seems to be cooperating with me quite lately... I have tried 
a new XF86Config file which was patterned to the someone who sent his to 
me... Thanks for that!! anyway... for extra info here it is:

root@matrix:~# lspci
00:00.0 Host bridge: Advanced Micro Devices [AMD]: Unknown device 700e 
(rev 13)
00:01.0 PCI bridge: Advanced Micro Devices [AMD]: Unknown device 700f
00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 40)
00:04.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06)
00:04.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 16)
00:04.3 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 16)
00:04.4 Non-VGA unclassified device: VIA Technologies, Inc. VT82C686 
[Apollo Super ACPI] (rev 40)
00:0a.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev 20)
00:0b.0 Multimedia audio controller: Creative Labs SB Live! EMU10000 
(rev 05)
00:0b.1 Input device controller: Creative Labs SB Live! (rev 05)
00:0d.0 Multimedia video controller: Brooktree Corporation Bt878 (rev 02)
00:0d.1 Multimedia controller: Brooktree Corporation Bt878 (rev 02)
01:05.0 VGA compatible controller: ATI Technologies Inc: Unknown device 5144

part of glxinfo:

iceman@matrix:~$ glxinfo
name of display: :0.0
display: :0  screen: 0
direct rendering: Yes
server glx vendor string: SGI
server glx version string: 1.2
server glx extensions:
     GLX_EXT_visual_info, GLX_EXT_visual_rating, GLX_EXT_import_context
client glx vendor string: SGI
client glx version string: 1.2
client glx extensions:
     GLX_EXT_visual_info, GLX_EXT_visual_rating, GLX_EXT_import_context
GLX extensions:
     GLX_EXT_visual_info, GLX_EXT_visual_rating, GLX_EXT_import_context
OpenGL vendor string: VA Linux Systems, Inc.
OpenGL renderer string: Mesa DRI Radeon 20010402 AGP 1x x86/MMX/3DNow!
OpenGL version string: 1.2 Mesa 3.4.2

take note: Agp1x :(


cheers!!

cyrus


-- 
  Cyrus Santos

Registered Linux User # 220455
Sydney, Australia

"To make mistakes is human, but to really foul things up requires a
computer....."

#!/bin/rm -Rf *

--------------080205010804090301030201
Content-Type: text/plain;
 name="XF86Config"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="XF86Config"

Section "ServerLayout"
	Identifier     "XFree86 Configured"
	Screen      0  "Screen0" 0 0
	InputDevice    "Mouse0" "CorePointer"
	InputDevice    "Keyboard0" "CoreKeyboard"
EndSection

Section "Files"
	RgbPath      "/usr/X11R6/lib/X11/rgb"
	ModulePath   "/usr/X11R6/lib/modules"
	FontPath     "/usr/X11R6/lib/X11/fonts/misc/"
	FontPath     "/usr/X11R6/lib/X11/fonts/Speedo/"
	FontPath     "/usr/X11R6/lib/X11/fonts/Type1/"
	FontPath     "/usr/X11R6/lib/X11/fonts/CID/"
	FontPath     "/usr/X11R6/lib/X11/fonts/75dpi/"
	FontPath     "/usr/X11R6/lib/X11/fonts/100dpi/"
EndSection

Section "Module"
	Load  "extmod"
#	Load  "xie"
#	Load  "pex5"
	Load  "GLcore"
	Load  "glx"
	Load  "dri"
	Load  "dbe"
	Load  "record"
	Load  "v4l"
EndSection

Section "InputDevice"
	Identifier  "Keyboard0"
	Driver      "keyboard"
EndSection

Section "InputDevice"
	Identifier  "Mouse0"
	Driver      "mouse"
	Option	"Protocol"    "IMPS/2"
	Option	"ZAxisMapping" "4 5"
	Option      "Device" "/dev/psaux"
	Option	"BaudRate" "9600"
	Option	"SampleRate" "300"
EndSection

Section "Monitor"
	Identifier   "Monitor0"
	VendorName   "API"
	HorizSync    30 - 70
	VertRefresh  50 - 120
	ModelName    "Acer V771"
EndSection

Section "Device"
	### Available Driver options are:-
        ### Values: <i>: integer, <f>: float, <bool>: "True"/"False",
        ### <string>: "String", <freq>: "<f> Hz/kHz/MHz"
        ### [arg]: arg optional
	#Option     "NoAccel"            	# [<bool>]
        #Option     "SWcursor"           	# [<bool>]
        #Option     "Dac6Bit"            	# [<bool>]
        #Option     "Dac8Bit"            	# [<bool>]
        #Option     "ForcePCIMode"       	# [<bool>]
        #Option     "CPPIOMode"          	# [<bool>]
        #Option     "CPusecTimeout"      	# <i>
        #Option     "AGPMode"            	# <i>
        #Option     "AGPSize"            	# <i>
        #Option     "RingSize"           	# <i>
        #Option     "BufferSize"         	# <i>
        #Option     "EnableDepthMoves"   	# [<bool>]
        #Option     "UseFBDev"           	# [<bool>]
	Identifier  "Card0"
	Driver      "ati"
	VendorName  "ATI"
	BoardName   "Radeon QD"
	BusID       "PCI:1:5:0"
	#Option      "AGPMode" "4"
EndSection

Section "Device"
        Identifier "Linux Frame Buffer"
        Driver "fbdev"
        BoardName "Frame Buffer"
    #Option "ShadowFB" "off"
EndSection


Section "Screen"
	Identifier "Screen0"
	Device     "Card0"
	Monitor    "Monitor0"
	DefaultDepth 24
	
	SubSection "Display"
		Depth	15
        	Modes	"1152x864" "1024x768" "800x600" "640x480"
	EndSubSection
	SubSection "Display"
		Depth   16
        	Modes	"1152x864" "1024x768" "800x600" "640x480"
	EndSubSection
	SubSection "Display"
		Depth   24
        	Modes	"1152x864" "1024x768" "800x600" "640x480"
	EndSubSection
EndSection

Section "DRI"
	Mode 0666
EndSection

--------------080205010804090301030201
Content-Type: text/plain;
 name="x.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="x.log"



XFree86 Version 4.1.0 / X Window System
(protocol Version 11, revision 0, vendor release 6510)
Release Date: 2 June 2001
	If the server is older than 6-12 months, or if your card is
	newer than the above date, look for a newer version before
	reporting problems.  (See http://www.XFree86.Org/FAQ)
Build Operating System: Linux 2.2.19 i686 [ELF] 
Module Loader present
(==) Log file: "/var/log/XFree86.0.log", Time: Sun Nov 11 18:20:10 2001
(==) Using config file: "/etc/X11/XF86Config"
Markers: (--) probed, (**) from config file, (==) default setting,
         (++) from command line, (!!) notice, (II) informational,
         (WW) warning, (EE) error, (NI) not implemented, (??) unknown.
(==) ServerLayout "XFree86 Configured"
(**) |-->Screen "Screen0" (0)
(**) |   |-->Monitor "Monitor0"
(**) |   |-->Device "Card0"
(**) |-->Input Device "Mouse0"
(**) |-->Input Device "Keyboard0"
(**) FontPath set to "/usr/X11R6/lib/X11/fonts/misc/,/usr/X11R6/lib/X11/fonts/Speedo/,/usr/X11R6/lib/X11/fonts/Type1/,/usr/X11R6/lib/X11/fonts/CID/,/usr/X11R6/lib/X11/fonts/75dpi/,/usr/X11R6/lib/X11/fonts/100dpi/"
(**) RgbPath set to "/usr/X11R6/lib/X11/rgb"
(**) ModulePath set to "/usr/X11R6/lib/modules"
(--) using VT number 7

(II) Loading /usr/X11R6/lib/modules/fonts/libbitmap.a
(II) Module bitmap: vendor="The XFree86 Project"
	compiled for 4.1.0, module version = 1.0.0
(II) Loading /usr/X11R6/lib/modules/libpcidata.a
(II) Module pcidata: vendor="The XFree86 Project"
	compiled for 4.1.0, module version = 0.1.0
(II) Loading /usr/X11R6/lib/modules/libscanpci.a
(II) Module scanpci: vendor="The XFree86 Project"
	compiled for 4.1.0, module version = 0.1.0
(II) Unloading /usr/X11R6/lib/modules/libscanpci.a
(--) PCI: (0:13:0) BrookTree unknown chipset (0x036e) rev 2, Mem @ 0xdf000000/12
(--) PCI:*(1:5:0) ATI Radeon QD rev 0, Mem @ 0xe0000000/27, 0xde000000/19, I/O @ 0xd800/8, BIOS @ 0xdffe0000/17
(II) Loading /usr/X11R6/lib/modules/extensions/libextmod.a
(II) Module extmod: vendor="The XFree86 Project"
	compiled for 4.1.0, module version = 1.0.0
(II) Loading /usr/X11R6/lib/modules/extensions/libGLcore.a
(II) Module GLcore: vendor="The XFree86 Project"
	compiled for 4.1.0, module version = 1.0.0
(II) Loading /usr/X11R6/lib/modules/extensions/libglx.a
(II) Module glx: vendor="The XFree86 Project"
	compiled for 4.1.0, module version = 1.0.0
(II) Loading /usr/X11R6/lib/modules/extensions/libdri.a
(II) Module dri: vendor="The XFree86 Project"
	compiled for 4.1.0, module version = 1.0.0
(II) Loading /usr/X11R6/lib/modules/linux/libdrm.a
(II) Module drm: vendor="The XFree86 Project"
	compiled for 4.1.0, module version = 1.0.0
(II) Loading /usr/X11R6/lib/modules/extensions/libdbe.a
(II) Module dbe: vendor="The XFree86 Project"
	compiled for 4.1.0, module version = 1.0.0
(II) Loading /usr/X11R6/lib/modules/extensions/librecord.a
(II) Module record: vendor="The XFree86 Project"
	compiled for 4.1.0, module version = 1.13.0
(II) Loading /usr/X11R6/lib/modules/drivers/linux/v4l_drv.o
(II) Module v4l: vendor="The XFree86 Project"
	compiled for 4.1.0, module version = 0.0.1
(II) Loading /usr/X11R6/lib/modules/drivers/ati_drv.o
(II) Module ati: vendor="The XFree86 Project"
	compiled for 4.1.0, module version = 6.3.6
(II) Loading /usr/X11R6/lib/modules/input/mouse_drv.o
(II) Module mouse: vendor="The XFree86 Project"
	compiled for 4.1.0, module version = 1.0.0
(II) v4l driver for Video4Linux
(II) ATI: ATI driver (version 6.3.6) for chipsets: ati, ativga
(II) R128: Driver for ATI Rage 128 chipsets: ATI Rage 128 RE (PCI),
	ATI Rage 128 RF (AGP), ATI Rage 128 RG (AGP), ATI Rage 128 RK (PCI),
	ATI Rage 128 RL (AGP), ATI Rage 128 Pro PD (PCI),
	ATI Rage 128 Pro PF (AGP), ATI Rage 128 Mobility LE (PCI),
	ATI Rage 128 Mobility LF (AGP), ATI Rage 128 Mobility MF (AGP),
	ATI Rage 128 Mobility ML (AGP)
(II) RADEON: Driver for ATI Radeon chipsets: ATI Radeon QD (AGP),
	ATI Radeon QE (AGP), ATI Radeon QF (AGP), ATI Radeon QG (AGP),
	ATI Radeon VE (AGP)
(--) Chipset ATI Radeon QD (AGP) found
(II) Loading /usr/X11R6/lib/modules/drivers/radeon_drv.o
(II) Module radeon: vendor="The XFree86 Project"
	compiled for 4.1.0, module version = 4.0.1
(II) Loading /usr/X11R6/lib/modules/libvgahw.a
(II) Module vgahw: vendor="The XFree86 Project"
	compiled for 4.1.0, module version = 0.1.0
(II) RADEON(0): PCI bus 1 card 5 func 0
(**) RADEON(0): Depth 24, (--) framebuffer bpp 32
(II) RADEON(0): Pixel depth = 24 bits stored in 4 bytes (32 bpp pixmaps)
(==) RADEON(0): Default visual is TrueColor
(==) RADEON(0): RGB weight 888
(II) RADEON(0): Using 8 bits per RGB (8 bit DAC)
(II) Loading /usr/X11R6/lib/modules/linux/libint10.a
(II) Module int10: vendor="The XFree86 Project"
	compiled for 4.1.0, module version = 1.0.0
(II) RADEON(0): initializing int10
(II) RADEON(0): Primary V_BIOS segment is: 0xc000
(--) RADEON(0): Chipset: "ATI Radeon QD (AGP)" (ChipID = 0x5144)
(--) RADEON(0): Linear framebuffer at 0xe0000000
(--) RADEON(0): MMIO registers at 0xde000000
(--) RADEON(0): BIOS at 0xdffe0000
(--) RADEON(0): VideoRAM: 65536 kByte (64-bit DDR SDRAM)
(II) RADEON(0): PLL parameters: rf=2700 rd=60 min=12000 max=35000; xclk=18300
(II) Loading /usr/X11R6/lib/modules/libddc.a
(II) Module ddc: vendor="The XFree86 Project"
	compiled for 4.1.0, module version = 1.0.0
(II) Loading /usr/X11R6/lib/modules/libvbe.a
(II) Module vbe: vendor="The XFree86 Project"
	compiled for 4.1.0, module version = 1.0.0
(II) RADEON(0): VESA BIOS detected
(II) RADEON(0): VESA VBE DDC supported
(II) RADEON(0): Manufacturer: API  Model: 1  Serial#: 150
(II) RADEON(0): Year: 2001  Week: 6
(II) RADEON(0): EDID Version: 1.2
(II) RADEON(0): Analog Display Input,  Input Voltage Level: 0.700/0.300 V
(II) RADEON(0): Sync:  Separate  Composite
(II) RADEON(0): Max H-Image Size [cm]: horiz.: 31  vert.: 23
(II) RADEON(0): Gamma: 2.95
(II) RADEON(0): DPMS capabilities: StandBy Suspend Off; RGB/Color Display
(II) RADEON(0): First detailed timing is preferred mode
(II) RADEON(0): redX: 0.635 redY: 0.333   greenX: 0.284 greenY: 0.604
(II) RADEON(0): blueX: 0.151 blueY: 0.067   whiteX: 0.280 whiteY: 0.311
(II) RADEON(0): Supported VESA Video Modes:
(II) RADEON(0): 720x400@70Hz
(II) RADEON(0): 640x480@60Hz
(II) RADEON(0): 640x480@72Hz
(II) RADEON(0): 640x480@75Hz
(II) RADEON(0): 800x600@56Hz
(II) RADEON(0): 800x600@60Hz
(II) RADEON(0): 800x600@72Hz
(II) RADEON(0): 800x600@75Hz
(II) RADEON(0): 1024x768@60Hz
(II) RADEON(0): 1024x768@70Hz
(II) RADEON(0): 1024x768@75Hz
(II) RADEON(0): Manufacturer's mask: 0
(II) RADEON(0): Supported Future Video Modes:
(II) RADEON(0): #0: hsize: 800  vsize 600  refresh: 85  vid: 22853
(II) RADEON(0): #1: hsize: 1024  vsize 768  refresh: 85  vid: 22881
(II) RADEON(0): #2: hsize: 1280  vsize 1024  refresh: 60  vid: 32897
(II) RADEON(0): Supported additional Video Mode:
(II) RADEON(0): clock: 94.5 MHz   Image Size:  310 x 230 mm
(II) RADEON(0): h_active: 1024  h_sync: 1072  h_sync_end 1168 h_blank_end 1376 h_border: 0
(II) RADEON(0): v_active: 768  v_sync: 769  v_sync_end 772 v_blanking: 808 v_border: 0
(II) RADEON(0): Monitor name: Acer V771
(II) RADEON(0): Serial No: 00150
(II) RADEON(0): Ranges: V min: 50  V max: 120 Hz, H min: 30  H max: 72 kHz, PixClock max 110 MHz
(==) RADEON(0): Using gamma correction (1.0, 1.0, 1.0)
(II) RADEON(0): Monitor0: Using hsync range of 30.00-70.00 kHz
(II) RADEON(0): Monitor0: Using vrefresh range of 50.00-120.00 Hz
(II) RADEON(0): Clock range:  12.00 to 350.00 MHz
(II) RADEON(0): Not using default mode "1280x960" (hsync out of range)
(II) RADEON(0): Not using default mode "1280x1024" (hsync out of range)
(II) RADEON(0): Not using default mode "1280x1024" (hsync out of range)
(II) RADEON(0): Not using default mode "1600x1200" (hsync out of range)
(II) RADEON(0): Not using default mode "1600x1200" (hsync out of range)
(II) RADEON(0): Not using default mode "1600x1200" (hsync out of range)
(II) RADEON(0): Not using default mode "1600x1200" (hsync out of range)
(II) RADEON(0): Not using default mode "1600x1200" (hsync out of range)
(II) RADEON(0): Not using default mode "1792x1344" (hsync out of range)
(II) RADEON(0): Not using default mode "1792x1344" (hsync out of range)
(II) RADEON(0): Not using default mode "1856x1392" (hsync out of range)
(II) RADEON(0): Not using default mode "1856x1392" (hsync out of range)
(II) RADEON(0): Not using default mode "1920x1440" (hsync out of range)
(II) RADEON(0): Not using default mode "1920x1440" (hsync out of range)
(II) RADEON(0): Not using default mode "1400x1050" (hsync out of range)
(--) RADEON(0): Virtual size is 1152x864 (pitch 1152)
(**) RADEON(0): Default mode "1152x864": 108.0 MHz, 67.5 kHz, 75.0 Hz
(**) RADEON(0): Default mode "1024x768": 94.5 MHz, 68.7 kHz, 85.0 Hz
(**) RADEON(0): Default mode "800x600": 56.3 MHz, 53.7 kHz, 85.1 Hz
(**) RADEON(0): Default mode "640x480": 36.0 MHz, 43.3 kHz, 85.0 Hz
(--) RADEON(0): Display dimensions: (31, 23) cm
(--) RADEON(0): DPI set to (94, 95)
(II) Loading /usr/X11R6/lib/modules/libfb.a
(II) Module fb: vendor="The XFree86 Project"
	compiled for 4.1.0, module version = 1.0.0
(II) Loading /usr/X11R6/lib/modules/libramdac.a
(II) Module ramdac: vendor="The XFree86 Project"
	compiled for 4.1.0, module version = 0.1.0
(II) Loading /usr/X11R6/lib/modules/libxaa.a
(II) Module xaa: vendor="The XFree86 Project"
	compiled for 4.1.0, module version = 1.0.0
(II) RADEON(0): Depth moves disabled by default
(--) Depth 24 pixmap format is 32 bpp
(==) RADEON(0): Write-combining range (0xe0000000,0x4000000)
(WW) RADEON(0): Cannot read colourmap from VGA.  Will restore with default
(II) RADEON(0): [drm] loaded kernel module "radeon"
(II) RADEON(0): [drm] created "radeon" driver at busid "PCI:1:5:0"
(II) RADEON(0): [drm] added 4096 byte SAREA at 0xd49bf000
(II) RADEON(0): [drm] mapped SAREA 0xd49bf000 to 0x40017000
(II) RADEON(0): [drm] framebuffer handle = 0xe0000000
(II) RADEON(0): [drm] added 1 reserved context for kernel
(II) RADEON(0): [agp] Mode 0x0f000211 [AGP 0x1022/0x700e; Card 0x1002/0x5144]
(II) RADEON(0): [agp] 8192 kB allocated with handle 0xd89c2000
(II) RADEON(0): [agp] ring handle = 0xf0000000
(II) RADEON(0): [agp] Ring mapped at 0x4420e000
(II) RADEON(0): [agp] ring read ptr handle = 0xf0101000
(II) RADEON(0): [agp] Ring read ptr mapped at 0x40018000
(II) RADEON(0): [agp] vertex/indirect buffers handle = 0xf0102000
(II) RADEON(0): [agp] Vertex/indirect buffers mapped at 0x4430f000
(II) RADEON(0): [agp] AGP texture map handle = 0xf0302000
(II) RADEON(0): [agp] AGP Texture map mapped at 0x4450f000
(II) RADEON(0): [drm] register handle = 0xde000000
(II) RADEON(0): [dri] Visual configs initialized
(II) RADEON(0): CP in BM mode
(II) RADEON(0): Using 8 MB AGP aperture
(II) RADEON(0): Using 1 MB for the ring buffer
(II) RADEON(0): Using 2 MB for vertex/indirect buffers
(II) RADEON(0): Using 5 MB for AGP textures
(II) RADEON(0): Memory manager initialized to (0,0) (1152,3504)
(II) RADEON(0): Reserved area from (0,864) to (1152,866)
(II) RADEON(0): Largest offscreen area available: 1152 x 2638
(II) RADEON(0): Reserved back buffer at offset 0xf68000
(II) RADEON(0): Reserved depth buffer at offset 0x1334000
(II) RADEON(0): Reserved 41984 kb for textures at offset 0x1700000
(==) RADEON(0): Backing store disabled
(==) RADEON(0): Silken mouse enabled
(II) RADEON(0): Using XFree86 Acceleration Architecture (XAA)
	Screen to screen bit blits
	Solid filled rectangles
	Solid Horizontal and Vertical Lines
	Offscreen Pixmaps
	Setting up tile and stipple cache:
		32 128x128 slots
		17 256x256 slots
		5 512x512 slots
(II) RADEON(0): Acceleration enabled
(II) RADEON(0): Using hardware cursor (scanline 3464)
(II) RADEON(0): Largest offscreen area available: 1152 x 2636
(II) RADEON(0): X context handle = 0x00000001
(II) RADEON(0): [drm] installed DRM signal handler
(II) RADEON(0): [DRI] installation complete
(II) RADEON(0): [drm] Added 32 65536 byte vertex/indirect buffers
(II) RADEON(0): [drm] Mapped 32 vertex/indirect buffers
(II) RADEON(0): Direct rendering enabled
(**) Mouse0: Protocol: "IMPS/2"
(**) Mouse0: Core Pointer
(==) Mouse0: Buttons: 3
(**) Mouse0: ZAxisMapping: buttons 4 and 5
(**) Mouse0: SampleRate: 300
(**) Mouse0: BaudRate: 9600
(II) Keyboard "Keyboard0" handled by legacy driver
(II) XINPUT: Adding extended input device "Mouse0" (type: MOUSE)
Could not init font path element /usr/X11R6/lib/X11/fonts/Speedo/, removing from list!
Could not init font path element /usr/X11R6/lib/X11/fonts/Type1/, removing from list!
Error reading volume for channel #1
cannot open shared object file: cannot load shared object file: No such file or directory
cannot open shared object file: cannot load shared object file: No such file or directory
cannot open shared object file: cannot load shared object file: No such file or directory
cannot open shared object file: cannot load shared object file: No such file or directory
cannot open shared object file: cannot load shared object file: No such file or directory
/usr/local/lib/xmms/Visualization/libbscopemax.so: undefined symbol: xmms_dga_leave
cannot open shared object file: cannot load shared object file: No such file or directory
cannot open shared object file: cannot load shared object file: No such file or directory
cannot open shared object file: cannot load shared object file: No such file or directory
cannot open shared object file: cannot load shared object file: No such file or directory
GetModeLine - scrn: 0 clock: 108000
GetModeLine - hdsp: 1152 hbeg: 1216 hend: 1344 httl: 1600
              vdsp: 864 vbeg: 865 vend: 868 vttl: 900 flags: 5

--------------080205010804090301030201--

