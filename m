Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263975AbTIIHxP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 03:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263985AbTIIHxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 03:53:15 -0400
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:35845
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP id S263975AbTIIHxN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 03:53:13 -0400
Subject: Re: 2.6.0-test5-mm1
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
In-Reply-To: <20030908235028.7dbd321b.akpm@osdl.org>
References: <20030908235028.7dbd321b.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1063093989.12321.28.camel@ixodes.goop.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 09 Sep 2003 00:53:09 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-09-08 at 23:50, Andrew Morton wrote:
> +group_leader-rework.patch
> 
>  Use the thread group leader's pgrp rather than the current thread's pgrp
>  everywhere.

Missed one:

 fs/autofs/inode.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN fs/autofs/inode.c~fix-pgrp fs/autofs/inode.c
--- local-2.6/fs/autofs/inode.c~fix-pgrp	2003-09-09 00:29:35.000000000 -0700
+++ local-2.6-jeremy/fs/autofs/inode.c	2003-09-09 00:30:05.000000000 -0700
@@ -129,7 +129,7 @@ int autofs_fill_super(struct super_block
 	sbi->magic = AUTOFS_SBI_MAGIC;
 	sbi->catatonic = 0;
 	sbi->exp_timeout = 0;
-	sbi->oz_pgrp = current->pgrp;
+	sbi->oz_pgrp = process_group(current);
 	autofs_initialize_hash(&sbi->dirhash);
 	sbi->queues = NULL;
 	memset(sbi->symlink_bitmap, 0, sizeof(long)*AUTOFS_SYMLINK_BITMAP_LEN);

_


