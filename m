Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964841AbWJYWRA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964841AbWJYWRA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 18:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964838AbWJYWRA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 18:17:00 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:12605 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S964837AbWJYWQ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 18:16:59 -0400
Date: Wed, 25 Oct 2006 15:17:37 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Athanasius <link@miggy.org>, toralf.foerster@gmx.de,
       gregkh <greg@kroah.com>, akpm <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>,
       lud <linux-usb-devel@lists.sourceforge.net>
Cc: Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       David Brownell <dbrownell@users.sourceforge.net>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: [PATCH] !CONFIG_NET_ETHERNET unsets CONFIG_PHYLIB, but
 CONFIG_USB_USBNET also needs CONFIG_PHYLIB
Message-Id: <20061025151737.1bf4898c.randy.dunlap@oracle.com>
In-Reply-To: <20061025201341.GH21200@miggy.org>
References: <Pine.LNX.4.64.0610231618510.3962@g5.osdl.org>
	<20061025201341.GH21200@miggy.org>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

USB network drivers that use mii_*() interfaces should
cause those interfaces to be built.  Or depend on them,
but this is what all drivers/net/ drivers do.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/usb/net/Kconfig |    3 +++
 1 file changed, 3 insertions(+)

--- linux-2619-rc3-pv.orig/drivers/usb/net/Kconfig
+++ linux-2619-rc3-pv/drivers/usb/net/Kconfig
@@ -84,6 +84,7 @@ config USB_PEGASUS
 config USB_RTL8150
 	tristate "USB RTL8150 based ethernet device support (EXPERIMENTAL)"
 	depends on EXPERIMENTAL
+	select MII
 	help
 	  Say Y here if you have RTL8150 based usb-ethernet adapter.
 	  Send me <petkan@users.sourceforge.net> any comments you may have.
@@ -94,6 +95,7 @@ config USB_RTL8150
 
 config USB_USBNET
 	tristate "Multi-purpose USB Networking Framework"
+	select MII
 	---help---
 	  This driver supports several kinds of network links over USB,
 	  with "minidrivers" built around a common network driver core
@@ -210,6 +212,7 @@ config USB_NET_PLUSB
 config USB_NET_MCS7830
 	tristate "MosChip MCS7830 based Ethernet adapters"
 	depends on USB_USBNET
+	select MII
 	help
 	  Choose this option if you're using a 10/100 Ethernet USB2
 	  adapter based on the MosChip 7830 controller. This includes




---
