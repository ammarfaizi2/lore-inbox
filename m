Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030308AbWBNDrV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030308AbWBNDrV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 22:47:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030314AbWBNDrV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 22:47:21 -0500
Received: from smtp111.sbc.mail.mud.yahoo.com ([68.142.198.210]:55455 "HELO
	smtp111.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030308AbWBNDrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 22:47:20 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Alessandro Zummo <azummo-vger@towertech.it>
Subject: Re: [PATCH 04/11] RTC subsystem, sysfs interface
Date: Mon, 13 Feb 2006 22:47:17 -0500
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20060213225416.865078000@towertech.it> <20060213225417.706366000@towertech.it>
In-Reply-To: <20060213225417.706366000@towertech.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602132247.17653.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alessandro,

On Monday 13 February 2006 17:54, Alessandro Zummo wrote:
> +static ssize_t rtc_sysfs_show_date(struct class_device *dev, char *buf)
> +{
> +	ssize_t retval = -ENODEV;
> +	struct rtc_time tm;
> +
> +	if ((retval = rtc_read_time(dev, &tm)) == 0) {

Retval is set unconditionally here so there is no point in initializing
it to -ENODEV above.

> +		retval = sprintf(buf, "%04d-%02d-%02d\n",
> +			tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday);
> +	}
> +
> +	return retval;
> +}
> +static CLASS_DEVICE_ATTR(date, S_IRUGO, rtc_sysfs_show_date, NULL);
> +
> +static ssize_t rtc_sysfs_show_time(struct class_device *dev, char *buf)
> +{
> +	ssize_t retval = -ENODEV;
> +	struct rtc_time tm;
> +
> +	if ((retval = rtc_read_time(dev, &tm)) == 0) {

Same here.

> +		retval = sprintf(buf, "%02d:%02d:%02d\n",
> +			tm.tm_hour, tm.tm_min, tm.tm_sec);
> +	}
> +
> +	return retval;
> +}
> +static CLASS_DEVICE_ATTR(time, S_IRUGO, rtc_sysfs_show_time, NULL);
> +
> +static ssize_t rtc_sysfs_show_since_epoch(struct class_device *dev, char *buf)
> +{
> +	ssize_t retval = -ENODEV;
> +	struct rtc_time tm;
> +
> +	if ((retval = rtc_read_time(dev, &tm)) == 0) {

And here.

> +		unsigned long time;
> +		rtc_tm_to_time(&tm, &time);
> +		retval = sprintf(buf, "%lu\n", time);
> +	}
> +
> +	return retval;
> +}
> +static CLASS_DEVICE_ATTR(since_epoch, S_IRUGO, rtc_sysfs_show_since_epoch, NULL);
> +
> +/* insertion/removal hooks */
> +
> +static int __devinit rtc_sysfs_add_device(struct class_device *class_dev,
> +					   struct class_interface *class_intf)
> +{
> +	class_device_create_file(class_dev, &class_device_attr_name);
> +	class_device_create_file(class_dev, &class_device_attr_date);
> +	class_device_create_file(class_dev, &class_device_attr_time);
> +	class_device_create_file(class_dev, &class_device_attr_since_epoch);

Maybe using attribute group here will help and also allow easier error
hanling?

-- 
Dmitry
