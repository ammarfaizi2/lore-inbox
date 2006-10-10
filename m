Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030629AbWJJWmQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030629AbWJJWmQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 18:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030616AbWJJWiA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 18:38:00 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:60034 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030609AbWJJWh4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 18:37:56 -0400
To: torvalds@osdl.org
Subject: [PATCH 7/16] befs: missing fs32_to_cpu() in debug.c
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1GXQEV-0008VZ-RW@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 23:37:55 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date: Sat, 24 Dec 2005 03:09:03 -0500

inode->mode is disk-endian

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/befs/debug.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fs/befs/debug.c b/fs/befs/debug.c
index 3afd088..bb68370 100644
--- a/fs/befs/debug.c
+++ b/fs/befs/debug.c
@@ -124,7 +124,7 @@ #ifdef CONFIG_BEFS_DEBUG
 	befs_debug(sb, "  type %08x", fs32_to_cpu(sb, inode->type));
 	befs_debug(sb, "  inode_size %u", fs32_to_cpu(sb, inode->inode_size));
 
-	if (S_ISLNK(inode->mode)) {
+	if (S_ISLNK(fs32_to_cpu(sb, inode->mode))) {
 		befs_debug(sb, "  Symbolic link [%s]", inode->data.symlink);
 	} else {
 		int i;
-- 
1.4.2.GIT


