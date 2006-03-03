Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752219AbWCCJ00@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752219AbWCCJ00 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 04:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752220AbWCCJ00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 04:26:26 -0500
Received: from smtp103.biz.mail.mud.yahoo.com ([68.142.200.238]:11412 "HELO
	smtp103.biz.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1752219AbWCCJ0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 04:26:25 -0500
Subject: [PATCH] smbfs: Fix debug logging-only compilation error
From: Kirk True <kernel@kirkandsheila.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Fri, 03 Mar 2006 01:24:38 -0800
Message-Id: <1141377878.8331.17.camel@itchy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Version: 2.6.16-rc5

When SMBFS_DEBUG_VERBOSE is #define-d, the compile breaks:

    fs/smbfs/inode.c:217: error: aggregate value used where an integer was expected

This is a simple matter of using the .tv_sec attribute of struct time_spec.

        Signed-off-by: Kirk True <kernel@kirkandsheila.com>

--- linux-2.6.16-rc5-orig/fs/smbfs/inode.c      2006-03-02 23:52:17.000000000 -0800
+++ linux-2.6.16-rc5/fs/smbfs/inode.c   2006-03-02 23:12:34.000000000 -0800
@@ -216,7 +216,7 @@
        if (inode->i_mtime.tv_sec != last_time || inode->i_size != last_sz) {
                VERBOSE("%ld changed, old=%ld, new=%ld, oz=%ld, nz=%ld\n",
                        inode->i_ino,
-                       (long) last_time, (long) inode->i_mtime,
+                       (long) last_time, (long) inode->i_mtime.tv_sec,
                        (long) last_sz, (long) inode->i_size);

                if (!S_ISDIR(inode->i_mode))


