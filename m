Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292036AbSCDG7A>; Mon, 4 Mar 2002 01:59:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292045AbSCDG6l>; Mon, 4 Mar 2002 01:58:41 -0500
Received: from smtp.cogeco.net ([216.221.81.25]:37090 "EHLO fep9.cogeco.net")
	by vger.kernel.org with ESMTP id <S292036AbSCDG6b>;
	Mon, 4 Mar 2002 01:58:31 -0500
Subject: SIS DRI module unresolved symbols
From: "Nix N. Nix" <nix@go-nix.ca>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 04 Mar 2002 01:57:35 -0500
Message-Id: <1015225109.992.30.camel@tux>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to set up a friend of mine with a Linux box (RedHat 7.2 -
XFree86 4.1.0). I'm running into problems getting the SIS DRI module to
load into the kernel because sis_malloc and, I believe sis_free do not
resolve.  I tried compiling it into the kernel, but the link at the end
failed, for the same reasons. The details:

<*> /dev/agpgart (AGP Support)                                       
[*]   Intel 440LX/BX/GX and I815/I830M/I840/I850 support             
[*]   Intel I810/I815/I830M (on-board) support                       
[*]   VIA chipset support                                            
[*]   AMD Irongate, 761, and 762 support                             
[*]   Generic SiS support                                            
[*]   ALI chipset support                                            
[*]   Serverworks LE/HE support                                      
[*] Direct Rendering Manager (XFree86 DRI support)                   
[ ]   Build drivers for old (XFree 4.0) DRM                          
--- DRM 4.1 drivers                                                  
<M>   3dfx Banshee/Voodoo3+                                          
<M>   ATI Rage 128                                                   
<M>   ATI Radeon                                                     
<M>   Intel I810                                                     
<M>   Matrox g200/g400                                               
<*>   SiS                                                            

This produces:
... -o vmlinux
drivers/char/drm/drm.o: In function `sis_fb_alloc':
drivers/char/drm/drm.o(.text+0x6893): undefined reference to
`sis_malloc'
drivers/char/drm/drm.o(.text+0x68d6): undefined reference to `sis_free'
drivers/char/drm/drm.o: In function `sis_fb_free':
drivers/char/drm/drm.o(.text+0x69c8): undefined reference to `sis_free'
drivers/char/drm/drm.o: In function `sis_final_context':
drivers/char/drm/drm.o(.text+0x6e4e): undefined reference to `sis_free'

Granted, he does have the one chipset not supported: 5591/5592. 
Nonetheless, the kernel should still compile and link.  Anyway, here's
his lspci output:

00:00.0 Host bridge: Silicon Integrated Systems [SiS] 630 Host (rev 21)
00:00.1 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev
d0)
00:01.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513
00:01.1 Ethernet controller: Silicon Integrated Systems [SiS] SiS900
10/100 Ethernet (rev 83)
00:01.2 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 07)
00:01.3 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 07)
00:01.4 Multimedia audio controller: Silicon Integrated Systems [SiS]
SiS PCI Audio Accelerator (rev 02)
00:02.0 PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP
01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS]
SiS630 GUI Accelerator+3D (rev 21)

The same thing happens with 2.4.17 .



Thanks for your help.

