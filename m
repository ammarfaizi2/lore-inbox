Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263467AbUFNQ3y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263467AbUFNQ3y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 12:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263457AbUFNQ3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 12:29:53 -0400
Received: from fw.osdl.org ([65.172.181.6]:41152 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263415AbUFNQ3T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 12:29:19 -0400
Date: Mon, 14 Jun 2004 09:29:17 -0700
From: Chris Wright <chrisw@osdl.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] __user annotation for dummy_shm_shmat
Message-ID: <20040614092917.C21045@build.pdx.osdl.net>
References: <20040614092343.A21045@build.pdx.osdl.net> <20040614092756.B21045@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040614092756.B21045@build.pdx.osdl.net>; from chrisw@osdl.org on Mon, Jun 14, 2004 at 09:27:56AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add proper __user annotation to dummy_shm_shmat.

  CHECK   security/dummy.c
security/dummy.c:995:2: warning: incorrect type in assignment (incompatible argument 2 (different address spaces))
security/dummy.c:995:2:    expected int ( *[addressable] [toplevel] shm_shmat )( ... )
security/dummy.c:995:2:    got int ( static [addressable] [toplevel] *<noident> )( ... )
  CC      security/dummy.o

Signed-off-by: Chris Wright <chrisw@osdl.org>

===== security/dummy.c 1.39 vs edited =====
--- 1.39/security/dummy.c	2004-05-10 04:25:52 -07:00
+++ edited/security/dummy.c	2004-06-14 09:09:51 -07:00
@@ -688,7 +688,7 @@
 	return 0;
 }
 
-static int dummy_shm_shmat (struct shmid_kernel *shp, char *shmaddr,
+static int dummy_shm_shmat (struct shmid_kernel *shp, char __user *shmaddr,
 			    int shmflg)
 {
 	return 0;
