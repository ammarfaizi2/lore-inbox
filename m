Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265792AbTL3N6T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 08:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265793AbTL3N6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 08:58:19 -0500
Received: from mail.ccdaust.com.au ([203.29.88.42]:62257 "EHLO
	gateway.ccdaust.com.au") by vger.kernel.org with ESMTP
	id S265792AbTL3N6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 08:58:18 -0500
Message-ID: <3FF1846F.40607@wasp.net.au>
Date: Tue, 30 Dec 2003 17:58:07 +0400
From: Brad Campbell <brad@wasp.net.au>
User-Agent: Mozilla Thunderbird 0.5a (20031207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: dahinds@users.sourceforge.net, marcelo.tosatti@cyclades.com
Subject: [patch] 2.4.x yenta.c
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a longstanding bug on my OZ6933 Cardbus Controller (rev 01)
(Having to insert a card twice to get it to come up)

I snarfed it from a 2.6-pre and applied it to 2.4. Could it be applied 
to 2.4.24 pretty please ?


diff -urN linux-2.4.23/drivers/pcmcia/yenta.c 
linux-2.4.23.olf/drivers/pcmcia/yenta.c
--- linux-2.4.23/drivers/pcmcia/yenta.c 2003-12-30 21:08:09.000000000 +0400
+++ linux-2.4.23.olf/drivers/pcmcia/yenta.c     2003-12-12 
20:50:58.000000000 +0400
@@ -634,6 +634,7 @@
   */
  static void yenta_config_init(pci_socket_t *socket)
  {
+       u32 state;
         u16 bridge;
         struct pci_dev *dev = socket->dev;

@@ -673,6 +674,10 @@
         exca_writeb(socket, I365_GENCTL, 0x00);

         /* Redo card voltage interrogation */
+       state = cb_readl(socket, CB_SOCKET_STATE);
+       if (!(state & (CB_CDETECT1 | CB_CDETECT2 | CB_5VCARD |
+                       CB_3VCARD | CB_XVCARD | CB_YVCARD)))
+
         cb_writel(socket, CB_SOCKET_FORCE, CB_CVSTEST);
  }

Regards,
Brad
