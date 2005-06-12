Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261942AbVFLLYW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261942AbVFLLYW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 07:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262266AbVFLLW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 07:22:29 -0400
Received: from aun.it.uu.se ([130.238.12.36]:25316 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261942AbVFLLSY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 07:18:24 -0400
Date: Sun, 12 Jun 2005 13:18:17 +0200 (MEST)
Message-Id: <200506121118.j5CBIHMt019710@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: marcelo.tosatti@cyclades.com
Subject: [PATCH 2.4.31 3/9] gcc4: fix nested function declaration errors
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc4 generates a few compile-time errors like:

In file included from ehci-hcd.c:249:
ehci-q.c: In function 'ehci_urb_done':
ehci-q.c:203: error: invalid storage class for function 'ehci_urb_enqueue'
make[3]: *** [ehci-hcd.o] Error 1
make[3]: Leaving directory `/tmp/linux-2.4.31/drivers/usb/host'
make[2]: *** [_modsubdir_host] Error 2
make[2]: Leaving directory `/tmp/linux-2.4.31/drivers/usb'
make[1]: *** [_modsubdir_usb] Error 2
make[1]: Leaving directory `/tmp/linux-2.4.31/drivers'
make: *** [_mod_drivers] Error 2

This is because function prototype declarations in nested scopes are
no longer accepted. The fix is to remove redundant declarations, or
to move non-redundant ones to the top level.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

 drivers/usb/host/ehci-q.c |    2 --
 1 files changed, 2 deletions(-)

diff -rupN linux-2.4.31/drivers/usb/host/ehci-q.c linux-2.4.31.gcc4-nested-fundec-errors/drivers/usb/host/ehci-q.c
--- linux-2.4.31/drivers/usb/host/ehci-q.c	2005-01-19 18:00:53.000000000 +0100
+++ linux-2.4.31.gcc4-nested-fundec-errors/drivers/usb/host/ehci-q.c	2005-06-12 11:44:05.000000000 +0200
@@ -199,8 +199,6 @@ ehci_urb_done (struct ehci_hcd *ehci, st
 #ifdef	INTR_AUTOMAGIC
 	struct urb		*resubmit = 0;
 	struct usb_device	*dev = 0;
-
-	static int ehci_urb_enqueue (struct usb_hcd *, struct urb *, int);
 #endif
 
 	if (likely (urb->hcpriv != 0)) {
