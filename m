Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261687AbVADO5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261687AbVADO5M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 09:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261677AbVADO40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 09:56:26 -0500
Received: from alog0110.analogic.com ([208.224.220.125]:1152 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261683AbVADOyo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 09:54:44 -0500
Date: Tue, 4 Jan 2005 09:48:17 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Linux-2.6.10 fix "shadow" declaration warnings.
Message-ID: <Pine.LNX.4.61.0501040944510.5860@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linux-2.6.10 has compiler warnings with -Wshadow..


--- /usr/src/linux-2.6.10/include/linux/jiffies.h.orig	2004-12-24 16:33:49.000000000 -0500
+++ /usr/src/linux-2.6.10/include/linux/jiffies.h	2005-01-04 09:41:52.448765824 -0500
@@ -309,13 +309,13 @@
  }

  static __inline__ void
-jiffies_to_timespec(const unsigned long jiffies, struct timespec *value)
+jiffies_to_timespec(const unsigned long tick, struct timespec *value)
  {
  	/*
  	 * Convert jiffies to nanoseconds and separate with
  	 * one divide.
  	 */
-	u64 nsec = (u64)jiffies * TICK_NSEC;
+	u64 nsec = (u64)tick * TICK_NSEC;
  	value->tv_sec = div_long_long_rem(nsec, NSEC_PER_SEC, &value->tv_nsec);
  }

@@ -347,13 +347,13 @@
  }

  static __inline__ void
-jiffies_to_timeval(const unsigned long jiffies, struct timeval *value)
+jiffies_to_timeval(const unsigned long tick, struct timeval *value)
  {
  	/*
  	 * Convert jiffies to nanoseconds and separate with
  	 * one divide.
  	 */
-	u64 nsec = (u64)jiffies * TICK_NSEC;
+	u64 nsec = (u64)tick * TICK_NSEC;
  	value->tv_sec = div_long_long_rem(nsec, NSEC_PER_SEC, &value->tv_usec);
  	value->tv_usec /= NSEC_PER_USEC;
  }



Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
