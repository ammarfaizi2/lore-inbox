Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270783AbRHWX5V>; Thu, 23 Aug 2001 19:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270797AbRHWX5C>; Thu, 23 Aug 2001 19:57:02 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:34578 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S270784AbRHWX5B>; Thu, 23 Aug 2001 19:57:01 -0400
Date: Fri, 24 Aug 2001 00:55:14 +0100 (BST)
From: Dave Jones <davej@suse.de>
X-X-Sender: <davej@noodles.codemonkey.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] const initdata.
Message-ID: <Pine.LNX.4.31.0108240051360.1732-100000@noodles.codemonkey.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As defined in in Rusty's kernel-hacking doc, __initdata must not be
marked as const.  Patch below does this for the PCI subsystem.

*nb*, This kind of patch needs to be done in quite a few other
places too.

regards,

Dave.

-- 
| Dave Jones.                    http://www.codemonkey.org.uk
| SuSE Labs .

diff -urN --exclude-from=/home/davej/.exclude linux-ac/drivers/pci/names.c linux-dj/drivers/pci/names.c
--- linux-ac/drivers/pci/names.c	Mon Oct  2 20:00:16 2000
+++ linux-dj/drivers/pci/names.c	Fri Aug 24 00:48:59 2001
@@ -32,9 +32,9 @@
  * real memory.. Parse the same file multiple times
  * to get all the info.
  */
-#define VENDOR( vendor, name )		static const char __vendorstr_##vendor[] __initdata = name;
+#define VENDOR( vendor, name )		static char __vendorstr_##vendor[] __initdata = name;
 #define ENDVENDOR()
-#define DEVICE( vendor, device, name ) 	static const char __devicestr_##vendor##device[] __initdata = name;
+#define DEVICE( vendor, device, name ) 	static char __devicestr_##vendor##device[] __initdata = name;
 #include "devlist.h"


@@ -43,7 +43,7 @@
 #define DEVICE( vendor, device, name )	{ 0x##device, 0, __devicestr_##vendor##device },
 #include "devlist.h"

-static const struct pci_vendor_info __initdata pci_vendor_list[] = {
+static struct pci_vendor_info __initdata pci_vendor_list[] = {
 #define VENDOR( vendor, name )		{ 0x##vendor, sizeof(__devices_##vendor) / sizeof(struct pci_device_info), __vendorstr_##vendor, __devices_##vendor },
 #define ENDVENDOR()
 #define DEVICE( vendor, device, name )


