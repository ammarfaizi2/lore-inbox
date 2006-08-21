Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751400AbWHUJL3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbWHUJL3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 05:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751726AbWHUJL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 05:11:29 -0400
Received: from smtp-101-monday.nerim.net ([62.4.16.101]:62732 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1751400AbWHUJL3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 05:11:29 -0400
Date: Mon, 21 Aug 2006 11:11:27 +0200
From: Jean Delvare <khali@linux-fr.org>
To: "Mark M. Hoffman" <mhoffman@lightlink.com>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       lm-sensors@lm-sensors.org
Subject: Re: [lm-sensors] [RFC][PATCH] hwmon:fix sparse warnings + error
 handling
Message-Id: <20060821111127.fe93bc0a.khali@linux-fr.org>
In-Reply-To: <20060821023017.GA30017@jupiter.solarsys.private>
References: <44E8C9AE.3060307@gmail.com>
	<20060821023017.GA30017@jupiter.solarsys.private>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark, Michal,

> Thanks for doing this... but Andrew please don't apply it.  The sensors project
> people are working on these even now, and we already have a patch for the
> w83627hf driver...
> 
> http://lists.lm-sensors.org/pipermail/lm-sensors/2006-August/017204.html
> 
> Jean Delvare (hwmon maintainer) should be sending these up the chain soon.
> 
> Michal: if you're interested in fixing any of the rest of them, please take
> a look at the patch above to see the mechanism we intend to use.  It actually
> makes the drivers *smaller* than they were.

The size change really depends on the driver. For older drivers with
individual file registration (sometimes hidden behind macros) the
driver size will indeed shrink, but for newer drivers with loop-based
file registration, this would be a slight increase in size. Not that it
really matters anyway, what matters is that we handle errors and file
deletion properly from now on.

Michal, if you go on working on this (and this is welcome), please
follow what Mark did, as this is what we agreed was the best approach.
Here is a quick status summary for drivers/hwmon:

Done by Mark M. Hoffman:
 o asb100
 o lm75
 o lm78
 o smsc47b397
 o w83627hf

Done by Jim Cromie:
 o pc87360

Will be done by David Hubbard:
 o w83627ehf

Will be done by me:
 o f71805f
 o it87
 o lm63
 o lm83
 o lm90

This leaves the following list:
 o abituguru
 o adm1021
 o adm1025
 o adm1026
 o adm1031
 o adm9240
 o atxp1
 o ds1621
 o fscher
 o fscpos
 o gl518sm
 o gl520sm
 o lm77
 o lm80
 o lm85
 o lm87
 o lm92
 o max1619
 o sis5595
 o smsc47m1
 o smsc47m192
 o via686a
 o vt8231
 o w83781d
 o w83791d
 o w83792d
 o w83l785ts

Almost 1000 warnings for drivers/hwmon alone... OTOH I wonder how
device_create_file and friends qualified for __must_check given that
nothing wrong can happen if they fail, from the kernel's point of view.
The files are not created and that's about it.

If you are going to fix some of the drivers listed above, please
advertise on the lm-sensors list so that your work is not duplicated.

As a side note, I have patches ready for everything under drivers/i2c
already, I sent them on the i2c list last week and will push them soon
now.

Thanks,
-- 
Jean Delvare
