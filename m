Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264238AbUFXKsm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264238AbUFXKsm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 06:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264251AbUFXKsm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 06:48:42 -0400
Received: from smtp806.mail.sc5.yahoo.com ([66.163.168.185]:26030 "HELO
	smtp806.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264238AbUFXKsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 06:48:36 -0400
Subject: [PATCH] fs/isofs/inode.c, 2-4GB files rejected on DVDs
From: Jason Mancini <xorbe@sbcglobal.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Thu, 24 Jun 2004 03:44:30 -0700
Message-Id: <1088073870.17691.8.camel@xorbe.dyndns.org>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.2-2mdk 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Let me try this again with Evolution...

> DVDs with 2-4GB files get their filesizes truncated.  Are there even
> "cruft" CDs in circulation today?  Maybe it should be a config item.
> A popular competing os seems to handle 2-4GB isofs filesizes.
> -Jason Mancini

=============================================================================
diff -Nru inode.c.orig inode.c
--- inode.c.orig        2004-06-24 03:38:09.171898370 -0700
+++ inode.c     2004-06-24 03:37:47.997909378 -0700
@@ -1282,12 +1282,20 @@
         * WARNING: ISO-9660 filesystems > 1 GB and even > 2 GB are fully
         *          legal. Do not prevent to use DVD's schilling@fokus.gmd.de
         */
+       /*
        if ((inode->i_size < 0 || inode->i_size > 0x7FFFFFFE) &&
            sbi->s_cruft == 'n') {
                printk(KERN_WARNING "Warning: defective CD-ROM.  "
                       "Enabling \"cruft\" mount option.\n");
                sbi->s_cruft = 'y';
        }
+       */
+
+       /*  Forget "cruft", I have DVDs to read with 2-4GB files.
+        */
+       if (inode->i_size < 0) {
+         inode->i_size &= 0x0FFFFFFFF;
+       }

        /*
         * Some dipshit decided to store some other bit of information
=============================================================================


