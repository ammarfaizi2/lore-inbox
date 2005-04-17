Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261424AbVDQTYV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261424AbVDQTYV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 15:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261423AbVDQTXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 15:23:24 -0400
Received: from hermes.domdv.de ([193.102.202.1]:37905 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S261424AbVDQTUW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 15:20:22 -0400
Message-ID: <4262B6F5.4060907@domdv.de>
Date: Sun, 17 Apr 2005 21:20:21 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       jmorris@redhat.com, davem@davemloft.net, ak@suse.de
Subject: [RFC][PATCH 4/4] AES assembler implementation for x86_64
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------070509020606040006080808"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070509020606040006080808
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

The attached patch contains the required changes for the crypto Kconfig
to enable the usage of the x86_64 AES assembler implementation.
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de

--------------070509020606040006080808
Content-Type: text/plain;
 name="aes-crypto.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="aes-crypto.diff"

diff -rNu linux-2.6.11.2.orig/crypto/Kconfig linux-2.6.11.2/crypto/Kconfig
--- linux-2.6.11.2.orig/crypto/Kconfig	2005-03-09 09:12:53.000000000 +0100
+++ linux-2.6.11.2/crypto/Kconfig	2005-04-17 13:10:51.000000000 +0200
@@ -133,7 +133,7 @@
 
 config CRYPTO_AES
 	tristate "AES cipher algorithms"
-	depends on CRYPTO && !(X86 && !X86_64)
+	depends on CRYPTO && !X86 && !X86_64
 	help
 	  AES cipher algorithms (FIPS-197). AES uses the Rijndael 
 	  algorithm.
@@ -153,7 +153,27 @@
 
 config CRYPTO_AES_586
 	tristate "AES cipher algorithms (i586)"
-	depends on CRYPTO && (X86 && !X86_64)
+	depends on CRYPTO && X86 && !X86_64
+	help
+	  AES cipher algorithms (FIPS-197). AES uses the Rijndael 
+	  algorithm.
+
+	  Rijndael appears to be consistently a very good performer in
+	  both hardware and software across a wide range of computing 
+	  environments regardless of its use in feedback or non-feedback 
+	  modes. Its key setup time is excellent, and its key agility is 
+	  good. Rijndael's very low memory requirements make it very well 
+	  suited for restricted-space environments, in which it also 
+	  demonstrates excellent performance. Rijndael's operations are 
+	  among the easiest to defend against power and timing attacks.	
+
+	  The AES specifies three key sizes: 128, 192 and 256 bits	  
+
+	  See <http://csrc.nist.gov/encryption/aes/> for more information.
+
+config CRYPTO_AES_X86_64
+	tristate "AES cipher algorithms (x86_64)"
+	depends on CRYPTO && X86 && X86_64
 	help
 	  AES cipher algorithms (FIPS-197). AES uses the Rijndael 
 	  algorithm.

--------------070509020606040006080808--
