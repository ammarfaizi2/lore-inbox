Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266535AbSLJCLQ>; Mon, 9 Dec 2002 21:11:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266546AbSLJCLQ>; Mon, 9 Dec 2002 21:11:16 -0500
Received: from mailout10.sul.t-online.com ([194.25.134.21]:60591 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S266535AbSLJCLO>; Mon, 9 Dec 2002 21:11:14 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.4] IP: disable ECN support by default - Config option
Date: Tue, 10 Dec 2002 03:18:21 +0100
User-Agent: KMail/1.4.3
Organization: WOLK - Working Overloaded Linux Kernel
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>
MIME-Version: 1.0
Message-Id: <200212100316.59910.m.c.p@wolk-project.de>
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_L2TVFNVZQT0JANMV2HEV"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_L2TVFNVZQT0JANMV2HEV
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Marcelo,

attached super trivial patch gives us a config option to choose whether w=
e=20
want ECN disabled per default if selected or not.

consider for inclusion into 2.4.

Has been in WOLK and in Debian kernels for ages.

ciao, Marc
--------------Boundary-00=_L2TVFNVZQT0JANMV2HEV
Content-Type: text/x-diff;
  charset="us-ascii";
  name="ecn-disable-per-default-config-option.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="ecn-disable-per-default-config-option.patch"

--- linux-old/net/ipv4/Config.in
+++ linux-wolk/net/ipv4/Config.in
@@ -40,6 +40,9 @@
    bool '  IP: ARP daemon support (EXPERIMENTAL)' CONFIG_ARPD
 fi
 bool '  IP: TCP Explicit Congestion Notification support' CONFIG_INET_ECN
+if [ "$CONFIG_INET_ECN" = "y" ]; then
+   bool '    IP: disable ECN support by default' CONFIG_INET_ECN_DISABLED
+fi
 bool '  IP: TCP syncookie support (disabled per default)' CONFIG_SYN_COOKIES
 if [ "$CONFIG_NETFILTER" != "n" ]; then
    source net/ipv4/netfilter/Config.in
--- linux-old/net/ipv4/tcp_input.c
+++ linux-wolk/net/ipv4/tcp_input.c
@@ -74,7 +74,7 @@
 int sysctl_tcp_sack = 1;
 int sysctl_tcp_fack = 1;
 int sysctl_tcp_reordering = TCP_FASTRETRANS_THRESH;
-#ifdef CONFIG_INET_ECN
+#if defined(CONFIG_INET_ECN) && !defined(CONFIG_INET_ECN_DISABLED)
 int sysctl_tcp_ecn = 1;
 #else
 int sysctl_tcp_ecn = 0;

--------------Boundary-00=_L2TVFNVZQT0JANMV2HEV--

