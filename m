Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261305AbSKGPe6>; Thu, 7 Nov 2002 10:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261306AbSKGPe6>; Thu, 7 Nov 2002 10:34:58 -0500
Received: from gateway.cinet.co.jp ([210.166.75.129]:41006 "EHLO
	precia.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S261305AbSKGPe5>; Thu, 7 Nov 2002 10:34:57 -0500
Message-ID: <3DCA89A0.E6B6DDEF@cinet.co.jp>
Date: Fri, 08 Nov 2002 00:41:20 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
X-Mailer: Mozilla 4.8C-ja  [ja/Vine] (X11; U; Linux 2.5.45-ac1-pc98smp i686)
X-Accept-Language: ja, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] 2.5.45-ac1 CardBus compile Fix
Content-Type: multipart/mixed;
 boundary="------------A1F21475D43E4AB34680EB7E"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------A1F21475D43E4AB34680EB7E
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit

I couldn't compile cistpl.c, that call obsolete function.

Here is trivial patch. This works fine for me.

Regards,
Osamu Tomita
--------------A1F21475D43E4AB34680EB7E
Content-Type: text/plain; charset=iso-2022-jp;
 name="2.5.45-ac1-cardbus-compile.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.5.45-ac1-cardbus-compile.patch"

--- linux-2.5.45-ac1/drivers/pcmcia/cistpl.c.orig	Thu Oct 31 09:42:24 2002
+++ linux-2.5.45-ac1/drivers/pcmcia/cistpl.c	Thu Nov  7 01:03:55 2002
@@ -429,7 +429,7 @@
 #ifdef CONFIG_CARDBUS
     if (s->state & SOCKET_CARDBUS) {
 	u_int ptr;
-	pcibios_read_config_dword(s->cap.cb_dev->subordinate->number, 0, 0x28, &ptr);
+	pci_bus_read_config_dword(s->cap.cb_dev->bus, 0, 0x28, &ptr);
 	tuple->CISOffset = ptr & ~7;
 	SPACE(tuple->Flags) = (ptr & 7);
     } else

--------------A1F21475D43E4AB34680EB7E--

