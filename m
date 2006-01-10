Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751097AbWAJPFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbWAJPFP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 10:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbWAJPFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 10:05:15 -0500
Received: from smtp107.sbc.mail.mud.yahoo.com ([68.142.198.206]:58782 "HELO
	smtp107.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751097AbWAJPFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 10:05:14 -0500
From: David Brownell <david-b@pacbell.net>
To: spi-devel-general@lists.sourceforge.net, dpervushin@ru.mvista.com
Subject: Re: [spi-devel-general] [PATCH] spi: add bus methods instead of driver's ones
Date: Tue, 10 Jan 2006 07:05:12 -0800
User-Agent: KMail/1.7.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1136893627.4780.9.camel@diimka-laptop>
In-Reply-To: <1136893627.4780.9.camel@diimka-laptop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601100705.13313.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 January 2006 3:47 am, dmitry pervushin wrote:
> The patch below replaces probe/remove/shutdown functions in device_driver
> structure by corresponding methods of spi_bus_type. 

> Signed-off-by: dmitry pervushin <dpervushin@ru.mvista.com>
> Index: linux-2.6.15.y/drivers/spi/spi.c
> ===================================================================
> --- linux-2.6.15.y.orig/drivers/spi/spi.c
> +++ linux-2.6.15.y/drivers/spi/spi.c
> @@ -125,42 +125,40 @@ struct bus_type spi_bus_type = {
>  	.dev_attrs	= spi_dev_attrs,
>  	.match		= spi_match_device,
>  	.uevent		= spi_uevent,
> +	.probe		= spi_bus_probe,
> +	.remove		= spi_bus_remove,
> +	.shutdown	= spi_bus_shutdown,
>  	.suspend	= spi_suspend,
>  	.resume		= spi_resume,
>  };

What kernel are you using here?  The one I'm looking at -- GIT snapshot
as of a few minutes ago -- doesn't have probe(), remove(), or shutdown()
methods in "struct bus_type".  I don't recall that it ever had such...



