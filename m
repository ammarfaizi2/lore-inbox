Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261152AbVFFHRY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbVFFHRY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 03:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261187AbVFFHRY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 03:17:24 -0400
Received: from mail.kroah.org ([69.55.234.183]:22735 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261152AbVFFHRS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 03:17:18 -0400
Date: Sun, 5 Jun 2005 23:22:03 -0700
From: Greg KH <greg@kroah.com>
To: Jean Delvare <khali@linux-fr.org>
Cc: LM Sensors <lm-sensors@lm-sensors.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Yani Ioannou <yani.ioannou@gmail.com>
Subject: Re: More hardware monitoring drivers ported to the new sysfs callbacks
Message-ID: <20050606062203.GA6344@kroah.com>
References: <20050605200901.41592fe9.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050605200901.41592fe9.khali@linux-fr.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 05, 2005 at 08:09:01PM +0200, Jean Delvare wrote:
> Hi all,
> 
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
> Individual patches will follow. Comments welcome. Greg, can you add
> these to one of your trees?

Applied, thanks.

> Before I go on with driver conversion, there are two points I'd like to
> discuss:
> 
> First, I don't much like the name of the new header file,
> linux/i2c-sysfs.h. It isn't related with i2c at all! It's all about
> sensors (or hardware monitoring if you prefer). I think the header file
> should be named linux/hwmon-sysfs.h or something similar.

Sure, that would be fine.

> Second, is there a reason why the SENSOR_DEVICE_ATTR macro creates a
> stucture named sensor_dev_attr_##_name rather than simply
> dev_attr_##_name? As it seems unlikely that SENSOR_DEVICE_ATTR and
> DEVICE_ATTR will both be called for the same file, going for the short
> form shouldn't cause any problem. This would make the calling code more
> readable IMHO.

Hm, I really don't care either way about this.

thanks,

greg k-h
