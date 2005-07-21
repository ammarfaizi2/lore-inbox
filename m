Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261940AbVGUWl2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261940AbVGUWl2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 18:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261921AbVGUWjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 18:39:15 -0400
Received: from aeimail.aei.ca ([206.123.6.84]:33996 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S261914AbVGUWh4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 18:37:56 -0400
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.13-rc3-mm1 - breaks DRI
Date: Thu, 21 Jul 2005 18:37:46 -0400
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <20050715013653.36006990.akpm@osdl.org> <200507210737.41539.tomlins@cam.org> <20050722015613.67a32450.akpm@osdl.org>
In-Reply-To: <20050722015613.67a32450.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200507211837.46699.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 21 July 2005 11:56, Andrew Morton wrote:
> Ed Tomlinson <tomlins@cam.org> wrote:
> >
> >> ----------  Forwarded Message  ----------
> >> 
> >> Subject: Re: Xorg and RADEON (dri disabled)
> >> Date: Wednesday 20 July 2005 21:25
> >> From: Ed Tomlinson <tomlins@cam.org>
> >> To: debian-amd64@lists.debian.org
> >> Cc: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
> >> 
> >> On Wednesday 20 July 2005 21:13, Michal Schmidt wrote:
> >> > Ed Tomlinson wrote:
> >> > > Hi,
> >> > > 
> >> > > With Xorg I get:
> >> > > 
> >> > > (==) RADEON(0): Write-combining range (0xd0000000,0x8000000)
> >> > > drmOpenDevice: node name is /dev/dri/card0
> >> > > drmOpenDevice: open result is -1, (No such device)
> >> > > drmOpenDevice: open result is -1, (No such device)
> >> > > drmOpenDevice: Open failed
> >> > > drmOpenDevice: node name is /dev/dri/card0
> >> > > drmOpenDevice: open result is -1, (No such device)
> >> > > drmOpenDevice: open result is -1, (No such device)
> >> > > drmOpenDevice: Open failed
> >> > > drmOpenByBusid: Searching for BusID pci:0000:01:00.0
> >> > > drmOpenDevice: node name is /dev/dri/card0
> >> > > drmOpenDevice: open result is 7, (OK)
> >> > > drmOpenByBusid: drmOpenMinor returns 7
> >> > > drmOpenByBusid: drmGetBusid reports pci:0000:01:00.0
> >> > > (II) RADEON(0): [drm] loaded kernel module for "radeon" driver
> >> > > (II) RADEON(0): [drm] DRM interface version 1.2
> >> > > (II) RADEON(0): [drm] created "radeon" driver at busid "pci:0000:01:00.0"
> >> > > (II) RADEON(0): [drm] added 8192 byte SAREA at 0xffffc20000411000
> >> > > (II) RADEON(0): [drm] drmMap failed
> >> > > (EE) RADEON(0): [dri] DRIScreenInit failed.  Disabling DRI.
> >> > > 
> >> > > And glxgears reports 300 frames per second.  How do I get dri back?  It
> >> > > was working fine with XFree.  The XF86Config-4 was changed by the upgrade
> >> > > dropping some parms in the Device section.  Restoring them has no effect
> >> > > on the problem.
> >> 
> >> > What kernel do you use? I get the same behaviour with 2.6.13-rc3-mm1, 
> >> > but it works with 2.6.13-rc3.
> >> 
> >> I also use 2.6.13-rc3-mm1.  Will try with a previous version an report to lkml if
> >> it works.
> >> 
> >
> > I just tried 13-rc2-mm1 and dri is working again. Its reported to also work
> > with 13-rc3.
> 
> Useful info, thanks.
> 
> >  What in mm1 is apt to be breaking dri?
> 
> Faulty kernel programming ;)
> 
> I assume that the failure to open /dev/dri/card0 only happens in rc3-mm1?

The difference in the X logs is that the working one does not have the:
(II) RADEON(0): [drm] created "radeon" driver at busid "pci:0000:01:00.0"
(II) RADEON(0): [drm] added 8192 byte SAREA at 0xffffc20000411000
(II) RADEON(0): [drm] drmMap failed

message.  When it works it has has:
(II) RADEON(0): [drm] created "radeon" driver at busid "pci:0000:01:00.0"
(II) RADEON(0): [drm] added 8192 byte SAREA at 0x10001000
(II) RADEON(0): [drm] mapped SAREA 0x10001000 to 0x2aaab2e67000
(II) RADEON(0): [drm] framebuffer handle = 0xd0000000
(II) RADEON(0): [drm] added 1 reserved context for kernel
(II) RADEON(0): [agp] Mode 0x1f004209 [AGP 0x10de/0x00e1; Card 0x1002/0x5961]
(II) RADEON(0): [agp] 8192 kB allocated with handle 0x00000001
(II) RADEON(0): [agp] ring handle = 0xe0000000
 
> Could you compare the dmesg output for 2.6.13-rc3 versus 2.6.13-rc3-mm1? 
> And double-check the .config settings: occasionally config options will be
> renamed and `make oldconfig' causes things to get acidentally disabled. 

>From 13-rc2-mm1:

Jul 21 07:31:20 grover kernel: [   13.652465] Linux agpgart interface v0.101 (c) Dave Jones
Jul 21 07:31:20 grover kernel: [   13.652492] [drm] Initialized drm 1.0.0 20040925

and later

Jul 21 07:31:34 grover kernel: [   72.401795] [drm] Initialized radeon 1.16.0 20050311 on minor 0: ATI Technologies Inc RV280 [Radeon 9200]
Jul 21 07:31:34 grover kernel: [   72.402388] agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
Jul 21 07:31:34 grover kernel: [   72.402399] agpgart: Putting AGP V3 device at 0000:00:00.0 into 4x mode
Jul 21 07:31:34 grover kernel: [   72.402419] agpgart: Putting AGP V3 device at 0000:01:00.0 into 4x mode
Jul 21 07:31:35 grover kernel: [   72.421888] [drm] Loading R200 Microcode

>From 13-rc3-mm1:

Jul 20 18:59:34 grover kernel: [   13.837537] Linux agpgart interface v0.101 (c) Dave Jones
Jul 20 18:59:34 grover kernel: [   13.837565] [drm] Initialized drm 1.0.0 20040925

and later

Jul 20 18:59:48 grover kernel: [   71.638470] [drm] Initialized radeon 1.16.0 20050311 on minor 0: ATI Techno
logies Inc RV280 [Radeon 9200]

Both .configs are fine.  Kernels have agp compiled in with DRM modular.

CONFIG_GART_IOMMU=y

CONFIG_AGP=y
CONFIG_AGP_AMD64=y
# CONFIG_AGP_INTEL is not set
CONFIG_DRM=y
CONFIG_DRM_TDFX=m
CONFIG_DRM_R128=m
CONFIG_DRM_RADEON=m

Hope this helps (Its an AMD64 Kernel),

Ed

