Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265295AbTFZBXd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 21:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265325AbTFZBXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 21:23:33 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:45502 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id S265295AbTFZBXb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 21:23:31 -0400
Date: Thu, 26 Jun 2003 11:37:04 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Arun Sharma <arun.sharma@intel.com>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>, linux-ia64@vger.kernel.org,
       "Jin, Gordon" <gordon.jin@intel.com>, trivial@rustcorp.com.au
Subject: [PATCH][COMPAT][TRIVIAL] fix type in compat_sys_fcntl64
Message-Id: <20030626113704.700d9c90.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

[Pointed out by Bjorn Helgaas via Arun Sharma]

This fixes an obvious cut and paste error in my original patch.  Please
apply.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.73-bk3/fs/compat.c 2.5.73-bk3-sfr.1/fs/compat.c
--- 2.5.73-bk3/fs/compat.c	2003-06-23 09:59:58.000000000 +1000
+++ 2.5.73-bk3-sfr.1/fs/compat.c	2003-06-26 11:31:23.000000000 +1000
@@ -451,7 +451,6 @@
 			break;
 		old_fs = get_fs();
 		set_fs(KERNEL_DS);
-		ret = sys_fcntl(fd, F_GETLK, (unsigned long)&f);
 		ret = sys_fcntl(fd, (cmd == F_GETLK64) ? F_GETLK :
 				((cmd == F_SETLK64) ? F_SETLK : F_SETLKW),
 				(unsigned long)&f);
