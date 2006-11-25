Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966284AbWKYI7Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966284AbWKYI7Y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 03:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966285AbWKYI7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 03:59:24 -0500
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:36759 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S966284AbWKYI7X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 03:59:23 -0500
Message-ID: <456805F3.1020407@drzeus.cx>
Date: Sat, 25 Nov 2006 09:59:31 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: Anderson Briglia <anderson.briglia@indt.org.br>
CC: "Linux-omap-open-source@linux.omap.com" 
	<linux-omap-open-source@linux.omap.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Tony Lindgren <tony@atomide.com>,
       "Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>,
       ext David Brownell <david-b@pacbell.net>,
       "Lizardo Anderson (EXT-INdT/Manaus)" <anderson.lizardo@indt.org.br>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 5/5] [RFC] Add MMC Password Protection (lock/unlock) support
 V7: mmc_omap_dma.diff
References: <4564648B.2020005@indt.org.br>
In-Reply-To: <4564648B.2020005@indt.org.br>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anderson Briglia wrote:
> OMAP platform specific patch.
> - Adjust the frame size for DMA transfers.
>
> Signed-off-by: Anderson Briglia <anderson.briglia <at> indt.org.br>
> Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar <at> indt.org.br>
>

This looks like a generic patch for OMAP and shouldn't be in this set.

> Index: linux-omap-2.6.git/drivers/mmc/omap.c
> ===================================================================
> --- linux-omap-2.6.git.orig/drivers/mmc/omap.c    2006-11-22
> 09:07:25.000000000 -0400
> +++ linux-omap-2.6.git/drivers/mmc/omap.c    2006-11-22
> 09:19:03.000000000 -0400
> @@ -629,6 +629,14 @@ mmc_omap_prepare_dma(struct mmc_omap_hos
>
>      data_addr = host->phys_base + OMAP_MMC_REG_DATA;
>      frame = data->blksz;
> +
> +#ifdef CONFIG_MMC_PASSWORDS
> +    /* MMC LOCK/UNLOCK: Do frame size multiple of two. This is
> +     * needed for DMA transfers to work properly, once
> +     * the block size depends on MMC password length.
> +     */
> +    frame += frame&0x1;
> +#endif
>      count = sg_dma_len(sg);
>
>      if ((data->blocks == 1) && (count > (data->blksz)))
>

Now this you're going to have to explain to me. Especially the part
where why this is specific to the lock commands.

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org

