Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267693AbTBKXZx>; Tue, 11 Feb 2003 18:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267915AbTBKXZx>; Tue, 11 Feb 2003 18:25:53 -0500
Received: from phobos.hpl.hp.com ([192.6.19.124]:51911 "EHLO phobos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S267693AbTBKXZw>;
	Tue, 11 Feb 2003 18:25:52 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15945.31739.980916.94425@napali.hpl.hp.com>
Date: Tue, 11 Feb 2003 14:40:59 -0800
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: fix fadvise64() return type
In-Reply-To: <20030207140015.0fe40a34.akpm@digeo.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please remember to declare the return-type of syscall stubs as "long".
On 64-bit platforms, it's generally necessary to ensure that the
entire 64-bit return value is valid (and can be checked against
negative values).

Thanks,

	--david

===== mm/fadvise.c 1.1 vs edited =====
--- 1.1/mm/fadvise.c	Mon Feb  3 23:46:36 2003
+++ edited/mm/fadvise.c	Tue Feb 11 14:38:21 2003
@@ -20,7 +20,7 @@
  * POSIX_FADV_WILLNEED could set PG_Referenced, and POSIX_FADV_NOREUSE could
  * deactivate the pages and clear PG_Referenced.
  */
-int sys_fadvise64(int fd, loff_t offset, size_t len, int advice)
+long sys_fadvise64(int fd, loff_t offset, size_t len, int advice)
 {
 	struct file *file = fget(fd);
 	struct inode *inode;
