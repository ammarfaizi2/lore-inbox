Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263279AbTFGQ7U (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 12:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263277AbTFGQ7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 12:59:20 -0400
Received: from smtp03.web.de ([217.72.192.158]:33545 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S263279AbTFGQ7T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 12:59:19 -0400
Date: Sat, 7 Jun 2003 19:29:27 +0200
From: =?ISO-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       trivial@rustcorp.com.au
Subject: Re: [PATCH] hugetlbfs: fix error reporting in case of invalid mount
 options
Message-Id: <20030607192927.3d308201.l.s.r@web.de>
In-Reply-To: <20030607163521.GG8978@holomorphy.com>
References: <20030607145532.2bc66f38.l.s.r@web.de>
	<20030607163521.GG8978@holomorphy.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Jun 2003 09:35:21 -0700 William Lee Irwin III <wli@holomorphy.com> wrote:
> Let's nuke it entirely. All other fs's barf without printk()'ing at all
> and kick -EINVAL back to the caller.

Mmmkay, even better. Patch below.

René



diff -u ./fs/hugetlbfs/inode.c~ ./fs/hugetlbfs/inode.c
--- ./fs/hugetlbfs/inode.c~	2003-06-07 19:22:27.000000000 +0200
+++ ./fs/hugetlbfs/inode.c	2003-06-07 19:23:03.000000000 +0200
@@ -524,10 +524,9 @@
 	struct hugetlbfs_config config;
 
 	ret = hugetlbfs_parse_options(data, &config);
-	if (ret) {
-		printk("hugetlbfs: invalid mount options: %s.\n", data);
+	if (ret)
 		return ret;
-	}
+
 	sb->s_blocksize = PAGE_CACHE_SIZE;
 	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
 	sb->s_magic = HUGETLBFS_MAGIC;
