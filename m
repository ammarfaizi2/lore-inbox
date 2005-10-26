Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964847AbVJZRlH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964847AbVJZRlH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 13:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964848AbVJZRlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 13:41:07 -0400
Received: from smtp6-g19.free.fr ([212.27.42.36]:8834 "EHLO smtp6-g19.free.fr")
	by vger.kernel.org with ESMTP id S964847AbVJZRlG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 13:41:06 -0400
Message-ID: <435FBFC4.5060508@free.fr>
Date: Wed, 26 Oct 2005 19:41:24 +0200
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: Marcel Selhorst <selhorst@crypto.rub.de>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Kylene Jo Hall <kjhall@us.ibm.com>
Subject: Re: [PATCH] Infineon TPM: move infineon driver off pci_dev
References: <435FB8A5.803@crypto.rub.de>
In-Reply-To: <435FB8A5.803@crypto.rub.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Marcel Selhorst wrote:
> Dear all,
> 
> the following patch moves the Infineon TPM driver off pci device
> and makes it a pure pnp-driver. It was tested with IFX0101 and
> IFX0102 and is now based on the tpm patchset (1 to 5) from Kylene
> Hall submitted yesterday.
> 
> Best regards,
> 
> Marcel Selhorst
> 
> Signed-off-by: Marcel Selhorst <selhorst@crypto.rub.de>
> ---
> 
> diff -pruN linux-2.6.14-rc5.ibm/drivers/char/tpm/tpm_infineon.c
> linux-2.6.14-rc5.infineon_v1.6/drivers/char/tpm/tpm_infineon.c
> --- linux-2.6.14-rc5.ibm/drivers/char/tpm/tpm_infineon.c	2005-10-26
> 15:21:53.000000000 +0200
> +++ linux-2.6.14-rc5.infineon_v1.6/drivers/char/tpm/tpm_infineon.c	2005-10-26
> 15:21:42.000000000 +0200
> @@ -5,6 +5,7 @@
>   * Specifications at www.trustedcomputinggroup.org
>   *
>   * Copyright (C) 2005, Marcel Selhorst <selhorst@crypto.rub.de>
> + * Sirrix AG - security technologies, http://www.sirrix.com and
>   * Applied Data Security Group, Ruhr-University Bochum, Germany
>   * Project-Homepage: http://www.prosec.rub.de/tpm
>   *
> @@ -31,7 +32,7 @@
>  /* These values will be filled after PnP-call */

> +	/* read IO-ports through PnP */
> +	if (pnp_port_valid(dev, 0) &&
> +	    !(pnp_port_flags(dev, 0) & IORESOURCE_DISABLED)) {
> +		TPM_INF_ADDR = pnp_port_start(dev, 0);
> +		TPM_INF_DATA = (TPM_INF_ADDR + 1);
> +		TPM_INF_BASE = pnp_port_start(dev, 1);
You should add a pnp_port_valid(dev, 1) check.
If you are paranoid, you could also check the port len.

I don't remember if it is done somewhere, but a request_region should be 
used.

The others parts are ok for me.

Matthieu
