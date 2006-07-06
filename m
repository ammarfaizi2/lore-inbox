Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030205AbWGFKho@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030205AbWGFKho (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 06:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030210AbWGFKho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 06:37:44 -0400
Received: from mail.sdi-muenchen.de ([62.245.203.250]:60849 "EHLO
	linux.sdi-muenchen.de") by vger.kernel.org with ESMTP
	id S1030205AbWGFKhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 06:37:43 -0400
From: Stephan =?iso-8859-1?q?M=FCller?= <smueller@chronox.de>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ecryptfs: partial signed integer to size_t conversion (updated)
Date: Thu, 6 Jul 2006 12:37:32 +0200
User-Agent: KMail/1.9.3
Cc: mhalcrow@us.ibm.com
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200607061237.32883.smueller@chronox.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel version: 2.6.17-mm1

This patch changes as much as possible all unsigned ints to size_t in the code 
part that deals with parsing the lower file.

It fixes no known bug, but might help in later development.

This patch is updated as the first attempt contained mangled tabs.

Signed-off-by: Stephan Mueller <smueller@chronox.de>

---

 fs/ecryptfs/crypto.c          |   14 ++++----
 fs/ecryptfs/ecryptfs_kernel.h |   26 +++++++-------
 fs/ecryptfs/keystore.c        |   75 
++++++++++++++++++++++-------------------
 fs/ecryptfs/main.c            |    1 +
 4 files changed, 62 insertions(+), 54 deletions(-)

7af4b3f8d4cfc00b47b447d579104c3b4f93f50f
diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index 285ad5f..100881e 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -53,7 +53,7 @@ ecryptfs_encrypt_page_offset(struct ecry
  * @src: Buffer to be converted to a hex string respresentation
  * @src_size: number of bytes to convert
  */
-void ecryptfs_to_hex(char *dst, char *src, int src_size)
+void ecryptfs_to_hex(char *dst, char *src, size_t src_size)
 {
 	int x;
 
@@ -1021,7 +1021,7 @@ static int ecryptfs_process_flags(struct
  *
  * Marker = 0x3c81b7f5
  */
-static void write_ecryptfs_marker(char *page_virt, int *written)
+static void write_ecryptfs_marker(char *page_virt, size_t *written)
 {
 	u32 m_1, m_2;
 
@@ -1037,7 +1037,7 @@ static void write_ecryptfs_marker(char *
 
 static void
 write_ecryptfs_flags(char *page_virt, struct ecryptfs_crypt_stat *crypt_stat,
-		     int *written)
+		     size_t *written)
 {
 	u32 flags = 0;
 	int i;
@@ -1173,7 +1173,7 @@ out:
 
 static void
 write_header_metadata(char *virt, struct ecryptfs_crypt_stat *crypt_stat,
-		      int *written)
+		      size_t *written)
 {
 	u32 header_extent_size;
 	u16 num_header_extents_at_front;
@@ -1227,8 +1227,8 @@ int ecryptfs_write_headers_virt(char *pa
 				struct dentry *ecryptfs_dentry)
 {
 	int rc;
-	int written;
-	int offset;
+	size_t written;
+	size_t offset;
 
 	offset = ECRYPTFS_FILE_SIZE_BYTES;
 	write_ecryptfs_marker((page_virt + offset), &written);
@@ -1587,7 +1587,7 @@ out:
  */
 int
 ecryptfs_process_cipher(struct crypto_tfm **tfm, struct crypto_tfm **key_tfm,
-			char *cipher_name, unsigned int key_size)
+			char *cipher_name, size_t key_size)
 {
 	char dummy_key[ECRYPTFS_MAX_KEY_BYTES];
 	int rc;
diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index 2ec8c1b..68a02ee 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -124,12 +124,12 @@ #define ECRYPTFS_EXPIRED          0x0000
 };
 
 void ecryptfs_dump_auth_tok(struct ecryptfs_auth_tok *auth_tok);
-extern void ecryptfs_to_hex(char *dst, char *src, int src_size);
+extern void ecryptfs_to_hex(char *dst, char *src, size_t src_size);
 extern void ecryptfs_from_hex(char *dst, char *src, int dst_size);
 
 struct ecryptfs_key_record {
-	u16 enc_key_size;
 	unsigned char type;
+	size_t enc_key_size;
 	unsigned char sig[ECRYPTFS_SIG_SIZE];
 	unsigned char enc_key[ECRYPTFS_MAX_ENCRYPTED_KEY_BYTES];
 };
@@ -193,13 +193,13 @@ #define ECRYPTFS_ENCRYPT_IV_PAGES   0x00
 #define ECRYPTFS_KEY_VALID          0x00000080
 	u32 flags;
 	unsigned int file_version;
-	unsigned int iv_bytes;
-	unsigned int num_keysigs;
-	unsigned int header_extent_size;
-	unsigned int num_header_extents_at_front;
-	unsigned int extent_size; /* Data extent size; default is 4096 */
-	unsigned int key_size;
-	unsigned int extent_shift;
+	size_t iv_bytes;
+	size_t num_keysigs;
+	size_t header_extent_size;
+	size_t num_header_extents_at_front;
+	size_t extent_size; /* Data extent size; default is 4096 */
+	size_t key_size;
+	size_t extent_shift;
 	unsigned int extent_mask;
 	struct ecryptfs_mount_crypt_stat *mount_crypt_stat;
 	struct crypto_tfm *tfm;
@@ -237,7 +237,7 @@ struct ecryptfs_mount_crypt_stat {
 	/* Pointers to memory we do not own, do not free these */
 	struct ecryptfs_auth_tok *global_auth_tok;
 	struct key *global_auth_tok_key;
-	unsigned int global_default_cipher_key_size;
+	size_t global_default_cipher_key_size;
 	struct crypto_tfm *global_key_tfm;
 	struct mutex global_key_tfm_mutex;
 	unsigned char global_default_cipher_name[ECRYPTFS_MAX_CIPHER_NAME_SIZE
@@ -464,8 +464,8 @@ int ecryptfs_cipher_code_to_string(char 
 void ecryptfs_set_default_sizes(struct ecryptfs_crypt_stat *crypt_stat);
 int ecryptfs_generate_key_packet_set(char *dest_base,
 				     struct ecryptfs_crypt_stat *crypt_stat,
-				     struct dentry *ecryptfs_dentry, int *len,
-				     int max);
+				     struct dentry *ecryptfs_dentry,
+				     size_t *len, size_t max);
 int process_request_key_err(long err_code);
 int
 ecryptfs_parse_packet_set(struct ecryptfs_crypt_stat *crypt_stat,
@@ -473,6 +473,6 @@ ecryptfs_parse_packet_set(struct ecryptf
 int ecryptfs_truncate(struct dentry *dentry, loff_t new_length);
 int
 ecryptfs_process_cipher(struct crypto_tfm **tfm, struct crypto_tfm **key_tfm,
-			char *cipher_name, unsigned int key_size);
+			char *cipher_name, size_t key_size);
 
 #endif /* #ifndef ECRYPTFS_KERNEL_H */
diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
index 688789a..f993ee0 100644
--- a/fs/ecryptfs/keystore.c
+++ b/fs/ecryptfs/keystore.c
@@ -93,7 +93,8 @@ struct kmem_cache *ecryptfs_auth_tok_lis
  *
  * Returns Zero on success
  */
-static int parse_packet_length(unsigned char *data, int *size, int 
*length_size)
+static int parse_packet_length(unsigned char *data, size_t *size,
+			       size_t *length_size)
 {
 	int rc = 0;
 
@@ -133,7 +134,8 @@ out:
  *
  * Returns zero on success; non-zero on error.
  */
-static int write_packet_length(char *dest, int size, int *packet_size_length)
+static int write_packet_length(char *dest, size_t size,
+			       size_t *packet_size_length)
 {
 	int rc = 0;
 
@@ -166,6 +168,7 @@ static int write_packet_length(char *des
  *                auth_tok_list.
  * @packet_size: This function writes the size of the parsed packet
  *               into this memory location; zero on error.
+ * @max_packet_size: maximum number of bytes to parse
  *
  * Returns zero on success; non-zero on error.
  */
@@ -173,12 +176,15 @@ static int
 parse_tag_3_packet(struct ecryptfs_crypt_stat *crypt_stat,
 		   unsigned char *data, struct list_head *auth_tok_list,
 		   struct ecryptfs_auth_tok **new_auth_tok,
-		   int *packet_size, int max_packet_size)
+		   size_t *packet_size, size_t max_packet_size)
 {
 	int rc = 0;
-	int body_size;
+	size_t body_size;
 	struct ecryptfs_auth_tok_list_item *auth_tok_list_item;
-	int length_size;
+	size_t length_size;
+
+	(*packet_size) = 0;
+	(*new_auth_tok) = NULL;
 
 	/* we check that:
 	 *   one byte for the Tag 3 ID flag
@@ -191,8 +197,6 @@ parse_tag_3_packet(struct ecryptfs_crypt
 		goto out;
 	}
 
-	(*new_auth_tok) = NULL;
-
 	/* check for Tag 3 identifyer - one byte */
 	if (data[(*packet_size)++] != ECRYPTFS_TAG_3_PACKET_TYPE) {
 		ecryptfs_printk(KERN_ERR, "Enter w/ first byte != 0x%.2x\n",
@@ -349,17 +353,18 @@ out:
  *                        error
  * @packet_size: This function writes the size of the parsed packet
  *               into this memory location; zero on error
+ * @max_packet_size: maximum number of bytes to parse
  *
  * Returns zero on success; non-zero on error.
  */
 static int
 parse_tag_11_packet(unsigned char *data, unsigned char *contents,
-		    int max_contents_bytes, int *tag_11_contents_size,
-		    int *packet_size, int max_packet_size)
+		    size_t max_contents_bytes, size_t *tag_11_contents_size,
+		    size_t *packet_size, size_t max_packet_size)
 {
 	int rc = 0;
-	int body_size;
-	int length_size;
+	size_t body_size;
+	size_t length_size;
 
 	(*packet_size) = 0;
 	(*tag_11_contents_size) = 0;
@@ -572,10 +577,10 @@ int ecryptfs_parse_packet_set(struct ecr
 			      unsigned char *src,
 			      struct dentry *ecryptfs_dentry)
 {
-	int i = 0;
+	size_t i = 0;
 	int rc = 0;
-	int found_auth_tok = 0;
-	int next_packet_is_auth_tok_packet;
+	size_t found_auth_tok = 0;
+	size_t next_packet_is_auth_tok_packet;
 	char sig[ECRYPTFS_SIG_SIZE_HEX];
 	struct list_head auth_tok_list;
 	struct list_head *walker;
@@ -584,20 +589,19 @@ int ecryptfs_parse_packet_set(struct ecr
 		&ecryptfs_superblock_to_private(
 			ecryptfs_dentry->d_sb)->mount_crypt_stat;
 	struct ecryptfs_auth_tok *candidate_auth_tok = NULL;
-	int packet_size = 0;
+	size_t packet_size;
 	struct ecryptfs_auth_tok *new_auth_tok;
 	unsigned char sig_tmp_space[ECRYPTFS_SIG_SIZE];
-	int tag_11_contents_size;
-	int tag_11_packet_size;
+	size_t tag_11_contents_size;
+	size_t tag_11_packet_size;
 
 	INIT_LIST_HEAD(&auth_tok_list);
 	/* Parse the header to find as many packets as we can, these will be
 	 * added the our &auth_tok_list */
 	next_packet_is_auth_tok_packet = 1;
 	while (next_packet_is_auth_tok_packet) {
-		int max_packet_size;
+		size_t max_packet_size = ((PAGE_CACHE_SIZE - 8) - i);
 
-		max_packet_size = ((PAGE_CACHE_SIZE - 8) - i);
 		switch (src[i]) {
 		case ECRYPTFS_TAG_3_PACKET_TYPE:
 			rc = parse_tag_3_packet(crypt_stat,
@@ -741,11 +745,11 @@ out:
  * Returns zero on success; non-zero on error.
  */
 static int
-write_tag_11_packet(char *dest, int max, char *contents, int contents_length,
-		    int *packet_length)
+write_tag_11_packet(char *dest, int max, char *contents, size_t 
contents_length,
+		    size_t *packet_length)
 {
 	int rc = 0;
-	int packet_size_length;
+	size_t packet_size_length;
 
 	(*packet_length) = 0;
 	if ((13 + contents_length) > max) {
@@ -788,30 +792,33 @@ write_tag_11_packet(char *dest, int max,
 /**
  * write_tag_3_packet
  * @dest: Buffer into which to write the packet
- * @max: Maximum number of bytes that can be writtn
+ * @max: Maximum number of bytes that can be written
+ * @auth_tok: Authentication token
+ * @crypt_stat: The cryptographic context
+ * @key_rec: encrypted key
  * @packet_size: This function will write the number of bytes that end
  *               up constituting the packet; set to zero on error
  *
  * Returns zero on success; non-zero on error.
  */
 static int
-write_tag_3_packet(char *dest, int max, struct ecryptfs_auth_tok *auth_tok,
+write_tag_3_packet(char *dest, size_t max, struct ecryptfs_auth_tok 
*auth_tok,
 		   struct ecryptfs_crypt_stat *crypt_stat,
-		   struct ecryptfs_key_record *key_rec, int *packet_size)
+		   struct ecryptfs_key_record *key_rec, size_t *packet_size)
 {
 	int rc = 0;
 
-	int i;
-	int signature_is_valid = 0;
-	int encrypted_session_key_valid = 0;
+	size_t i;
+	size_t signature_is_valid = 0;
+	size_t encrypted_session_key_valid = 0;
 	char session_key_encryption_key[ECRYPTFS_MAX_KEY_BYTES];
 	struct scatterlist dest_sg[2];
 	struct scatterlist src_sg[2];
 	struct crypto_tfm *tfm = NULL;
 	struct mutex *tfm_mutex = NULL;
-	int key_rec_size;
-	int packet_size_length;
-	int cipher_code;
+	size_t key_rec_size;
+	size_t packet_size_length;
+	size_t cipher_code;
 
 	(*packet_size) = 0;
 	/* Check for a valid signature on the auth_tok */
@@ -992,15 +999,15 @@ out:
 int
 ecryptfs_generate_key_packet_set(char *dest_base,
 				 struct ecryptfs_crypt_stat *crypt_stat,
-				 struct dentry *ecryptfs_dentry, int *len,
-				 int max)
+				 struct dentry *ecryptfs_dentry, size_t *len,
+				 size_t max)
 {
 	int rc = 0;
 	struct ecryptfs_auth_tok *auth_tok;
 	struct ecryptfs_mount_crypt_stat *mount_crypt_stat =
 		&ecryptfs_superblock_to_private(
 			ecryptfs_dentry->d_sb)->mount_crypt_stat;
-	int written;
+	size_t written;
 	struct ecryptfs_key_record key_rec;
 
 	(*len) = 0;
diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
index 9f27841..44bcbe8 100644
--- a/fs/ecryptfs/main.c
+++ b/fs/ecryptfs/main.c
@@ -530,6 +530,7 @@ static int ecryptfs_get_sb(struct file_s
 	}
 	rc = ecryptfs_read_super(sb, dev_name);
 	if (rc) {
+		up_write(&sb->s_umount);
 		deactivate_super(sb);
 		ret = rc;
 		ecryptfs_printk(KERN_ERR, "Reading sb failed: %d\n", ret);
