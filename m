Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265686AbUBGBBf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 20:01:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265799AbUBGBBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 20:01:35 -0500
Received: from 204.Red-213-96-224.pooles.rima-tde.net ([213.96.224.204]:46603
	"EHLO betawl.net") by vger.kernel.org with ESMTP id S265686AbUBGBBc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 20:01:32 -0500
Date: Sat, 7 Feb 2004 02:01:29 +0100
From: Santiago Garcia Mantinan <manty@manty.net>
To: linux-kernel@vger.kernel.org
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: [PATCH] Fix PCMCIA card detection in 2.4 (in time for 2.4.25?)
Message-ID: <20040207010129.GA4513@man.manty.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 11th Aug 2003 I had reported yenya problems on Acer TravelMate 260 with
2.6.0test3, the bad news is that these problems also exist on 2.4 up to
2.4.25-test1, the good one is that Russell King had posted a fix on Oct 28
2003, similar subject than this message, that patch was for 2.6 and got into
2.6.0test10, so while this issue is solved in 2.6 kernels, it still exists
in 2.4. Today I tried to aply Russell's patch to 2.4, I had to rewrite it,
but otherwise it is exactly the same patch and it seems to work, at least in
my machine.

Can people test this so that we can clean up any doubts Marcelo may have and
it gets roled into 2.4.25?

Regards...
-- 
Manty/BestiaTester -> http://manty.net

--- old/drivers/pcmcia/yenta.c	2004-02-07 01:55:45.000000000 +0100
+++ new/drivers/pcmcia/yenta.c	2004-02-07 01:58:12.000000000 +0100
@@ -636,6 +636,7 @@
  */
 static void yenta_config_init(pci_socket_t *socket)
 {
+	u32 state;
 	u16 bridge;
 	struct pci_dev *dev = socket->dev;
 
@@ -675,6 +676,9 @@
 	exca_writeb(socket, I365_GENCTL, 0x00);
 
 	/* Redo card voltage interrogation */
+	state = cb_readl(socket, CB_SOCKET_STATE);
+	if (!(state & (CB_CDETECT1 | CB_CDETECT2 | CB_5VCARD |
+	CB_3VCARD | CB_XVCARD | CB_YVCARD)))
 	cb_writel(socket, CB_SOCKET_FORCE, CB_CVSTEST);
 }
 
