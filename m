Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758053AbWK0L2m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758053AbWK0L2m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 06:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758056AbWK0L2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 06:28:42 -0500
Received: from cantor2.suse.de ([195.135.220.15]:12989 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1758053AbWK0L2l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 06:28:41 -0500
Date: Mon, 27 Nov 2006 12:28:51 +0100
From: Karsten Keil <kkeil@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, kai.germaschewski@gmx.de,
       isdn4linux@listserv.isdn4linux.de, linux-kernel@vger.kernel.org,
       sparclinux@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] remove the broken HISAX_AMD7930 option
Message-ID: <20061127112851.GA23577@pingi.kke.suse.de>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	Andrew Morton <akpm@osdl.org>, kai.germaschewski@gmx.de,
	isdn4linux@listserv.isdn4linux.de, linux-kernel@vger.kernel.org,
	sparclinux@vger.kernel.org
References: <20061125191504.GA3702@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061125191504.GA3702@stusta.de>
Organization: SuSE Linux AG
X-Operating-System: Linux 2.6.16.21-0.23-smp x86_64
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2006 at 08:15:04PM +0100, Adrian Bunk wrote:
> HISAX_AMD7930 was never anywhere near to being working, and this doesn't 
> seem to change in the forseeable future.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 

Acked-by: Karsten Keil <kkeil@suse.de>

> ---
> 
> Thgis patch was already sent on:
> - 18 Nov 2006
> 
>  drivers/isdn/hisax/Kconfig  |    7 -------
>  drivers/isdn/hisax/config.c |   18 ------------------
>  drivers/isdn/hisax/hisax.h  |    6 ------
>  3 files changed, 31 deletions(-)
> 
> --- linux-2.6.19-rc5-mm2/drivers/isdn/hisax/Kconfig.old	2006-11-17 19:41:07.000000000 +0100
> +++ linux-2.6.19-rc5-mm2/drivers/isdn/hisax/Kconfig	2006-11-17 19:41:15.000000000 +0100
> @@ -349,13 +349,6 @@ config HISAX_ENTERNOW_PCI
>  	  This enables HiSax support for the Formula-n enter:now PCI
>  	  ISDN card.
>  
> -config HISAX_AMD7930
> -	bool "Am7930 (EXPERIMENTAL)"
> -	depends on EXPERIMENTAL && SPARC && BROKEN
> -	help
> -	  This enables HiSax support for the AMD7930 chips on some SPARCs.
> -	  This code is not finished yet.
> -
>  endif
>  
>  if ISDN_DRV_HISAX
> --- linux-2.6.19-rc5-mm2/drivers/isdn/hisax/hisax.h.old	2006-11-17 19:41:33.000000000 +0100
> +++ linux-2.6.19-rc5-mm2/drivers/isdn/hisax/hisax.h	2006-11-17 19:41:44.000000000 +0100
> @@ -1139,12 +1139,6 @@ struct IsdnCardState {
>  #define  CARD_HFC_SX 0
>  #endif
>  
> -#ifdef  CONFIG_HISAX_AMD7930
> -#define CARD_AMD7930 1
> -#else
> -#define CARD_AMD7930 0
> -#endif
> -
>  #ifdef	CONFIG_HISAX_NICCY
>  #define	CARD_NICCY 1
>  #ifndef ISDN_CHIP_ISAC
> --- linux-2.6.19-rc5-mm2/drivers/isdn/hisax/config.c.old	2006-11-17 19:41:57.000000000 +0100
> +++ linux-2.6.19-rc5-mm2/drivers/isdn/hisax/config.c	2006-11-17 19:43:03.000000000 +0100
> @@ -227,14 +227,6 @@ const char *CardType[] = {
>  #define DEFAULT_CFG {5,0x2E0,0,0}
>  #endif
>  
> -
> -#ifdef CONFIG_HISAX_AMD7930
> -#undef DEFAULT_CARD
> -#undef DEFAULT_CFG
> -#define DEFAULT_CARD ISDN_CTYPE_AMD7930
> -#define DEFAULT_CFG {12,0x3e0,0,0}
> -#endif
> -
>  #ifdef CONFIG_HISAX_NICCY
>  #undef DEFAULT_CARD
>  #undef DEFAULT_CFG
> @@ -545,10 +537,6 @@ extern int setup_hfcpci(struct IsdnCard 
>  extern int setup_hfcsx(struct IsdnCard *card);
>  #endif
>  
> -#if CARD_AMD7930
> -extern int setup_amd7930(struct IsdnCard *card);
> -#endif
> -
>  #if CARD_NICCY
>  extern int setup_niccy(struct IsdnCard *card);
>  #endif
> @@ -1064,11 +1052,6 @@ static int checkcard(int cardnr, char *i
>  		ret = setup_niccy(card);
>  		break;
>  #endif
> -#if CARD_AMD7930
> -	case ISDN_CTYPE_AMD7930:
> -		ret = setup_amd7930(card);
> -		break;
> -#endif
>  #if CARD_ISURF
>  	case ISDN_CTYPE_ISURF:
>  		ret = setup_isurf(card);
> @@ -1438,7 +1421,6 @@ static int __init HiSax_init(void)
>  			break;
>  		case ISDN_CTYPE_ELSA_PCI:
>  		case ISDN_CTYPE_NETJET_S:
> -		case ISDN_CTYPE_AMD7930:
>  		case ISDN_CTYPE_TELESPCI:
>  		case ISDN_CTYPE_W6692:
>  		case ISDN_CTYPE_NETJET_U:

-- 
Karsten Keil
SuSE Labs
ISDN development
