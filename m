Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966210AbWK2IJh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966210AbWK2IJh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 03:09:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966222AbWK2IJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 03:09:37 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:38306 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S966210AbWK2IJg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 03:09:36 -0500
Message-ID: <456D4033.5000202@gmail.com>
Date: Wed, 29 Nov 2006 09:09:23 +0100
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Randy Dunlap <randy.dunlap@oracle.com>
CC: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Subject: Re: [PATCH -mm] char: drivers use/need PCI
References: <20061128211203.fa197b15.randy.dunlap@oracle.com>
In-Reply-To: <20061128211203.fa197b15.randy.dunlap@oracle.com>
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Muni-Spam-TestIP: 147.251.48.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap wrote:
> From: Randy Dunlap <randy.dunlap@oracle.com>
> 
> With CONFIG_PCI=n:
> drivers/char/mxser_new.c: In function 'mxser_release_res':
> drivers/char/mxser_new.c:2383: warning: implicit declaration of function 'pci_release_region'
> drivers/char/mxser_new.c: In function 'mxser_probe':
> drivers/char/mxser_new.c:2578: warning: implicit declaration of function 'pci_request_region'
> drivers/built-in.o: In function `sx_remove_card':
> sx.c:(.text.sx_remove_card+0x65): undefined reference to `pci_release_region'
> drivers/char/isicom.c: In function 'isicom_probe':
> drivers/char/isicom.c:1793: warning: implicit declaration of function 'pci_request_region'
> drivers/char/isicom.c:1827: warning: implicit declaration of function 'pci_release_region'
> 
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
> ---
>  drivers/char/Kconfig |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> --- linux-2.6.19-rc6-mm2.orig/drivers/char/Kconfig
> +++ linux-2.6.19-rc6-mm2/drivers/char/Kconfig
> @@ -203,7 +203,7 @@ config MOXA_SMARTIO
>  
>  config MOXA_SMARTIO_NEW
>  	tristate "Moxa SmartIO support v. 2.0 (EXPERIMENTAL)"
> -	depends on SERIAL_NONSTANDARD
> +	depends on SERIAL_NONSTANDARD && PCI
>  	help
>  	  Say Y here if you have a Moxa SmartIO multiport serial card and/or
>  	  want to help develop a new version of this driver.
> @@ -218,7 +218,7 @@ config MOXA_SMARTIO_NEW
>  
>  config ISI
>  	tristate "Multi-Tech multiport card support (EXPERIMENTAL)"
> -	depends on SERIAL_NONSTANDARD
> +	depends on SERIAL_NONSTANDARD && PCI
>  	select FW_LOADER
>  	help
>  	  This is a driver for the Multi-Tech cards which provide several
> @@ -312,7 +312,7 @@ config SPECIALIX_RTSCTS
>  
>  config SX
>  	tristate "Specialix SX (and SI) card support"
> -	depends on SERIAL_NONSTANDARD
> +	depends on SERIAL_NONSTANDARD && PCI
>  	help
>  	  This is a driver for the SX and SI multiport serial cards.
>  	  Please read the file <file:Documentation/sx.txt> for details.

Nack. I have to correct the mxser and sx code. Thanks,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
