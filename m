Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267248AbUIPEnK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267248AbUIPEnK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 00:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267378AbUIPEnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 00:43:09 -0400
Received: from mproxy.gmail.com ([216.239.56.251]:57116 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267248AbUIPEnB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 00:43:01 -0400
Message-ID: <21d7e99704091521426866c520@mail.gmail.com>
Date: Thu, 16 Sep 2004 14:42:53 +1000
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: dri-devel@lists.sourceforge.net, arlied@linux.ie,
       linux-kernel@vger.kernel.org
Subject: Re: DRM regression in Linux 2.6.9-rc1-bk12
In-Reply-To: <20040916025942.GA27261@samarkand.rivenstone.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20040916025942.GA27261@samarkand.rivenstone.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for this report, I'll look over the changes for pcigart this
evening, I don't own a PCI radeon to test on... hopefully it's just
something small in the reduced macro code...

Dave.


On Wed, 15 Sep 2004 22:59:43 -0400, Joseph Fannin <jhf@rivenstone.net> wrote:
>     Hi!
> 
>     [ I suspect dri-devel is going to bounce my mails, so I'm CC'ing
> linux-kernel ]
> 
>     DRI stopped working on my setup in Linux 2.6.9-rc1-bk12.  I've
> narrowed the problem down to this changeset (Drop __HAVE_CTX_BITMAP,
> __HAVE_SG, __HAVE_PCI_DMA):
> 
> http://linux.bkbits.net:8080/linux-2.5/cset@413a5e3ecfrYcOqFo6JOgkPIU-qVmQ
> 
>     Backing this patch out makes DRI in -bk12 work again.
> 
>     I've verified this on two machines with PCI Radeon 7000 cards, so
> there's PCIGART stuff involved; unfortunately I don't have any AGP
> Radeons to test with.  (I originally suspected the __REALLY_HAVE_AGP
> change, but that's fine, along with the DRIVER_FILE_FIELDS removal).
> 
>     For what it matters, I'm primarily testing on a ppc Macintosh, but
> I've verified this on a PC too.
> 
>     Wow, there was no kidding about DRM being difficult to read.  :-)
> I hope this is helpful, but I don't urgently need DRI working.  I'd be
> glad to give any help tracking the problem down.
> 
>     On kernels with non-working DRM, I get this message from the kernel:
> 
> [drm:radeon_cp_init] *ERROR* radeon_cp_init called without lock held
> [drm:radeon_unlock] *ERROR* Process 2150 using kernel context 0
> 
>     While X says:
> 
>         [24] 0  0       0x000003c0 - 0x000003df (0x20) IS[B](OprU)
> drmOpenDevice: minor is 0
> drmOpenDevice: node name is /dev/dri/card0
> drmOpenDevice: open result is -1, (Unknown error 999)
> drmOpenDevice: open result is -1, (Unknown error 999)
> drmOpenDevice: Open failed
> drmOpenDevice: minor is 0
> drmOpenDevice: node name is /dev/dri/card0
> drmOpenDevice: open result is -1, (Unknown error 999)
> drmOpenDevice: open result is -1, (Unknown error 999)
> drmOpenDevice: Open failed
> drmOpenDevice: minor is 0
> drmOpenDevice: node name is /dev/dri/card0
> drmOpenDevice: open result is 7, (OK)
> drmGetBusid returned ''
> (II) RADEON(0): [drm] loaded kernel module for "radeon" driver
> (II) RADEON(0): [drm] created "radeon" driver at busid "PCI:0:18:0"
> (II) RADEON(0): [drm] added 8192 byte SAREA at 0xcd971000
> (II) RADEON(0): [drm] mapped SAREA 0xcd971000 to 0xb5d89000
> (II) RADEON(0): [drm] framebuffer handle = 0xd8000000
> (II) RADEON(0): [drm] added 1 reserved context for kernel
> 
> (EE) RADEON(0): [pci] Out of memory (-1007)          <------- *** LOOK HERE ***
> 
> (II) RADEON(0): [drm] removed 1 reserved context for kernel
> (II) RADEON(0): [drm] unmapping 8192 bytes of SAREA 0xcd971000 at
> 0xb5d89000
> (II) RADEON(0): Memory manager initialized to (0,0) (1280,6553)
> (II) RADEON(0): Reserved area from (0,1024) to (1280,1026)
> (II) RADEON(0): Largest offscreen area available: 1280 x 5527
> (II) RADEON(0): Using XFree86 Acceleration Architecture (XAA)
> 
> <snip>
> 
> (II) RADEON(0): Direct rendering disabled
> 
>     Thanks!
> 
> --
> Joseph Fannin
> jhf@rivenstone.net
> 
> "Bull in pure form is rare; there is usually some contamination by data."
>     -- William Graves Perry Jr.
> 
> 
> 
>
