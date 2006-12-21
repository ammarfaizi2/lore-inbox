Return-Path: <linux-kernel-owner+w=401wt.eu-S1422721AbWLUEy1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422721AbWLUEy1 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 23:54:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422716AbWLUEy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 23:54:27 -0500
Received: from smtp.osdl.org ([65.172.181.25]:37888 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422712AbWLUEyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 23:54:25 -0500
Date: Wed, 20 Dec 2006 20:54:06 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Ralf Baechle <ralf@linux-mips.org>, Jeff Garzik <jgarzik@pobox.com>,
       Antonino Daplas <adaplas@pol.net>, James.Bottomley@SteelEye.com,
       linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH 2.6.20-rc1 01/10] TURBOchannel update to the driver
 model
Message-Id: <20061220205406.0061081c.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64N.0612201139080.11005@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.64N.0612201139080.11005@blysk.ds.pg.gda.pl>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Dec 2006 12:01:30 +0000 (GMT)
"Maciej W. Rozycki" <macro@linux-mips.org> wrote:

> +/**
> + * tc_register_driver - register a new TC driver
> + * @drv: the driver structure to register
> + *
> + * Adds the driver structure to the list of registered drivers
> + * Returns a negative value on error, otherwise 0.
> + * If no error occurred, the driver remains registered even if
> + * no device was claimed during registration.
> + */
> +int tc_register_driver(struct tc_driver *tdrv)
> +{
> +	return driver_register(&tdrv->driver);
> +}
> +EXPORT_SYMBOL(tc_register_driver);
> +
> +/**
> + * tc_unregister_driver - unregister a TC driver
> + * @drv: the driver structure to unregister
> + *
> + * Deletes the driver structure from the list of registered TC drivers,
> + * gives it a chance to clean up by calling its remove() function for
> + * each device it was responsible for, and marks those devices as
> + * driverless.
> + */
> +void tc_unregister_driver(struct tc_driver *tdrv)
> +{
> +	driver_unregister(&tdrv->driver);
> +}
> +EXPORT_SYMBOL(tc_unregister_driver);

I spose making these inline would save a bit of code, stack space and 
a couple of exports.
