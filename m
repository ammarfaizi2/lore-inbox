Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750709AbVJIPlN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbVJIPlN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 11:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750711AbVJIPlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 11:41:13 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:16525 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750709AbVJIPlL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 11:41:11 -0400
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17225.14892.889867.73327@tut.ibm.com>
Date: Sun, 9 Oct 2005 10:41:32 -0500
To: torvalds@osdl.org
Cc: viro@ftp.linux.org.uk, linux-kernel@vger.kernel.org
Subject: [PATCH] relayfs: fix bogus param value in call to vmap
X-Mailer: VM 7.19 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The third param in this call to vmap shouldn't be GFP_KERNEL, which
makes no sense, but rather VM_MAP.  Thanks to Al Viro for spotting
this.

Tom

Signed-off-by: Tom Zanussi <zanussi@us.ibm.com>

diff --git a/fs/relayfs/buffers.c b/fs/relayfs/buffers.c
--- a/fs/relayfs/buffers.c
+++ b/fs/relayfs/buffers.c
@@ -109,7 +109,7 @@ static void *relay_alloc_buf(struct rcha
 		if (unlikely(!buf->page_array[i]))
 			goto depopulate;
 	}
-	mem = vmap(buf->page_array, n_pages, GFP_KERNEL, PAGE_KERNEL);
+	mem = vmap(buf->page_array, n_pages, VM_MAP, PAGE_KERNEL);
 	if (!mem)
 		goto depopulate;
 


