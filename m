Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262941AbVCDMfo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262941AbVCDMfo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 07:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262943AbVCDM36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 07:29:58 -0500
Received: from [192.139.46.150] ([192.139.46.150]:57258 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S262909AbVCDM0r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 07:26:47 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [patch -mm series] ia64 specific /dev/mem handlers
References: <16923.193.128608.607599@jaguar.mkp.net>
	<20050303033704.6fb77a34.akpm@osdl.org>
	<yq0r7iwevqm.fsf@jaguar.mkp.net>
From: Jes Sorensen <jes@wildopensource.com>
Date: 04 Mar 2005 07:26:31 -0500
In-Reply-To: <yq0r7iwevqm.fsf@jaguar.mkp.net>
Message-ID: <yq0k6onegw8.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jes" == Jes Sorensen <jes@wildopensource.com> writes:

>>>>> "Andrew" == Andrew Morton <akpm@osdl.org> writes:
Andrew> This patch causes hiccups on my ia32e box.

Andrew> linux:/home/akpm# /usr/sbin/hwscan --isapnp zsh: 7528
Andrew> segmentation fault

Jes> Weird, I'll take a look.

-EPROGRAMMERISANIDIOT ... try this.

Cheers,
Jes

/dev/mem handle read/write case where ppos+count < PAGE_SIZE

Signed-off-by: Jes Sorensen <jes@wildopensource.com>


--- ../old/linux-2.6.11-rc5-mm1/drivers/char/mem.c	2005-03-04 07:20:51.000000000 -0500
+++ drivers/char/mem.c	2005-03-04 07:22:20.000000000 -0500
@@ -152,7 +152,9 @@
 		if (-p & (PAGE_SIZE - 1))
 			sz = -p & (PAGE_SIZE - 1);
 		else
-			sz = min_t(unsigned long, PAGE_SIZE, count);
+			sz = PAGE_SIZE;
+
+		sz = min_t(unsigned long, sz, count);
 
 		/*
 		 * On ia64 if a page has been mapped somewhere as
@@ -207,7 +209,9 @@
 		if (-p & (PAGE_SIZE - 1))
 			sz = -p & (PAGE_SIZE - 1);
 		else
-			sz = min_t(unsigned long, PAGE_SIZE, count);
+			sz = PAGE_SIZE;
+
+		sz = min_t(unsigned long, sz, count);
 
 		/*
 		 * On ia64 if a page has been mapped somewhere as
@@ -353,7 +357,9 @@
 			if (-p & (PAGE_SIZE - 1))
 				sz = -p & (PAGE_SIZE - 1);
 			else
-				sz = min_t(unsigned long, PAGE_SIZE, count);
+				sz = PAGE_SIZE;
+
+			sz = min_t(unsigned long, sz, count);
 
 			/*
 			 * On ia64 if a page has been mapped somewhere as
@@ -430,7 +436,9 @@
 		if (-realp & (PAGE_SIZE - 1))
 			sz = -realp & (PAGE_SIZE - 1);
 		else
-			sz = min_t(unsigned long, PAGE_SIZE, count);
+			sz = PAGE_SIZE;
+
+		sz = min_t(unsigned long, sz, count);
 
 		/*
 		 * On ia64 if a page has been mapped somewhere as
