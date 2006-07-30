Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932356AbWG3QgR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbWG3QgR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 12:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932358AbWG3QgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 12:36:17 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:8997 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932361AbWG3QgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 12:36:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Q07n33TqoJaKGfYrADOGV0kucic9gslNhJCTLavCvAsg2UPGkcAhkqVOr7LbQOGl8siCJxzYeXbut15wAqR24Y5/rCkYMNlpFFBpubLaTuoiOXx3Uu1X88G/azcys5c8lxL1Uz+GkYl1Hoxy7nz3gPXeJxSybvdvFVMryLLdJds=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 03/12] making the kernel -Wshadow clean - fix jiffies.h
Date: Sun, 30 Jul 2006 18:37:17 +0200
User-Agent: KMail/1.9.3
References: <200607301830.01659.jesper.juhl@gmail.com>
In-Reply-To: <200607301830.01659.jesper.juhl@gmail.com>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607301837.17646.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix -Wshadow warnings in include/linux/jiffies.h


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 include/linux/jiffies.h |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

--- linux-2.6.18-rc2-orig/include/linux/jiffies.h	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6.18-rc2/include/linux/jiffies.h	2006-07-18 20:31:57.000000000 +0200
@@ -325,13 +325,13 @@ timespec_to_jiffies(const struct timespe
 }
 
 static __inline__ void
-jiffies_to_timespec(const unsigned long jiffies, struct timespec *value)
+jiffies_to_timespec(const unsigned long jiffy, struct timespec *value)
 {
 	/*
 	 * Convert jiffies to nanoseconds and separate with
 	 * one divide.
 	 */
-	u64 nsec = (u64)jiffies * TICK_NSEC;
+	u64 nsec = (u64)jiffy * TICK_NSEC;
 	value->tv_sec = div_long_long_rem(nsec, NSEC_PER_SEC, &value->tv_nsec);
 }
 
@@ -363,13 +363,13 @@ timeval_to_jiffies(const struct timeval 
 }
 
 static __inline__ void
-jiffies_to_timeval(const unsigned long jiffies, struct timeval *value)
+jiffies_to_timeval(const unsigned long jiffy, struct timeval *value)
 {
 	/*
 	 * Convert jiffies to nanoseconds and separate with
 	 * one divide.
 	 */
-	u64 nsec = (u64)jiffies * TICK_NSEC;
+	u64 nsec = (u64)jiffy * TICK_NSEC;
 	long tv_usec;
 
 	value->tv_sec = div_long_long_rem(nsec, NSEC_PER_SEC, &tv_usec);



