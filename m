Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263301AbUFNQ2Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263301AbUFNQ2Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 12:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263340AbUFNQ2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 12:28:15 -0400
Received: from fw.osdl.org ([65.172.181.6]:36032 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263301AbUFNQ2K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 12:28:10 -0400
Date: Mon, 14 Jun 2004 09:27:56 -0700
From: Chris Wright <chrisw@osdl.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, Mika Kukkonen <mika@osdl.org>,
       sds@epoch.ncsc.mil, jmorris@redhat.com
Subject: [PATCH 2/3] __user annotation for selinux_shm_shmat
Message-ID: <20040614092756.B21045@build.pdx.osdl.net>
References: <20040614092343.A21045@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040614092343.A21045@build.pdx.osdl.net>; from chrisw@osdl.org on Mon, Jun 14, 2004 at 09:23:43AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add proper __user annotation to selinux_shm_shmat.

  CHECK   security/selinux/hooks.c
security/selinux/hooks.c:4163:17: warning: incorrect type in initializer (incompatible argument 2 (different address spaces))
security/selinux/hooks.c:4163:17:    expected int ( *shm_shmat )( ... )
security/selinux/hooks.c:4163:17:    got int ( static [addressable] [toplevel] *<noident> )( ... )
  CC      security/selinux/hooks.o

From: Mika Kukkonen <mika@osdl.org>
Signed-off-by: Chris Wright <chrisw@osdl.org>

===== security/selinux/hooks.c 1.41 vs edited =====
--- 1.41/security/selinux/hooks.c	2004-06-12 20:52:29 -07:00
+++ edited/security/selinux/hooks.c	2004-06-14 09:00:37 -07:00
@@ -3781,7 +3781,7 @@
 }
 
 static int selinux_shm_shmat(struct shmid_kernel *shp,
-			     char *shmaddr, int shmflg)
+			     char __user *shmaddr, int shmflg)
 {
 	u32 perms;
 
