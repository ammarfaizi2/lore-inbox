Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273796AbRJaWNs>; Wed, 31 Oct 2001 17:13:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274813AbRJaWN2>; Wed, 31 Oct 2001 17:13:28 -0500
Received: from air-1.osdl.org ([65.201.151.5]:23826 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S274789AbRJaWNK>;
	Wed, 31 Oct 2001 17:13:10 -0500
Date: Wed, 31 Oct 2001 14:13:29 -0800 (PST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@osdlab.pdx.osdl.net>
To: Tim Hockin <thockin@sun.com>
cc: <p_gortmaker@yahoo.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <torvalds@transmeta.com>, <alan@redhat.com>
Subject: Re: [PATCH] don't reset alarm interrupt on RTC
In-Reply-To: <3BE07669.5FF78E63@sun.com>
Message-ID: <Pine.LNX.4.33.0110311408330.11035-100000@osdlab.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 31 Oct 2001, Tim Hockin wrote:

> All,
>
> Attached is a 1-liner to not clear the Alarm-Int-Enable bit automatically
> on the RTC device.  This makes wake-on-alarm possible.
>
> Please let me know if there is a problem with it.  This is against 2.4.13
> for inclusion in 2.4.14.
>
> Tim
>

diff -ruN dist-2.4.13+patches/drivers/char/rtc.c
linux-2.4/drivers/char/rtc.c
--- dist-2.4.13+patches/drivers/char/rtc.c      Mon Oct  1 16:43:52 2001
+++ linux-2.4/drivers/char/rtc.c        Mon Oct 29 11:07:42 2001
@@ -560,7 +560,7 @@
        spin_lock_irq(&rtc_lock);
        tmp = CMOS_READ(RTC_CONTROL);
        tmp &=  ~RTC_PIE;
-       tmp &=  ~RTC_AIE;
+       //tmp &=  ~RTC_AIE;
        tmp &=  ~RTC_UIE;
        CMOS_WRITE(tmp, RTC_CONTROL);
        CMOS_READ(RTC_INTR_FLAGS);

Why would you want to unconditionally enable this interrupt?

And how do you set the alarm time?

I implmemented Wake-on-alarm for the ACPI suspend case. The way I did it
was to implement a procfs handler that set the alarm time and enabled the
interrupt. I fantasized about porting it to the RTC procfs handler, but I
never got around to it. The ACPI list archives should have more info/clues
about it..

But, I don't think this should be enabled by default.

	-pat

