Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933132AbWFZXsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933132AbWFZXsJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933139AbWFZXsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 19:48:08 -0400
Received: from mail.sdi-muenchen.de ([62.245.203.250]:13049 "EHLO
	linux.sdi-muenchen.de") by vger.kernel.org with ESMTP
	id S933135AbWFZXsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 19:48:05 -0400
From: Stephan =?iso-8859-1?q?M=FCller?= <smueller@chronox.de>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH 04/06] ecryptfs: Use the passed-in max value as the upper bound.
Date: Tue, 27 Jun 2006 01:47:59 +0200
User-Agent: KMail/1.9.1
Cc: Michael Halcrow <mhalcrow@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606270147.59754.smueller@chronox.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel version: 2.6.17-mm1

Function encrypted_session_key_set is given a maximum length it is allowed 
to write. This patch makes this function to obey this length.

Signed-off-by: Stephan Mueller <smueller@chronox.de>

---

 fs/ecryptfs/keystore.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

f64944018925812338c59adab29982be8f963386
diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
index efcf00a..4b9b742 100644
--- a/fs/ecryptfs/keystore.c
+++ b/fs/ecryptfs/keystore.c
@@ -929,7 +929,7 @@ encrypted_session_key_set:
 	/* TODO: Packet size limit */
 	/* We have 5 bytes of surrounding packet data */
 	if ((0x05 + ECRYPTFS_SALT_SIZE
-	     + (*key_rec).enc_key_size) >= PAGE_CACHE_SIZE) {
+	     + (*key_rec).enc_key_size) >= max) {
 		ecryptfs_printk(KERN_ERR, "Authentication token is too "
 				"large\n");
 		rc = -EINVAL;
