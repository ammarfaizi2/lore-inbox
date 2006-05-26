Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750802AbWEZOWG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbWEZOWG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 10:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbWEZOWF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 10:22:05 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:1229 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750781AbWEZOV6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 10:21:58 -0400
In-reply-to: <20060526142117.GA2764@us.ibm.com>
From: Mike Halcrow <mhalcrow@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>,
       Mike Halcrow <mhalcrow@us.ibm.com>, Mike Halcrow <mike@halcrow.us>
Subject: [PATCH 3/10] Convert signed data types to unsigned data types
Message-Id: <E1FjdCG-00033G-K3@localhost.localdomain>
Date: Fri, 26 May 2006 09:21:48 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert data types in structures in the header to be unsigned if they
are supposed to ever only contain unsigned values.

Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>

---

 fs/ecryptfs/ecryptfs_kernel.h |   46 +++++++++++++++++++++--------------------
 1 files changed, 23 insertions(+), 23 deletions(-)

704eeca89309cfaed08992f03e100d465b458b56
diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index 48fd0a1..6164161 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -80,18 +80,18 @@ #define ECRYPTFS_USERSPACE_SHOULD_TRY_TO
 #define ECRYPTFS_USERSPACE_SHOULD_TRY_TO_ENCRYPT 0x00000002
 #define ECRYPTFS_CONTAINS_DECRYPTED_KEY 0x00000004
 #define ECRYPTFS_CONTAINS_ENCRYPTED_KEY 0x00000008
-	s32 flags;
-	s32 encrypted_key_size;
-	s32 decrypted_key_size;
+	u32 flags;
+	u32 encrypted_key_size;
+	u32 decrypted_key_size;
 	u8 encrypted_key[ECRYPTFS_MAX_ENCRYPTED_KEY_BYTES];
 	u8 decrypted_key[ECRYPTFS_MAX_KEY_BYTES];
 };
 
 struct ecryptfs_password {
-	s32 password_bytes;
+	u32 password_bytes;
 	s32 hash_algo;
-	s32 hash_iterations;
-	s32 session_key_encryption_key_bytes;
+	u32 hash_iterations;
+	u32 session_key_encryption_key_bytes;
 #define ECRYPTFS_PERSISTENT_PASSWORD 0x01
 #define ECRYPTFS_SESSION_KEY_ENCRYPTION_KEY_SET 0x02
 	u32 flags;
@@ -104,15 +104,15 @@ #define ECRYPTFS_SESSION_KEY_ENCRYPTION_
 
 /* May be a password or a private key */
 struct ecryptfs_auth_tok {
-	uint16_t version; /* 8-bit major and 8-bit minor */
+	u16 version; /* 8-bit major and 8-bit minor */
 #define ECRYPTFS_PASSWORD         0x00000001
 #define ECRYPTFS_PRIVATE_KEY      0x00000002
 #define ECRYPTFS_CONTAINS_SECRET  0x00000004
 #define ECRYPTFS_EXPIRED          0x00000008
 	u32 flags;
 	uid_t uid;
-	s64 creation_time;
-	s64 expiration_time;
+	u64 creation_time;
+	u64 expiration_time;
 	union {
 		struct ecryptfs_password password;
 		/* Private key is in future eCryptfs releases */
@@ -143,7 +143,7 @@ struct ecryptfs_page_crypt_context {
 	struct page *page;
 #define ECRYPTFS_PREPARE_COMMIT_MODE 0
 #define ECRYPTFS_WRITEPAGE_MODE      1
-	int mode;
+	unsigned int mode;
 	union {
 		struct file *lower_file;
 		struct writeback_control *wbc;
@@ -191,23 +191,22 @@ #define ECRYPTFS_ENABLE_HMAC        0x00
 #define ECRYPTFS_ENCRYPT_IV_PAGES   0x00000040
 #define ECRYPTFS_KEY_VALID          0x00000080
 	u32 flags;
-	int file_version;
-	int iv_bytes;
-	int num_keysigs;
-	int header_extent_size;
-	int num_header_extents_at_front; /* Number of header extents
-					  * at the front of the file */
-	int extent_size; /* Data extent size; default is 4096 */
-	int key_size_bits;
+	unsigned int file_version;
+	unsigned int iv_bytes;
+	unsigned int num_keysigs;
+	unsigned int header_extent_size;
+	unsigned int num_header_extents_at_front;
+	unsigned int extent_size; /* Data extent size; default is 4096 */
+	unsigned int key_size_bits;
 	unsigned int extent_shift;
 	unsigned int extent_mask;
 	struct crypto_tfm *tfm;
 	struct crypto_tfm *md5_tfm; /* Crypto context for generating
 				     * the initialization vectors */
-	char cipher[ECRYPTFS_MAX_CIPHER_NAME_SIZE];
+	unsigned char cipher[ECRYPTFS_MAX_CIPHER_NAME_SIZE];
 	unsigned char key[ECRYPTFS_MAX_KEY_BYTES];
 	unsigned char root_iv[ECRYPTFS_MAX_IV_BYTES];
-	char keysigs[ECRYPTFS_MAX_NUM_KEYSIGS][ECRYPTFS_SIG_SIZE_HEX];
+	unsigned char keysigs[ECRYPTFS_MAX_NUM_KEYSIGS][ECRYPTFS_SIG_SIZE_HEX];
 	struct mutex cs_mutex;
 };
 
@@ -234,8 +233,9 @@ struct ecryptfs_mount_crypt_stat {
 	/* Pointers to memory we do not own, do not free these */
 	struct ecryptfs_auth_tok *global_auth_tok;
 	struct key *global_auth_tok_key;
-	char global_default_cipher_name[ECRYPTFS_MAX_CIPHER_NAME_SIZE + 1];
-	char global_auth_tok_sig[ECRYPTFS_SIG_SIZE_HEX + 1];
+	unsigned char global_default_cipher_name[ECRYPTFS_MAX_CIPHER_NAME_SIZE
+						 + 1];
+	unsigned char global_auth_tok_sig[ECRYPTFS_SIG_SIZE_HEX + 1];
 };
 
 /* superblock private data. */
@@ -253,7 +253,7 @@ struct ecryptfs_file_info {
 
 /* auth_tok <=> encrypted_session_key mappings */
 struct ecryptfs_auth_tok_list_item {
-	char encrypted_session_key[ECRYPTFS_MAX_KEY_BYTES];
+	unsigned char encrypted_session_key[ECRYPTFS_MAX_KEY_BYTES];
 	struct list_head list;
 	struct ecryptfs_auth_tok auth_tok;
 };
-- 
1.3.3

