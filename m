Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261594AbVFESZx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261594AbVFESZx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 14:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261597AbVFESZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 14:25:53 -0400
Received: from rproxy.gmail.com ([64.233.170.198]:57112 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261594AbVFESZo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 14:25:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ntFF78ihoXt3b6dpngkMtOV34VXxLA2ffD6yXFaXkjO1vuevyjCsU14w9nINMaug2q28z4ecu/Y5UYBfZ1rUboQlHqVTC5axQ4qRT19Jos2/zvWVPGtpBRFUJhZtRIY79G7ml4thGeHmCjGJLvivd4OVOmPJX9FN5vXwDhAn3IM=
Message-ID: <25381867050605112532cb0700@mail.gmail.com>
Date: Sun, 5 Jun 2005 14:25:43 -0400
From: Yani Ioannou <yani.ioannou@gmail.com>
Reply-To: Yani Ioannou <yani.ioannou@gmail.com>
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: More hardware monitoring drivers ported to the new sysfs callbacks
Cc: LM Sensors <lm-sensors@lm-sensors.org>,
       LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
In-Reply-To: <20050605200901.41592fe9.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050605200901.41592fe9.khali@linux-fr.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean,

> I have been modifying three additional hardware monitoring drivers to
> take benefit of Yani Ioannou's new, extended sysfs callbacks. These
> drivers are lm63, lm83 and lm90. All of these are relatively small when
> compared to the first two modified drivers (adm1026 and it87). My goal
> was to demonstrate that the new callbacks can also be used in small
> drivers, with significant benefits. The result is even smaller drivers
> (less memory used when loaded), relying far less on macros, which makes
> the code easier to read (and the drivers presumably faster to distribute
> using distcc).
>
> Module                Before   After
> lm63                   10128    9424 ( -704/ -6%)
> lm83                    8784    6864 (-1920/-21%)
> lm90                   12420   10628 (-1792/-14%)
> 

Good stuff :-)

> First, I don't much like the name of the new header file,
> linux/i2c-sysfs.h. It isn't related with i2c at all! It's all about
> sensors (or hardware monitoring if you prefer). I think the header file
> should be named linux/hwmon-sysfs.h or something similar.

hwmon wasn't near being added to -mm at the time so I went with the
status quo and named it i2c-sysfs, I'm all for renaming it to
hwmon-sysfs.h though.

> Second, is there a reason why the SENSOR_DEVICE_ATTR macro creates a
> stucture named sensor_dev_attr_##_name rather than simply
> dev_attr_##_name? As it seems unlikely that SENSOR_DEVICE_ATTR and
> DEVICE_ATTR will both be called for the same file, going for the short
> form shouldn't cause any problem. This would make the calling code more
> readable IMHO.

I know the variable names are a bit long, but my patch against adm1026
for example still uses DEVICE_ATTR for attributes that can't make any
use of the dynamic callbacks, and hence I don't want to waste the
extra space required for a sensor device attribute. So there is still
reason to use both in one file. When it comes to macros that define
'hidden' variable names I'm inclined to err on the side of caution and
use the longer name too.

Thanks,
Yani
