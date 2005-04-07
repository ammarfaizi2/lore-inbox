Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261279AbVDGKDt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261279AbVDGKDt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 06:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261281AbVDGKDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 06:03:48 -0400
Received: from zone4.gcu-squad.org ([213.91.10.50]:50383 "EHLO
	zone4.gcu-squad.org") by vger.kernel.org with ESMTP id S261279AbVDGKDp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 06:03:45 -0400
Date: Thu, 7 Apr 2005 11:59:05 +0200 (CEST)
To: ladis@linux-mips.org, greg@kroah.com
Subject: Re: [PATCH] i2c: new driver for ds1337 RTC
X-IlohaMail-Blah: khali@localhost
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.14 (On: webmail.gcu.info)
Message-ID: <8iOUo9nl.1112867945.5643950.khali@localhost>
In-Reply-To: <20050407094506.GA19360@orphique>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
CC: LKML <linux-kernel@vger.kernel.org>,
       "LM Sensors" <sensors@Stimpy.netroedge.com>,
       "James Chapman" <jchapman@katalix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Ladislav,

> I know it is bad time to send any patches, but lets try anyway :)
>
> My embedded device is using DS1339 I2C RTC clock which differs from
> DS1337 only in one register at address 10h which enables battery charge.
> Originaly I was using my own driver, but decided to extend existing
> one. Chip detection is done automaticaly, see ds1337_is_ds1339 function
> and comment above. While playing with code, few things seemed strange to
> me, so here is comment:
>
> * driver is using adapter->algo->master_xfer function without checking
>   it is present and without holding bus lock. That looks insane to me.
>   fixed.
>
> * BCD_TO_BIN is inteded to use this way: BCD_TO_BIN(val); Drive changed
>   to use BCD2BIN.
>
> * Changed dev_dbg to print "dev" of device this driver is for not
>   adapter's dev.
>
> * Changed get/set time to be compatible with other RTC drivers, ie.
>   epoch is handled separately. That should be done in RTC interface
>   part [*].
>
> Driver is tested and works with DS1339, detection algoritm was tested
> with extending address space to 18 bytes in DS1339. Please test on
> DS1337 as well. Comments and suggestions welcome.

Please slice this into separarte patches. Adding support for the DS1339
is one thing, bug fixes are another. I can't review patches which do
that many different things at once.

As a side note, please avoid noise in your patch. Converting constants
from decimal to hexadecimal or renaming variables makes my review job
way harder, as it distracts me from the real point of your patch.

Once you realize that the time I need to review a patch increases in a
quadratic way (if not worse) relatively to the length of the patch, I am
sure you will see why it is important to send small patches doing just
one thing without noise.

Thanks,
--
Jean Delvare
