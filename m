Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263614AbTDXMYh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 08:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263638AbTDXMYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 08:24:37 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:59666 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263614AbTDXMYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 08:24:34 -0400
Date: Thu, 24 Apr 2003 13:36:41 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Marc Zyngier <mzyngier@freesurf.fr>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] aha1740 update
Message-ID: <20030424133641.A29770@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Marc Zyngier <mzyngier@freesurf.fr>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
References: <wrpk7dkt84r.fsf@hina.wild-wind.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <wrpk7dkt84r.fsf@hina.wild-wind.fr.eu.org>; from mzyngier@freesurf.fr on Thu, Apr 24, 2003 at 02:03:32PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 24, 2003 at 02:03:32PM +0200, Marc Zyngier wrote:
>   * forms part of the process of creating an executable the information
> @@ -44,6 +47,11 @@
>  #include <asm/system.h>
>  #include <asm/io.h>
>  
> +#include <linux/init.h>
> +#include <linux/device.h>
> +#include <linux/eisa.h>
> +#include <linux/dma-mapping.h>

If there's a chance put this before the <asm/*.h> includes.

> +/* This should really fit in driver/scsi/scsi.h, along with
> + * scsi_to_{pci,sbus}_dma_dir.... */

Right.  Please submit a patch to James.

> +/* Eventually this will go into an include file, but this will be later */

No. (okay, you just moved it..)

> +static Scsi_Host_Template driver_template = AHA1740;

Please initialize the struct here instead of the macro obsfucation.
(again not yhour fault, but you're touching the driver so please
clean it up while at it).

> -#include "scsi_module.c"
> +static __init int aha1740_init (void)
> +{
> +    driver_template.module = THIS_MODULE;

Please do this at compile-time.

>  /* Okay, you made it all the way through.  As of this writing, 3/31/93, I'm
>  brad@saturn.gaylord.com or brad@bradpc.gaylord.com.  I'll try to help as time

This comment looks a _bit_ outdated to me, what about nuking it?

Well, and as you're touching the driver big time a cleanup to follow
Documentation/CondingStyle would be nice.
