Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262893AbTIANyA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 09:54:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262898AbTIANyA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 09:54:00 -0400
Received: from hal-5.inet.it ([213.92.5.24]:35807 "EHLO hal-5.inet.it")
	by vger.kernel.org with ESMTP id S262893AbTIANx7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 09:53:59 -0400
From: Paolo Ornati <javaman@katamail.com>
To: marcelo@conectiva.com.br
Subject: [PATCH 2.4.22][RESEND] small config fix for ISDN
Date: Mon, 1 Sep 2003 15:54:00 +0200
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200309011554.00720.javaman@katamail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

trying to install modules in 2.4.22 I get this error:
depmod: *** Unresolved symbols in /lib/modules/2.4.22/kernel/drivers/isdn/isdn.o
depmod: 	sk_run_filter
depmod: 	sk_chk_filter

this is the fix for drivers/isdn/Config.in, please apply:

--- drivers/isdn/Config.in.orig	2003-08-31 13:23:25.000000000 +0200
+++ drivers/isdn/Config.in	2003-08-31 13:29:31.000000000 +0200
@@ -8,7 +8,7 @@
 if [ "$CONFIG_INET" != "n" ]; then
    bool '  Support synchronous PPP' CONFIG_ISDN_PPP
    if [ "$CONFIG_ISDN_PPP" != "n" ]; then
-      bool         '    PPP filtering for ISDN' CONFIG_IPPP_FILTER $CONFIG_FILTER
+      dep_bool     '    PPP filtering for ISDN' CONFIG_IPPP_FILTER $CONFIG_FILTER
       bool         '    Use VJ-compression with synchronous PPP' CONFIG_ISDN_PPP_VJ
       bool         '    Support generic MP (RFC 1717)' CONFIG_ISDN_MPP
       dep_tristate '    Support BSD compression' CONFIG_ISDN_PPP_BSDCOMP $CONFIG_ISDN

