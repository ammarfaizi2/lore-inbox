Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266519AbUIMLNV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266519AbUIMLNV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 07:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266526AbUIMLNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 07:13:21 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:3761 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id S266519AbUIMLNS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 07:13:18 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16709.32973.307634.787473@thebsh.namesys.com>
Date: Mon, 13 Sep 2004 15:13:17 +0400
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm5
In-Reply-To: <200409131248.53098.rjw@sisk.pl>
References: <20040913015003.5406abae.akpm@osdl.org>
	<200409131248.53098.rjw@sisk.pl>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael J. Wysocki writes:
 > On Monday 13 of September 2004 10:50, Andrew Morton wrote:
 > > 
 > > Due to master.kernel.org being on the blink, 2.6.9-rc1-mm5 Is currently at
 > > 
 > >  http://www.zip.com.au/~akpm/linux/patches/2.6.9-rc1-mm5/
 > 
 > I can't build it on x86-64:
 > 
 >   LD      init/built-in.o
 >   LD      .tmp_vmlinux1
 > fs/built-in.o(.text+0xd1893): In function `mask_ok_common':
 > : undefined reference to `vfs_permission'
 > make: *** [.tmp_vmlinux1] Error 1

reiser4 wasn't updated during vfs_permission/generic_permission
conversion. Evil conspiracy is obviously underway.

Untested patch is below.

Andrew, please apply.

Nikita.
----------------------------------------------------------------------
--- perm.c	2004-05-17 14:04:55.000000000 +0400
+++ perm.c.new	2004-09-13 15:07:10.432547928 +0400
@@ -13,7 +13,7 @@
 static int
 mask_ok_common(struct inode *inode, int mask)
 {
-	return vfs_permission(inode, mask);
+	return generic_permission(inode, mask, NULL);
 }
 
 static int
----------------------------------------------------------------------
 > 
 > The .config is attached.
 > 
 > Greets,
 > RJW
 > 
