Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932382AbVJSAsL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbVJSAsL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 20:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932389AbVJSAsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 20:48:11 -0400
Received: from packet.digeo.com ([12.110.80.53]:46278 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id S932382AbVJSAsJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 20:48:09 -0400
From: "Jayachandran C." <jchandra@digeo.com>
Date: Tue, 18 Oct 2005 17:47:59 -0700
To: rusty@rustcorp.com.au
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] kernel/module.c: removed dead code
Message-ID: <20051019004759.GD5338@random.pao.digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-OriginalArrivalTime: 19 Oct 2005 00:47:59.0445 (UTC) FILETIME=[C0A03050:01C5D446]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes an issue reported by Coverity in kernel/module.c

Error reported: Cannot reach this line of code "else return ptr;"

Patch description:
  This is the error path, so 'err' will be negative, the else case
  is not required, this patch removes it.
                                                                                                    
Signed-off-by: Jayachandran C. <c.jayachandran at gmail.com>
---

 module.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

--- linux-2.6.13-rc4-git2.clean/kernel/module.c	2005-10-13 11:42:59.000000000 -0700
+++ linux-2.6.13-rc4-git2.jc/kernel/module.c	2005-10-14 16:17:54.212548129 -0700
@@ -1853,8 +1853,7 @@
 	kfree(args);
  free_hdr:
 	vfree(hdr);
-	if (err < 0) return ERR_PTR(err);
-	else return ptr;
+	return ERR_PTR(err);
 
  truncated:
 	printk(KERN_ERR "Module len %lu truncated\n", len);
