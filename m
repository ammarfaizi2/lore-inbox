Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289999AbSAPQiY>; Wed, 16 Jan 2002 11:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290000AbSAPQiD>; Wed, 16 Jan 2002 11:38:03 -0500
Received: from mailhost.mipsys.com ([62.161.177.33]:33242 "EHLO
	mailhost.mipsys.com") by vger.kernel.org with ESMTP
	id <S289999AbSAPQh5>; Wed, 16 Jan 2002 11:37:57 -0500
From: <benh@kernel.crashing.org>
To: <linux-kernel@vger.kernel.org>, Lukas Geyer <geyer@ml.kva.se>
Subject: Re: Two issues with 2.4.18pre3 on PPC
Date: Wed, 16 Jan 2002 17:37:37 +0100
Message-Id: <20020116163737.29030@mailhost.mipsys.com>
In-Reply-To: <Pine.LNX.4.33.0201161417540.6868-100000@cauchy.ml.kva.se>
In-Reply-To: <Pine.LNX.4.33.0201161417540.6868-100000@cauchy.ml.kva.se>
X-Mailer: CTM PowerMail 3.1.1 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>- The generic RTC driver in drivers/char/rtc.c does not work for this
>  iBook. The driver in drivers/macintosh/rtc.c does work, but it only
>  implements the two ioctls RTC_RD_TIME and RTC_SET_TIME. (Is this due to
>  hardware limitations?) Anyway, it is confusing to have both drivers
>  configurable for PPC, maybe the corresponding Config.in files should be
>  adjusted. (In addition, this is complicated by the fact that both
>  configuration options appear in different submenus and if you select
>  both as modules, then the generic driver will "shadow" the macintosh
>  one.)

That's a weirdness we haven't solved yet. Part of the problem is
that a common kernel can boot pmac, chrp and prep, and the later
ones can use the drivers/char/rtc.c driver. Actually, the
drivers/macintosh/rtc.c one may work on these too as it's just
a wrapper on some platform code selected at runtime depending on
the machine class.

Now, regarding the support of only GET/SET ioctls, it's normal.
Some of these machines don't have the legacy PC hardware RTC with
alarm support etc... That's the case of macs where the RTC hardware
is purely a real time clock. (It has other features, like scheduled
power up, but these aren't implemented yet and could be done entirely
in userland using /dev/adb anyway).

So the driver in drivers/macintosh/rtc.c is just a wrapper on the
get/set time functions provided by each type of machine.

Ben.



