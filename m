Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750713AbVKQJec@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbVKQJec (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 04:34:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750714AbVKQJec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 04:34:32 -0500
Received: from [213.91.10.50] ([213.91.10.50]:44791 "EHLO zone4.gcu-squad.org")
	by vger.kernel.org with ESMTP id S1750713AbVKQJec convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 04:34:32 -0500
X-DKIM: Sendmail DKIM Filter v0.1.1 zone4.gcu-squad.org jAH9Ksx5006691
Date: Thu, 17 Nov 2005 10:20:53 +0100 (CET)
To: avolkov@varma-el.com
Subject: Re: [PATCH 1/1] Added support of ST m41t85 rtc chip
X-IlohaMail-Blah: khali@localhost
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.14 (On: webmail.gcu.info)
Message-ID: <Vljn9pXR.1132219253.1222760.khali@localhost>
In-Reply-To: <437B61B1.50003@varma-el.com>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
CC: "Mark A. Greer" <mgreer@mvista.com>,
       "LM Sensors" <lm-sensors@lm-sensors.org>,
       "LKML" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-2.0.1 (zone4.gcu-squad.org [127.0.0.1]); Thu, 17 Nov 2005 10:20:54 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrey,

On 2005-11-16, Andrey Volkov wrote:
> It's pity, but all chips of m41xx family (approx. 20 members) have same
> i2c slave address (0x68) and have not some hwd model specific id
> registers. Hence I couldn't made any clue about chip specific
> regs/pins/... at run-time (and couldn't use two or more chips in one i2c
> subnet :)). And the situation worsens, as various chips have various
> time regs offsets, as ex. REG_SEC of m41t00 have offset 0, but
> in m41t85 _SAME_ REG_SEC have offset 1, etc (God, who in ST was so,
> hm, ...., so made such decision?).

I wholeheartedly second your views, it would be way way better if all I2C
chips had an ID register. However, having a separate driver for every
chip doesn't actually solve the undifferenciability issue. You can't
prevent the user from loading the wrong driver. Also, the problem isn't
specific to the m41txx family of chips, many other families of chips
suffer the same.

The main problem here is that i2c-core currently lacks a mechanism which
would let us explicitely attach a given driver (and chip type within
that driver) to an arbitrary adapter, address pair. I will be working on
implementing this with the help of others in the next few weeks. RTC
drivers and media/video drivers should enjoy this new interface.

Thanks,
--
Jean Delvare
