Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261331AbTCGBa5>; Thu, 6 Mar 2003 20:30:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261334AbTCGBa5>; Thu, 6 Mar 2003 20:30:57 -0500
Received: from fmr05.intel.com ([134.134.136.6]:45279 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP
	id <S261331AbTCGBaz>; Thu, 6 Mar 2003 20:30:55 -0500
Subject: Re: Latest bk build error in xfrm.h
From: Rusty Lynch <rusty@linux.co.intel.com>
To: "David S. Miller" <davem@redhat.com>
Cc: miyazawa@linux-ipv6.org, linux-kernel@vger.kernel.org
In-Reply-To: <20030306.160300.126216253.davem@redhat.com>
References: <1046980043.4170.31.camel@vmhack>
	<1046986725.4169.40.camel@vmhack> 
	<20030306.160300.126216253.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 Mar 2003 17:24:04 -0800
Message-Id: <1047000245.4169.45.camel@vmhack>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-06 at 16:03, David S. Miller wrote:
>    From: Rusty Lynch <rusty@linux.co.intel.com>
>    Date: 06 Mar 2003 13:38:44 -0800
> 
>    The problem is now the core networking has a dependency on the crypto
>    hmac code (CONFIG_CRYOTPO_HMAC) since the ipv4 ipsec code was added to
>    include/net/xfrm.h (which is included from all kinds of places.)
>    
>    The pretty much exhaust my networking/ipsec knowledge so no patch.
>    
> I just pushed the following patch to Linus, should fix the build for
> everyone.  It's also available at:
> 
> 	bk://kernel.bkbits.net/davem/netfix-2.5
> 
> Thanks.
> 
> ChangeSet@1.1075.2.1, 2003-03-06 16:17:07-08:00, davem@nuts.ninka.net
>   [IPSEC]: Fix build when ipsec is disabled.
> 

There is still a build dependency between the INET_AH/INET_ESP and
CRYPTO_HMAC that the Kconfig does not cover.  The following trivial
patch fixes it:

--- net/ipv4/Kconfig.orig	2003-03-06 17:36:13.000000000 -0800
+++ net/ipv4/Kconfig	2003-03-06 17:37:38.000000000 -0800
@@ -350,6 +350,7 @@
 
 config INET_AH
 	tristate "IP: AH transformation"
+	depends on CRYPTO_HMAC
 	---help---
 	  Support for IPsec AH.
 
@@ -357,6 +358,7 @@
 
 config INET_ESP
 	tristate "IP: ESP transformation"
+	depends on CRYPTO_HMAC
 	---help---
 	  Support for IPsec ESP.
 
 

