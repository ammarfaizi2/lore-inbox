Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265335AbUAZLbV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 06:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265420AbUAZLbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 06:31:21 -0500
Received: from spc1-leed3-6-0-cust58.leed.broadband.ntl.com ([80.7.68.58]:6895
	"EHLO arthur.pjc.net") by vger.kernel.org with ESMTP
	id S265335AbUAZLbT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 06:31:19 -0500
Date: Mon, 26 Jan 2004 11:31:18 +0000
From: Patrick Caulfield <patrick@tykepenguin.com>
To: davem@redhat.com, linux-kernel@vger.kernel.org
Cc: Steve Whitehouse <Steve@ChyGwyn.com>
Subject: [PATCH] 2/2 DECnet fix crash reading /proc/net/decnet_cache
Message-ID: <20040126113118.GC21366@tykepenguin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes an oops if a user reads /proc/net/decnet_cache


--- net/decnet/dn_route.c  24 Nov 2003 03:16:28 -0000      1.3
+++ net/decnet/dn_route.c  17 Dec 2003 09:54:37 -0000
@@ -1720,7 +1720,8 @@

 static void dn_rt_cache_seq_stop(struct seq_file *seq, void *v)
 {
-       rcu_read_unlock();
+       if (v)
+               rcu_read_unlock();
 }
  
 static int dn_rt_cache_seq_show(struct seq_file *seq, void *v)


patrick

