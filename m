Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263628AbTFZUMt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 16:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263705AbTFZUMs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 16:12:48 -0400
Received: from air-2.osdl.org ([65.172.181.6]:56283 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263628AbTFZUMi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 16:12:38 -0400
Date: Thu, 26 Jun 2003 13:26:49 -0700
From: Bob Miller <rem@osdl.org>
To: trivial@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.5.73 TRIVIAL] Remove un-needed MOD_*_USE_COUNT from i4lididrv.c
Message-ID: <20030626202649.GD16162@doc.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Module init methods are called with a reference already taken by the
module code so the MOD_*_USE_COUNT can be deleted.

--
Bob Miller                                      Email: rem@osdl.org
Open Source Development Lab                     Phone: 503.626.2455 Ext. 17

diff -Nru a/drivers/isdn/hardware/eicon/i4lididrv.c b/drivers/isdn/hardware/eicon/i4lididrv.c
--- a/drivers/isdn/hardware/eicon/i4lididrv.c	Wed Jun 25 16:18:28 2003
+++ b/drivers/isdn/hardware/eicon/i4lididrv.c	Wed Jun 25 16:18:28 2003
@@ -1354,8 +1354,6 @@
   status_lock = SPIN_LOCK_UNLOCKED;
   ll_lock = SPIN_LOCK_UNLOCKED;
 
-  MOD_INC_USE_COUNT;
-
   if (strlen(id) < 1)
     strcpy(id, "diva");
 
@@ -1382,7 +1380,6 @@
   create_proc();
 
 out:
-  MOD_DEC_USE_COUNT;
   return(ret);
 }
