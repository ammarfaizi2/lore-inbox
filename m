Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262740AbTI1W7w (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 18:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262743AbTI1W7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 18:59:52 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:8919 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262740AbTI1W7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 18:59:50 -0400
Date: Mon, 29 Sep 2003 00:59:41 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: netdev@oss.sgi.com, davem@redhat.com, pekkas@netcore.fi
Cc: lksctp-developers@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: RFC: [2.6 patch] disallow modular IPv6
Message-ID: <20030928225941.GW15338@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems modular IPv6 doesn't work 100% reliable, e.g. after looking at 
the code it doesn't seem to be a good idea to compile a kernel without 
IPv6 support and later build and install IPv6 modules. Is there a great 
need for modular IPv6 or is the patch below to disallow modular IPv6 OK?

diffstat output:

 net/Kconfig      |    2 +-
 net/sctp/Kconfig |    6 ------
 2 files changed, 1 insertion(+), 7 deletions(-)

cu
Adrian


--- linux-2.6.0-test6-full/net/Kconfig.old	2003-09-29 00:53:05.000000000 +0200
+++ linux-2.6.0-test6-full/net/Kconfig	2003-09-29 00:55:55.000000000 +0200
@@ -117,7 +117,7 @@
 
 #   IPv6 as module will cause a CRASH if you try to unload it
 config IPV6
-	tristate "The IPv6 protocol (EXPERIMENTAL)"
+	bool "The IPv6 protocol (EXPERIMENTAL)"
 	depends on INET && EXPERIMENTAL
 	---help---
 	  This is experimental support for the next version of the Internet
--- linux-2.6.0-test6-full/net/sctp/Kconfig.old	2003-09-29 00:50:11.000000000 +0200
+++ linux-2.6.0-test6-full/net/sctp/Kconfig	2003-09-29 00:52:55.000000000 +0200
@@ -5,14 +5,8 @@
 menu "SCTP Configuration (EXPERIMENTAL)"
 	depends on INET && EXPERIMENTAL
 
-config IPV6_SCTP__
-	tristate
-	default y if IPV6=n
-	default IPV6 if IPV6
-
 config IP_SCTP
 	tristate "The SCTP Protocol (EXPERIMENTAL)"
-	depends on IPV6_SCTP__
 	---help---
 	  Stream Control Transmission Protocol
 
