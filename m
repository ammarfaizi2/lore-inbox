Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933128AbWFZXrJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933128AbWFZXrJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933134AbWFZXrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 19:47:08 -0400
Received: from mail.sdi-muenchen.de ([62.245.203.250]:10233 "EHLO
	linux.sdi-muenchen.de") by vger.kernel.org with ESMTP
	id S933128AbWFZXrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 19:47:06 -0400
From: Stephan =?iso-8859-1?q?M=FCller?= <smueller@chronox.de>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH 02/06] ecryptfs: Validate body size
Date: Tue, 27 Jun 2006 01:47:00 +0200
User-Agent: KMail/1.9.1
Cc: Michael Halcrow <mhalcrow@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606270147.00218.smueller@chronox.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel version: 2.6.17-mm1

The patch ensures that body_size is checked for improper values.

Signed-off-by: Stephan Mueller <smueller@chronox.de>

---

 fs/ecryptfs/keystore.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

4d78bed2424c6af4a0d1ef4944d485bd5fd48d36
diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
index e80d7a6..9b98fac 100644
--- a/fs/ecryptfs/keystore.c
+++ b/fs/ecryptfs/keystore.c
@@ -397,6 +397,12 @@ parse_tag_11_packet(unsigned char *data,
 		rc = -EINVAL;
 		goto out;
 	}
+	if (body_size < 13) {
+		ecryptfs_printk(KERN_WARNING, "Invalid body size ([%d])\n",
+				body_size);
+		rc = -EINVAL;
+		goto out;
+	}
 	/* We have 13 bytes of surrounding packet values */
 	(*tag_11_contents_size) = (body_size - 13);
 	if ((*tag_11_contents_size) > max_contents_bytes) {
