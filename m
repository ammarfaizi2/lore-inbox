Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286647AbSBKChy>; Sun, 10 Feb 2002 21:37:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286411AbSBKChg>; Sun, 10 Feb 2002 21:37:36 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:4622 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S286447AbSBKCh2>; Sun, 10 Feb 2002 21:37:28 -0500
Message-ID: <3C672E62.702FFB3C@delusion.de>
Date: Mon, 11 Feb 2002 03:37:22 +0100
From: "Udo A. Steinberg" <reality@delusion.de>
Organization: Disorganized
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.3 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>, greg@kroah.com
Subject: [PATCH] Linux-2.5.4-pre6 uhci.c compile fix
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus, Greg,

The attached patch fixes a trivial compiler warning in uhci.c:

uhci.c: In function `uhci_unlink_generic':
uhci.c:1694: warning: suggest parentheses around && within ||

Regards,
Udo.


diff -X dontdiff -Naur linux-2.5.4-pre-vanilla/drivers/usb/uhci.c linux-2.5.4-pre/drivers/usb/uhci.c
--- linux-2.5.4-pre-vanilla/drivers/usb/uhci.c  Mon Feb 11 03:04:17 2002
+++ linux-2.5.4-pre/drivers/usb/uhci.c  Mon Feb 11 03:11:47 2002
@@ -1689,8 +1689,8 @@
 
                /* Control and Isochronous ignore the toggle, so this */
                /* is safe for all types */
-               if ((!(td->status & TD_CTRL_ACTIVE) &&
-                   (uhci_actual_length(td->status) < uhci_expected_length(td->info)) ||
+               if (((!(td->status & TD_CTRL_ACTIVE) &&
+                   (uhci_actual_length(td->status) < uhci_expected_length(td->info))) ||
                    tmp == head)) {
                        usb_settoggle(urb->dev, uhci_endpoint(td->info),
                                uhci_packetout(td->info),
