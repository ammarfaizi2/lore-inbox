Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030328AbWHUIET@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030328AbWHUIET (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 04:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030338AbWHUIET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 04:04:19 -0400
Received: from smtp-101-monday.nerim.net ([62.4.16.101]:39951 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1030328AbWHUIES
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 04:04:18 -0400
Date: Mon, 21 Aug 2006 10:04:16 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, lm-sensors@lm-sensors.org,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [lm-sensors] [RFC][PATCH] hwmon:fix sparse warnings + error
 handling
Message-Id: <20060821100416.4d356328.khali@linux-fr.org>
In-Reply-To: <44E8C9AE.3060307@gmail.com>
References: <44E8C9AE.3060307@gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> --- linux-work-clean/drivers/hwmon/w83627hf.c	2006-08-20 22:02:40.000000000 +0200
> +++ linux-work/drivers/hwmon/w83627hf.c	2006-08-20 22:27:14.000000000 +0200
> @@ -513,9 +513,21 @@ static DEVICE_ATTR(in0_max, S_IRUGO | S_
> 
>  #define device_create_file_in(client, offset) \
>  do { \
> -device_create_file(&client->dev, &dev_attr_in##offset##_input); \
> -device_create_file(&client->dev, &dev_attr_in##offset##_min); \
> -device_create_file(&client->dev, &dev_attr_in##offset##_max); \
> +	err = device_create_file(&client->dev, &dev_attr_in##offset##_input); \
> +	if (err) {\
> +		hwmon_device_unregister(data->class_dev); \
> +		return err; \
> +	} \
> +	err = device_create_file(&client->dev, &dev_attr_in##offset##_min); \
> +	if (err) {\
> +		hwmon_device_unregister(data->class_dev); \
> +		return err; \
> +	} \
> +	err = device_create_file(&client->dev, &dev_attr_in##offset##_max); \
> +	if (err) {\
> +		hwmon_device_unregister(data->class_dev); \
> +		return err; \
> +	} \
>  } while (0)

_Never_ use "return" in a macro. It's way too confusing for whoever will
read the code later.

-- 
Jean Delvare
