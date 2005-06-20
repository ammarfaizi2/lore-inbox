Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261639AbVFUDmI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261639AbVFUDmI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 23:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261641AbVFUDYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 23:24:04 -0400
Received: from mail.kroah.org ([69.55.234.183]:2276 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261637AbVFTW7b convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:59:31 -0400
Cc: jonsmirl@gmail.com
Subject: [PATCH] SYSFS: fix PAGE_SIZE check
In-Reply-To: <11193083692565@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:29 -0700
Message-Id: <11193083693615@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] SYSFS: fix PAGE_SIZE check

Without this change I can't set an attribute exactly PAGE_SIZE in
length. There is no need for zero termination because the interface
uses lengths.

From: Jon Smirl <jonsmirl@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 9d9d27fb651a7c95a46f276bacb4329db47470a6
tree cf25134082cb61e860f65af73adc91674ec74258
parent 42b16c051c3f462095fb8c9bad1bc05b34518cb9
author Jon Smirl <jonsmirl@gmail.com> Tue, 14 Jun 2005 09:54:54 -0400
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:15:38 -0700

 fs/sysfs/file.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -182,7 +182,7 @@ fill_write_buffer(struct sysfs_buffer * 
 		return -ENOMEM;
 
 	if (count >= PAGE_SIZE)
-		count = PAGE_SIZE - 1;
+		count = PAGE_SIZE;
 	error = copy_from_user(buffer->page,buf,count);
 	buffer->needs_read_fill = 1;
 	return error ? -EFAULT : count;

