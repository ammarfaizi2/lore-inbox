Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423574AbWJZPgc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423574AbWJZPgc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 11:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423575AbWJZPgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 11:36:32 -0400
Received: from rwcrmhc15.comcast.net ([204.127.192.85]:23703 "EHLO
	rwcrmhc15.comcast.net") by vger.kernel.org with ESMTP
	id S1423574AbWJZPgc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 11:36:32 -0400
Subject: [PATCH] time_adjust cleared before use
From: Jim Houston <jim.houston@comcast.net>
Reply-To: jim.houston@comcast.net
To: Roman Zippel <zippel@linux-m68k.org>
Cc: John Stultz <johnstul@us.ibm.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Thu, 26 Oct 2006 11:29:57 -0400
Message-Id: <1161876597.7885.9.camel@x2.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I notice that the code which implements adjtime clears
the time_adjust value before using it.  The attached 
patch makes the obvious fix.

Jim Houston - Concurrent Computer Corp.

--

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 47195fa..3afeaa3 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -161,9 +161,9 @@ void second_overflow(void)
 			time_adjust += MAX_TICKADJ;
 			tick_length -= MAX_TICKADJ_SCALED;
 		} else {
-			time_adjust = 0;
 			tick_length += (s64)(time_adjust * NSEC_PER_USEC /
 					     HZ) << TICK_LENGTH_SHIFT;
+			time_adjust = 0;
 		}
 	}
 }


