Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262425AbUFQU2k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262425AbUFQU2k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 16:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262756AbUFQU2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 16:28:40 -0400
Received: from iceberg.elsat.net.pl ([217.173.160.37]:4994 "EHLO
	iceberg.elsat.net.pl") by vger.kernel.org with ESMTP
	id S262425AbUFQU2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 16:28:37 -0400
Date: Thu, 17 Jun 2004 22:28:38 +0200
From: Krzysztof Rusocki <kszysiu@iceberg.elsat.net.pl>
To: cltien@cmedia.com.tw
Cc: linux-kernel@vger.kernel.org
Subject: cmpci oops on rmmod + fix
Message-ID: <20040617202838.GA17910@iceberg.elsat.net.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hi,

The cmpci driver included in Linux 2.6.7 causes an oops on rmmod,
I believe cm_remove should be marked __devexit rather than __devinit.

Patch attached.

Cheers,
Krzysztof

--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cmpci-devexit-1.diff"

--- cmpci.c.2.6.7	2004-06-17 15:09:29.061994072 +0200
+++ cmpci.c	2004-06-17 22:34:20.660244240 +0200
@@ -3280,7 +3280,7 @@
 MODULE_DESCRIPTION("CM8x38 Audio Driver");
 MODULE_LICENSE("GPL");
 
-static void __devinit cm_remove(struct pci_dev *dev)
+static void __devexit cm_remove(struct pci_dev *dev)
 {
 	struct cm_state *s = pci_get_drvdata(dev);
 
@@ -3337,7 +3337,7 @@
        .name	 = "cmpci",
        .id_table = id_table,
        .probe	 = cm_probe,
-       .remove	 = cm_remove
+       .remove	 = __devexit_p(cm_remove)
 };
 
 static int __init init_cmpci(void)

--fdj2RfSjLxBAspz7--
