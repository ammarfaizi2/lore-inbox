Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750839AbWGWHtK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750839AbWGWHtK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 03:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbWGWHtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 03:49:10 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:47979 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750888AbWGWHtI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 03:49:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=sEA1BLW1PaaKELPKKHY494YaW/8Pt5oRcI04qvuONQ5o4qw5K+IgRQDsmZtZpKIaUNEQGnChoXHTCZwzRamp/K9TxqhPThm0aRqP5r0sMz//G/Vkx5xQNTrY9zNUILokl0NLkMKXo9//AOsI3ToImg/p6OIeqFHZp06ZM3UM7tY=
Message-ID: <44C329FB.3010901@gmail.com>
Date: Sun, 23 Jul 2006 09:48:52 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/acpi/battery.c cleanups
References: <20060723002907.GA8886@leiferikson.gentoo>
In-Reply-To: <20060723002907.GA8886@leiferikson.gentoo>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Weiner napsal(a):
> Removed assignment casts, substituted kmalloc+memset with kzalloc, made
> functions void if they never return a value. Style adjustments.
> 
> Signed-off-by: Johannes Weiner <hnazfoo@gmail.com>
> 
> ---
> 
> 
> ------------------------------------------------------------------------
> 
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index 6e52217..85f6a23 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -147,7 +147,7 @@ acpi_battery_get_info(struct acpi_batter
>  		return -ENODEV;
>  	}
>  
> -	package = (union acpi_object *)buffer.pointer;
> +	package = buffer.pointer;
>  
>  	/* Extract Package Data */
>  
> @@ -158,12 +158,11 @@ acpi_battery_get_info(struct acpi_batter
>  		goto end;
>  	}
>  
> -	data.pointer = kmalloc(data.length, GFP_KERNEL);
> +	data.pointer = kzalloc(data.length, GFP_KERNEL);
>  	if (!data.pointer) {
>  		result = -ENOMEM;
>  		goto end;
>  	}
> -	memset(data.pointer, 0, data.length);
>  
>  	status = acpi_extract_package(package, &format, &data);
>  	if (ACPI_FAILURE(status)) {
> @@ -173,11 +172,11 @@ acpi_battery_get_info(struct acpi_batter
>  		goto end;
>  	}
>  
> -      end:
> +end:
>  	kfree(buffer.pointer);
>  
>  	if (!result)
> -		(*bif) = (struct acpi_battery_info *)data.pointer;
> +		(*bif) = data.pointer;

still unneeded ()

>  
>  	return result;
>  }
> @@ -207,7 +206,7 @@ acpi_battery_get_status(struct acpi_batt
>  		return -ENODEV;
>  	}
>  
> -	package = (union acpi_object *)buffer.pointer;
> +	package = buffer.pointer;
>  
>  	/* Extract Package Data */
>  
> @@ -218,12 +217,11 @@ acpi_battery_get_status(struct acpi_batt
>  		goto end;
>  	}
>  
> -	data.pointer = kmalloc(data.length, GFP_KERNEL);
> +	data.pointer = kzalloc(data.length, GFP_KERNEL);
>  	if (!data.pointer) {
>  		result = -ENOMEM;
>  		goto end;
>  	}
> -	memset(data.pointer, 0, data.length);
>  
>  	status = acpi_extract_package(package, &format, &data);
>  	if (ACPI_FAILURE(status)) {
> @@ -233,11 +231,11 @@ acpi_battery_get_status(struct acpi_batt
>  		goto end;
>  	}
>  
> -      end:
> +end:
>  	kfree(buffer.pointer);
>  
>  	if (!result)
> -		(*bst) = (struct acpi_battery_status *)data.pointer;
> +		(*bst) = data.pointer;

and here

regards,
-- 
<a href="http://www.fi.muni.cz/~xslaby/">Jiri Slaby</a>
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
