Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933131AbWFZXqm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933131AbWFZXqm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933128AbWFZXql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 19:46:41 -0400
Received: from mail.sdi-muenchen.de ([62.245.203.250]:8185 "EHLO
	linux.sdi-muenchen.de") by vger.kernel.org with ESMTP
	id S933131AbWFZXqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 19:46:40 -0400
From: Stephan =?iso-8859-1?q?M=FCller?= <smueller@chronox.de>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH 01/06] ecryptfs: Validate minimum header extent size
Date: Tue, 27 Jun 2006 01:46:27 +0200
User-Agent: KMail/1.9.1
Cc: Michael Halcrow <mhalcrow@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606270146.27959.smueller@chronox.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel version: 2.6.17-mm1

The encrypted file ecryptfs maintains has in the first page meta data that 
is needed for ecryptfs operation. As the encrypted file is untrusted, 
every bit read of that file must be validated.

The patch ensures that crypt_stat->num_header_extents_at_front is checked 
for improper values.

Signed-off-by: Stephan Mueller <smueller@chronox.de>

---

 fs/ecryptfs/crypto.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

1d76f6b4a787047ca354c8385614b0d549db6bc8
diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index 427f470..91b350e 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -1333,7 +1333,8 @@ static int parse_header_metadata(struct 
 	crypt_stat->num_header_extents_at_front =
 		(int)num_header_extents_at_front;
 	(*bytes_read) = 6;
-	if (crypt_stat->header_extent_size
+	if ((crypt_stat->header_extent_size
+	     * crypt_stat->num_header_extents_at_front)
 	    < ECRYPTFS_MINIMUM_HEADER_EXTENT_SIZE) {
 		rc = -EINVAL;
 		ecryptfs_printk(KERN_WARNING, "Invalid header extent size: "
