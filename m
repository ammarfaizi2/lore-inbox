Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282860AbRLBMYa>; Sun, 2 Dec 2001 07:24:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282858AbRLBMYV>; Sun, 2 Dec 2001 07:24:21 -0500
Received: from cm.med.3284844210.kabelnet.net ([195.202.190.178]:61201 "EHLO
	phobos.hvrlab.org") by vger.kernel.org with ESMTP
	id <S282856AbRLBMYJ>; Sun, 2 Dec 2001 07:24:09 -0500
Subject: [PATCH] inet_ecn.h [2.4.16/2.5.0]
From: Herbert Valerio Riedel <hvr@kernel.org>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 02 Dec 2001 13:23:29 +0100
Message-Id: <1007295809.1531.4.camel@janus.txd.hvrlab.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

...the following allows to build a kernel without CONFIG_INET...

--- /usr/src/linux/include/net/inet_ecn.h	Sat Nov  3 23:50:06 2001
+++ inet_ecn.h	Sun Dec  2 13:15:57 2001
@@ -24,8 +24,13 @@
 	return outer;
 }
 
+#if defined(CONFIG_INET) || defined (CONFIG_INET_MODULE)
 #define	INET_ECN_xmit(sk) do { (sk)->protinfo.af_inet.tos |= 2; } while (0)
 #define	INET_ECN_dontxmit(sk) do { (sk)->protinfo.af_inet.tos &= ~3; } while (0)
+#else
+#define	INET_ECN_xmit(sk)
+#define	INET_ECN_dontxmit(sk)
+#endif
 
 #define IP6_ECN_flow_init(label) do {	\
       (label) &= ~htonl(3<<20);		\



regards,
hvr
--


