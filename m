Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261837AbTL1Rzu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 12:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261850AbTL1Rzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 12:55:50 -0500
Received: from 80-219-102-241.dclient.hispeed.ch ([80.219.102.241]:23556 "EHLO
	ritz.dnsalias.org") by vger.kernel.org with ESMTP id S261837AbTL1Rzs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 12:55:48 -0500
From: Daniel Ritz <daniel.ritz@gmx.ch>
Reply-To: daniel.ritz@gmx.ch
To: Russell King <rmk@arm.linux.org.uk>,
       "linux-pcmcia" <linux-pcmcia@lists.infradead.org>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6] fix yenta memleak
Date: Sun, 28 Dec 2003 18:52:14 +0100
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200312281852.14336.daniel.ritz@gmx.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fix a memleak on yenta_socket unload.
against 2.6.0


--- 1.50/drivers/pcmcia/yenta_socket.c	Tue Oct 28 00:12:06 2003
+++ edited/drivers/pcmcia/yenta_socket.c	Sun Dec 28 18:35:30 2003
@@ -648,6 +648,8 @@
 
 	pci_release_regions(dev);
 	pci_set_drvdata(dev, NULL);
+
+	kfree(sock);
 }
 
 

