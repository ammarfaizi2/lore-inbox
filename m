Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268185AbUJCWxh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268185AbUJCWxh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 18:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268207AbUJCWxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 18:53:36 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:57525
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S268185AbUJCWxd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 18:53:33 -0400
Date: Sun, 3 Oct 2004 15:51:18 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Krzysztof Taraszka <dzimi@pld-linux.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s/whirlpool_tv_template/wp512_tv_template/g
Message-Id: <20041003155118.273a3add.davem@davemloft.net>
In-Reply-To: <200410031524.06208.dzimi@pld-linux.org>
References: <200410031310.13666.dzimi@pld-linux.org>
	<200410031524.06208.dzimi@pld-linux.org>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Oct 2004 15:24:06 +0200
Krzysztof Taraszka <dzimi@pld-linux.org> wrote:

> Dnia niedziela, 3 pa¼dziernika 2004 13:10, Krzysztof Taraszka napisa³:
> > patch for 2.4.28-pre3-bk6, fix compilation error
> 
> uuuuups, my fault, there still exist compilation error, here is right patch.

A better fix is on the way to Marcelo, as follows:

ChangeSet@1.1577, 2004-10-03 14:46:02-07:00, ajgrothe@yahoo.com
  [CRYPTO]: Add missing tcrypt part of whirlpool updates.
  
  Signed-off-by: Aaron Grothe <ajgrothe@yahoo.com>
  Signed-off-by: David S. Miller <davem@davemloft.net>

diff -Nru a/crypto/tcrypt.c b/crypto/tcrypt.c
--- a/crypto/tcrypt.c	2004-10-03 22:17:12 -07:00
+++ b/crypto/tcrypt.c	2004-10-03 22:17:12 -07:00
@@ -63,7 +63,8 @@
 static char *check[] = {
 	"des", "md5", "des3_ede", "rot13", "sha1", "sha256", "blowfish",
 	"twofish", "serpent", "sha384", "sha512", "md4", "aes", "cast6", 
-	"arc4", "michael_mic", "deflate", "tea", "xtea", "whirlpool", NULL
+	"arc4", "michael_mic", "deflate", "tea", "xtea", "wp512", 
+	"wp384", "wp256", NULL
 };
 
 static void
@@ -581,7 +582,9 @@
 
 		test_hash("sha384", sha384_tv_template, SHA384_TEST_VECTORS);
 		test_hash("sha512", sha512_tv_template, SHA512_TEST_VECTORS);
-		test_hash("whirlpool", whirlpool_tv_template, WHIRLPOOL_TEST_VECTORS);
+		test_hash("wp512", wp512_tv_template, WP512_TEST_VECTORS);
+		test_hash("wp384", wp384_tv_template, WP384_TEST_VECTORS);
+		test_hash("wp256", wp256_tv_template, WP256_TEST_VECTORS);
 		test_deflate();		
 #ifdef CONFIG_CRYPTO_HMAC
 		test_hmac("md5", hmac_md5_tv_template, HMAC_MD5_TEST_VECTORS);
@@ -686,9 +689,16 @@
 	case 21:
 		test_cipher ("khazad", MODE_ECB, ENCRYPT, khazad_enc_tv_template, KHAZAD_ENC_TEST_VECTORS);
 		test_cipher ("khazad", MODE_ECB, DECRYPT, khazad_dec_tv_template, KHAZAD_DEC_TEST_VECTORS);
-		break;
 	case 22:
-		test_hash("whirlpool", whirlpool_tv_template, WHIRLPOOL_TEST_VECTORS);
+		test_hash("wp512", wp512_tv_template, WP512_TEST_VECTORS);
+		break;
+
+	case 23:
+		test_hash("wp384", wp384_tv_template, WP384_TEST_VECTORS);
+		break;
+
+	case 24:
+		test_hash("wp256", wp256_tv_template, WP256_TEST_VECTORS);
 		break;
 
 #ifdef CONFIG_CRYPTO_HMAC


