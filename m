Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268335AbUI2MiP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268335AbUI2MiP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 08:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268342AbUI2MiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 08:38:15 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:31236 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S268335AbUI2MiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 08:38:09 -0400
Date: Wed, 29 Sep 2004 13:37:59 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: dri-devel <dri-devel@lists.sourceforge.net>,
       Xserver development <xorg@freedesktop.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: New DRM driver model - gets rid of DRM() macros!
Message-ID: <20040929133759.A11891@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jon Smirl <jonsmirl@gmail.com>,
	dri-devel <dri-devel@lists.sourceforge.net>,
	Xserver development <xorg@freedesktop.org>,
	lkml <linux-kernel@vger.kernel.org>
References: <9e4733910409280854651581e2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <9e4733910409280854651581e2@mail.gmail.com>; from jonsmirl@gmail.com on Tue, Sep 28, 2004 at 11:54:35AM -0400
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2004 at 11:54:35AM -0400, Jon Smirl wrote:
> I've checked two new directories into DRM CVS for Linux 2.6 -
> linux-core, shared-core. This code implements a new model for DRM
> where DRM is split into a core piece and personality modules that
> share the core. The major reason for doing this is that it allows me
> to remove all of the DRM() macros; something that is causing lot's of
> complaints from the Linux kernel people.

I gave it a quick look and it looks great so far.

Some ideas that would be nice improvements still (not that some may be
inherited from the old drm code, I just looked at the CVS checkout):

 - once we have Alan's idea of the graphics core implemented drm_init()
   should go awaw
 - drm_probe (and it's call to drm_fill_in_dev) looks a little fishy,
   what about doing the full ->probe callback in each driver where it
   can do basic hw setup, dealing with pci and calls back into the drm
   core for minor number allocation and common structure allocations.
   This would get rid of the ->preinit and ->postinit hooks.
 - isn't drm_order just a copy of get_order()?
 - any chance to use proper kernel-doc comments instead of the bastdized
   and hard to read version you have currently?
 - the coding style is a little strange, like spurious whitespaces inside
   braces, maybe you could run it through scripts/Lindent
 - care to use linux/lists.h instead of opencoded lists, e.g. in
   dev->file_last/dev->file_first or dev->vmalist
 - drm_flush is a noop.  a NULL ->flush does the same thing, just easier
 - dito or ->poll
 - dito for ->read
 - why do you use DRM_COPY_FROM_USER_IOCTL in Linux-specific code?
 - drm__mem_info should be converted to fs/seq_file.c functions
 - dito for functions in drm_proc.c
 
