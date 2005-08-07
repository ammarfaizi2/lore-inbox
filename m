Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752617AbVHGXOw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752617AbVHGXOw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 19:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753081AbVHGXOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 19:14:52 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:55047 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1752617AbVHGXOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 19:14:51 -0400
Date: Mon, 8 Aug 2005 01:14:49 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Will Dyson <will.dyson@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [2.6 patch] remove unused fs/befs/attribute.c
Message-ID: <20050807231449.GH4006@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Dyson <will.dyson@gmail.com>

If anyone needs a fully-functional befs driver, the easiest route to 
that would probably be getting Haiku's befs driver to compile in 
userland as a FUSE fs.

At any rate, attribute.c can go. It is easy enough to add back in if
anyone ever wants to do the (relativly minor) refactoring nessisary to
get it working.

Signed-off-by: Will Dyson <will.dyson@gmail.com>
Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was sent by Will Dyson on:
- 4 Aug 2005

 fs/befs/attribute.c |  117 --------------------------------------------
 1 files changed, 117 deletions(-)

--- a/fs/befs/attribute.c	Tue Aug  2 13:00:13 2005
+++ /dev/null	Thu Aug  4 00:31:20 2005
@@ -1,117 +0,0 @@
-/*
- * linux/fs/befs/attribute.c
- *
- * Copyright (C) 2002 Will Dyson <will_dyson@pobox.com>
- *
- * Many thanks to Dominic Giampaolo, author of "Practical File System
- * Design with the Be File System", for such a helpful book.
- *
- */
-
-#include <linux/fs.h>
-#include <linux/kernel.h>
-#include <linux/string.h>
-
-#include "befs.h"
-#include "endian.h"
-
-#define SD_DATA(sd)\
-	(void*)((char*)sd + sizeof(*sd) + (sd->name_size - sizeof(sd->name)))
-
-#define SD_NEXT(sd)\
-	(befs_small_data*)((char*)sd + sizeof(*sd) + (sd->name_size - \
-	sizeof(sd->name) + sd->data_size))
-
-int
-list_small_data(struct super_block *sb, befs_inode * inode, filldir_t filldir);
-
-befs_small_data *
-find_small_data(struct super_block *sb, befs_inode * inode,
-				 const char *name);
-int
-read_small_data(struct super_block *sb, befs_inode * inode,
-		 befs_small_data * sdata, void *buf, size_t bufsize);
-
-/**
- *
- *
- *
- *
- *
- */
-befs_small_data *
-find_small_data(struct super_block *sb, befs_inode * inode, const char *name)
-{
-	befs_small_data *sdata = inode->small_data;
-
-	while (sdata->type != 0) {
-		if (strcmp(name, sdata->name) != 0) {
-			return sdata;
-		}
-		sdata = SD_NEXT(sdata);
-	}
-	return NULL;
-}
-
-/**
- *
- *
- *
- *
- *
- */
-int
-read_small_data(struct super_block *sb, befs_inode * inode,
-		const char *name, void *buf, size_t bufsize)
-{
-	befs_small_data *sdata;
-
-	sdata = find_small_data(sb, inode, name);
-	if (sdata == NULL)
-		return BEFS_ERR;
-	else if (sdata->data_size > bufsize)
-		return BEFS_ERR;
-
-	memcpy(buf, SD_DATA(sdata), sdata->data_size);
-
-	return BEFS_OK;
-}
-
-/**
- *
- *
- *
- *
- *
- */
-int
-list_small_data(struct super_block *sb, befs_inode * inode)
-{
-
-}
-
-/**
- *
- *
- *
- *
- *
- */
-int
-list_attr(struct super_block *sb, befs_inode * inode)
-{
-
-}
-
-/**
- *
- *
- *
- *
- *
- */
-int
-read_attr(struct super_block *sb, befs_inode * inode)
-{
-
-}


