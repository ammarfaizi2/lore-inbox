Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932132AbWDOWpu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbWDOWpu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 18:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932510AbWDOWpu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 18:45:50 -0400
Received: from smtp-out.google.com ([216.239.45.12]:9538 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932132AbWDOWpt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 18:45:49 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:content-type;
	b=JNomSo0ba9g+aEMj+34yBnLu338FezkwW42DHLN374w//wX0LyT1iDQ3bah+fhAS4
	vuTamxrv1AWz9d+08Hwsg==
Message-ID: <44417792.2070900@google.com>
Date: Sat, 15 Apr 2006 15:45:38 -0700
From: "Martin J. Bligh" <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Default CONFIG_DEBUG_MUTEXES to n
Content-Type: multipart/mixed;
 boundary="------------020104020700020002020903"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020104020700020002020903
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

CONFIG_DEBUG_MUTEXES has a significant performant impact (reduced perf
of reaim by 50% on ia32 NUMA boxes). It should not be on by default.

Signed-off-by: Martin J. Bligh <mbligh@google.com>



--------------020104020700020002020903
Content-Type: text/plain;
 name="2.6.17-rc1_no_mutex_dbg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.6.17-rc1_no_mutex_dbg"

diff -aurpN -X /home/mbligh/.diff.exclude linux-2.6.17-rc1/lib/Kconfig.debug 2.6.17-rc1_no_mutex_dbg/lib/Kconfig.debug
--- linux-2.6.17-rc1/lib/Kconfig.debug	2006-04-15 15:28:54.000000000 -0700
+++ 2.6.17-rc1_no_mutex_dbg/lib/Kconfig.debug	2006-04-15 15:44:14.000000000 -0700
@@ -101,7 +101,7 @@ config DEBUG_PREEMPT
 
 config DEBUG_MUTEXES
 	bool "Mutex debugging, deadlock detection"
-	default y
+	default n
 	depends on DEBUG_KERNEL
 	help
 	 This allows mutex semantics violations and mutex related deadlocks
@@ -109,6 +109,7 @@ config DEBUG_MUTEXES
 
 config DEBUG_SPINLOCK
 	bool "Spinlock debugging"
+	default n
 	depends on DEBUG_KERNEL
 	help
 	  Say Y here and build SMP to catch missing spinlock initialization

--------------020104020700020002020903--
