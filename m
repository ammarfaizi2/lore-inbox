Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261904AbUE3HRq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261904AbUE3HRq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 03:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261907AbUE3HRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 03:17:46 -0400
Received: from wl-193.226.227-253-szolnok.dunaweb.hu ([193.226.227.253]:31625
	"EHLO szolnok.dunaweb.hu") by vger.kernel.org with ESMTP
	id S261904AbUE3HRi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 03:17:38 -0400
Message-ID: <40B98A89.9020200@freemail.hu>
Date: Sun, 30 May 2004 09:17:29 +0200
From: Zoltan Boszormenyi <zboszor@freemail.hu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; hu-HU; rv:1.4.1) Gecko/20031114
X-Accept-Language: hu, en-US
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Dave Airlie <airlied@linux.ie>
Subject: Re: bk-drm patch missing from 2.6.6-mm2 and later?
References: <40B97F6A.1030008@freemail.hu>	<40B982D0.60904@freemail.hu> <20040529235734.2d7acfb5.akpm@osdl.org>
In-Reply-To: <20040529235734.2d7acfb5.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton írta:
> Zoltan Boszormenyi <zboszor@freemail.hu> wrote:
> 
>>Zoltan Boszormenyi írta:
>>
>>>Hi,
>>>
>>>2.6.6-mm1 has it, 2.6.6-mm2 and later does not
>>>and announce.txt from 2.6.6-mm2 does not say
>>>anything about why it has been dropped.
>>>2.6.7-rc1 does not seem to have it either.
>>>Would you please include it again or at least
>>>say something about it...
>>>
>>>Best regards,
>>>Zoltán Böszörményi
>>>
>>
>>Sorry, I searched for "dri" instead of "drm".
>>2.6.7-rc1 has the patch.

           ^ not 2.6.7-rc1-mm1, plain 2.6.7-rc1

> Yes, but it's empty.   Dave, is the latest DRM devel tree
> at http://drm.bkbits.net/drm-2.6?

Empty?

http://www.kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.7-rc1.bz2
has patches to drivers/char/drm/* that look exactly like
the bk-drm.patch from 2.6.6-mm1. And more, like ati_pcigart.h and
others that weren't in 2.6.6-mm1 so that seems newer.

But http://linus.bkbits.net:8080/linux-2.5/ChangeSet@-3w?nav=index.html
does not seem to list it.

http://www.kernel.org/pub/linux/kernel/v2.6/testing/ChangeLog-2.6.7-rc1
has these (I may not have cut&pated every one of them):

<airlied@pdx.freedesktop.org>
         - Converted Linux drivers to initialize DRM instances based on 
PCI IDs, not
         just a single instance. The PCI ID lists include a driver 
private field, which may be used
         by drivers for chip family or other information. Based on work 
by jonsmirl
         and Eric Anholt. I've left out the PCI device naming for this 
patch as
         that might be a bit controversial. clean up tdfx to look like 
everyone else..
 

<airlied@pdx.freedesktop.org>
         From: Eric Anholt:
         - Move IRQ functions from drm_dma.h to new drm_irq.h and 
disentangle them from
         __HAVE_DMA. This will be useful for adding vblank sync support 
to sis and
         tdfx. Rename dma_service to irq_handler, which is more 
accurately what it is.
         - Fix the #if _HAVE_DMA_IRQ in radeon, r128, mga, i810, i830, 
gamma to have
         the right number of underscores. This may have been a problem 
in the case
         that the server died without doing its DRM_IOCTL_CONTROL to uninit
 

<airlied@pdx.freedesktop.org>
         left gamma_dma.c out of last changeset
 

<airlied@pdx.freedesktop.org>
         - Add DRM_GET_PRIV_WITH_RETURN macro. This can be used in 
shared code to get
         the drm_file_t * based on the filp passed in ioctl handlers.
 

<airlied@pdx.freedesktop.org>
         From Eric Anholt:
          Introduce a new ioctl, DRM_IOCTL_SET_VERSION. This ioctl 
allows the server
         or client to notify the DRM that it expects a certain version 
of the device
         dependent or device independent interface. If the major doesn't 
match or minor
         is too large, EINVAL is returned. A major of -1 means that the 
requestor
         doesn't care about that portion of the interface. The ioctl 
returns the actual
         versions in the same struct.
 

<airlied@pdx.freedesktop.org>
         From: Michel Daenzer:
         Memory layout transition:
 

         * the 2D driver initializes MC_FB_LOCATION and related 
registers sanely
         * the DRM deduces the layout from these registers
         * clients use the new SETPARAM ioctl to tell the DRM where they 
think the
         framebuffer is located in the card's address space
         * the DRM uses all this information to check client state and 
fix it up if
         necessary
 

         This is a prerequisite for things like direct rendering with 
IGP chips and
         video capturing.
 

<airlied@pdx.freedesktop.org>
         From Eric Anholt: some cleanups from AlanH:
         - Tie the DRM to a specific device: setunique no longer 
succeeds when given
         a busid that doesn't correspond to the device the DRM is 
attached to. This
         is a breaking of backwards-compatibility only for the 
multiple-DRI-head case
         with X Servers that don't use interface 1.1.
         - Move irq_busid to drm_irq.h and make it only return the IRQ 
for the current
         device. Retains compatibility with previous X Servers, cleans 
up unnecessary
         code. This means no irq_busid on !__HAVE_IRQ, but can be changed if
         necessary.
         - Bump interface version to 1.2. This version when set 
signifies that the
         control ioctl should ignore the irq number passed in and enable the
         interrupt handler for the attached device. Otherwise it errors 
out when
         the passed-in irq is not equal to the device's.
         - Store the highest version the interface has been set to in 
the device.
 

<airlied@pdx.freedesktop.org>
         From Eric Anholt:
         Return EBUSY when attempting to addmap a DRM_SHM area with a 
lock in it if
         dev->lock.hw_lock is already set. This fixes the case of two X 
Servers running
         on the same head on different VTs with interface 1.1, by making 
the 2nd head
         fail to inizialize like before.
 
 
<airlied@pdx.freedesktop.org>
         From Eric Anholt + Jon Smirl:
         Don't ioremap the framebuffer area. The ioremapped area wasn't 
used by
         anything.
 

<airlied@pdx.freedesktop.org>
         From Michel Daenzer:
         Adapt to nopage() prototype change in Linux 2.6.1.
 

         Reviewed by: Arjan van de Ven <arjanv@redhat.com>, additional 
feedback
         from William Lee Irwin III and Linus Torvalds.
 

<airlied@pdx.freedesktop.org>
         More differentiated error codes for DRM(agp_acquire)
 

<airlied@pdx.freedesktop.org>
         drm_ctx_dtor.patch
         Submitted by: Erdi Chen
 

<airlied@pdx.freedesktop.org>
         Miscellaneous changes from DRM CVS
 

<airlied@pdx.freedesktop.org>
         radeon_drm.h:
           missing define from previous checkin
 

<airlied@pdx.freedesktop.org>
         * Introduce COMMIT_RING() as in radeon DRM, stop using error prone
           writeback for ring read pointer (Paul Mackerras)
         * Get rid of some superfluous stuff, minor fixes
 

<airlied@pdx.freedesktop.org>
         From Jon Smirl:
         This code allows the mesa drivers to use a single definition of 
the DRM sarea/IOCTLS


 

Best regards,
Zoltán Böszörményi

