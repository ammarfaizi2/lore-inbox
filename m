Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967598AbWK2TtX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967598AbWK2TtX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 14:49:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967599AbWK2TtX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 14:49:23 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:52111 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S967598AbWK2TtW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 14:49:22 -0500
Date: Wed, 29 Nov 2006 11:52:30 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, stable@kernel.org
Subject: Re: Linux 2.6.18.4
Message-ID: <20061129195230.GC1397@sequoia.sous-sol.org>
References: <20061129195103.GB1397@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061129195103.GB1397@sequoia.sous-sol.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index 9eda185..d026088 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 18
-EXTRAVERSION = .3
+EXTRAVERSION = .4
 NAME=Avast! A bilge rat!
 
 # *DOCUMENTATION*
diff --git a/net/bridge/br_ioctl.c b/net/bridge/br_ioctl.c
index 4e4119a..4c61a7e 100644
--- a/net/bridge/br_ioctl.c
+++ b/net/bridge/br_ioctl.c
@@ -58,12 +58,13 @@ static int get_fdb_entries(struct net_br
 {
 	int num;
 	void *buf;
-	size_t size = maxnum * sizeof(struct __fdb_entry);
+	size_t size;
 
-	if (size > PAGE_SIZE) {
-		size = PAGE_SIZE;
+	/* Clamp size to PAGE_SIZE, test maxnum to avoid overflow */
+	if (maxnum > PAGE_SIZE/sizeof(struct __fdb_entry))
 		maxnum = PAGE_SIZE/sizeof(struct __fdb_entry);
-	}
+
+	size = maxnum * sizeof(struct __fdb_entry);
 
 	buf = kmalloc(size, GFP_USER);
 	if (!buf)
