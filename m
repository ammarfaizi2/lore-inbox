Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315417AbSGQQux>; Wed, 17 Jul 2002 12:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315437AbSGQQux>; Wed, 17 Jul 2002 12:50:53 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:11538
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S315417AbSGQQuw>; Wed, 17 Jul 2002 12:50:52 -0400
Date: Wed, 17 Jul 2002 09:48:52 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19-rc2 and !CONFIG_BLK_DEV_IDEPCI
In-Reply-To: <Pine.GSO.4.21.0207171458420.16979-100000@vervain.sonytel.be>
Message-ID: <Pine.LNX.4.10.10207170947420.10225-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Already addressed in a test patch to be run in a LAD-ide-2.5.26-2.patch
soon.  Also "ide-features.c " becomes a deleted file.

On Wed, 17 Jul 2002, Geert Uytterhoeven wrote:

> 	Hi,
> 
> I need the following patch to compile 2.4.19-rc2 for m68k because struct hwif_s
> contains no pci_devid field if CONFIG_BLK_DEV_IDEPCI is not defined.
> 
> --- linux-2.4.19-rc2/drivers/ide/ide-features.c	Wed Jul 17 15:03:10 2002
> +++ linux-m68k-2.4.19-rc2/drivers/ide/ide-features.c	Wed Jul 17 15:12:28 2002
> @@ -245,8 +245,10 @@
>   */
>  byte eighty_ninty_three (ide_drive_t *drive)
>  {
> +#ifdef CONFIG_BLK_DEV_IDEPCI
>  	if (HWIF(drive)->pci_devid.vid==0x105a)
>  	    return(HWIF(drive)->udma_four);
> +#endif
>  	/* PDC202XX: that's because some HDD will return wrong info */
>  	return ((byte) ((HWIF(drive)->udma_four) &&
>  #ifndef CONFIG_IDEDMA_IVB
> 
> Or perhaps all eighty_ninty_three() stuff should be protected by #ifdef
> CONFIG_BLK_DEV_IDEDMA? That seems to work as well (alternative patch below)...
> 
> --- linux-2.4.19-rc2/drivers/ide/ide-features.c	Wed Jul 17 09:53:15 2002
> +++ linux-m68k-2.4.19-rc2/drivers/ide/ide-features.c	Wed Jul 17 13:06:52 2002
> @@ -240,6 +240,7 @@
>  	return 0;
>  }
>  
> +#ifdef CONFIG_BLK_DEV_IDEDMA
>  /*
>   *  All hosts that use the 80c ribbon mus use!
>   */
> @@ -254,6 +255,7 @@
>  #endif /* CONFIG_IDEDMA_IVB */
>  			(drive->id->hw_config & 0x6000)) ? 1 : 0);
>  }
> +#endif // CONFIG_BLK_DEV_IDEDMA
>  
>  /*
>   * Similar to ide_wait_stat(), except it never calls ide_error internally.
> @@ -374,6 +376,8 @@
>  EXPORT_SYMBOL(ide_driveid_update);
>  EXPORT_SYMBOL(ide_ata66_check);
>  EXPORT_SYMBOL(set_transfer);
> +#ifdef CONFIG_BLK_DEV_IDEDMA
>  EXPORT_SYMBOL(eighty_ninty_three);
> +#endif // CONFIG_BLK_DEV_IDEDMA
>  EXPORT_SYMBOL(ide_config_drive_speed);
>  
> Gr{oetje,eeting}s,
> 
> 						Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds
> 

Andre Hedrick
LAD Storage Consulting Group

