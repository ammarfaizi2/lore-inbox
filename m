Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261599AbVFESIF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261599AbVFESIF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 14:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261603AbVFESIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 14:08:05 -0400
Received: from smtp-100-sunday.nerim.net ([62.4.16.100]:10762 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261599AbVFESH5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 14:07:57 -0400
Date: Sun, 5 Jun 2005 20:09:01 +0200
From: Jean Delvare <khali@linux-fr.org>
To: LM Sensors <lm-sensors@lm-sensors.org>,
       LKML <linux-kernel@vger.kernel.org>
Cc: Yani Ioannou <yani.ioannou@gmail.com>, Greg KH <greg@kroah.com>
Subject: More hardware monitoring drivers ported to the new sysfs callbacks
Message-Id: <20050605200901.41592fe9.khali@linux-fr.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have been modifying three additional hardware monitoring drivers to
take benefit of Yani Ioannou's new, extended sysfs callbacks. These
drivers are lm63, lm83 and lm90. All of these are relatively small when
compared to the first two modified drivers (adm1026 and it87). My goal
was to demonstrate that the new callbacks can also be used in small
drivers, with significant benefits. The result is even smaller drivers
(less memory used when loaded), relying far less on macros, which makes
the code easier to read (and the drivers presumably faster to distribute
using distcc).

Module                Before   After
lm63                   10128    9424 ( -704/ -6%)
lm83                    8784    6864 (-1920/-21%)
lm90                   12420   10628 (-1792/-14%)

Individual patches will follow. Comments welcome. Greg, can you add
these to one of your trees?

Before I go on with driver conversion, there are two points I'd like to
discuss:

First, I don't much like the name of the new header file,
linux/i2c-sysfs.h. It isn't related with i2c at all! It's all about
sensors (or hardware monitoring if you prefer). I think the header file
should be named linux/hwmon-sysfs.h or something similar.

Second, is there a reason why the SENSOR_DEVICE_ATTR macro creates a
stucture named sensor_dev_attr_##_name rather than simply
dev_attr_##_name? As it seems unlikely that SENSOR_DEVICE_ATTR and
DEVICE_ATTR will both be called for the same file, going for the short
form shouldn't cause any problem. This would make the calling code more
readable IMHO.

Thanks,
-- 
Jean Delvare
