Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262881AbUKTMJf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262881AbUKTMJf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 07:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262913AbUKTMJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 07:09:33 -0500
Received: from mail.obster.org ([82.139.198.99]:13975 "EHLO
	hofmuehl.obster.org") by vger.kernel.org with ESMTP id S262881AbUKTMIS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 07:08:18 -0500
Message-ID: <419F33AE.2050009@obster.org>
Date: Sat, 20 Nov 2004 13:08:14 +0100
From: Michael Obster <kernel@obster.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.1) Gecko/20041014
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch] 2.6: mc146818rtc.h
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------050702020703040205030906"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050702020703040205030906
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

this patch prevents user-space including spinlock.h which breaks the build.

Cheers,
Michael Obster
---
This will rock you. - http://www.rocklinux.org

--------------050702020703040205030906
Content-Type: text/plain;
 name="mc146818rtc-spinlock.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mc146818rtc-spinlock.patch"

--- ./include/linux/mc146818rtc.h.orig	2004-11-19 14:30:45.047279312 +0100
+++ ./include/linux/mc146818rtc.h	2004-11-19 14:32:04.137255808 +0100
@@ -13,10 +13,12 @@
 
 #include <asm/io.h>
 #include <linux/rtc.h>			/* get the user-level API */
-#include <linux/spinlock.h>		/* spinlock_t */
 #include <asm/mc146818rtc.h>		/* register access macros */
 
+#ifdef __KERNEL__
+#include <linux/spinlock.h>		/* spinlock_t */
 extern spinlock_t rtc_lock;		/* serialize CMOS RAM access */
+#endif
 
 /**********************************************************************
  * register summary

--------------050702020703040205030906--
