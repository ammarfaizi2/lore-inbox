Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261293AbTIKNpJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 09:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbTIKNpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 09:45:09 -0400
Received: from mailwasher.lanl.gov ([192.16.0.25]:32662 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S261293AbTIKNpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 09:45:00 -0400
Subject: [PATCH] 2.6.0-test5-bk fix ver_linux script to work with recent
	reiserfsprogs.
From: Steven Cole <elenstev@mesatop.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1063287639.1660.221.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 11 Sep 2003 07:40:40 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recent reiserfsprogs report the version number in a different format
than before, causing the present ver_linux script to not report the
version number.

This patch allows scripts/ver_linux to work with these newer versions,
while maintaining backward compatibility with the older versions.  This
was tested with reiserfsprogs 3.x.0j, 3.6.8, 3.6.10, and 3.6.11.

Steven

--- 2.5-bk-current/scripts/ver_linux.original	Wed Sep 10 15:11:11 2003
+++ 2.5-bk-current/scripts/ver_linux	Thu Sep 11 07:05:59 2003
@@ -39,6 +39,9 @@
 reiserfsck -V 2>&1 | grep reiserfsprogs | awk \
 'NR==1{print "reiserfsprogs         ", $NF}'
 
+reiserfsck -V 2>&1 | grep namesys | awk \
+'NR==1{print "reiserfsprogs         ", $2}'
+
 xfs_db -V 2>&1 | grep version | awk \
 'NR==1{print "xfsprogs              ", $3}'
 







