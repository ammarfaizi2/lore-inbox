Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262492AbTCILKV>; Sun, 9 Mar 2003 06:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262493AbTCILKV>; Sun, 9 Mar 2003 06:10:21 -0500
Received: from t2s5.tele2.cz ([213.246.64.40]:24247 "HELO t2s5.tele2.cz")
	by vger.kernel.org with SMTP id <S262492AbTCILKT>;
	Sun, 9 Mar 2003 06:10:19 -0500
Content-Type: text/plain; charset=US-ASCII
From: Michal Semler <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: thunder7@xs4all.nl
Subject: Re: very buggy 3DFx framebuffer support!!! :(
Date: Sun, 9 Mar 2003 12:19:56 +0100
X-Mailer: KMail [version 1.3.2]
References: <E18rmiu-0000ew-00@notas> <20030309055453.GA9064@middle.of.nowhere>
In-Reply-To: <20030309055453.GA9064@middle.of.nowhere>
Cc: linux-kernel@vger.kernel.org, jsimmons@infradead.org, vandrove@vc.cvut.cz
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E18ryqT-0000FI-00@notas>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well,

my card si 3DFx Voodoo3 3000 with tvout support

When non append is selected, output of dmesg looks like this:

fb: Voodoo3 memory = 16384K
fb: MTRR's turned on
tdfxfb: reserving 1024 bytes for the hwcursor at d1817000
Console: switching to colour frame buffer device 80x30
fb0: 3Dfx Voodoo3 frame buffer device

agpgart: Maximum main memory to use for agp memory: 203M
agpgart: Detected Intel i815 chipset
agpgart: AGP aperture is 64M @ 0xf4000000
[drm] Initialized tdfx 1.0.0 20010216 on minor 0
[drm] AGP 0.99 on Intel i815 @ 0xf4000000 64MB
[drm] Initialized radeon 1.1.1 20010405 on minor 1
[drm] AGP 0.99 on Intel i815 @ 0xf4000000 64MB
[drm] Initialized i810 1.2.0 20010920 on minor 2

When append is selected, output looks like this:

fb: Voodoo3 memory = 16384K
fb: MTRR's turned on
tdfxfb: reserving 1024 bytes for the hwcursor at d1817000
fbcon_setup: No support for fontwidth 8
fbcon_setup: type 0 (aux 0, depth 24) not supported
Console: switching to colour frame buffer device 128x48
fb0: 3Dfx Voodoo3 frame buffer device

When console switch, tux is black-white, all background is black and non 
booting text is seen anymore. X server starts normally and working, when I 
select console f1-f6 console screw up :(. When I boot with non append, 
background is white as I wrote down the text when select fbset, console screw 
up the same way as when selecting console from Xserver

My .config lookslike this:
# Frame-buffer support
#
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
# CONFIG_FB_RIVA is not set
# CONFIG_FB_CLGEN is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_VESA is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_HGA is not set
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_MATROX is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
CONFIG_FB_3DFX=y
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_VIRTUAL is not set
CONFIG_FBCON_ADVANCED=y
CONFIG_FBCON_MFB=m
CONFIG_FBCON_CFB2=m
CONFIG_FBCON_CFB4=m
CONFIG_FBCON_CFB8=y
CONFIG_FBCON_CFB16=y
CONFIG_FBCON_CFB24=y
CONFIG_FBCON_CFB32=y
# CONFIG_FBCON_AFB is not set
# CONFIG_FBCON_ILBM is not set
# CONFIG_FBCON_IPLAN2P2 is not set
# CONFIG_FBCON_IPLAN2P4 is not set
# CONFIG_FBCON_IPLAN2P8 is not set
# CONFIG_FBCON_MAC is not set
# CONFIG_FBCON_VGA_PLANES is not set
# CONFIG_FBCON_VGA is not set
# CONFIG_FBCON_HGA is not set
# CONFIG_FBCON_FONTWIDTH8_ONLY is not set
CONFIG_FBCON_FONTS=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
# CONFIG_FONT_SUN8x16 is not set
# CONFIG_FONT_SUN12x22 is not set
# CONFIG_FONT_6x11 is not set
# CONFIG_FONT_PEARL_8x8 is not set
# CONFIG_FONT_ACORN_8x8 is not set

ask me for other things if you'll need some...

Michal

Dne ne 9. b?ezen 2003 06:54 jste napsal(a):
> From: Michal Semler <cijoml@volny.cz>
> Date: Sat, Mar 08, 2003 at 11:23:18PM +0100
>
> > Hello,
> >
> > I found out very buggy 3DFx framebuffer support :(
> >
> > when I select nothing when console bootings, I got white background under
> > Tux, rolling up with black background of text. Then everything under Tux
> > has black background and white text, but there, where is tux icon
> > everything on the right side of the icon has still white background
> >
> > when I select in lilo
> > append="video=tdfx:1024x768-24@75"
> >
> > my console gets screws up and I can't see anything under it. X windows
> > but works.
> >
> > When I boot computer without append and then call it with fbset -a
> > 1024x768-75 things are the same ;( and I still can select Xwindows with
> > alt+f7
> >
> > Please can anybody fix this?
> >
> > Linux 2.4.20 vanilla, gcc 3.0.4, Debian woody 3.0r1, 3DFx card, P3 733
> > Coppermine
>
> What 3dfx card? Output in log-files? Dmesg-output? output of 'dmesg' ?
>
> Jurriaan
