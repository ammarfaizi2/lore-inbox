Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261707AbVGITVn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261707AbVGITVn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 15:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261710AbVGITVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 15:21:43 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:53484 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261707AbVGITVP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 15:21:15 -0400
Date: Sat, 9 Jul 2005 21:19:04 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Marcel Selhorst <selhorst@crypto.rub.de>
Cc: linux-kernel@vger.kernel.org, kjhall@us.ibm.com, adobriyan@gmail.com
Subject: Re: [PATCH] tpm: Support for new chip type
Message-ID: <20050709191903.GB1553@elf.ucw.cz>
References: <42CDAFBA.5080005@crypto.rub.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42CDAFBA.5080005@crypto.rub.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> after some corrections here is a newer patch supporting the Infineon Trusted Platform
> Module SLD 9630 (TPM 1.1b), which is embedded on Intel-mainboards or in
> HP/Fujitsu-Siemens/Toshiba-Notebooks.
> The module fits the interfaces created by IBM and was patched against the
> latest kernel-snapshot 2.6.13-rc2.
> Further information about this module and a list of supported hardware can be
> found here: http://www.prosec.rub.de/tpm
> 
> Best Regards,
> Marcel Selhorst
> 
> Signed-off-by: Marcel Selhorst <selhorst@crypto.rub.de>

> diff -uprN linux-2.6.12.2/drivers/char/tpm/tpm_infineon.c linux/drivers/char/tpm/tpm_infineon.c
> --- linux-2.6.12.2/drivers/char/tpm/tpm_infineon.c	1970-01-01 00:00:00.000000000 +0000
> +++ linux/drivers/char/tpm/tpm_infineon.c	2005-07-07 14:56:27.000000000 +0000
> @@ -0,0 +1,505 @@
> +/*
> + * Copyright (C) 2005
> + * Marcel Selhorst <selhorst@crypto.rub.de>
> + * Applied Data Security Group
> + * Ruhr-University Bochum, Germany
> + *

Could you make this

> + * Copyright (C) 2005 Marcel Selhorst <selhorst@crypto.rub.de>
> + * Applied Data Security Group Ruhr-University Bochum, Germany

and make sure Description stands out a bit more (like maybe putting it
first?)

> + * Description:
> + * Device Driver for the Infineon Technologies
> + * SLD 9630 TT Trusted Platform Module
> + * Specifications at www.trustedcomputinggroup.org	
> + *
> + * Project-Homepage:
> + * http://www.prosec.rub.de/tpm
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation, version 2 of the
> + * License.
> + *
> + */

> +#include "tpm.h"
> +
> +/* Infineon specific delay definitions */
> +enum infineon_tpm_delay {
> +	TPM_MAX_WTX_PACKAGES = 50,	/* maximum number of WTX-packages */
> +	TPM_WTX_MSLEEP_TIME = 20,	/* msleep-Time for WTX-packages */
> +	TPM_MSLEEP_TIME = 3,	/* msleep-Time --> Interval to check status register */
> +	TPM_MAX_TRIES = 5000	/* gives number of max. msleep()-calls before
> +				   throwing timeout */
> +};

> +/* Infineon specific TPM data */
> +enum infineon_tpm_specific {
> +	TCPA_INFINEON_DEV_VEN_VALUE = 0x15D1,
> +	TPM_DATA = (TPM_ADDR + 1) & 0xff
> +};

Ugh, is it just me or are you abusing enums a bit?
> +static int __init tpm_inf_probe(struct pci_dev *pci_dev,
> +				const struct pci_device_id *pci_id)
> +{
> +
> +	int rc = 0;
> +	u8 ioh;
> +	u8 iol;

Put these two on one line? Are you sure probe can't be called during
runtime for some pci hotplug case?
								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
