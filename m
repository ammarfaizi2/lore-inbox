Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbTHaLqa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 07:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261274AbTHaLqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 07:46:30 -0400
Received: from hal-4.inet.it ([213.92.5.23]:14818 "EHLO hal-4.inet.it")
	by vger.kernel.org with ESMTP id S261249AbTHaLq3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 07:46:29 -0400
From: Paolo Ornati <javaman@katamail.com>
To: marcelo@conectiva.com.br
Subject: [PATCH 2.4.22] small config fix for ISDN
Date: Sun, 31 Aug 2003 13:44:29 +0200
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308311344.29416.javaman@katamail.com>
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

