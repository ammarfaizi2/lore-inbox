Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261339AbVCaVep@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261339AbVCaVep (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 16:34:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbVCaVep
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 16:34:45 -0500
Received: from wproxy.gmail.com ([64.233.184.194]:17999 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261339AbVCaVem (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 16:34:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Vn6pOyEJGhaFMYKlev3pxGsNKq12cgycOmY/aHu4EI65OBYTWT2a9kDiiuEjHdzFrq8aOCVMWWE9qjiue/+AjTNsvUYfi9BzvI8PIOMRT/mJ9TUU3wJcB9vcSzi8WS0aAMP3x8zvyveLEhrObgDdZgULC6vZ1dM/pjD0ACSRLWs=
Message-ID: <40f323d005033113347abcdeb2@mail.gmail.com>
Date: Thu, 31 Mar 2005 16:34:41 -0500
From: Benoit Boissinot <bboissin@gmail.com>
Reply-To: Benoit Boissinot <bboissin@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [2.6 patch] sound/oss/: cleanups
Cc: linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>
In-Reply-To: <20050328220307.GO4285@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <20050306220747.GP5070@stusta.de>
	 <40f323d00503281255124bd0c8@mail.gmail.com>
	 <20050328220307.GO4285@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Mar 2005 00:03:07 +0200, Adrian Bunk <bunk@stusta.de> wrote:
> On Mon, Mar 28, 2005 at 03:55:36PM -0500, Benoit Boissinot wrote:
> > On Sun, 6 Mar 2005 23:07:47 +0100, Adrian Bunk <bunk@stusta.de> wrote:
> > > This patch contains cleanups including the following:
> > > - make needlessly global code static
> > >
> That's a different problem.
> Please apply the patch below on top of my other patch.
>  
> <--  snip  -->
> 
> Rearrange sound/oss/nm256_audio.c and to drop nm256_debug from nm256.h
> since it confuses gcc 4.0 .

Could this patch go in -mm (it is needed for allyesconfig and gcc-4).

Thanks,

Benoit
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6.12-rc1-mm3-full/sound/oss/nm256.h.old     2005-03-28 23:49:39.000000000 +0200
> +++ linux-2.6.12-rc1-mm3-full/sound/oss/nm256.h 2005-03-28 23:51:33.000000000 +0200
> @@ -128,9 +128,6 @@
>      struct nm256_info *next_card;
>  };
> 
> -/* Debug flag--bigger numbers mean more output. */
> -extern int nm256_debug;
> -
>  /* The BIOS signature. */
>  #define NM_SIGNATURE 0x4e4d0000
>  /* Signature mask. */
> --- linux-2.6.12-rc1-mm3-full/sound/oss/nm256_audio.c.old       2005-03-28 23:51:53.000000000 +0200
> +++ linux-2.6.12-rc1-mm3-full/sound/oss/nm256_audio.c   2005-03-28 23:52:19.000000000 +0200
> @@ -28,12 +28,13 @@
>  #include <linux/delay.h>
>  #include <linux/spinlock.h>
>  #include "sound_config.h"
> -#include "nm256.h"
> -#include "nm256_coeff.h"
> 
>  static int nm256_debug;
>  static int force_load;
> 
> +#include "nm256.h"
> +#include "nm256_coeff.h"
> +
>  /*
>   * The size of the playback reserve.  When the playback buffer has less
>   * than NM256_PLAY_WMARK_SIZE bytes to output, we request a new
> 
>
