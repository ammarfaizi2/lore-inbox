Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262410AbVAZJ4e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262410AbVAZJ4e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 04:56:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262411AbVAZJ4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 04:56:34 -0500
Received: from hermine.aitel.hist.no ([158.38.50.15]:17159 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S262410AbVAZJ41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 04:56:27 -0500
Message-ID: <41F76B4D.8090905@hist.no>
Date: Wed, 26 Jan 2005 11:05:01 +0100
From: Helge Hafting <helge.hafting@hist.no>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Airlie <airlied@gmail.com>
CC: Andreas Hartmann <andihartmann@01019freenet.de>,
       Helge Hafting <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.10 dies when X uses PCI radeon 9200 SE, further binary search
 result
References: <fa.ks44mbo.ljgao4@ifi.uio.no> <fa.hinb9iv.s38127@ifi.uio.no>	 <41F21FA4.1040304@pD9F8757A.dip0.t-ipconnect.de> <21d7e99705012205012c95665@mail.gmail.com>
In-Reply-To: <21d7e99705012205012c95665@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Airlie wrote:

>
>Well if you can track down which patch in -rc2 causes it then we can
>annoy the person who created it, if you build some kernels from the bk
>snapshots it might help as -rc2 is quite large vs -rc1..
>
>  
>
So far, 2.6.9-rc1-bk10 works (X starts without hang, log indicates drm 
works too).

2.6.9-rc1-bk15 started X without a hang, but failed drm according to the 
log:
(II) RADEON(0): [drm] created "radeon" driver at busid "PCI:0:8:0"
(II) RADEON(0): [drm] added 8192 byte SAREA at 0xe0932000
(II) RADEON(0): [drm] mapped SAREA 0xe0932000 to 0xafd8d000
(II) RADEON(0): [drm] framebuffer handle = 0xe0000000
(II) RADEON(0): [drm] added 1 reserved context for kernel
(EE) RADEON(0): [pci] Out of memory (-1007)
(II) RADEON(0): [drm] removed 1 reserved context for kernel
(II) RADEON(0): [drm] unmapping 8192 bytes of SAREA 0xe0932000 at 0xafd8d000
(II) RADEON(0): Memory manager initialized to (0,0) (1280,8191)

A normal lok (bk10) looks like this:
(II) RADEON(0): [drm] created "radeon" driver at busid "PCI:0:8:0"
(II) RADEON(0): [drm] added 8192 byte SAREA at 0xe0932000
(II) RADEON(0): [drm] mapped SAREA 0xe0932000 to 0xafd8d000
(II) RADEON(0): [drm] framebuffer handle = 0xe0000000
(II) RADEON(0): [drm] added 1 reserved context for kernel
(II) RADEON(0): [pci] 8192 kB allocated with handle 0xe0935000
(II) RADEON(0): [pci] ring handle = 0xe0935000
(II) RADEON(0): [pci] Ring mapped at 0xafc8c000
(II) RADEON(0): [pci] Ring contents 0x00000000
(II) RADEON(0): [pci] ring read ptr handle = 0xe0a36000
(II) RADEON(0): [pci] Ring read ptr mapped at 0xafc8b000
(II) RADEON(0): [pci] Ring read ptr contents 0x00000000
(II) RADEON(0): [pci] vertex/indirect buffers handle = 0xe0a37000
(II) RADEON(0): [pci] Vertex/indirect buffers mapped at 0xafa8b000
(II) RADEON(0): [pci] Vertex/indirect buffers contents 0x00000000
(II) RADEON(0): [pci] GART texture map handle = 0xe0c37000
(II) RADEON(0): [pci] GART Texture map mapped at 0xaf5ab000
(II) RADEON(0): [drm] register handle = 0xf6000000
(II) RADEON(0): [dri] Visual configs initialized
(II) RADEON(0): CP in BM mode
(II) RADEON(0): Using 8 MB GART aperture
(II) RADEON(0): Using 1 MB for the ring buffer
(II) RADEON(0): Using 2 MB for vertex/indirect buffers
(II) RADEON(0): Using 5 MB for GART textures
(II) RADEON(0): Memory manager initialized to (0,0) (1280,8191)


What is the most useful to do now?
Binary searching for the crash between bk15 and rc2?   Or:
Binary searching for the "out of memory" between bk10 and bk15?

Helge Hafting


