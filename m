Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbWHKPyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbWHKPyi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 11:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932168AbWHKPyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 11:54:38 -0400
Received: from hera.kernel.org ([140.211.167.34]:2533 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932164AbWHKPyh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 11:54:37 -0400
From: Len Brown <len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] acpi: Fix a broken kfree in i2c_ec
Date: Fri, 11 Aug 2006 11:55:48 -0400
User-Agent: KMail/1.8.2
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <20060811083031.69e20658.khali@linux-fr.org>
In-Reply-To: <20060811083031.69e20658.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608111155.48889.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.
thanks,
-Len

On Friday 11 August 2006 02:30, Jean Delvare wrote:
> Fix an obviously broken kfree() in acpi/i2c_ec device initialization
> error path.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> ---
> This function would benefit from some improvements (single error path,
> kzalloc) but let's fix that obvious bug first. This would preferably go
> to Linus before 2.6.18.
> 
>  drivers/acpi/i2c_ec.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-2.6.18-rc3.orig/drivers/acpi/i2c_ec.c	2006-07-26 23:03:57.000000000 +0200
> +++ linux-2.6.18-rc3/drivers/acpi/i2c_ec.c	2006-08-01 16:22:45.000000000 +0200
> @@ -330,7 +330,7 @@
>  	status = acpi_evaluate_integer(ec_hc->handle, "_EC", NULL, &val);
>  	if (ACPI_FAILURE(status)) {
>  		ACPI_DEBUG_PRINT((ACPI_DB_WARN, "Error obtaining _EC\n"));
> -		kfree(ec_hc->smbus);
> +		kfree(ec_hc);
>  		kfree(smbus);
>  		return -EIO;
>  	}
> 
> 
> -- 
> Jean Delvare
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
