Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751197AbWITGah@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbWITGah (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 02:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbWITGah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 02:30:37 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:12429 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1751197AbWITGag
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 02:30:36 -0400
Message-ID: <4510E00C.4040703@drzeus.cx>
Date: Wed, 20 Sep 2006 08:30:36 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Alex Dubov <oakad@yahoo.com>
CC: linux-kernel@vger.kernel.org, rmk+lkml@arm.linux.org.uk
Subject: Re: [PATCH 2/2] [MMC] Driver for TI FlashMedia card reader - Kconfig/Makefile
 entries
References: <20060920060410.37146.qmail@web36710.mail.mud.yahoo.com>
In-Reply-To: <20060920060410.37146.qmail@web36710.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Dubov wrote:
> Signed-off-by: Alex Dubov <oakad@yahoo.com>
> ---
>  drivers/misc/Kconfig  |   21 ++++++++++++++++++++-
>  drivers/misc/Makefile |    4 +++-
>  drivers/mmc/Kconfig   |   14 ++++++++++++++
>  drivers/mmc/Makefile  |    1 +
>  4 files changed, 38 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 7fc692a..7dfe4f3 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -28,5 +28,24 @@ config IBM_ASM
>  
>  	  If unsure, say N.
>  
> -endmenu
> +config TIFM_CORE
> +	tristate "TI Flash Media interface support (EXPERIMENTAL)"
> +	depends on EXPERIMENTAL
>   
> +	help
> +	  If you want support for Texas Instruments(R) Flash Media adapters
> +	  you should select this option and than also choose an appropriate
> +	  host adapter and card format driver support.
> +	  
> +	  If unsure, say N.
>   

I believe most drivers do not have this, but either a comment about M
will build a module or nothing at all.

(Yes, yes, I know my drivers do not follow this. I've been meaning to
fix that. :))

> +
> +config TIFM_7XX1
> +	tristate "TI Flash Media PCI74xx/PCI76xx host adapter support (EXPERIMENTAL)"
> +	depends on PCI && TIFM_CORE && EXPERIMENTAL
> +	default TIFM_CORE
> +	help
> +	  This option enables support for Texas Instruments(R) PCI74xx and
> +	  PCI76xx families of Flash Media adapters, found in many laptops.
>  
> +	  If unsure, say N.
> +
>   

Same here. And you should also mention (again) that card drivers are
needed to do anything useful.

> +endmenu
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index 19c2b85..b1a9d90 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -3,5 +3,7 @@ # Makefile for misc devices that really 
>  #
>  obj- := misc.o	# Dummy rule to force built-in.o to be made
>  
> -obj-$(CONFIG_IBM_ASM)	+= ibmasm/
> +obj-$(CONFIG_IBM_ASM)		+= ibmasm/
>  obj-$(CONFIG_HDPU_FEATURES)	+= hdpuftrs/
> +obj-$(CONFIG_TIFM_CORE)       	+= tifm_core.o
> +obj-$(CONFIG_TIFM_7XX1)       	+= tifm_7xx1.o
> diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
> index 45bcf09..aa08dd1 100644
> --- a/drivers/mmc/Kconfig
> +++ b/drivers/mmc/Kconfig
> @@ -109,4 +109,18 @@ config MMC_IMX
>  
>  	  If unsure, say N.
>  
> +comment "Texas Instruments Flash Media MMC/SD interface requires TIFM_CORE"
> +        depends on MMC != n && TIFM_CORE = n
> +	
> +config MMC_TIFM_SD
> +	tristate "TI Flash Media MMC/SD Interface support  (EXPERIMENTAL)"
> +	depends on TIFM_CORE && MMC && EXPERIMENTAL
> +	default TIFM_CORE
> +	help
> +	  This selects the Texas Instruments(R) Flash Media MMC/SD card
> +	  interface found in many laptops.
> +	  If you have a controller with this interface, say Y or M here.
> +
> +	  If unsure, say N.
> +
>   

Ditto. And until this depends/select business is sorted out, I'd prefer
a select on TIFM_CORE here.


Other than that...

Acked-by: Pierre Ossman <drzeus@drzeus.cx>

