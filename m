Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030243AbVKPI5B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030243AbVKPI5B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 03:57:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030240AbVKPI5B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 03:57:01 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:19643 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1030243AbVKPI5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 03:57:00 -0500
Message-ID: <437AF451.8060404@namesys.com>
Date: Wed, 16 Nov 2005 00:56:49 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>, vs <vs@thebsh.namesys.com>
Subject: [Fwd: [PATCH 4/8] reiser4-crypt2cipher-rename.patch]
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------090200080000000400000509"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090200080000000400000509
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit




--------------090200080000000400000509
Content-Type: message/rfc822;
 name="[PATCH 4/8] reiser4-crypt2cipher-rename.patch.eml"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="[PATCH 4/8] reiser4-crypt2cipher-rename.patch.eml"

Return-Path: <vs@tribesman.namesys.com>
Delivered-To: reiser@namesys.com
Received: (qmail 24420 invoked from network); 15 Nov 2005 17:00:10 -0000
Received: from ppp83-237-207-83.pppoe.mtu-net.ru (HELO tribesman.namesys.com) (83.237.207.83)
  by thebsh.namesys.com with SMTP; 15 Nov 2005 17:00:10 -0000
Received: by tribesman.namesys.com (Postfix on SuSE Linux 8.0 (i386), from userid 512)
	id CAAC271D995; Tue, 15 Nov 2005 19:59:48 +0300 (MSK)
Date: Tue, 15 Nov 2005 19:59:46 +0300
To: reiser@namesys.com
Subject: [PATCH 4/8] reiser4-crypt2cipher-rename.patch
Message-ID: <437A1402.mail7JJ115XWE@tribesman.namesys.com>
User-Agent: nail 10.5 4/27/03
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="MA0YZ14O4V-=-1GHF21HD44-CUT-HERE-1QBTTO5KTV-=-H0EUOE2RIJ"
From: vs@tribesman.namesys.com (Vladimir Saveliev)

This is a multi-part message in MIME format.

--MA0YZ14O4V-=-1GHF21HD44-CUT-HERE-1QBTTO5KTV-=-H0EUOE2RIJ
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

.

--MA0YZ14O4V-=-1GHF21HD44-CUT-HERE-1QBTTO5KTV-=-H0EUOE2RIJ
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="reiser4-crypt2cipher-rename.patch"


From: Edward Shishkin <edward@namesys.com>

This is cleanup patch. It replaces crypto by cipher everwhere.

Signed-off-by: Vladimir V. Saveliev <vs@namesys.com>


 fs/reiser4/init_super.c                |    6 +--
 fs/reiser4/inode.c                     |    4 +-
 fs/reiser4/inode.h                     |    2 -
 fs/reiser4/plugin/crypto/cipher.c      |   23 ++++++-----
 fs/reiser4/plugin/file/cryptcompress.c |   64 ++++++++++++++-------------------
 fs/reiser4/plugin/file/cryptcompress.h |    9 ++--
 fs/reiser4/plugin/file/file.c          |    1 
 fs/reiser4/plugin/file_plugin_common.c |    2 -
 fs/reiser4/plugin/plugin.c             |   14 +++----
 fs/reiser4/plugin/plugin.h             |   44 +++++++++++-----------
 fs/reiser4/plugin/plugin_header.h      |    2 -
 fs/reiser4/plugin/plugin_set.c         |   16 ++++----
 fs/reiser4/plugin/plugin_set.h         |    6 +--
 13 files changed, 93 insertions(+), 100 deletions(-)

diff -puN fs/reiser4/init_super.c~reiser4-crypt2cipher-rename fs/reiser4/init_super.c
--- linux-2.6.14-mm2/fs/reiser4/init_super.c~reiser4-crypt2cipher-rename	2005-11-15 17:17:52.000000000 +0300
+++ linux-2.6.14-mm2-vs/fs/reiser4/init_super.c	2005-11-15 17:17:52.000000000 +0300
@@ -640,9 +640,9 @@ static struct {
 		.type = REISER4_ITEM_PLUGIN_TYPE,
 		.id = COMPOUND_DIR_ID
 	},
