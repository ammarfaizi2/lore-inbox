Return-Path: <linux-kernel-owner+akpm=40osdl.org-S265986AbUGAQCy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265986AbUGAQCy (ORCPT <rfc822;akpm@osdl.org>);
	Thu, 1 Jul 2004 12:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265992AbUGAQCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 12:02:54 -0400
Received: from zeus.kernel.org ([204.152.189.113]:39829 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S265986AbUGAQCt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 12:02:49 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Mario 'BitKoenig' Holbe" <Mario.Holbe@RZ.TU-Ilmenau.DE>
Subject: framebuffer + fbtv + X kills system
Date: Thu, 1 Jul 2004 17:29:03 +0200
Organization: Technische Universitaet Ilmenau, Germany
Message-ID: <cc1ajv$5bs$1@sea.gmane.org>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd952a595.dip.t-dialin.net
User-Agent: slrn/0.9.8.0 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I experience unconditional system crashes in the following
situation:

I'm using kernel 2.4.26 with tdfx framebuffer as console
driver (3Dfx Voodoo 3 3000 AGP): `video=tdfx:1280x1024-16@85'
I'm further running a XFree86 X-Server (with `Driver "tdfx"',
`Option "UseFBDev" "true"', `DefaultDepth 24' and `Modes
"1280x1024" ...'.

I'm using fbtv -s 300x300 -k -q (fbtv is part of xawtv)
to map a TV picture from a BT878 card (Hauppauge WinTV PCI)
in the upper right corner of the monitor. The -k option means
that fbtv keeps capture on when switching consoles.

This works very well, as long as I don't switch to the
X console (switching to other consoles works well, even
if they have another video mode - the picture is crappy then,
but the system remains stable).
If I switch to X, the system gets horribly slow. X gets nothing
really drawed anymore.
Sometimes I succeed in switching back to a non-X console,
sometimes the machine is just rebooting after a while.
When switching back out-of-X works, the framebuffer seems
to be broken: switching to other modes that worked before
(via fbset, no matter on what console), doesn't work anymore -
most times, monitor reports `signal out of range'.

Is this reproducible for someone else too perhaps?

I know, there are a lot of components involved. However,
since I route all graphics access through framebuffer and
since framebuffer is the only component which shows errors,
I think, framebuffer is the problem here:
it's interface just should not allow any application to crash
the system or bring it in a state, where it doesn't work
anymore as it did before.

Here are a few system details about the comfiguration
I'm running:
Kernel command line: auto BOOT_IMAGE=Linux ro root=303 console=ttyS0,38400n8 console=tty0 video=tdfx:1280x1024-16@85 nmi_watchdog=1 panic=60 parport=0x378,7,3
ACPI: Using PIC for interrupt routing
fb: Voodoo3 memory = 16384K
fb: MTRR's turned on
tdfxfb: reserving 1024 bytes for the hwcursor at f9815000
Console: switching to colour frame buffer device 160x64
fb0: 3Dfx Voodoo3 frame buffer device
PCI: Enabling device 00:0a.1 (0004 -> 0006)
btaudio: Bt878 (rev 17) at 00:0a.1, irq: 10, latency: 32, mmio: 0xf2800000
btaudio: using card config "default"
btaudio: registered device dsp2 [digital]
btaudio: registered device dsp3 [analog]
btaudio: registered device mixer1
Linux video capture interface: v1.00
bttv: driver version 0.7.108 loaded
bttv: using 4 buffers with 2080k (8320k total) for capture
bttv: Bt8xx card found (0).
PCI: Enabling device 00:0a.0 (0004 -> 0006)
bttv0: Bt878 (rev 17) at 00:0a.0, irq: 10, latency: 32, mmio: 0xf3000000
bttv0: detected: Hauppauge WinTV [card=10], PCI subsystem ID is 0070:13eb
bttv0: using: Hauppauge (bt878) [card=10,autodetected]
bttv0: Hauppauge/Voodoo msp34xx: reset line init [5]
i2c-dev.o: Registered 'bt848 #0' as minor 1
bttv0: Hauppauge eeprom: model=44354, tuner=Philips FM1216 (5), radio=yes
bttv0: using tuner=5
bttv0: i2c: checking for MSP34xx @ 0x80... found
msp34xx: init: chip=MSP3415D-B3 +nicam +simple
msp3410: daemon started
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
tvaudio: TV audio decoder + audio/video mux driver
tvaudio: known chips: tda9840,tda9873h,tda9874h/a,tda9850,tda9855,tea6300,tea6420,tda8425,pic16c54 (PV951),ta8874z
tuner: chip found @ 0xc2
tuner: type set to 5 (Philips PAL_BG (FI1216 and compatibles))
bttv0: PLL: 28636363 => 35468950 .. ok
bttv0: registered device video0
bttv0: registered device vbi0
bttv0: registered device radio0
lirc_dev: IR Remote Control driver registered, at major 61
lirc_i2c: chip found @ 0x18 (Hauppauge IR)
tuner: type already set (5)

Kernel is compiled with:
CONFIG_AGP=y
CONFIG_AGP_VIA=y
CONFIG_DRM=y
CONFIG_DRM_NEW=y
CONFIG_DRM_TDFX=m
CONFIG_VIDEO_DEV=m
CONFIG_VIDEO_PROC_FS=y
CONFIG_VIDEO_BT848=m
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_FB_3DFX=y
CONFIG_FBCON_ADVANCED=y
CONFIG_FBCON_MFB=y
CONFIG_FBCON_CFB2=y
CONFIG_FBCON_CFB4=y
CONFIG_FBCON_CFB8=y
CONFIG_FBCON_CFB16=y
CONFIG_FBCON_CFB24=y
CONFIG_FBCON_CFB32=y
CONFIG_FBCON_FONTS=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_FONT_SUN8x16=y
ONFIG_SOUND_BT878=m
CONFIG_SOUND_ES1370=m


regards,
   Mario
-- 
I've never been certain whether the moral of the Icarus story should
only be, as is generally accepted, "Don't try to fly too high," or
whether it might also be thought of as, "Forget the wax and feathers
and do a better job on the wings."            -- Stanley Kubrick

