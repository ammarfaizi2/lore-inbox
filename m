Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261807AbUKCTFN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbUKCTFN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 14:05:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261816AbUKCTFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 14:05:13 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:60331 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S261807AbUKCTDr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 14:03:47 -0500
Date: Wed, 3 Nov 2004 12:03:45 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       urban@teststation.com
Subject: [PATCH 2.6.10-rc1] Fix building of samba userland
Message-ID: <20041103190345.GI381@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.  After 2.6.8.1, samba userland would no longer build with current
kernel headers, as it needs some of the samba kernel headers to work,
yet they included <linux/fs.h> outside of __KERNEL__, and after 2.6.9
this was no longer safe, and caused compilation to fail like this:
Compiling client/smbmount.c
In file included from /fdb041101/montavista/foundation/devkit/ppc/74xx/bin/../ta
rget/usr/include/linux/fs.h:19,
                 from /fdb041101/montavista/foundation/devkit/ppc/74xx/bin/../ta
rget/usr/include/linux/smb_fs.h:15,
                 from ../source/client/smbmount.c:27:
/fdb041101/montavista/foundation/devkit/ppc/74xx/bin/../target/usr/include/linux
/prio_tree.h:22: error: parse error before "pgoff_t"
/fdb041101/montavista/foundation/devkit/ppc/74xx/bin/../target/usr/include/linux
/prio_tree.h:27: error: parse error before "pgoff_t"
The simple fix is to move <linux/fs.h> down below the __KERNEL__ test.

Signed-off-by: Tom Rini <trini@kernel.crashing.org>

--- 1.14/include/linux/smb_fs.h	2003-06-25 16:30:54 -07:00
+++ edited/include/linux/smb_fs.h	2004-11-03 12:00:07 -07:00
@@ -12,7 +12,6 @@
 #include <linux/smb.h>
 #include <linux/smb_fs_i.h>
 #include <linux/smb_fs_sb.h>
-#include <linux/fs.h>
 
 /*
  * ioctl commands
@@ -26,6 +25,7 @@
 
 #ifdef __KERNEL__
 
+#include <linux/fs.h>
 #include <linux/pagemap.h>
 #include <linux/vmalloc.h>
 #include <linux/smb_mount.h>

-- 
Tom Rini
http://gate.crashing.org/~trini/
