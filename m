Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292315AbSCDKWd>; Mon, 4 Mar 2002 05:22:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292316AbSCDKWX>; Mon, 4 Mar 2002 05:22:23 -0500
Received: from WARSL401PIP6.highway.telekom.at ([195.3.96.113]:42561 "HELO
	email03.aon.at") by vger.kernel.org with SMTP id <S292315AbSCDKWP>;
	Mon, 4 Mar 2002 05:22:15 -0500
Date: Mon, 4 Mar 2002 11:22:04 +0100
From: Thomas Krennwallner <krennwallner@aon.at>
To: linux-kernel@vger.kernel.org
Cc: marcelo@conectiva.com.br
Subject: [PATCH] apm bootparam 2.4.18
Message-ID: <20020304112204.B20600@super-skunk.zenzi.myip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux 2.2.19 on an i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Bootparam handling in apm.c is broken. apm=on and apm=off turns APM off, no
bootparam turns apm on.

so long
Thomas

--- linux-2.4.18/arch/i386/kernel/apm.c	Mon Feb 25 20:37:53 2002
+++ linux/arch/i386/kernel/apm.c	Fri Mar  1 10:36:34 2002
@@ -392,7 +392,7 @@
 static int			got_clock_diff;
 #endif
 static int			debug;
-static int			apm_disabled = -1;
+static int			apm_disabled = 0;
 #ifdef CONFIG_SMP
 static int			power_off;
 #else
@@ -1868,7 +1868,7 @@
 	if (realmode_power_off)
 		apm_info.realmode_power_off = 1;
 	/* User can override, but default is to trust DMI */
-	if (apm_disabled != -1)
+	if (apm_disabled)
 		apm_info.disabled = apm_disabled;
 
 	/*
