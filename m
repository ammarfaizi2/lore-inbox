Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757046AbWLCQjP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757046AbWLCQjP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 11:39:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757050AbWLCQjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 11:39:15 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:22440 "EHLO
	rubicon.netdirect.ca") by vger.kernel.org with ESMTP
	id S1757046AbWLCQjO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 11:39:14 -0500
X-Originating-Ip: 74.109.98.100
Date: Sun, 3 Dec 2006 11:35:49 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] lib: Convert kmalloc()+memset() to kzalloc()
Message-ID: <Pine.LNX.4.64.0612031132220.4502@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.541, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00, SARE_SUB_OBFU_Z 0.26)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Convert the single obvious instance in lib/ of kmalloc() + memset()
to kzalloc().

Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>

---

diff --git a/lib/kobject.c b/lib/kobject.c
index 744a4b1..7ce6dc1 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -111,10 +111,9 @@ char *kobject_get_path(struct kobject *k
 	len = get_kobj_path_length(kobj);
 	if (len == 0)
 		return NULL;
-	path = kmalloc(len, gfp_mask);
+	path = kzalloc(len, gfp_mask);
 	if (!path)
 		return NULL;
-	memset(path, 0x00, len);
 	fill_kobj_path(kobj, path, len);

 	return path;