-	[PSET_CRYPTO] = {
-		.type = REISER4_CRYPTO_PLUGIN_TYPE,
-		.id = NONE_CRYPTO_ID
+	[PSET_CIPHER] = {
+		.type = REISER4_CIPHER_PLUGIN_TYPE,
+		.id = NONE_CIPHER_ID
 	},
 	[PSET_DIGEST] = {
 		.type = REISER4_DIGEST_PLUGIN_TYPE,
diff -puN fs/reiser4/inode.c~reiser4-crypt2cipher-rename fs/reiser4/inode.c
--- linux-2.6.14-mm2/fs/reiser4/inode.c~reiser4-crypt2cipher-rename	2005-11-15 17:17:52.000000000 +0300
+++ linux-2.6.14-mm2-vs/fs/reiser4/inode.c	2005-11-15 17:17:52.000000000 +0300
@@ -548,10 +548,10 @@ fibration_plugin *inode_fibration_plugin
 	return reiser4_inode_data(inode)->pset->fibration;
 }
 
-crypto_plugin *inode_crypto_plugin(const struct inode * inode)
+cipher_plugin *inode_cipher_plugin(const struct inode * inode)
 {
 	assert("edward-36", inode != NULL);
-	return reiser4_inode_data(inode)->pset->crypto;
+	return reiser4_inode_data(inode)->pset->cipher;
 }
 
 compression_plugin *inode_compression_plugin(const struct inode * inode)
diff -puN fs/reiser4/inode.h~reiser4-crypt2cipher-rename fs/reiser4/inode.h
--- linux-2.6.14-mm2/fs/reiser4/inode.h~reiser4-crypt2cipher-rename	2005-11-15 17:17:52.000000000 +0300
+++ linux-2.6.14-mm2-vs/fs/reiser4/inode.h	2005-11-15 17:17:52.000000000 +0300
@@ -344,7 +344,7 @@ extern perm_plugin *inode_perm_plugin(co
 extern formatting_plugin *inode_formatting_plugin(const struct inode *inode);
 extern hash_plugin *inode_hash_plugin(const struct inode *inode);
 extern fibration_plugin *inode_fibration_plugin(const struct inode *inode);
-extern crypto_plugin *inode_crypto_plugin(const struct inode *inode);
+extern cipher_plugin *inode_cipher_plugin(const struct inode *inode);
 extern digest_plugin *inode_digest_plugin(const struct inode *inode);
 extern compression_plugin *inode_compression_plugin(const struct inode *inode);
 extern compression_mode_plugin *inode_compression_mode_plugin(const struct inode
diff -puN fs/reiser4/plugin/crypto/cipher.c~reiser4-crypt2cipher-rename fs/reiser4/plugin/crypto/cipher.c
--- linux-2.6.14-mm2/fs/reiser4/plugin/crypto/cipher.c~reiser4-crypt2cipher-rename	2005-11-15 17:17:52.000000000 +0300
+++ linux-2.6.14-mm2-vs/fs/reiser4/plugin/crypto/cipher.c	2005-11-15 17:17:52.000000000 +0300
@@ -8,10 +8,11 @@
 #include <linux/types.h>
 #include <linux/random.h>
 
-#define MAX_CRYPTO_BLOCKSIZE 128
+#define MIN_CIPHER_BLOCKSIZE 8
+#define MAX_CIPHER_BLOCKSIZE 128
 
 /*
-  Default align() method of the crypto-plugin (look for description of this
+  Default align() method of the cipher plugin (look for description of this
   method in plugin/plugin.h)
 
   1) creates the aligning armored format of the input flow before encryption.
@@ -26,14 +27,14 @@
 */
 static int align_stream_common(__u8 * pad,
 			       int flow_size /* size of non-aligned flow */,
-			       int blocksize /* crypto-block size */)
+			       int blocksize /* cipher block size */)
 {
 	int pad_size;
 
 	assert("edward-01", pad != NULL);
 	assert("edward-02", flow_size != 0);
 	assert("edward-03", blocksize != 0
-	       || blocksize <= MAX_CRYPTO_BLOCKSIZE);
+	       || blocksize <= MAX_CIPHER_BLOCKSIZE);
 
 	pad_size = blocksize - (flow_size % blocksize);
 	get_random_bytes(pad, pad_size);
@@ -66,11 +67,11 @@ static struct crypto_tfm * alloc_aes (vo
 #endif /* REISER4_AES */
 }
 
-crypto_plugin crypto_plugins[LAST_CRYPTO_ID] = {
-	[NONE_CRYPTO_ID] = {
+cipher_plugin cipher_plugins[LAST_CIPHER_ID] = {
+	[NONE_CIPHER_ID] = {
 		.h = {
-			.type_id = REISER4_CRYPTO_PLUGIN_TYPE,
-			.id = NONE_CRYPTO_ID,
+			.type_id = REISER4_CIPHER_PLUGIN_TYPE,
+			.id = NONE_CIPHER_ID,
 			.pops = NULL,
 			.label = "none",
 			.desc = "no cipher transform",
@@ -84,10 +85,10 @@ crypto_plugin crypto_plugins[LAST_CRYPTO
 		.encrypt = NULL,
 		.decrypt = NULL
 	},
-	[AES_CRYPTO_ID] = {
+	[AES_CIPHER_ID] = {
 		.h = {
-			.type_id = REISER4_CRYPTO_PLUGIN_TYPE,
-			.id = AES_CRYPTO_ID,
+			.type_id = REISER4_CIPHER_PLUGIN_TYPE,
+			.id = AES_CIPHER_ID,
 			.pops = NULL,
 			.label = "aes",
 			.desc = "aes cipher transform",
diff -puN fs/reiser4/plugin/file/cryptcompress.c~reiser4-crypt2cipher-rename fs/reiser4/plugin/file/cryptcompress.c
--- linux-2.6.14-mm2/fs/reiser4/plugin/file/cryptcompress.c~reiser4-crypt2cipher-rename	2005-11-15 17:17:52.000000000 +0300
+++ linux-2.6.14-mm2-vs/fs/reiser4/plugin/file/cryptcompress.c	2005-11-15 17:17:52.000000000 +0300
@@ -40,11 +40,6 @@ init_inode_data_cryptcompress(struct ino
 }
 
 #if REISER4_DEBUG
-static int crc_generic_check_ok(void)
-{
-	return MIN_CRYPTO_BLOCKSIZE == DC_CHECKSUM_SIZE << 1;
-}
-
 int crc_inode_ok(struct inode *inode)
 {
 	if (cluster_shift_ok(inode_cluster_shift(inode)))
@@ -107,7 +102,7 @@ static int
 alloc_crypto_tfms(plugin_set * pset, crypto_stat_t * info)
 {
 	struct crypto_tfm * ret = NULL;
-	crypto_plugin * cplug = pset->crypto;
+	cipher_plugin * cplug = pset->cipher;
 	digest_plugin * dplug = pset->digest;
 
 	assert("edward-1363", info != NULL);
@@ -280,7 +275,7 @@ create_crypto_stat(struct inode * object
 		goto err;
 	/* Someone can change plugins of the host, so
 	   we keep the original ones it the crypto-stat. */
-	info_set_crypto_plugin(info, inode_crypto_plugin(object));
+	info_set_cipher_plugin(info, inode_cipher_plugin(object));
 	info_set_digest_plugin(info, inode_digest_plugin(object));
 
 	ret = crypto_cipher_setkey(info_cipher_tfm(info),
@@ -355,7 +350,7 @@ int can_inherit_crypto_crc(struct inode 
 	/* the file being looked up */
 	if (!inode_crypto_stat(parent))
 		return 0;
-	return (inode_crypto_plugin(child) == inode_crypto_plugin(parent) &&
+	return (inode_cipher_plugin(child) == inode_cipher_plugin(parent) &&
 		inode_digest_plugin(child) == inode_digest_plugin(parent) &&
 		inode_crypto_stat(child)->keysize == inode_crypto_stat(parent)->keysize &&
 		keyid_eq(inode_crypto_stat(child), inode_crypto_stat(parent)));
@@ -363,8 +358,8 @@ int can_inherit_crypto_crc(struct inode 
 
 int need_cipher(struct inode * inode)
 {
-	return inode_crypto_plugin(inode) !=
-		crypto_plugin_by_id(NONE_CRYPTO_ID);
+	return inode_cipher_plugin(inode) !=
+		cipher_plugin_by_id(NONE_CIPHER_ID);
 }
 
 /* returns true, if crypto stat can be attached to the @host */
@@ -394,7 +389,7 @@ static int inode_set_crypto(struct inode
 	}
 	info = reiser4_inode_data(object);
 	info->extmask |= (1 << CRYPTO_STAT);
-	info->plugin_mask |= (1 << PSET_CRYPTO) | (1 << PSET_DIGEST);
+	info->plugin_mask |= (1 << PSET_CIPHER) | (1 << PSET_DIGEST);
  	return 0;
 }
 
@@ -449,7 +444,7 @@ static int inode_set_cluster(struct inod
 	return 0;
 }
 
-/* plugin->create() method for crypto-compressed files
+/* plugin->create() method for cryptcompress files
 
 . install plugins
 . attach crypto info if specified
@@ -468,7 +463,6 @@ create_cryptcompress(struct inode *objec
 	assert("edward-30", data != NULL);
 	assert("edward-26", inode_get_flag(object, REISER4_NO_SD));
 	assert("edward-27", data->id == CRC_FILE_PLUGIN_ID);
-	assert("edward-1170", crc_generic_check_ok());
 
 	info = reiser4_inode_data(object);
 
@@ -525,7 +519,7 @@ int open_cryptcompress(struct inode * in
 }
 
 static unsigned int
-crypto_blocksize(struct inode * inode)
+cipher_blocksize(struct inode * inode)
 {
 	assert("edward-758", need_cipher(inode));
 	assert("edward-1400", inode_crypto_stat(inode) != NULL);
@@ -544,8 +538,8 @@ static loff_t inode_scaled_offset (struc
 	    src_off == get_key_offset(max_key()))
 		return src_off;
 
-	return inode_crypto_plugin(inode)->scale(inode,
-						 crypto_blocksize(inode),
+	return inode_cipher_plugin(inode)->scale(inode,
+						 cipher_blocksize(inode),
 						 src_off);
 }
 
@@ -805,7 +799,7 @@ need_cut_or_align(struct inode * inode, 
 	tfm_cluster_t * tc = &clust->tc;
 	switch (rw) {
 	case WRITE_OP: /* estimate align */
-		*oh = tc->len % crypto_blocksize(inode);
+		*oh = tc->len % cipher_blocksize(inode);
 		if (*oh != 0)
 			return 1;
 		break;
@@ -825,7 +819,7 @@ static void
 align_or_cut_overhead(struct inode * inode, reiser4_cluster_t * clust, rw_op rw)
 {
 	int oh;
-	crypto_plugin * cplug = inode_crypto_plugin(inode);
+	cipher_plugin * cplug = inode_cipher_plugin(inode);
 
 	assert("edward-1402", need_cipher(inode));
 
@@ -836,12 +830,12 @@ align_or_cut_overhead(struct inode * ino
 		clust->tc.len +=
 			cplug->align_stream(tfm_input_data(clust) +
 					    clust->tc.len, clust->tc.len,
-					    crypto_blocksize(inode));
+					    cipher_blocksize(inode));
 		*(tfm_input_data(clust) + clust->tc.len - 1) =
-			crypto_blocksize(inode) - oh;
+			cipher_blocksize(inode) - oh;
 		break;
 	case READ_OP: /* do cut */
-		assert("edward-1403", oh <= crypto_blocksize(inode));
+		assert("edward-1403", oh <= cipher_blocksize(inode));
 		clust->tc.len -= oh;
 		break;
 	default:
@@ -853,11 +847,11 @@ align_or_cut_overhead(struct inode * ino
 /* the following two functions are to evaluate results
    of compression transform */
 static unsigned
-max_crypto_overhead(struct inode * inode)
+max_cipher_overhead(struct inode * inode)
 {
-	if (!need_cipher(inode) || !inode_crypto_plugin(inode)->align_stream)
+	if (!need_cipher(inode) || !inode_cipher_plugin(inode)->align_stream)
 		return 0;
-	return crypto_blocksize(inode);
+	return cipher_blocksize(inode);
 }
 
 static int deflate_overhead(struct inode *inode)
@@ -903,7 +897,7 @@ static int
 save_compressed(int size_before, int size_after, struct inode * inode)
 {
 	return (size_after + deflate_overhead(inode) +
-		max_crypto_overhead(inode) < size_before);
+		max_cipher_overhead(inode) < size_before);
 }
 
 /* Guess result of the evaluation above */
@@ -927,8 +921,8 @@ need_inflate(reiser4_cluster_t * clust, 
    in disk clusters:
 
 		   data                   This is (transformed) logical cluster.
-		   crypto_overhead        This is created by ->align() method
-                                          of crypto-plugin. May be absent.
+		   cipher_overhead        This is created by ->align() method
+                                          of cipher plugin. May be absent.
 		   checksum          (4)  This is created by ->checksum method
                                           of compression plugin to check
                                           integrity. May be absent.
@@ -937,7 +931,7 @@ need_inflate(reiser4_cluster_t * clust, 
 
 		   data
 		   control_byte      (1)   contains aligned overhead size:
-		                           1 <= overhead <= crypto_blksize
+		                           1 <= overhead <= cipher_blksize
 */
 /* Append checksum at the end of input transform stream
    and increase its length */
@@ -1067,12 +1061,12 @@ int deflate_cluster(reiser4_cluster_t * 
 		}
 	}
 	if (need_cipher(inode)) {
-		crypto_plugin * ciplug;
+		cipher_plugin * ciplug;
 		struct crypto_tfm * tfm;
 		struct scatterlist src;
 		struct scatterlist dst;
 
-		ciplug = inode_crypto_plugin(inode);
+		ciplug = inode_cipher_plugin(inode);
 		tfm = info_cipher_tfm(inode_crypto_stat(inode));
 		if (compressed)
 			alternate_streams(tc);
@@ -1127,12 +1121,12 @@ int inflate_cluster(reiser4_cluster_t * 
 			return RETERR(-EIO);
 	}
 	if (need_cipher(inode)) {
-		crypto_plugin * ciplug;
+		cipher_plugin * ciplug;
 		struct crypto_tfm * tfm;
 		struct scatterlist src;
 		struct scatterlist dst;
 
-		ciplug = inode_crypto_plugin(inode);
+		ciplug = inode_cipher_plugin(inode);
 		tfm = info_cipher_tfm(inode_crypto_stat(inode));
 		result = grab_tfm_stream(inode, tc, OUTPUT_STREAM);
 		if (result)
@@ -2548,7 +2542,7 @@ set_cluster_by_window(struct inode *inod
 		return result;
 
 	if (file_off > inode->i_size) {
-		/* Uhmm, hole in crypto-file... */
+		/* Uhmm, hole in cryptcompress file... */
 		loff_t hole_size;
 		hole_size = file_off - inode->i_size;
 
@@ -3886,7 +3880,7 @@ load_cryptcompress_plugin(struct inode *
 	return 0;
 }
 
-static int change_crypto_file(struct inode *inode, reiser4_plugin * plugin)
+static int change_cryptcompress(struct inode *inode, reiser4_plugin * plugin)
 {
 	/* cannot change object plugin of already existing object */
 	return RETERR(-EINVAL);
@@ -3897,7 +3891,7 @@ struct reiser4_plugin_ops cryptcompress_
 	.save_len = save_len_cryptcompress_plugin,
 	.save = NULL,
 	.alignment = 8,
-	.change = change_crypto_file
+	.change = change_cryptcompress
 };
 
 /*
diff -puN fs/reiser4/plugin/file/cryptcompress.h~reiser4-crypt2cipher-rename fs/reiser4/plugin/file/cryptcompress.h
--- linux-2.6.14-mm2/fs/reiser4/plugin/file/cryptcompress.h~reiser4-crypt2cipher-rename	2005-11-15 17:17:52.000000000 +0300
+++ linux-2.6.14-mm2-vs/fs/reiser4/plugin/file/cryptcompress.h	2005-11-15 17:17:52.000000000 +0300
@@ -15,7 +15,6 @@
 #define MAX_CLUSTER_SHIFT 16
 #define MAX_CLUSTER_NRPAGES (1U << MAX_CLUSTER_SHIFT >> PAGE_CACHE_SHIFT)
 #define DC_CHECKSUM_SIZE 4
-#define MIN_CRYPTO_BLOCKSIZE 8
 
 #if REISER4_DEBUG
 static inline int cluster_shift_ok(int shift)
@@ -472,10 +471,10 @@ info_digest_tfm (crypto_stat_t * info)
 	return info_get_tfm(info, DIGEST_TFM);
 }
 
-static inline crypto_plugin *
+static inline cipher_plugin *
 info_cipher_plugin (crypto_stat_t * info)
 {
-	return &info_get_tfma(info, CIPHER_TFM)->plug->crypto;
+	return &info_get_tfma(info, CIPHER_TFM)->plug->cipher;
 }
 
 static inline digest_plugin *
@@ -491,9 +490,9 @@ info_set_plugin(crypto_stat_t * info, re
 }
 
 static inline void
-info_set_crypto_plugin(crypto_stat_t * info, crypto_plugin * cplug)
+info_set_cipher_plugin(crypto_stat_t * info, cipher_plugin * cplug)
 {
-	info_set_plugin(info, CIPHER_TFM, crypto_plugin_to_plugin(cplug));
+	info_set_plugin(info, CIPHER_TFM, cipher_plugin_to_plugin(cplug));
 }
 
 static inline void
diff -puN fs/reiser4/plugin/file/file.c~reiser4-crypt2cipher-rename fs/reiser4/plugin/file/file.c
--- linux-2.6.14-mm2/fs/reiser4/plugin/file/file.c~reiser4-crypt2cipher-rename	2005-11-15 17:17:52.000000000 +0300
+++ linux-2.6.14-mm2-vs/fs/reiser4/plugin/file/file.c	2005-11-15 17:17:52.000000000 +0300
@@ -638,7 +638,6 @@ static int shorten_file(struct inode *in
 		return 0;
 	}
 
-	/* FIXME: not sure how crypto files will work here. Probably they will not. */
 	result = find_file_state(unix_file_inode_data(inode));
 	if (result)
 		return result;
diff -puN fs/reiser4/plugin/file_plugin_common.c~reiser4-crypt2cipher-rename fs/reiser4/plugin/file_plugin_common.c
--- linux-2.6.14-mm2/fs/reiser4/plugin/file_plugin_common.c~reiser4-crypt2cipher-rename	2005-11-15 17:17:52.000000000 +0300
+++ linux-2.6.14-mm2-vs/fs/reiser4/plugin/file_plugin_common.c	2005-11-15 17:17:52.000000000 +0300
@@ -155,7 +155,7 @@ int adjust_to_parent_cryptcompress(struc
  	assert("edward-1416", parent != NULL);
 
  	grab_plugin(object, parent, PSET_CLUSTER);
- 	grab_plugin(object, parent, PSET_CRYPTO);
+ 	grab_plugin(object, parent, PSET_CIPHER);
  	grab_plugin(object, parent, PSET_DIGEST);
  	grab_plugin(object, parent, PSET_COMPRESSION);
  	grab_plugin(object, parent, PSET_COMPRESSION_MODE);
diff -puN fs/reiser4/plugin/plugin.c~reiser4-crypt2cipher-rename fs/reiser4/plugin/plugin.c
--- linux-2.6.14-mm2/fs/reiser4/plugin/plugin.c~reiser4-crypt2cipher-rename	2005-11-15 17:17:52.000000000 +0300
+++ linux-2.6.14-mm2-vs/fs/reiser4/plugin/plugin.c	2005-11-15 17:17:52.000000000 +0300
@@ -467,14 +467,14 @@ reiser4_plugin_type_data plugins[REISER4
 		.plugins_list =	{NULL, NULL},
 		.size = sizeof(fibration_plugin)
 	},
-	[REISER4_CRYPTO_PLUGIN_TYPE] = {
-		.type_id = REISER4_CRYPTO_PLUGIN_TYPE,
-		.label = "crypto",
-		.desc = "Crypto plugins",
-		.builtin_num = sizeof_array(crypto_plugins),
-		.builtin = crypto_plugins,
+	[REISER4_CIPHER_PLUGIN_TYPE] = {
+		.type_id = REISER4_CIPHER_PLUGIN_TYPE,
+		.label = "cipher",
+		.desc = "Cipher plugins",
+		.builtin_num = sizeof_array(cipher_plugins),
+		.builtin = cipher_plugins,
 		.plugins_list =	{NULL, NULL},
-		.size = sizeof(crypto_plugin)
+		.size = sizeof(cipher_plugin)
 	},
 	[REISER4_DIGEST_PLUGIN_TYPE] = {
 		.type_id = REISER4_DIGEST_PLUGIN_TYPE,
diff -puN fs/reiser4/plugin/plugin.h~reiser4-crypt2cipher-rename fs/reiser4/plugin/plugin.h
--- linux-2.6.14-mm2/fs/reiser4/plugin/plugin.h~reiser4-crypt2cipher-rename	2005-11-15 17:17:52.000000000 +0300
+++ linux-2.6.14-mm2-vs/fs/reiser4/plugin/plugin.h	2005-11-15 17:17:52.000000000 +0300
@@ -161,7 +161,7 @@ typedef enum {
 	/* for objects completely handled by the VFS: fifos, devices,
 	   sockets  */
 	SPECIAL_FILE_PLUGIN_ID,
-	/* Plugin id for crypto-compression objects */
+	/* regular cryptcompress file */
 	CRC_FILE_PLUGIN_ID,
 	/* number of file plugins. Used as size of arrays to hold
 	   file plugins. */
@@ -446,22 +446,22 @@ typedef struct hash_plugin {
 	 __u64(*hash) (const unsigned char *name, int len);
 } hash_plugin;
 
-typedef struct crypto_plugin {
+typedef struct cipher_plugin {
 	/* generic fields */
 	plugin_header h;
 	struct crypto_tfm * (*alloc) (void);
 	void (*free) (struct crypto_tfm * tfm);
 	/* Offset translator. For each offset this returns (k * offset), where
-	   k (k >= 1) is a coefficient of expansion of the crypto algorithm.
+	   k (k >= 1) is an expansion factor of the cipher algorithm.
 	   For all symmetric algorithms k == 1. For asymmetric algorithms (which
 	   inflate data) offset translation guarantees that all disk cluster's
 	   units will have keys smaller then next cluster's one.
 	 */
 	 loff_t(*scale) (struct inode * inode, size_t blocksize, loff_t src);
-	/* Crypto algorithms can accept data only by chunks of crypto block
-	   size. This method is to align any flow up to crypto block size when
-	   we pass it to crypto algorithm. To align means to append padding of
-	   special format specific to the crypto algorithm */
+	/* Cipher algorithms can accept data only by chunks of cipher block
+	   size. This method is to align any flow up to cipher block size when
+	   we pass it to cipher algorithm. To align means to append padding of
+	   special format specific to the cipher algorithm */
 	int (*align_stream) (__u8 * tail, int clust_size, int blocksize);
 	/* low-level key manager (check, install, etc..) */
 	int (*setkey) (struct crypto_tfm * tfm, const __u8 * key,
@@ -469,7 +469,7 @@ typedef struct crypto_plugin {
 	/* main text processing procedures */
 	void (*encrypt) (__u32 * expkey, __u8 * dst, const __u8 * src);
 	void (*decrypt) (__u32 * expkey, __u8 * dst, const __u8 * src);
-} crypto_plugin;
+} cipher_plugin;
 
 typedef struct digest_plugin {
 	/* generic fields */
@@ -614,11 +614,11 @@ union reiser4_plugin {
 	hash_plugin hash;
 	/* fibration plugin used by directory plugin */
 	fibration_plugin fibration;
-	/* crypto plugin, used by file plugin */
-	crypto_plugin crypto;
-	/* digest plugin, used by file plugin */
+	/* cipher transform plugin, used by file plugin */
+	cipher_plugin cipher;
+	/* digest transform plugin, used by file plugin */
 	digest_plugin digest;
-	/* compression plugin, used by file plugin */
+	/* compression transform plugin, used by file plugin */
 	compression_plugin compression;
 	/* tail plugin, used by file plugin */
 	formatting_plugin formatting;
@@ -636,9 +636,9 @@ union reiser4_plugin {
 	oid_allocator_plugin oid_allocator;
 	/* plugin for different jnode types */
 	jnode_plugin jnode;
-	/* compression_mode_plugin, used by object plugin */
+	/* compression mode plugin, used by object plugin */
 	compression_mode_plugin compression_mode;
-	/* cluster_plugin, used by object plugin */
+	/* cluster plugin, used by object plugin */
 	cluster_plugin clust;
 	/* regular plugin, used by directory plugin */
 	regular_plugin regular;
@@ -695,13 +695,13 @@ typedef enum {
 	LAST_HASH_ID
 } reiser4_hash_id;
 
-/* builtin crypto-plugins */
+/* builtin cipher plugins */
 
 typedef enum {
-	NONE_CRYPTO_ID,
-	AES_CRYPTO_ID,
-	LAST_CRYPTO_ID
-} reiser4_crypto_id;
+	NONE_CIPHER_ID,
+	AES_CIPHER_ID,
+	LAST_CIPHER_ID
+} reiser4_cipher_id;
 
 /* builtin digest plugins */
 
@@ -843,7 +843,7 @@ PLUGIN_BY_ID(sd_ext_plugin, REISER4_SD_E
 PLUGIN_BY_ID(perm_plugin, REISER4_PERM_PLUGIN_TYPE, perm);
 PLUGIN_BY_ID(hash_plugin, REISER4_HASH_PLUGIN_TYPE, hash);
 PLUGIN_BY_ID(fibration_plugin, REISER4_FIBRATION_PLUGIN_TYPE, fibration);
-PLUGIN_BY_ID(crypto_plugin, REISER4_CRYPTO_PLUGIN_TYPE, crypto);
+PLUGIN_BY_ID(cipher_plugin, REISER4_CIPHER_PLUGIN_TYPE, cipher);
 PLUGIN_BY_ID(digest_plugin, REISER4_DIGEST_PLUGIN_TYPE, digest);
 PLUGIN_BY_ID(compression_plugin, REISER4_COMPRESSION_PLUGIN_TYPE, compression);
 PLUGIN_BY_ID(formatting_plugin, REISER4_FORMATTING_PLUGIN_TYPE, formatting);
@@ -875,7 +875,7 @@ typedef enum {
 	PSET_FIBRATION,
 	PSET_SD,
 	PSET_DIR_ITEM,
-	PSET_CRYPTO,
+	PSET_CIPHER,
 	PSET_DIGEST,
 	PSET_COMPRESSION,
 	PSET_COMPRESSION_MODE,
@@ -900,7 +900,7 @@ extern hash_plugin hash_plugins[LAST_HAS
 /* defined in fs/reiser4/plugin/fibration.c */
 extern fibration_plugin fibration_plugins[LAST_FIBRATION_ID];
 /* defined in fs/reiser4/plugin/crypt.c */
-extern crypto_plugin crypto_plugins[LAST_CRYPTO_ID];
+extern cipher_plugin cipher_plugins[LAST_CIPHER_ID];
 /* defined in fs/reiser4/plugin/digest.c */
 extern digest_plugin digest_plugins[LAST_DIGEST_ID];
 /* defined in fs/reiser4/plugin/compress/compress.c */
diff -puN fs/reiser4/plugin/plugin_header.h~reiser4-crypt2cipher-rename fs/reiser4/plugin/plugin_header.h
--- linux-2.6.14-mm2/fs/reiser4/plugin/plugin_header.h~reiser4-crypt2cipher-rename	2005-11-15 17:17:52.000000000 +0300
+++ linux-2.6.14-mm2-vs/fs/reiser4/plugin/plugin_header.h	2005-11-15 17:17:52.000000000 +0300
@@ -22,7 +22,7 @@ typedef enum {
 	REISER4_SD_EXT_PLUGIN_TYPE,
 	REISER4_FORMAT_PLUGIN_TYPE,
 	REISER4_JNODE_PLUGIN_TYPE,
-	REISER4_CRYPTO_PLUGIN_TYPE,
+	REISER4_CIPHER_PLUGIN_TYPE,
 	REISER4_DIGEST_PLUGIN_TYPE,
 	REISER4_COMPRESSION_PLUGIN_TYPE,
 	REISER4_COMPRESSION_MODE_PLUGIN_TYPE,
diff -puN fs/reiser4/plugin/plugin_set.c~reiser4-crypt2cipher-rename fs/reiser4/plugin/plugin_set.c
--- linux-2.6.14-mm2/fs/reiser4/plugin/plugin_set.c~reiser4-crypt2cipher-rename	2005-11-15 17:17:52.000000000 +0300
+++ linux-2.6.14-mm2-vs/fs/reiser4/plugin/plugin_set.c	2005-11-15 17:17:52.000000000 +0300
@@ -61,7 +61,7 @@ static inline int pseq(const unsigned lo
 		sizeof set1->fibration +
 		sizeof set1->sd +
 		sizeof set1->dir_item +
-		sizeof set1->crypto +
+		sizeof set1->cipher +
 		sizeof set1->digest +
 		sizeof set1->compression +
 		sizeof set1->compression_mode +
@@ -79,7 +79,7 @@ static inline int pseq(const unsigned lo
 	    set1->fibration == set2->fibration &&
 	    set1->sd == set2->sd &&
 	    set1->dir_item == set2->dir_item &&
-	    set1->crypto == set2->crypto &&
+	    set1->cipher == set2->cipher &&
 	    set1->digest == set2->digest &&
 	    set1->compression == set2->compression &&
 	    set1->compression_mode == set2->compression_mode &&
@@ -105,7 +105,7 @@ static inline unsigned long calculate_ha
 	HASH_FIELD(result, set, fibration);
 	HASH_FIELD(result, set, sd);
 	HASH_FIELD(result, set, dir_item);
-	HASH_FIELD(result, set, crypto);
+	HASH_FIELD(result, set, cipher);
 	HASH_FIELD(result, set, digest);
 	HASH_FIELD(result, set, compression);
 	HASH_FIELD(result, set, compression_mode);
@@ -139,7 +139,7 @@ static plugin_set empty_set = {
 	.fibration = NULL,
 	.sd = NULL,
 	.dir_item = NULL,
-	.crypto = NULL,
+	.cipher = NULL,
 	.digest = NULL,
 	.compression = NULL,
 	.compression_mode = NULL,
@@ -244,9 +244,9 @@ static struct {
 		.offset = offsetof(plugin_set, dir_item),
 		.type = REISER4_ITEM_PLUGIN_TYPE
 	},
-	[PSET_CRYPTO] = {
-		.offset = offsetof(plugin_set, crypto),
-		.type = REISER4_CRYPTO_PLUGIN_TYPE
+	[PSET_CIPHER] = {
+		.offset = offsetof(plugin_set, cipher),
+		.type = REISER4_CIPHER_PLUGIN_TYPE
 	},
 	[PSET_DIGEST] = {
 		.offset = offsetof(plugin_set, digest),
@@ -320,7 +320,7 @@ DEFINE_PLUGIN_SET(file_plugin, file)
     DEFINE_PLUGIN_SET(hash_plugin, hash)
     DEFINE_PLUGIN_SET(fibration_plugin, fibration)
     DEFINE_PLUGIN_SET(item_plugin, sd)
-    DEFINE_PLUGIN_SET(crypto_plugin, crypto)
+    DEFINE_PLUGIN_SET(cipher_plugin, cipher)
     DEFINE_PLUGIN_SET(digest_plugin, digest)
     DEFINE_PLUGIN_SET(compression_plugin, compression)
     DEFINE_PLUGIN_SET(compression_mode_plugin, compression_mode)
diff -puN fs/reiser4/plugin/plugin_set.h~reiser4-crypt2cipher-rename fs/reiser4/plugin/plugin_set.h
--- linux-2.6.14-mm2/fs/reiser4/plugin/plugin_set.h~reiser4-crypt2cipher-rename	2005-11-15 17:17:52.000000000 +0300
+++ linux-2.6.14-mm2-vs/fs/reiser4/plugin/plugin_set.h	2005-11-15 17:17:52.000000000 +0300
@@ -33,8 +33,8 @@ struct plugin_set {
 	item_plugin *sd;
 	/* plugin of items a directory is built of */
 	item_plugin *dir_item;
-	/* crypto plugin */
-	crypto_plugin *crypto;
+	/* cipher plugin */
+	cipher_plugin *cipher;
 	/* digest plugin */
 	digest_plugin *digest;
 	/* compression plugin */
@@ -57,7 +57,7 @@ extern int plugin_set_formatting(plugin_
 extern int plugin_set_hash(plugin_set ** set, hash_plugin * plug);
 extern int plugin_set_fibration(plugin_set ** set, fibration_plugin * plug);
 extern int plugin_set_sd(plugin_set ** set, item_plugin * plug);
-extern int plugin_set_crypto(plugin_set ** set, crypto_plugin * plug);
+extern int plugin_set_cipher(plugin_set ** set, cipher_plugin * plug);
 extern int plugin_set_digest(plugin_set ** set, digest_plugin * plug);
 extern int plugin_set_compression(plugin_set ** set, compression_plugin * plug);
 extern int plugin_set_compression_mode(plugin_set ** set,

_

--MA0YZ14O4V-=-1GHF21HD44-CUT-HERE-1QBTTO5KTV-=-H0EUOE2RIJ--




--------------090200080000000400000509--
