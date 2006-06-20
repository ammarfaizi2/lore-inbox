Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751200AbWFTV0v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbWFTV0v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 17:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751173AbWFTVYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 17:24:35 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:25786 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751148AbWFTVYO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 17:24:14 -0400
In-reply-to: <20060620212134.GB18701@us.ibm.com>
From: Mike Halcrow <mhalcrow@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       Mike Halcrow <mhalcrow@us.ibm.com>, Mike Halcrow <mike@halcrow.us>
Subject: [PATCH 9/12] Add #define values for cipher codes from RFC2440 (OpenPGP)
Message-Id: <E1Fsnhh-0007A6-WD@localhost.localdomain>
Date: Tue, 20 Jun 2006 16:24:09 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add #define values for cipher codes from RFC2440 (OpenPGP).

Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>

---

 fs/ecryptfs/crypto.c          |   19 +++++++++----------
 fs/ecryptfs/ecryptfs_kernel.h |    9 +++++++++
 fs/ecryptfs/keystore.c        |    8 ++++----
 3 files changed, 22 insertions(+), 14 deletions(-)

892f18996cb6a98db0065db51395998eea989fa8
diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index 5292220..426e5e4 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -1023,18 +1023,17 @@ struct ecryptfs_cipher_code_str_map_elem
 
 /* Add support for additional ciphers by adding elements here. The
  * cipher_code is whatever OpenPGP applicatoins use to identify the
- * ciphers. */
-/* List in order of probability. */
+ * ciphers. List in order of probability. */
 static struct ecryptfs_cipher_code_str_map_elem
 ecryptfs_cipher_code_str_map[] = {
-	{"aes", 0x07}, /* AES-128 */
-	{"blowfish", 0x04},
-	{"des3_ede", 0x02},
-	{"cast5", 0x03},
-	{"twofish", 0x0a},
-	{"cast6", 0x0b},
-	{"aes", 0x08}, /* AES-192 */
-	{"aes", 0x09} /* AES-256 */
+	{"aes",RFC2440_CIPHER_AES_128 },
+	{"blowfish", RFC2440_CIPHER_BLOWFISH},
+	{"des3_ede", RFC2440_CIPHER_DES3_EDE},
+	{"cast5", RFC2440_CIPHER_CAST_5},
+	{"twofish", RFC2440_CIPHER_TWOFISH},
+	{"cast6", RFC2440_CIPHER_CAST_6},
+	{"aes", RFC2440_CIPHER_AES_192},
+	{"aes", RFC2440_CIPHER_AES_256}
 };
 
 /**
diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index 4dc95af..39057a8 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -53,6 +53,15 @@ #define ECRYPTFS_DEFAULT_HEADER_EXTENT_S
 #define ECRYPTFS_DEFAULT_EXTENT_SIZE 4096
 #define ECRYPTFS_MINIMUM_HEADER_EXTENT_SIZE 8192
 
+#define RFC2440_CIPHER_DES3_EDE 0x02
+#define RFC2440_CIPHER_CAST_5 0x03
+#define RFC2440_CIPHER_BLOWFISH 0x04
+#define RFC2440_CIPHER_AES_128 0x07
+#define RFC2440_CIPHER_AES_192 0x08
+#define RFC2440_CIPHER_AES_256 0x09
+#define RFC2440_CIPHER_TWOFISH 0x0a
+#define RFC2440_CIPHER_CAST_6 0x0b
+
 #define ECRYPTFS_SET_FLAG(flag_bit_vector, flag) (flag_bit_vector |= (flag))
 #define ECRYPTFS_CLEAR_FLAG(flag_bit_vector, flag) (flag_bit_vector &= ~(flag))
 #define ECRYPTFS_CHECK_FLAG(flag_bit_vector, flag) (flag_bit_vector & (flag))
diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
index 101773f..d301ac8 100644
--- a/fs/ecryptfs/keystore.c
+++ b/fs/ecryptfs/keystore.c
@@ -247,7 +247,7 @@ parse_tag_3_packet(struct ecryptfs_crypt
 	/* A little extra work to differentiate among the AES key
 	 * sizes; see RFC2440 */
 	switch(data[(*packet_size)++]) {
-	case 0x08:
+	case RFC2440_CIPHER_AES_192:
 		crypt_stat->key_size_bits = 192;
 		break;
 	default:
@@ -931,15 +931,15 @@ encrypted_session_key_set:
 		goto out;
 	}
 	/* If it is AES, we need to get more specific. */
-	if (cipher_code == 0x07) {
+	if (cipher_code == RFC2440_CIPHER_AES_128){
 		switch (crypt_stat->key_size_bits) {
 		case 128:
 			break;
 		case 192:
-			cipher_code = 0x08;	/* AES-192 */
+			cipher_code = RFC2440_CIPHER_AES_192;
 			break;
 		case 256:
-			cipher_code = 0x09;	/* AES-256 */
+			cipher_code = RFC2440_CIPHER_AES_256;
 			break;
 		default:
 			rc = -EINVAL;
-- 
1.3.3

