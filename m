Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265434AbUAPNmf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 08:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265445AbUAPNme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 08:42:34 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:64157 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S265434AbUAPNmd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 08:42:33 -0500
Message-ID: <4007EAE7.2030104@in.ibm.com>
Date: Fri, 16 Jan 2004 19:15:11 +0530
From: Prashanth T <prasht@in.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: rml@tech9.net
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] rwlock_is_locked undefined for UP systems
Content-Type: multipart/mixed;
 boundary="------------040103070504000600070506"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040103070504000600070506
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,
    I had to use rwlock_is_locked( ) with linux2.6 for kdb and noticed that
this routine to be undefined for UP.  I have attached the patch for 2.6.1
below to return 0 for rwlock_is_locked( ) on UP systems.
Please let me know.

Thanks
Prashanth





--------------040103070504000600070506
Content-Type: text/plain;
 name="rwlock-check-UP.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rwlock-check-UP.patch"

diff -urN linux-2.6.1/include/linux/spinlock.h linux-2.6.1-rwlock-patch/include/linux/spinlock.h
--- linux-2.6.1/include/linux/spinlock.h	2004-01-09 12:29:33.000000000 +0530
+++ linux-2.6.1-rwlock-patch/include/linux/spinlock.h	2004-01-16 18:15:10.000000000 +0530
@@ -176,6 +176,7 @@
 #endif
 
 #define rwlock_init(lock)	do { (void)(lock); } while(0)
+#define rwlock_is_locked(lock)  ((void)(lock), 0)
 #define _raw_read_lock(lock)	do { (void)(lock); } while(0)
 #define _raw_read_unlock(lock)	do { (void)(lock); } while(0)
 #define _raw_write_lock(lock)	do { (void)(lock); } while(0)

--------------040103070504000600070506--

