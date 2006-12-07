Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032388AbWLGQmi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032388AbWLGQmi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 11:42:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032394AbWLGQmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 11:42:38 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:51606 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1032388AbWLGQmi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 11:42:38 -0500
Date: Thu, 7 Dec 2006 08:43:07 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kbuild : Make Fusion MPT selectable from "Device
 drivers" menu
Message-Id: <20061207084307.7e6de9ec.randy.dunlap@oracle.com>
In-Reply-To: <Pine.LNX.4.64.0612070651560.17882@localhost.localdomain>
References: <Pine.LNX.4.64.0612070651560.17882@localhost.localdomain>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2006 06:59:52 -0500 (EST) Robert P. J. Day wrote:

> 
>   Rewrite the Fusion MPT Kconfig file so that all of MPT functionality
> is entirely selectable from "Device drivers."
> 
> Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>

Acked-by: Randy Dunlap <randy.dunlap@oracle.com>

but I think that you should cc: the FUSION email addresses
that are listed in the MAINTAINERS file...


> ---
> 
>   The original Kconfig file seems to have an odd structure, as you can
> see from the first part of the file:
> 
> ========================================================
> menu "Fusion MPT device support"
> 
> config FUSION
>         bool
>         default n
> 
> config FUSION_SPI
>         tristate "Fusion MPT ScsiHost drivers for SPI"
>         depends on PCI && SCSI
>         select FUSION
>         select SCSI_SPI_ATTRS
>         ...
> ========================================================
> 
>   note how the majority of entries in that file don't directly
> *depend* on FUSION.  instead, they depend on *external* config
> variables, and *select* FUSION, and this is not the only place i've
> noticed that kind of dependency wording.
> 
>   is that a regular feature?  having that structure certainly makes it
> slightly more difficult to rewrite the menu entries, and it's not
> clear there's any obvious advantage to doing it that way.
> 
> 
> diff --git a/drivers/message/fusion/Kconfig b/drivers/message/fusion/Kconfig
> index ea31d84..b2da14d 100644
> --- a/drivers/message/fusion/Kconfig
> +++ b/drivers/message/fusion/Kconfig
> @@ -1,14 +1,12 @@
> -
> -menu "Fusion MPT device support"
> -
> -config FUSION
> -	bool
> +menuconfig FUSION
> +	bool "Fusion MPT device support"
>  	default n
> 
> +if FUSION
> +
>  config FUSION_SPI
>  	tristate "Fusion MPT ScsiHost drivers for SPI"
>  	depends on PCI && SCSI
> -	select FUSION
>  	select SCSI_SPI_ATTRS
>  	---help---
>  	  SCSI HOST support for a parallel SCSI host adapters.
> @@ -23,7 +21,6 @@ config FUSION_SPI
>  config FUSION_FC
>  	tristate "Fusion MPT ScsiHost drivers for FC"
>  	depends on PCI && SCSI
> -	select FUSION
>  	select SCSI_FC_ATTRS
>  	---help---
>  	  SCSI HOST support for a Fiber Channel host adapters.
> @@ -40,7 +37,6 @@ config FUSION_FC
>  config FUSION_SAS
>  	tristate "Fusion MPT ScsiHost drivers for SAS"
>  	depends on PCI && SCSI
> - 	select FUSION
>  	select SCSI_SAS_ATTRS
>  	---help---
>  	  SCSI HOST support for a SAS host adapters.
> @@ -100,4 +96,4 @@ config FUSION_LAN
> 
>  	  If unsure whether you really want or need this, say N.
> 
> -endmenu
> +endif
> -


---
~Randy
