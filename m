Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264329AbUA0OIs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 09:08:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264442AbUA0OIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 09:08:48 -0500
Received: from avalon.informatik.uni-freiburg.de ([132.230.150.1]:48847 "EHLO
	avalon.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S264329AbUA0OIq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 09:08:46 -0500
Message-ID: <4016711A.10004@gmx.net>
Date: Tue, 27 Jan 2004 15:09:30 +0100
From: Michael Veeck <michael.veeck@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.6) Gecko/20040114
X-Accept-Language: de-at, de, en-us, en
MIME-Version: 1.0
To: owner-xfs@oss.sgi.com
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] XFS: remove warning in xfs_log_recover, 2.6.2-rc2 
Content-Type: multipart/mixed;
 boundary="------------070606090701080007020708"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070606090701080007020708
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Compiling the 2.6.2-rc2 kernel on my machine with allyesconfig and gcc 
3.3.1 triggers the following warning:

   CC      fs/xfs/xfs_log_recover.o
fs/xfs/xfs_log_recover.c: In function `xlog_recover_reorder_trans':
fs/xfs/xfs_log_recover.c:1534: warning: `flags' might be used 
uninitialized in this function

I've added an "= 0" to the appropiate line which lets it cleanly compile 
now. Attached patch fixes the warning and is against 2.6.2-rc2. Apply 
with patch -p1 < patch-XFSwarning.

Best regards
Michael Veeck

--------------070606090701080007020708
Content-Type: text/plain;
 name="patch-XFSwarning"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-XFSwarning"

diff -Naur a/fs/xfs/xfs_log_recover.c b/fs/xfs/xfs_log_recover.c
--- old/fs/xfs/xfs_log_recover.c	2004-01-27 14:28:03.000000000 +0100
+++ new/fs/xfs/xfs_log_recover.c	2004-01-27 14:02:25.000000000 +0100
@@ -1531,7 +1531,7 @@
 	xlog_recover_item_t	*first_item, *itemq, *itemq_next;
 	xfs_buf_log_format_t	*buf_f;
 	xfs_buf_log_format_v1_t	*obuf_f;
-	ushort			flags;
+	ushort			flags = 0;
 
 	first_item = itemq = trans->r_itemq;
 	trans->r_itemq = NULL;

--------------070606090701080007020708
Content-Type: text/plain;
 name="README"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="README"

[PATCH] xfs has uninitialized flags-variable in xfs_log_recover. init it to 0. from michael.veeck@gmx.net

--------------070606090701080007020708--
