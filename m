Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269213AbUI3AAq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269213AbUI3AAq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 20:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269216AbUI3AAq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 20:00:46 -0400
Received: from smtp.easystreet.com ([69.30.22.10]:33834 "EHLO
	smtp.easystreet.com") by vger.kernel.org with ESMTP id S269213AbUI3AAm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 20:00:42 -0400
Subject: Re: New DRM driver model - gets rid of DRM() macros!
From: Eric Anholt <eta@lclark.edu>
To: Keith Whitwell <keith@tungstengraphics.com>
Cc: Jon Smirl <jonsmirl@gmail.com>,
       Discuss issues related to the xorg tree 
	<xorg@freedesktop.org>,
       DRI <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <415AC5C2.9030707@tungstengraphics.com>
References: <9e4733910409280854651581e2@mail.gmail.com>
	 <415AC5C2.9030707@tungstengraphics.com>
Content-Type: text/plain
Message-Id: <1096502440.16006.3.camel@leguin>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 29 Sep 2004 17:00:40 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-29 at 07:25, Keith Whitwell wrote:
> Jon Smirl wrote:
> >
> > Drivers provide these callbacks......
> > 
> > struct drm_driver_fn {
> >        u32 driver_features;
> >        int dev_priv_size;
> >        int permanent_maps;
> >        drm_ioctl_desc_t *ioctls;
> >        int num_ioctls;
> 
> >        int (*preinit)(struct drm_device *, unsigned long flags);
> >        void (*prerelease)(struct drm_device *, struct file *filp);
> >        void (*pretakedown)(struct drm_device *);
> >        int (*postcleanup)(struct drm_device *);
> >        int (*presetup)(struct drm_device *);
> >        int (*postsetup)(struct drm_device *);
> >        int (*dma_ioctl)( DRM_IOCTL_ARGS );
> >        /* these are opposites at the moment */
> >        int (*open_helper)(struct drm_device *, drm_file_t *);
> >        void (*free_filp_priv)(struct drm_device *, drm_file_t *);
> 
> >        void (*release)(struct drm_device *, struct file *filp);
> >        void (*dma_ready)(struct drm_device *);
> 
> Is this used by any driver?
> 
> >        int (*dma_quiescent)(struct drm_device *);
> 
> >        int (*context_ctor)(struct drm_device *dev, int context);
> >        int (*context_dtor)(struct drm_device *dev, int context);
> >        int (*kernel_context_switch)(struct drm_device *dev, int old, int new);
> >        int (*kernel_context_switch_unlock)(struct drm_device *dev);
> 
> The whole context thing in the kernel is pretty much cruft.  The gamma module 
> used to rely on it, maybe the ffb module if that still exists?  It would be 
> good to see this disappear.
> 
> Though the drivers don't rely on it, I don't know if the server-side code 
> persists in setting it up regardless, which might make it hard to get rid of.

SiS relies on context ctor/dtor (dtor only, when I'm done) for its
kernel memory manager.

-- 
Eric Anholt                                eta@lclark.edu          
http://people.freebsd.org/~anholt/         anholt@FreeBSD.org


