Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030251AbWJCC1P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030251AbWJCC1P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 22:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030250AbWJCC1P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 22:27:15 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:12417 "EHLO
	asav10.insightbb.com") by vger.kernel.org with ESMTP
	id S1030239AbWJCC1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 22:27:13 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AR4FAK9mIUWBToozLA
From: Dmitry Torokhov <dtor@insightbb.com>
To: Lennart Poettering <mzxreary@0pointer.de>
Subject: Re: [PATCH] misc,acpi,backlight: MSI S270 Laptop support
Date: Mon, 2 Oct 2006 22:27:09 -0400
User-Agent: KMail/1.9.3
Cc: len.brown@intel.com, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org, s270-linux@mail.0pointer.de
References: <20061003011056.GA28731@ecstasy.ring2.lan>
In-Reply-To: <20061003011056.GA28731@ecstasy.ring2.lan>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610022227.10087.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lennart,

On Monday 02 October 2006 21:10, Lennart Poettering wrote:
> +        
> +        msipf_device = platform_device_register_simple("msi-laptop-pf", -1, NULL, 0);
> +	if (IS_ERR(msipf_device)) {
> +		ret = PTR_ERR(msipf_device);
> +		goto fail_platform_driver;
> +	}
> +

Please do not use platform_device_register_simple, use platform_device_alloc
and platform_device_add instead (_simple will go away some day).

> +        ret = sysfs_create_group(&msipf_device->dev.kobj, &msipf_attribute_group);
> +        if (ret)
> +                goto fail_platform_device;
> +
> +
> +        /* Enable automatic brightness control again */
> +        if (auto_brightness != 2)
> +                set_auto_brightness(1);     
> +

What happens if auto_brightness is 2 but userspace messed up with it
through device's sysfs attribute? Overall brightness controll interface
(module vs. per-device) needs to be tightened up.

-- 
Dmitry
