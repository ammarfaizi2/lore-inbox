Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262171AbTFFS3x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 14:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262174AbTFFS3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 14:29:53 -0400
Received: from air-2.osdl.org ([65.172.181.6]:24750 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262171AbTFFS3p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 14:29:45 -0400
Subject: [2.5.70] make allmodconfig --> infinite loop
From: Andy Pfiffer <andyp@osdl.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1054924969.25858.28.camel@andyp.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 06 Jun 2003 11:42:50 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like this changeset (via tinyurl.com):

http://tinyurl.com/dnpr

causes "make allmodconfig" to go into a silent infinite loop.  The
changeset immediately before it (on the same bk path -- 1.1259.10.12)
does not demonstrate the problem.

Has anyone else seen this?

Thanks,
Andy

-== this appears to be the patch that causes the infinite loop ==-

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or
higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1259.10.12 -> 1.1259.10.13
#	    net/ipv6/Kconfig	1.4     -> 1.5    
#	    net/ipv4/Kconfig	1.7     -> 1.8    
#	      crypto/Kconfig	1.15    -> 1.16   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/06/03	greg@kroah.com	1.1254.4.8
# [PATCH] PCI: Remove a lot of PCI core only functions from
include/linux/pci.h
# --------------------------------------------
# 03/06/03	jmorris@intercode.com.au	1.1259.10.13
# [CRYPTO]: Use "select" kconfig facility instead of fragile defaults.
# --------------------------------------------
#
diff -Nru a/crypto/Kconfig b/crypto/Kconfig
--- a/crypto/Kconfig	Fri Jun  6 11:41:07 2003
+++ b/crypto/Kconfig	Fri Jun  6 11:41:07 2003
@@ -6,16 +6,12 @@
 
 config CRYPTO
 	bool "Cryptographic API"
-	default y if INET_AH=y || INET_AH=m || INET_ESP=y || INET_ESP=m ||
INET6_AH=y || INET6_AH=m || \
-		     INET6_ESP=y || INET6_ESP=m || INET6_IPCOMP=y || INET6_IPCOMP=m
|| IPV6_PRIVACY=y
 	help
 	  This option provides the core Cryptographic API.
 
 config CRYPTO_HMAC
 	bool "HMAC support"
 	depends on CRYPTO
-	default y if INET_AH=y || INET_AH=m || INET_ESP=y || INET_ESP=m ||
INET6_AH=y || INET6_AH=m || \
-		     INET6_ESP=y || INET6_ESP=m
 	help
 	  HMAC: Keyed-Hashing for Message Authentication (RFC2104).
 	  This is required for IPSec.
@@ -35,16 +31,12 @@
 config CRYPTO_MD5
 	tristate "MD5 digest algorithm"
 	depends on CRYPTO
-	default y if INET_AH=y || INET_AH=m || INET_ESP=y || INET_ESP=m ||
INET6_AH=y || INET6_AH=m || \
-	             INET6_ESP=y || INET6_ESP=m || IPV6_PRIVACY=y
 	help
 	  MD5 message digest algorithm (RFC1321).
 
 config CRYPTO_SHA1
 	tristate "SHA1 digest algorithm"
 	depends on CRYPTO
-	default y if INET_AH=y || INET_AH=m || INET_ESP=y || INET_ESP=m  ||
INET6_AH=y || INET6_AH=m || \
-	             INET6_ESP=y || INET6_ESP=m
 	help
 	  SHA-1 secure hash standard (FIPS 180-1/DFIPS 180-2).
 
@@ -72,7 +64,6 @@
 config CRYPTO_DES
 	tristate "DES and Triple DES EDE cipher algorithms"
 	depends on CRYPTO
-	default y if INET_ESP=y || INET_ESP=m || INET6_ESP=y || INET6_ESP=m
 	help
 	  DES cipher algorithm (FIPS 46-2), and Triple DES EDE (FIPS 46-3).
 
@@ -138,7 +129,6 @@
 config CRYPTO_DEFLATE
 	tristate "Deflate compression algorithm"
 	depends on CRYPTO
-	default y if INET_IPCOMP=y || INET_IPCOMP=m || INET6_IPCOMP=y ||
INET6_IPCOMP=m
 	help
 	  This is the Deflate algorithm (RFC1951), specified for use in
 	  IPSec with the IPCOMP protocol (RFC3173, RFC2394).
diff -Nru a/net/ipv4/Kconfig b/net/ipv4/Kconfig
--- a/net/ipv4/Kconfig	Fri Jun  6 11:41:07 2003
+++ b/net/ipv4/Kconfig	Fri Jun  6 11:41:07 2003
@@ -343,6 +343,10 @@
 
 config INET_AH
 	tristate "IP: AH transformation"
+	select CRYPTO
+	select CRYPTO_HMAC
+	select CRYPTO_MD5
+	select CRYPTO_SHA1
 	---help---
 	  Support for IPsec AH.
 
@@ -350,6 +354,11 @@
 
 config INET_ESP
 	tristate "IP: ESP transformation"
+	select CRYPTO
+	select CRYPTO_HMAC
+	select CRYPTO_MD5
+	select CRYPTO_SHA1
+	select CRYPTO_DES
 	---help---
 	  Support for IPsec ESP.
 
@@ -357,6 +366,8 @@
 
 config INET_IPCOMP
 	tristate "IP: IPComp transformation"
+	select CRYPTO
+	select CRYPTO_DEFLATE
 	---help---
 	  Support for IP Paylod Compression (RFC3173), typically needed
 	  for IPsec.
diff -Nru a/net/ipv6/Kconfig b/net/ipv6/Kconfig
--- a/net/ipv6/Kconfig	Fri Jun  6 11:41:07 2003
+++ b/net/ipv6/Kconfig	Fri Jun  6 11:41:07 2003
@@ -4,6 +4,8 @@
 config IPV6_PRIVACY
 	bool "IPv6: Privacy Extensions (RFC 3041) support"
 	depends on IPV6
+	select CRYPTO
+	select CRYPTO_MD5
 	---help---
 	  Privacy Extensions for Stateless Address Autoconfiguration in IPv6
 	  support.  With this option, additional periodically-alter 
@@ -20,6 +22,10 @@
 config INET6_AH
 	tristate "IPv6: AH transformation"
 	depends on IPV6
+	select CRYPTO
+	select CRYPTO_HMAC
+	select CRYPTO_MD5
+	select CRYPTO_SHA1
 	---help---
 	  Support for IPsec AH.
 
@@ -28,6 +34,11 @@
 config INET6_ESP
 	tristate "IPv6: ESP transformation"
 	depends on IPV6
+	select CRYPTO
+	select CRYPTO_HMAC
+	select CRYPTO_MD5
+	select CRYPTO_SHA1
+	select CRYPTO_DES
 	---help---
 	  Support for IPsec ESP.
 
@@ -36,6 +47,8 @@
 config INET6_IPCOMP
 	tristate "IPv6: IPComp transformation"
 	depends on IPV6
+	select CRYPTO
+	select CRYPTO_DEFLATE
 	---help---
 	  Support for IP Paylod Compression (RFC3173), typically needed
 	  for IPsec.




