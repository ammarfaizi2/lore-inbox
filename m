Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750748AbWDJFRL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbWDJFRL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 01:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758AbWDJFRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 01:17:11 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:19862 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S1750748AbWDJFRL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 01:17:11 -0400
Date: Mon, 10 Apr 2006 15:16:51 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Greg Kroah-Hartman <gregkh@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix block device symlink name
Message-Id: <20060410151651.01fd6167.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As noted further on the this file, some block devices have a / in their
name, so fix the "block:..." symlink name the same as the /sys/block name.

(code and comment copied from below)

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---

 fs/partitions/check.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

This might also be a candidate for a stable kernel.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

088ec2acec602096210801cfdc0e4732d81de10d
diff --git a/fs/partitions/check.c b/fs/partitions/check.c
index f924f45..2ef03aa 100644
--- a/fs/partitions/check.c
+++ b/fs/partitions/check.c
@@ -345,6 +345,7 @@ static char *make_block_name(struct gend
 	char *name;
 	static char *block_str = "block:";
 	int size;
+	char *s;
 
 	size = strlen(block_str) + strlen(disk->disk_name) + 1;
 	name = kmalloc(size, GFP_KERNEL);
@@ -352,6 +353,10 @@ static char *make_block_name(struct gend
 		return NULL;
 	strcpy(name, block_str);
 	strcat(name, disk->disk_name);
+	/* ewww... some of these buggers have / in name... */
+	s = strchr(name, '/');
+	if (s)
+		*s = '!';
 	return name;
 }
 
-- 
1.2.4
