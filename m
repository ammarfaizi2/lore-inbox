Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129975AbRAATqU>; Mon, 1 Jan 2001 14:46:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130548AbRAATqK>; Mon, 1 Jan 2001 14:46:10 -0500
Received: from f1j.dsl.xmission.com ([166.70.20.140]:11303 "EHLO
	f1j.dsl.xmission.com") by vger.kernel.org with ESMTP
	id <S129975AbRAATp7>; Mon, 1 Jan 2001 14:45:59 -0500
Message-ID: <3A50D742.441B60F1@xmission.com>
Date: Mon, 01 Jan 2001 12:15:14 -0700
From: Frank Jacobberger <f1j@xmission.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-prerelease i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Adam Sampson <azz@gnu.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Happy new year^H^H^H^Hkernel..
In-Reply-To: <Pine.LNX.4.10.10101010938590.2892-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> On 1 Jan 2001, Adam Sampson wrote:
> >
> > It appears to work (even with the reiserfs patch with the obvious
> > Makefile tweak), but the drm modules have unresolved symbols:
>
> Does this fix it for you (do a "make clean" before re-building your tree)?
>
>                 Linus
>
> ----
> --- v2.4.0-prerelease/linux/drivers/char/drm/Makefile   Mon Jan  1 09:38:35 2001
> +++ linux/drivers/char/drm/Makefile     Mon Jan  1 09:38:04 2001
> @@ -44,22 +44,22 @@
>  mga-objs   := mga_drv.o   mga_dma.o     mga_context.o  mga_bufs.o  mga_state.o
>  i810-objs  := i810_drv.o  i810_dma.o    i810_context.o i810_bufs.o
>
> -obj-$(CONFIG_DRM_GAMMA) += gamma.o
> -obj-$(CONFIG_DRM_TDFX)  += tdfx.o
> -obj-$(CONFIG_DRM_R128)  += r128.o
> -obj-$(CONFIG_DRM_FFB)   += ffb.o
> -obj-$(CONFIG_DRM_MGA)   += mga.o
> -obj-$(CONFIG_DRM_I810)  += i810.o
> -
> -
>  # When linking into the kernel, link the library just once.
>  # If making modules, we include the library into each module
>
>  ifdef MAKING_MODULES
>    lib = drmlib.a
>  else
> -  obj-y += drmlib.a
> +  extra-obj = drmlib.a
>  endif
> +
> +obj-$(CONFIG_DRM_GAMMA) += gamma.o $(extra-obj)
> +obj-$(CONFIG_DRM_TDFX)  += tdfx.o $(extra-obj)
> +obj-$(CONFIG_DRM_R128)  += r128.o $(extra-obj)
> +obj-$(CONFIG_DRM_FFB)   += ffb.o $(extra-obj)
> +obj-$(CONFIG_DRM_MGA)   += mga.o $(extra-obj)
> +obj-$(CONFIG_DRM_I810)  += i810.o $(extra-obj)
> +
>
>  include $(TOPDIR)/Rules.make

Works like a charm here.... fix added drmlib.a with tdfx.o to
/lib/modules/2.4.0-prerelease/kernel/drivers/char/drm


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
