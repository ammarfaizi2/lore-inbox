Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261950AbTERDx2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 23:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261953AbTERDx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 23:53:28 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:12548 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S261950AbTERDx0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 23:53:26 -0400
Date: Sun, 18 May 2003 14:04:11 +1000
To: James Morris <jmorris@intercode.com.au>
Cc: davem@redhat.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Added missing dependencies on CRYPTO_HMAC
Message-ID: <20030518040411.GA7062@gondor.apana.org.au>
References: <20030518031546.GA4943@gondor.apana.org.au> <Mutt.LNX.4.44.0305181334280.21675-100000@excalibur.intercode.com.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
In-Reply-To: <Mutt.LNX.4.44.0305181334280.21675-100000@excalibur.intercode.com.au>
User-Agent: Mutt/1.5.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, May 18, 2003 at 01:40:28PM +1000, James Morris wrote:
> 
> How would users know what the minimally required set of algorithms are?  
> Would they then know to go _back_ to the networking menu to enable the
> protocols?

Good point.  What about this patch then?
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

Index: net/ipv4/Kconfig
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/net/ipv4/Kconfig,v
retrieving revision 1.1.1.4
retrieving revision 1.3
diff -u -r1.1.1.4 -r1.3
--- net/ipv4/Kconfig	4 May 2003 23:53:36 -0000	1.1.1.4
+++ net/ipv4/Kconfig	18 May 2003 04:02:20 -0000	1.3
@@ -348,8 +348,12 @@
 
 	  If unsure, say N.
 
+comment "Cryptographic HMAC support is needed for IPv4 AH or ESP support"
+	depends on INET && CRYPTO_HMAC=n
+
 config INET_AH
 	tristate "IP: AH transformation"
+	depends on INET && CRYPTO_HMAC
 	---help---
 	  Support for IPsec AH.
 
@@ -357,6 +361,7 @@
 
 config INET_ESP
 	tristate "IP: ESP transformation"
+	depends on INET && CRYPTO_HMAC
 	---help---
 	  Support for IPsec ESP.
 
@@ -364,6 +369,7 @@
 
 config INET_IPCOMP
 	tristate "IP: IPComp transformation"
+	depends on INET
 	---help---
 	  Support for IP Paylod Compression (RFC3173), typically needed
 	  for IPsec.
Index: net/ipv6/Kconfig
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/net/ipv6/Kconfig,v
retrieving revision 1.1.1.3
retrieving revision 1.3
diff -u -r1.1.1.3 -r1.3
--- net/ipv6/Kconfig	24 Mar 2003 22:00:39 -0000	1.1.1.3
+++ net/ipv6/Kconfig	18 May 2003 04:02:20 -0000	1.3
@@ -17,9 +17,12 @@
 
 	  See <file:Documentation/networking/ip-sysctl.txt> for details.
 
+comment "Cryptographic HMAC support is needed for IPv6 AH or ESP support"
+	depends on IPV6 && CRYPTO_HMAC=n
+
 config INET6_AH
 	tristate "IPv6: AH transformation"
-	depends on IPV6
+	depends on IPV6 && CRYPTO_HMAC
 	---help---
 	  Support for IPsec AH.
 
@@ -27,7 +30,7 @@
 
 config INET6_ESP
 	tristate "IPv6: ESP transformation"
-	depends on IPV6
+	depends on IPV6 && CRYPTO_HMAC
 	---help---
 	  Support for IPsec ESP.
 

--wac7ysb48OaltWcw--
