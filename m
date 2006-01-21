Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932335AbWAUAlt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335AbWAUAlt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 19:41:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932337AbWAUAlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 19:41:49 -0500
Received: from ns1.siteground.net ([207.218.208.2]:14827 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S932335AbWAUAls (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 19:41:48 -0500
Date: Fri, 20 Jan 2006 16:40:23 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, matthew.e.tolentino@intel.com,
       Andi Kleen <ak@suse.de>,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>
Subject: [bug] __meminit breaks cpu hotplug
Message-ID: <20060121004023.GB3573@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recent __meminit additions broke cpu hotplug when the kernel is configured 
with  HOTPLUG_CPU but not HOTPLUG_MEMORY.   
Although __meminit replaced __devinit functions many places, all those functions
looked like they should have been marked with __cpuinit to begin with.  That
is the reason I have changed the below to __cpuinit.  I leave it to Matt if he
wants to use __devinit here instead. (Depending on where he sees __meminit
would be used.)

Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>
Signed-off-by: Shai Fultheim <shai@scalex86.org>

Index: linux-2.6.16-rc1/include/linux/init.h
===================================================================
--- linux-2.6.16-rc1.orig/include/linux/init.h	2006-01-17 14:12:16.000000000 -0800
+++ linux-2.6.16-rc1/include/linux/init.h	2006-01-20 12:24:44.000000000 -0800
@@ -247,10 +247,10 @@ void __init parse_early_param(void);
 #define __memexit
 #define __memexitdata
 #else
-#define __meminit	__init
-#define __meminitdata __initdata
-#define __memexit __exit
-#define __memexitdata	__exitdata
+#define __meminit	__cpuinit
+#define __meminitdata __cpuinitdata
+#define __memexit __cpuexit
+#define __memexitdata	__cpuexitdata
 #endif
 
 /* Functions marked as __devexit may be discarded at kernel link time, depending
