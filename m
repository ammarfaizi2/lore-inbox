Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271686AbRHQQnr>; Fri, 17 Aug 2001 12:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271688AbRHQQnh>; Fri, 17 Aug 2001 12:43:37 -0400
Received: from hr1-cf9a48a7.dsl.impulse.net ([207.154.72.167]:62992 "HELO
	madrabbit.org") by vger.kernel.org with SMTP id <S271686AbRHQQn0>;
	Fri, 17 Aug 2001 12:43:26 -0400
Subject: [PATCH 2.4.8-ac6] (Yet) Another Sony Vaio laptop with a broken
	APM...
From: Ray Lee <ray-lk@madrabbit.org>
To: stelian.pop@fr.alcove.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12 (Preview Release)
Date: 17 Aug 2001 09:43:38 -0700
Message-Id: <998066618.31380.53.camel@orca>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stelian Pop wrote:

> This patch adds yet another Vaio laptop to the list of those
> having the APM minutes left swapping problem.

Huh, so *that's* what's going on. I normally just pay attention to the
percentage left, since the minutes display was horked. The patch against
2.4.8-ac6 below fixes the same problem for my PCG-XG29. (It may fix it
for a few others as well, at least the XG29K, perhaps the XG19/19k as
well. IIRC, they just differ in the screen size and which version of
windows you have to blow away.)

> I wonder if there is _any_ Vaio laptop that gets this
> item right. If not, we could just do a search on SYS_VENDOR /
> PRODUCT_NAME strings, like the is_sony_vaio_laptop test...

It's looking more and more likely that they're all backwards. Hey, at
least they're consistent, right?

--- linux-2.4.8-ac6.orig/arch/i386/kernel/dmi_scan.c	Thu Aug 16 23:13:58 2001
+++ linux-2.4.8-ac6/arch/i386/kernel/dmi_scan.c	Thu Aug 16 23:27:38 2001
@@ -472,6 +472,11 @@
 			MATCH(DMI_BIOS_VERSION, "R0208P1"),
 			MATCH(DMI_BIOS_DATE, "11/09/00"), NO_MATCH
 			} },
+	{ swab_apm_power_in_minutes, "Sony VAIO", {	/* Handle problems with APM on Sony Vaio PCG-XG29 */
+			MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
+			MATCH(DMI_BIOS_VERSION, "R0117A0"),
+			MATCH(DMI_BIOS_DATE, "04/25/00"), NO_MATCH
+			} },
 	
 	/* Problem Intel 440GX bioses */
 

--
Ray Lee  /  Every truth has a context.

