Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbUBYOLK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 09:11:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbUBYOLK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 09:11:10 -0500
Received: from gruby.cs.net.pl ([62.233.142.99]:7950 "EHLO gruby.cs.net.pl")
	by vger.kernel.org with ESMTP id S261332AbUBYOLG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 09:11:06 -0500
Date: Wed, 25 Feb 2004 15:11:01 +0100
From: Jakub Bogusz <qboosh@pld-linux.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.3 - fix for undefined mdelay in 3c505
Message-ID: <20040225141101.GK16814@gruby.cs.net.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="EuxKj2iCbKjpUGkD"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EuxKj2iCbKjpUGkD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch fixes undefined mdelay() in 3c505 driver - at least on alpha
(maybe on other archs <linux/delay.h> is included by some other headers,
but on alpha it isn't) there was warning:

*** Warning: "mdelay" [drivers/net/3c505.ko] undefined!


-- 
Jakub Bogusz    http://cyber.cs.net.pl/~qboosh/
PLD Team        http://www.pld-linux.org/

--EuxKj2iCbKjpUGkD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-3c505-mdelay.patch"

fixes "*** Warning: "mdelay" [drivers/net/3c505.ko] undefined!"

--- linux-2.6.3/drivers/net/3c505.c.orig	2004-02-18 04:59:55.000000000 +0100
+++ linux-2.6.3/drivers/net/3c505.c	2004-02-25 14:54:15.000000000 +0100
@@ -106,6 +106,7 @@
 #include <linux/ioport.h>
 #include <linux/spinlock.h>
 #include <linux/ethtool.h>
+#include <linux/delay.h>
 
 #include <asm/uaccess.h>
 #include <asm/bitops.h>

--EuxKj2iCbKjpUGkD--
