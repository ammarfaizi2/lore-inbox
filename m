Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129990AbRAIP4g>; Tue, 9 Jan 2001 10:56:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131653AbRAIP40>; Tue, 9 Jan 2001 10:56:26 -0500
Received: from mgw-x4.nokia.com ([131.228.20.27]:13730 "EHLO mgw-x4.nokia.com")
	by vger.kernel.org with ESMTP id <S129990AbRAIP4P>;
	Tue, 9 Jan 2001 10:56:15 -0500
Message-ID: <3A5B3455.9D5613D2@nokia.com>
Date: Tue, 09 Jan 2001 16:55:01 +0100
From: Stefan Jonsson <stefan.jonsson@nokia.com>
X-Mailer: Mozilla 4.71 [en] (X11; I; Linux 2.2.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: alan@lxorguk.ukuu.org.uk, torvalds@transmeta.com
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.0 and 2.2.18 : Small bugfix for IP_ADD_MEMBERSHIP
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This small patch fixes a small bug in IP_ADD_MEMBERSHIP where im->loaded
is used but not initialized when compiled without CONFIG_IP_MULTICAST.

--- net/ipv4/igmp.c.orig	Tue Jan  9 13:40:48 2001
+++ net/ipv4/igmp.c	Tue Jan  9 13:37:26 2001
@@ -442,8 +442,8 @@
 	im->timer.function=&igmp_timer_expire;
 	im->unsolicit_count = IGMP_Unsolicited_Report_Count;
 	im->reporter = 0;
-	im->loaded = 0;
 #endif
+	im->loaded = 0;
 	im->next=in_dev->mc_list;
 	in_dev->mc_list=im;
 	igmp_group_added(im);
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
