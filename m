Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271848AbTGRPgb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 11:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271834AbTGRPfJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 11:35:09 -0400
Received: from hauptpostamt.charite.de ([193.175.66.220]:15503 "EHLO
	hauptpostamt.charite.de") by vger.kernel.org with ESMTP
	id S271819AbTGRPek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 11:34:40 -0400
Date: Fri, 18 Jul 2003 17:49:18 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: More 2.6.0-test1-ac2 issues / nvidia kernel module
Message-ID: <20030718154918.GA27176@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, please: nvidia taints the kernel - so flame at your will - but
this is a more general question regarding module loading:

If I load the nvidia kernel module like this:

% modprobe nvidia NVreg_Mobile=2  NVreg_SoftEDIDs=0

and start kdm afterwards, it works as in 2.4 -- I get a two screen
setup with one screen on my laptop TFT and one on my external TFT
screen.

If I use this /etc/modules.conf:

... snip ...
### update-modules: start processing /etc/modutils/nvidia-kernel
alias /dev/nvidia* nvidia
alias char-major-195 nvidia

### update-modules: end processing /etc/modutils/nvidia-kernel

### update-modules: start processing /etc/modutils/nvidia-options
options nvidia NVreg_Mobile=2 NVreg_SoftEDIDs=0

### update-modules: end processing /etc/modutils/nvidia-options
... snap ...

the X11 will barf upon start -- but the module will be loaded. From
Xfree.0.log:

...
(II) Loading /usr/X11R6/lib/modules/libvbe.a
(II) Module vbe: vendor="The XFree86 Project"
        compiled for 4.2.1.1, module version = 1.0.0
        ABI class: XFree86 Video Driver, version 0.5
(II) LoadModule: "nvidia"
(II) Loading /usr/X11R6/lib/modules/drivers/nvidia_drv.o
(II) Module nvidia: vendor="NVIDIA Corporation"
        compiled for 4.0.2, module version = 1.0.4363
        Module class: XFree86 Video Driver
(II) LoadModule: "mouse"
(II) Loading /usr/X11R6/lib/modules/input/mouse_drv.o
(II) Module mouse: vendor="The XFree86 Project"
        compiled for 4.2.1.1, module version = 1.0.0
        Module class: XFree86 XInput Driver
        ABI class: XFree86 XInput driver, version 0.3
(II) NVIDIA XFree86 Driver  1.0-4363  Sat Apr 19 17:49:42 PDT 2003
(II) NVIDIA Unified Driver for all NVIDIA GPUs
...
(**) NVIDIA(1): Depth 24, (--) framebuffer bpp 32
(==) NVIDIA(1): RGB weight 888
(==) NVIDIA(1): Default visual is TrueColor
(==) NVIDIA(1): Using gamma correction (1.0, 1.0, 1.0)
(**) NVIDIA(1): Option "ConnectedMonitor" "CRT,DFP"
(**) NVIDIA(1): ConnectedMonitor string: "CRT,DFP"
(--) NVIDIA(1): Linear framebuffer at 0xEC000000
(--) NVIDIA(1): MMIO registers at 0xFD000000
(EE) NVIDIA(1): Failed to initialize the NVIDIA kernel module!
(EE) NVIDIA(1):  *** Aborting ***
(II) UnloadModule: "nvidia"
(II) UnloadModule: "vgahw"
(II) UnloadModule: "nvidia"
(II) UnloadModule: "vgahw"
(II) Unloading /usr/X11R6/lib/modules/libvgahw.a
(EE) Screen(s) found, but none have a usable configuration.

-- 
Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.de
Charite Campus Mitte                            Tel.  +49 (0)30-450 570-155
Referat V a - Kommunikationsnetze -             Fax.  +49 (0)30-450 570-916
AIM: ralfpostfix
