Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265114AbUF1S3y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265114AbUF1S3y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 14:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265119AbUF1S3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 14:29:54 -0400
Received: from cantor.suse.de ([195.135.220.2]:25050 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265117AbUF1S3t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 14:29:49 -0400
Date: Mon, 28 Jun 2004 20:18:43 +0200
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: [PATCH] signed bug in net/decnet/dn_nsp_in.c dn_nsp_linkservice()
Message-ID: <20040628181843.GA15021@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


net/decnet/dn_nsp_in.c:534: warning: comparison is always false due to limited range of data type

char can be either signed or unsigned, depending on the target system.
patch is against 2.6.7-bk11


--- ./net/decnet/dn_nsp_in.c
+++ ./net/decnet/dn_nsp_in.c	2004/06/28 18:11:40
@@ -504,7 +504,7 @@
 	struct dn_scp *scp = DN_SK(sk);
 	unsigned short segnum;
 	unsigned char lsflags;
-	char fcval;
+	signed char fcval;
 	int wake_up = 0;
 	char *ptr = skb->data;
 	unsigned char fctype = scp->services_rem & NSP_FC_MASK;
-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
