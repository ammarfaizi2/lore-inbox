Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932849AbVIHB3X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932849AbVIHB3X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 21:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932846AbVIHB3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 21:29:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27034 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932541AbVIHB3V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 21:29:21 -0400
Message-Id: <20050908012855.090515000@localhost.localdomain>
References: <20050908012842.299637000@localhost.localdomain>
Date: Wed, 07 Sep 2005 18:28:44 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org,
       James Bottomley <James.Bottomley@steeleye.com>,
       Andrew Morton <akpm@osdl.org>
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       alan@lxorguk.ukuu.org.uk, linux-scsi <linux-scsi@vger.kernel.org>,
       Mark Salyzyn <mark_salyzyn@adaptec.com>,
       Mark Haverkamp <markh@osdl.org>,
       James Bottomley <James.Bottomley@steeleye.com>,
       Chris Wright <chrisw@osdl.org>
Subject: [PATCH 2/9] [PATCH] aacraid: 2.6.13 aacraid bad BUG_ON fix
Content-Disposition: inline; filename=aacraid-bad-BUG_ON-fix.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any  objections, please let us know.
------------------

This was noticed by Doug Bazamic and the fix found by Mark Salyzyn at
Adaptec.

There was an error in the BUG_ON() statement that validated the
calculated fib size which can cause the driver to panic.

Signed-off-by: Mark Haverkamp <markh@osdl.org>
Acked-by: James Bottomley <James.Bottomley@SteelEye.com>
Signed-off-by: Chris Wright <chrisw@osdl.org>
---
 drivers/scsi/aacraid/aachba.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.13.y/drivers/scsi/aacraid/aachba.c
===================================================================
--- linux-2.6.13.y.orig/drivers/scsi/aacraid/aachba.c
+++ linux-2.6.13.y/drivers/scsi/aacraid/aachba.c
@@ -968,7 +968,7 @@ static int aac_read(struct scsi_cmnd * s
 		fibsize = sizeof(struct aac_read64) + 
 			((le32_to_cpu(readcmd->sg.count) - 1) * 
 			 sizeof (struct sgentry64));
-		BUG_ON (fibsize > (sizeof(struct hw_fib) - 
+		BUG_ON (fibsize > (dev->max_fib_size - 
 					sizeof(struct aac_fibhdr)));
 		/*
 		 *	Now send the Fib to the adapter

--
