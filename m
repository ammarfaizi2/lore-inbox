Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262444AbVBYVtI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262444AbVBYVtI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 16:49:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262258AbVBYVrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 16:47:23 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:60681 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262256AbVBYVqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 16:46:21 -0500
Date: Fri, 25 Feb 2005 22:46:13 +0100
From: Adrian Bunk <bunk@stusta.de>
To: jmorris@redhat.com, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] better CRYPTO_AES <-> CRYPTO_AES_586 dependencies
Message-ID: <20050225214613.GF3311@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.11-rc4-mm1 contains an option (IEEE80211_CRYPT_CCMP) that selects 
CRYPTO_AES - but this is currently wrong on i386.

This patch changes CRYPTO_AES to being the only user-visible options and 
selecting either CRYPTO_AES_586 or a new CRYPTO_AES_GENERIC option 
depending on the platform.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

BTW: Does CRYPTO_AES_586 work on an 386 or 486?

 crypto/Kconfig  |   26 +++++++-------------------
 crypto/Makefile |    2 +-
 2 files changed, 8 insertions(+), 20 deletions(-)

--- linux-2.6.11-rc4-mm1-full/crypto/Kconfig.old	2005-02-25 22:26:20.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/crypto/Kconfig	2005-02-25 22:28:44.000000000 +0100
@@ -133,7 +133,9 @@
 
 config CRYPTO_AES
 	tristate "AES cipher algorithms"
-	depends on CRYPTO && !(X86 && !X86_64)
+	depends on CRYPTO
+	select CRYPTO_AES_GENERIC if !(X86 && !X86_64)
+	select CRYPTO_AES_586 if (X86 && !X86_64)
 	help
 	  AES cipher algorithms (FIPS-197). AES uses the Rijndael 
 	  algorithm.
@@ -151,25 +153,11 @@
 
 	  See <http://csrc.nist.gov/CryptoToolkit/aes/> for more information.
 
-config CRYPTO_AES_586
-	tristate "AES cipher algorithms (i586)"
-	depends on CRYPTO && (X86 && !X86_64)
-	help
-	  AES cipher algorithms (FIPS-197). AES uses the Rijndael 
-	  algorithm.
+config CRYPTO_AES_GENERIC
+	tristate
 
-	  Rijndael appears to be consistently a very good performer in
-	  both hardware and software across a wide range of computing 
-	  environments regardless of its use in feedback or non-feedback 
-	  modes. Its key setup time is excellent, and its key agility is 
-	  good. Rijndael's very low memory requirements make it very well 
-	  suited for restricted-space environments, in which it also 
-	  demonstrates excellent performance. Rijndael's operations are 
-	  among the easiest to defend against power and timing attacks.	
-
-	  The AES specifies three key sizes: 128, 192 and 256 bits	  
-
-	  See <http://csrc.nist.gov/encryption/aes/> for more information.
+config CRYPTO_AES_586
+	tristate
 
 config CRYPTO_CAST5
 	tristate "CAST5 (CAST-128) cipher algorithm"
--- linux-2.6.11-rc4-mm1-full/crypto/Makefile.old	2005-02-25 22:29:33.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/crypto/Makefile	2005-02-25 22:29:42.000000000 +0100
@@ -19,7 +19,7 @@
 obj-$(CONFIG_CRYPTO_BLOWFISH) += blowfish.o
 obj-$(CONFIG_CRYPTO_TWOFISH) += twofish.o
 obj-$(CONFIG_CRYPTO_SERPENT) += serpent.o
-obj-$(CONFIG_CRYPTO_AES) += aes.o
+obj-$(CONFIG_CRYPTO_AES_GENERIC) += aes.o
 obj-$(CONFIG_CRYPTO_CAST5) += cast5.o
 obj-$(CONFIG_CRYPTO_CAST6) += cast6.o
 obj-$(CONFIG_CRYPTO_ARC4) += arc4.o


