Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263975AbTDZMcP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Apr 2003 08:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264648AbTDZMcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Apr 2003 08:32:15 -0400
Received: from camus.xss.co.at ([194.152.162.19]:43280 "EHLO camus.xss.co.at")
	by vger.kernel.org with ESMTP id S263975AbTDZMcN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Apr 2003 08:32:13 -0400
Message-ID: <3EAA7F21.3070503@xss.co.at>
Date: Sat, 26 Apr 2003 14:44:17 +0200
From: Andreas Haumer <andreas@xss.co.at>
Organization: xS+S
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.21rc1-ac2
References: <200304251753.h3PHrqU08482@devserv.devel.redhat.com>
In-Reply-To: <200304251753.h3PHrqU08482@devserv.devel.redhat.com>
X-Enigmail-Version: 0.74.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Here is a first test report for 2.4.21-rc1-ac2:

*) Shutdown/Reboot problems in 2.4.21-rc1-ac1 due to
   deadlock in ide_unregister_subdriver() seem to be
   fixed!

*) EXTRAVERSION in top-level Makefile was not updated

*) Unresolved symbol "fc_type_trans" in iph5526.o
   Fixed by the following patch:

--- linux-2.4.21-rc1-ac2/net/802/fc.c.orig      Sat Apr 26 13:35:22 2003
+++ linux-2.4.21-rc1-ac2/net/802/fc.c   Sat Apr 26 13:40:40 2003
@@ -11,6 +11,8 @@
  */

 #include <linux/config.h>
+#include <linux/module.h>
+
 #include <asm/uaccess.h>
 #include <asm/system.h>
 #include <linux/types.h>
@@ -95,6 +97,8 @@
        return 0;
 #endif
 }
+
+EXPORT_SYMBOL(fc_type_trans);

 unsigned short
 fc_type_trans(struct sk_buff *skb, struct net_device *dev)

--- linux-2.4.21-rc1-ac2/net/802/Makefile.orig  Sat Apr 26 13:44:38 2003
+++ linux-2.4.21-rc1-ac2/net/802/Makefile       Sat Apr 26 13:45:42 2003
@@ -9,7 +9,7 @@

 O_TARGET := 802.o

-export-objs = llc_macinit.o p8022.o psnap.o
+export-objs = llc_macinit.o p8022.o psnap.o fc.o

 obj-y  = p8023.o


No other problems found so far... :-)

HTH

- andreas

-- 
Andreas Haumer                     | mailto:andreas@xss.co.at
*x Software + Systeme              | http://www.xss.co.at/
Karmarschgasse 51/2/20             | Tel: +43-1-6060114-0
A-1100 Vienna, Austria             | Fax: +43-1-6060114-71

