Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261259AbTEKLbC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 07:31:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261261AbTEKLbC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 07:31:02 -0400
Received: from netline-be1.netline.ch ([195.141.226.32]:3086 "EHLO
	netline-be1.netline.ch") by vger.kernel.org with ESMTP
	id S261259AbTEKLa7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 07:30:59 -0400
Subject: Re: Improved DRM support for cant_use_aperture platforms
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: davidm@hpl.hp.com
Cc: davej@suse.de, linux-kernel@vger.kernel.org,
       dri-devel@lists.sourceforge.net
In-Reply-To: <200305101009.h4AA9GZi012265@napali.hpl.hp.com>
References: <200305101009.h4AA9GZi012265@napali.hpl.hp.com>
Content-Type: text/plain; charset=iso-8859-1
Organization: Debian, XFree86
Message-Id: <1052653415.12338.159.camel@thor>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.1.99 (Preview Release)
Date: 11 May 2003 13:43:36 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sam, 2003-05-10 at 12:09, David Mosberger wrote:
> 
> This patch is rather big, but actually very straight-forward: it adds
> a "agp dev" argument to DRM_IOREMAP(), DRM_IOREMAP_NOCACHE(), and
> DRM_IOREMAPFREE() and then uses it in drm_memory.h to support
> platforms where CPU accesses to the AGP space are not translated by
> the GART (true for ia64 and alpha, not true for x86, I don't know
> about the other platforms).  On platforms where cant_use_aperture is
> always false, this whole patch will look like a no-op.  On ia64, it
> works.  Don't know about other platforms, but it should simplify
> things for Alpha at least (and if it breaks a platform, I shall be
> happy to work with the respective maintainer to get fix back to
> working).

I'd love to commit this to DRI CVS, but there'd have to be fallbacks for
older kernels (this is against 2.4.20-ben8):

gcc
-I/home/michdaen/src/dri-cvs/xc-trunk/programs/Xserver/hw/xfree86/os-support/linux/drm/kernel -D__KERNEL__ -I/home/michdaen/src/linux-2.4.20-ben8-xfs-lolat/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -I/home/michdaen/src/linux-2.4.20-ben8-xfs-lolat/arch/ppc -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -DMODULE  -nostdinc -iwithprefix include -DKBUILD_BASENAME=radeon_drv  -c -o radeon_drv.o radeon_drv.c
In file included from radeon_drv.c:49:
drm_memory.h:37:21: asm/agp.h: No such file or directory
drm_memory.h:38:26: asm/tlbflush.h: No such file or directory
In file included from radeon_drv.c:49:
drm_memory.h: In function `agp_remap':
drm_memory.h:98: warning: implicit declaration of function `pfn_to_page'
drm_memory.h:98: warning: assignment makes pointer from integer without
a cast
drm_memory.h:99: warning: implicit declaration of function `vmap'
drm_memory.h:99: `PAGE_AGP' undeclared (first use in this function)
drm_memory.h:99: (Each undeclared identifier is reported only once
drm_memory.h:99: for each function it appears in.)
drm_memory.h:99: warning: assignment makes pointer from integer without
a cast
drm_memory.h:104: warning: implicit declaration of function
`flush_tlb_kernel_range'
drm_memory.h: In function `drm_follow_page':
drm_memory.h:113: warning: implicit declaration of function
`pte_offset_kernel'
drm_memory.h:113: warning: initialization makes pointer from integer
without a cast
drm_memory.h:114: warning: implicit declaration of function `pte_pfn'
drm_memory.h: In function `drm_ioremapfree':
drm_memory.h:186: warning: implicit declaration of function `vunmap'
make[3]: *** [radeon_drv.o] Error 1


-- 
Earthling Michel Dänzer   \  Debian (powerpc), XFree86 and DRI developer
Software libre enthusiast  \     http://svcs.affero.net/rm.php?r=daenzer

