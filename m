Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273881AbRJaV5g>; Wed, 31 Oct 2001 16:57:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274194AbRJaV51>; Wed, 31 Oct 2001 16:57:27 -0500
Received: from patan.Sun.COM ([192.18.98.43]:60553 "EHLO patan.sun.com")
	by vger.kernel.org with ESMTP id <S273854AbRJaV5Q>;
	Wed, 31 Oct 2001 16:57:16 -0500
Message-ID: <3BE07669.5FF78E63@sun.com>
Date: Wed, 31 Oct 2001 14:08:41 -0800
From: Tim Hockin <thockin@sun.com>
Organization: Sun Microsystems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.12C5_V i686)
X-Accept-Language: en
MIME-Version: 1.0
To: p_gortmaker@yahoo.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        torvalds@transmeta.com, alan@redhat.com
Subject: [PATCH] don't reset alarm interrupt on RTC
Content-Type: multipart/mixed;
 boundary="------------AB321144391FE811EAB37727"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------AB321144391FE811EAB37727
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

All,

Attached is a 1-liner to not clear the Alarm-Int-Enable bit automatically
on the RTC device.  This makes wake-on-alarm possible.

Please let me know if there is a problem with it.  This is against 2.4.13
for inclusion in 2.4.14.

Tim
-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Cobalt Server Appliances
thockin@sun.com
--------------AB321144391FE811EAB37727
Content-Type: text/plain; charset=us-ascii;
 name="drivers_char_rtc.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="drivers_char_rtc.c.diff"

diff -ruN dist-2.4.13+patches/drivers/char/rtc.c linux-2.4/drivers/char/rtc.c
--- dist-2.4.13+patches/drivers/char/rtc.c	Mon Oct  1 16:43:52 2001
+++ linux-2.4/drivers/char/rtc.c	Mon Oct 29 11:07:42 2001
@@ -560,7 +560,7 @@
 	spin_lock_irq(&rtc_lock);
 	tmp = CMOS_READ(RTC_CONTROL);
 	tmp &=  ~RTC_PIE;
-	tmp &=  ~RTC_AIE;
+	//tmp &=  ~RTC_AIE;
 	tmp &=  ~RTC_UIE;
 	CMOS_WRITE(tmp, RTC_CONTROL);
 	CMOS_READ(RTC_INTR_FLAGS);

--------------AB321144391FE811EAB37727--

