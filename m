Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266614AbUFRUDK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266614AbUFRUDK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 16:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266727AbUFRUDD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 16:03:03 -0400
Received: from web81307.mail.yahoo.com ([206.190.37.82]:11191 "HELO
	web81307.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266614AbUFRT7e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 15:59:34 -0400
Message-ID: <20040618195930.42655.qmail@web81307.mail.yahoo.com>
Date: Fri, 18 Jun 2004 12:59:30 -0700 (PDT)
From: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: [PATCH 0/3] Couple of sysfs patches
To: Russell King <rmk@arm.linux.org.uk>
Cc: Greg KH <greg@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
>  void platform_device_unregister(struct platform_device * pdev)
>  {
> -	if (pdev)
> +	int i;
> +
> +	if (pdev) {
>  		device_unregister(&pdev->dev);
> +
> +		for (i = 0; i < pdev->num_resources; i++) {
> +			struct resource *r = &pdev->resource[i];
> +			if (r->flags & (IORESOURCE_MEM|IORESOURCE_IO))
> +				release_resource(r);
> +		}
> +	}
>  }

Ok, now it's possibly just a nitpicking but would not it be "more correct"
if allocated resources were freed in reverse order?

--
Dmitry
