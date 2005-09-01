Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030193AbVIAPWg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030193AbVIAPWg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 11:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030199AbVIAPWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 11:22:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36481 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030193AbVIAPWf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 11:22:35 -0400
Subject: [PATCH] aacraid:  2.6.13 aacraid bad BUG_ON fix
From: Mark Haverkamp <markh@osdl.org>
To: James Bottomley <James.Bottomley@steeleye.com>,
       Andrew Morton <akpm@osdl.org>
Cc: linux-scsi <linux-scsi@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Mark Salyzyn <mark_salyzyn@adaptec.com>
Content-Type: text/plain
Date: Thu, 01 Sep 2005 08:19:23 -0700
Message-Id: <1125587963.21124.9.camel@markh1.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This was noticed by Doug Bazamic and the fix found by Mark Salyzyn at
Adaptec.

There was an error in the BUG_ON() statement that validated the
calculated fib size which can cause the driver to panic.

Signed-off-by: Mark Haverkamp <markh@osdl.org>

--- a/drivers/scsi/aacraid/aachba.c	2005-08-28 19:41:01.000000000 -0400
+++ b/drivers/scsi/aacraid/aachba.c	2005-09-01 08:05:29.118304656 -0400
@@ -968,7 +968,7 @@
 		fibsize = sizeof(struct aac_read64) + 
 			((le32_to_cpu(readcmd->sg.count) - 1) * 
 			 sizeof (struct sgentry64));
-		BUG_ON (fibsize > (sizeof(struct hw_fib) - 
+		BUG_ON (fibsize > (dev->max_fib_size - 
 					sizeof(struct aac_fibhdr)));
 		/*
 		 *	Now send the Fib to the adapter

-- 
Mark Haverkamp <markh@osdl.org>

