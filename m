Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263784AbUFXKTi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263784AbUFXKTi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 06:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264183AbUFXKTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 06:19:38 -0400
Received: from bay17-f24.bay17.hotmail.com ([64.4.43.74]:43792 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S263784AbUFXKTf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 06:19:35 -0400
X-Originating-IP: [69.104.143.247]
X-Originating-Email: [jayrusman@hotmail.com]
From: "Jason Mancini" <jayrusman@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: fs/isofs/inode.c "bug"
Date: Thu, 24 Jun 2004 03:19:34 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY17-F24AlDCVrvGAk00075c7b@hotmail.com>
X-OriginalArrivalTime: 24 Jun 2004 10:19:34.0671 (UTC) FILETIME=[BF10E1F0:01C459D4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DVDs with 2-4GB files get their filesizes truncated.  Are there even
"cruft" CDs in circulation today?  Maybe it should be a config item.
A popular competing os seems to handle 2-4GB isofs filesizes.
-Jason Mancini


--- inode.c     2004-06-24 02:43:33.000000000 -0700
+++ /usr/src/linux/fs/isofs/inode.c     2004-06-24 03:09:44.290764261 -0700
@@ -1282,13 +1286,20 @@
         * WARNING: ISO-9660 filesystems > 1 GB and even > 2 GB are fully
         *          legal. Do not prevent to use DVD's 
schilling@fokus.gmd.de
         */
+       /*
        if ((inode->i_size < 0 || inode->i_size > 0x7FFFFFFE) &&
            sbi->s_cruft == 'n') {
                printk(KERN_WARNING "Warning: defective CD-ROM.  "
                       "Enabling \"cruft\" mount option.\n");
                sbi->s_cruft = 'y';
        }
+       */

+       /*  Forget "cruft", I have DVDs to read with 2-4GB filesizes.
+        */
+       if (inode->i_size < 0) {
+         inode->i_size &= 0x0FFFFFFFF;
+       }
        /*
         * Some dipshit decided to store some other bit of information
         * in the high byte of the file length.  Catch this and holler.

_________________________________________________________________
MSN Toolbar provides one-click access to Hotmail from any Web page – FREE 
download! http://toolbar.msn.click-url.com/go/onm00200413ave/direct/01/

