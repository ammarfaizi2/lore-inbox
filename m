Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261299AbTIOTGg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 15:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261306AbTIOTGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 15:06:36 -0400
Received: from law11-f84.law11.hotmail.com ([64.4.17.84]:9484 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S261380AbTIOTGQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 15:06:16 -0400
X-Originating-IP: [220.224.1.170]
X-Originating-Email: [kartik_me@hotmail.com]
From: "kartikey bhatt" <kartik_me@hotmail.com>
To: erlend-a@ux.his.no
Cc: jmorris@intercode.com.au, linux-kernel@vger.kernel.org, mpm@selenic.com
Subject: Re: [CRYPTO] Testing Module Cleanup.
Date: Tue, 16 Sep 2003 00:36:15 +0530
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Law11-F84eSOzNCWbzw00015673@hotmail.com>
X-OriginalArrivalTime: 15 Sep 2003 19:06:15.0795 (UTC) FILETIME=[6FE67C30:01C37BBC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

anyway you have modified it.
thanks for improving code.

             -Kartikey Mahendra Bhatt


>From: Erlend Aasland <erlend-a@ux.his.no>
>To: kartikey bhatt <kartik_me@hotmail.com>
>CC: jmorris@intercode.com.au, linux-kernel@vger.kernel.org
>Subject: Re: [CRYPTO] Testing Module Cleanup.
>Date: Mon, 15 Sep 2003 15:43:34 +0200
>
>On 09/15/03 00:30, kartikey bhatt wrote:
> > I have cleaned up the testing module.
> > A complete rewrite.
> > Any suggestions are welcome.
>
>What about removing some magic numbers to make it a little more
>readable?
>
>
>Regards
>	Erlend Aasland
>
>--- linux-2.6.0-test5-dirty/crypto/tcrypt.c	2003-09-15 21:36:30.000000000 
>+0200
>+++ linux-2.6.0-test5-dirty/crypto/tcrypt.c~	2003-09-15 21:35:21.000000000 
>+0200
>@@ -43,6 +43,14 @@
>  #define IDX7		27333
>  #define IDX8		3000
>
>+/*
>+ * Used by test_cipher()
>+ */
>+#define ENCRYPT 1
>+#define DECRYPT 0
>+#define MODE_ECB 1
>+#define MODE_CBC 0
>+
>  static unsigned int IDX[8] = { IDX1, IDX2, IDX3, IDX4, IDX5, IDX6, IDX7, 
>IDX8 };
>
>  static int mode;
>@@ -251,10 +259,16 @@
>  	char *key;
>  	struct cipher_testvec *cipher_tv;
>  	struct scatterlist sg[8];
>-	char *e, *m;
>+	char e[11], m[4];
>
>-	e = enc ? "encryption" : "decryption";
>-	m = mode ? "ECB" : "CBC";
>+	if (enc == ENCRYPT)
>+		strncpy(e, "encryption", 11);
>+	else
>+		strncpy(e, "decryption", 11);
>+	if (mode == MODE_ECB)
>+		strncpy(m, "ECB", 4);
>+	else
>+		strncpy(m, "CBC", 4);
>
>  	printk("\ntesting %s %s %s \n", algo, m, e);
>
>@@ -497,46 +511,46 @@
>  		test_hash("sha1", sha1_tv_template, SHA1_TEST_VECTORS);
>
>  		//DES
>-		test_cipher ("des", 1, 1, des_enc_tv_template, DES_ENC_TEST_VECTORS);
>-		test_cipher ("des", 1, 0, des_dec_tv_template, DES_DEC_TEST_VECTORS);
>-		test_cipher ("des", 0, 1, des_cbc_enc_tv_template, 
>DES_CBC_ENC_TEST_VECTORS);
>-		test_cipher ("des", 0, 0, des_cbc_dec_tv_template, 
>DES_CBC_DEC_TEST_VECTORS);
>+		test_cipher ("des", MODE_ECB, ENCRYPT, des_enc_tv_template, 
>DES_ENC_TEST_VECTORS);
>+		test_cipher ("des", MODE_ECB, DECRYPT, des_dec_tv_template, 
>DES_DEC_TEST_VECTORS);
>+		test_cipher ("des", MODE_CBC, ENCRYPT, des_cbc_enc_tv_template, 
>DES_CBC_ENC_TEST_VECTORS);
>+		test_cipher ("des", MODE_CBC, DECRYPT, des_cbc_dec_tv_template, 
>DES_CBC_DEC_TEST_VECTORS);
>
>  		//DES3_EDE
>-		test_cipher ("des3_ede", 1, 1, des3_ede_enc_tv_template, 
>DES3_EDE_ENC_TEST_VECTORS);
>-		test_cipher ("des3_ede", 1, 0, des3_ede_dec_tv_template, 
>DES3_EDE_DEC_TEST_VECTORS);
>+		test_cipher ("des3_ede", MODE_ECB, ENCRYPT, des3_ede_enc_tv_template, 
>DES3_EDE_ENC_TEST_VECTORS);
>+		test_cipher ("des3_ede", MODE_ECB, DECRYPT, des3_ede_dec_tv_template, 
>DES3_EDE_DEC_TEST_VECTORS);
>
>  		test_hash("md4", md4_tv_template, MD4_TEST_VECTORS);
>
>  		test_hash("sha256", sha256_tv_template, SHA256_TEST_VECTORS);
>
>  		//BLOWFISH
>-		test_cipher ("blowfish", 1, 1, bf_enc_tv_template, BF_ENC_TEST_VECTORS);
>-		test_cipher ("blowfish", 1, 0, bf_dec_tv_template, BF_DEC_TEST_VECTORS);
>-		test_cipher ("blowfish", 0, 1, bf_cbc_enc_tv_template, 
>BF_CBC_ENC_TEST_VECTORS);
>-		test_cipher ("blowfish", 0, 0, bf_cbc_dec_tv_template, 
>BF_CBC_DEC_TEST_VECTORS);
>+		test_cipher ("blowfish", MODE_ECB, ENCRYPT, bf_enc_tv_template, 
>BF_ENC_TEST_VECTORS);
>+		test_cipher ("blowfish", MODE_ECB, DECRYPT, bf_dec_tv_template, 
>BF_DEC_TEST_VECTORS);
>+		test_cipher ("blowfish", MODE_CBC, ENCRYPT, bf_cbc_enc_tv_template, 
>BF_CBC_ENC_TEST_VECTORS);
>+		test_cipher ("blowfish", MODE_CBC, DECRYPT, bf_cbc_dec_tv_template, 
>BF_CBC_DEC_TEST_VECTORS);
>
>  		//TWOFISH
>-		test_cipher ("twofish", 1, 1, tf_enc_tv_template, TF_ENC_TEST_VECTORS);
>-		test_cipher ("twofish", 1, 0, tf_dec_tv_template, TF_DEC_TEST_VECTORS);
>-		test_cipher ("twofish", 0, 1, tf_cbc_enc_tv_template, 
>TF_CBC_ENC_TEST_VECTORS);
>-		test_cipher ("twofish", 0, 0, tf_cbc_dec_tv_template, 
>TF_CBC_DEC_TEST_VECTORS);
>+		test_cipher ("twofish", MODE_ECB, ENCRYPT, tf_enc_tv_template, 
>TF_ENC_TEST_VECTORS);
>+		test_cipher ("twofish", MODE_ECB, DECRYPT, tf_dec_tv_template, 
>TF_DEC_TEST_VECTORS);
>+		test_cipher ("twofish", MODE_CBC, ENCRYPT, tf_cbc_enc_tv_template, 
>TF_CBC_ENC_TEST_VECTORS);
>+		test_cipher ("twofish", MODE_CBC, DECRYPT, tf_cbc_dec_tv_template, 
>TF_CBC_DEC_TEST_VECTORS);
>
>  		//SERPENT
>-		test_cipher ("serpent", 1, 1, serpent_enc_tv_template, 
>SERPENT_ENC_TEST_VECTORS);
>-		test_cipher ("serpent", 1, 0, serpent_dec_tv_template, 
>SERPENT_DEC_TEST_VECTORS);
>+		test_cipher ("serpent", MODE_ECB, ENCRYPT, serpent_enc_tv_template, 
>SERPENT_ENC_TEST_VECTORS);
>+		test_cipher ("serpent", MODE_ECB, DECRYPT, serpent_dec_tv_template, 
>SERPENT_DEC_TEST_VECTORS);
>
>  		//AES
>-		test_cipher ("aes", 1, 1, aes_enc_tv_template, AES_ENC_TEST_VECTORS);
>-		test_cipher ("aes", 1, 0, aes_dec_tv_template, AES_DEC_TEST_VECTORS);
>+		test_cipher ("aes", MODE_ECB, ENCRYPT, aes_enc_tv_template, 
>AES_ENC_TEST_VECTORS);
>+		test_cipher ("aes", MODE_ECB, DECRYPT, aes_dec_tv_template, 
>AES_DEC_TEST_VECTORS);
>
>  		//CAST5
>-		test_cipher ("cast5", 1, 1, cast5_enc_tv_template, 
>CAST5_ENC_TEST_VECTORS);
>-		test_cipher ("cast5", 1, 0, cast5_dec_tv_template, 
>CAST5_DEC_TEST_VECTORS);
>+		test_cipher ("cast5", MODE_ECB, ENCRYPT, cast5_enc_tv_template, 
>CAST5_ENC_TEST_VECTORS);
>+		test_cipher ("cast5", MODE_ECB, DECRYPT, cast5_dec_tv_template, 
>CAST5_DEC_TEST_VECTORS);
>
>  		//CAST6
>-		test_cipher ("cast6", 1, 1, cast6_enc_tv_template, 
>CAST6_ENC_TEST_VECTORS);
>-		test_cipher ("cast6", 1, 0, cast6_dec_tv_template, 
>CAST6_DEC_TEST_VECTORS);
>+		test_cipher ("cast6", MODE_ECB, ENCRYPT, cast6_enc_tv_template, 
>CAST6_ENC_TEST_VECTORS);
>+		test_cipher ("cast6", MODE_ECB, DECRYPT, cast6_dec_tv_template, 
>CAST6_DEC_TEST_VECTORS);
>
>  		test_hash("sha384", sha384_tv_template, SHA384_TEST_VECTORS);
>  		test_hash("sha512", sha512_tv_template, SHA512_TEST_VECTORS);
>@@ -557,15 +571,15 @@
>  		break;
>
>  	case 3:
>-		test_cipher ("des", 1, 1, des_enc_tv_template, DES_ENC_TEST_VECTORS);
>-		test_cipher ("des", 1, 0, des_dec_tv_template, DES_DEC_TEST_VECTORS);
>-		test_cipher ("des", 0, 1, des_cbc_enc_tv_template, 
>DES_CBC_ENC_TEST_VECTORS);
>-		test_cipher ("des", 0, 0, des_cbc_dec_tv_template, 
>DES_CBC_DEC_TEST_VECTORS);
>+		test_cipher ("des", MODE_ECB, ENCRYPT, des_enc_tv_template, 
>DES_ENC_TEST_VECTORS);
>+		test_cipher ("des", MODE_ECB, DECRYPT, des_dec_tv_template, 
>DES_DEC_TEST_VECTORS);
>+		test_cipher ("des", MODE_CBC, ENCRYPT, des_cbc_enc_tv_template, 
>DES_CBC_ENC_TEST_VECTORS);
>+		test_cipher ("des", MODE_CBC, DECRYPT, des_cbc_dec_tv_template, 
>DES_CBC_DEC_TEST_VECTORS);
>  		break;
>
>  	case 4:
>-		test_cipher ("des3_ede", 1, 1, des3_ede_enc_tv_template, 
>DES3_EDE_ENC_TEST_VECTORS);
>-		test_cipher ("des3_ede", 1, 0, des3_ede_dec_tv_template, 
>DES3_EDE_DEC_TEST_VECTORS);
>+		test_cipher ("des3_ede", MODE_ECB, ENCRYPT, des3_ede_enc_tv_template, 
>DES3_EDE_ENC_TEST_VECTORS);
>+		test_cipher ("des3_ede", MODE_ECB, DECRYPT, des3_ede_dec_tv_template, 
>DES3_EDE_DEC_TEST_VECTORS);
>  		break;
>
>  	case 5:
>@@ -577,28 +591,28 @@
>  		break;
>
>  	case 7:
>-		test_cipher ("blowfish", 1, 1, bf_enc_tv_template, BF_ENC_TEST_VECTORS);
>-		test_cipher ("blowfish", 1, 0, bf_dec_tv_template, BF_DEC_TEST_VECTORS);
>-		test_cipher ("blowfish", 0, 1, bf_cbc_enc_tv_template, 
>BF_CBC_ENC_TEST_VECTORS);
>-		test_cipher ("blowfish", 0, 0, bf_cbc_dec_tv_template, 
>BF_CBC_DEC_TEST_VECTORS);
>+		test_cipher ("blowfish", MODE_ECB, ENCRYPT, bf_enc_tv_template, 
>BF_ENC_TEST_VECTORS);
>+		test_cipher ("blowfish", MODE_ECB, DECRYPT, bf_dec_tv_template, 
>BF_DEC_TEST_VECTORS);
>+		test_cipher ("blowfish", MODE_CBC, ENCRYPT, bf_cbc_enc_tv_template, 
>BF_CBC_ENC_TEST_VECTORS);
>+		test_cipher ("blowfish", MODE_CBC, DECRYPT, bf_cbc_dec_tv_template, 
>BF_CBC_DEC_TEST_VECTORS);
>  		break;
>
>  	case 8:
>-		test_cipher ("twofish", 1, 1, tf_enc_tv_template, TF_ENC_TEST_VECTORS);
>-		test_cipher ("twofish", 1, 0, tf_dec_tv_template, TF_DEC_TEST_VECTORS);
>-		test_cipher ("twofish", 0, 1, tf_cbc_enc_tv_template, 
>TF_CBC_ENC_TEST_VECTORS);
>-		test_cipher ("twofish", 0, 0, tf_cbc_dec_tv_template, 
>TF_CBC_DEC_TEST_VECTORS);
>+		test_cipher ("twofish", MODE_ECB, ENCRYPT, tf_enc_tv_template, 
>TF_ENC_TEST_VECTORS);
>+		test_cipher ("twofish", MODE_ECB, DECRYPT, tf_dec_tv_template, 
>TF_DEC_TEST_VECTORS);
>+		test_cipher ("twofish", MODE_CBC, ENCRYPT, tf_cbc_enc_tv_template, 
>TF_CBC_ENC_TEST_VECTORS);
>+		test_cipher ("twofish", MODE_CBC, DECRYPT, tf_cbc_dec_tv_template, 
>TF_CBC_DEC_TEST_VECTORS);
>  		break;
>
>  	case 9:
>-		test_cipher ("serpent", 1, 1, serpent_enc_tv_template, 
>SERPENT_ENC_TEST_VECTORS);
>-		test_cipher ("serpent", 1, 0, serpent_dec_tv_template, 
>SERPENT_DEC_TEST_VECTORS);
>+		test_cipher ("serpent", MODE_ECB, ENCRYPT, serpent_enc_tv_template, 
>SERPENT_ENC_TEST_VECTORS);
>+		test_cipher ("serpent", MODE_ECB, DECRYPT, serpent_dec_tv_template, 
>SERPENT_DEC_TEST_VECTORS);
>
>  		break;
>
>  	case 10:
>-		test_cipher ("aes", 1, 1, aes_enc_tv_template, AES_ENC_TEST_VECTORS);
>-		test_cipher ("aes", 1, 0, aes_dec_tv_template, AES_DEC_TEST_VECTORS);
>+		test_cipher ("aes", MODE_ECB, ENCRYPT, aes_enc_tv_template, 
>AES_ENC_TEST_VECTORS);
>+		test_cipher ("aes", MODE_ECB, DECRYPT, aes_dec_tv_template, 
>AES_DEC_TEST_VECTORS);
>  		break;
>
>  	case 11:
>@@ -614,13 +628,13 @@
>  		break;
>
>  	case 14:
>-		test_cipher ("cast5", 1, 1, cast5_enc_tv_template, 
>CAST5_ENC_TEST_VECTORS);
>-		test_cipher ("cast5", 1, 0, cast5_dec_tv_template, 
>CAST5_DEC_TEST_VECTORS);
>+		test_cipher ("cast5", MODE_ECB, ENCRYPT, cast5_enc_tv_template, 
>CAST5_ENC_TEST_VECTORS);
>+		test_cipher ("cast5", MODE_ECB, DECRYPT, cast5_dec_tv_template, 
>CAST5_DEC_TEST_VECTORS);
>  		break;
>
>  	case 15:
>-		test_cipher ("cast6", 1, 1, cast6_enc_tv_template, 
>CAST6_ENC_TEST_VECTORS);
>-		test_cipher ("cast6", 1, 0, cast6_dec_tv_template, 
>CAST6_DEC_TEST_VECTORS);
>+		test_cipher ("cast6", MODE_ECB, ENCRYPT, cast6_enc_tv_template, 
>CAST6_ENC_TEST_VECTORS);
>+		test_cipher ("cast6", MODE_ECB, DECRYPT, cast6_dec_tv_template, 
>CAST6_DEC_TEST_VECTORS);
>  		break;
>
>  #ifdef CONFIG_CRYPTO_HMAC

_________________________________________________________________
Get personal loans. It's hassle-free. 
http://server1.msn.co.in/msnleads/citibankpersonalloan/citibankploanjuly03.asp?type=txt 
It's approved instantly.

