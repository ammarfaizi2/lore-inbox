Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932101AbWJHXQu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbWJHXQu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 19:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932111AbWJHXQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 19:16:49 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:56593 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932107AbWJHXQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 19:16:37 -0400
Date: Mon, 9 Oct 2006 01:16:32 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Paul B Schroeder <pschroeder@uplogix.com>
Cc: linux-kernel@vger.kernel.org, gregkh@suse.de,
       linux-usb-devel@lists.sourceforge.net
Subject: [2.6 patch] drivers/usb/serial/mos7840.c: fix a check-after-dereference
Message-ID: <20061008231632.GQ6755@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes an obvious check-after-dereference spotted by the 
Coverity checker.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6/drivers/usb/serial/mos7840.c.old	2006-10-09 00:35:49.000000000 +0200
+++ linux-2.6/drivers/usb/serial/mos7840.c	2006-10-09 00:36:28.000000000 +0200
@@ -2412,11 +2412,12 @@
 	}
 
 	mos7840_port = mos7840_get_port_private(port);
-	tty = mos7840_port->port->tty;
 
 	if (mos7840_port == NULL)
 		return -1;
 
+	tty = mos7840_port->port->tty;
+
 	dbg("%s - port %d, cmd = 0x%x", __FUNCTION__, port->number, cmd);
 
 	switch (cmd) {

