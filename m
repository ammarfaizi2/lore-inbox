Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272478AbTHKKGM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 06:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272492AbTHKKGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 06:06:12 -0400
Received: from hera.cwi.nl ([192.16.191.8]:23699 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S272478AbTHKKGI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 06:06:08 -0400
From: Andries.Brouwer@cwi.nl
Date: Mon, 11 Aug 2003 12:05:52 +0200 (MEST)
Message-Id: <UTC200308111005.h7BA5qa11199.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, fgrum@free.fr
Subject: Re: Apacer SM/CF combo reader driver
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	From: Fabien Grumelard <fgrum@free.fr>
	Subject: Re: Apacer SM/CF combo reader driver

	> If you need the SM half, ask me again.

	yes, this is what I want to use.


About the 07c4:a109 CF+SM Apacer LC1 reader:

I just checked status in 2.4.21.

The CF half words if you select CONFIG_USB_STORAGE_DATAFAB.
The SM hals works is you select CONFIG_USB_STORAGE_SDDR55
and apply a tiny patch to unusual devices:

diff -u --recursive --new-file -X /linux/dontdiff a/drivers/usb/storage/unusual_devs.h b/drivers/usb/storage/unusual_devs.h
--- a/drivers/usb/storage/unusual_devs.h        Sun Jul  6 14:22:55 2003
+++ b/drivers/usb/storage/unusual_devs.h        Mon Aug 11 12:50:26 2003
@@ -462,6 +462,14 @@
                US_FL_START_STOP ),
 #endif
 
+#ifdef CONFIG_USB_STORAGE_SDDR55
+UNUSUAL_DEV(  0x07c4, 0xa109, 0x0000, 0xffff,
+               "Datafab Systems, Inc.",
+               "USB to CF + SM Combo (LC1)",
+               US_SC_SCSI, US_PR_SDDR55, NULL,
+               US_FL_SINGLE_LUN),
+#endif
+
 #ifdef CONFIG_USB_STORAGE_DATAFAB
 UNUSUAL_DEV(  0x07c4, 0xa000, 0x0000, 0x0015,
                "Datafab",

Andries

[Note: the vanilla kernel setup still does not handle
composite devices like these - you need the twoluns
setup from the URL I gave if you want to use both CF and SM.
But if you are satisfied with having one, then you have it.]

[Note: if you select both CONFIG_USB_STORAGE_DATAFAB and
CONFIG_USB_STORAGE_SDDR55 then the order of the items in
unusual_devs.h will determine which is found first, so
whether you get CF or SM. That is why I put the entry "too early"
in the above.]
