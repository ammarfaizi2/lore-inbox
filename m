Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752383AbWAFFNu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752383AbWAFFNu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 00:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752385AbWAFFNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 00:13:50 -0500
Received: from omta04ps.mx.bigpond.com ([144.140.83.156]:58587 "EHLO
	omta04ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1752383AbWAFFNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 00:13:49 -0500
Message-ID: <43BDFC8B.9020805@bigpond.net.au>
Date: Fri, 06 Jan 2006 16:13:47 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] lib: Fix bug in int_sqrt() for 64 bit longs
Content-Type: multipart/mixed;
 boundary="------------010102070302070702090409"
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta04ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Fri, 6 Jan 2006 05:13:47 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010102070302070702090409
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The implementation of int_sqrt() assumes that longs have 32 bits.  On 
systems that have 64 bit longs this will result in gross errors when the 
argument to the function is greater than 2^32 - 1 on such systems. I 
doubt whether any such use is currently made of int_sqrt() but the 
attached patch fixes the problem anyway.

Signed-off-by: Peter Williams <pwil3058@bigpond.com.au>

-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

--------------010102070302070702090409
Content-Type: text/plain;
 name="fix-int_sqrt_bug"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-int_sqrt_bug"

Index: GIT-warnings/lib/int_sqrt.c
===================================================================
--- GIT-warnings.orig/lib/int_sqrt.c	2005-10-25 13:55:22.000000000 +1000
+++ GIT-warnings/lib/int_sqrt.c	2006-01-06 14:29:19.000000000 +1100
@@ -15,7 +15,7 @@ unsigned long int_sqrt(unsigned long x)
 	op = x;
 	res = 0;
 
-	one = 1 << 30;
+	one = 1 << (BITS_PER_LONG - 2);
 	while (one > op)
 		one >>= 2;
 

--------------010102070302070702090409--
