Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932605AbVJGNr6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932605AbVJGNr6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 09:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932612AbVJGNr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 09:47:57 -0400
Received: from newmail.linux4media.de ([193.201.54.81]:3524 "EHLO l4m.mine.nu")
	by vger.kernel.org with ESMTP id S932605AbVJGNr5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 09:47:57 -0400
From: Bernhard Rosenkraenzer <bero@arklinux.org>
To: adaplas@users.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Modular i810fb broken, partial fix
Date: Fri, 7 Oct 2005 15:47:14 +0200
User-Agent: KMail/1.8.91
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ixnRDgMOY+QNEon"
Message-Id: <200510071547.14616.bero@arklinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_ixnRDgMOY+QNEon
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,
i810fb as a module is broken (checked with 2.6.13-mm3 and 2.6.14-rc2-mm1).
It compiles, but the module doesn't actually load because the kernel doesn't 
recognize the hardware (the MODULE_DEVICE_TABLE statement is missing).

The attached patch fixes this.

However, the resulting module still doesn't work.
It loads, and then garbles the display (black screen with a couple of yellow 
lines, no matter what is written into the framebuffer device).

Related .config entries:
CONFIG_I2C_I810=m
CONFIG_FB_I810=m
CONFIG_FB_I810_GTF=y
CONFIG_FB_I810_I2C=y

--Boundary-00=_ixnRDgMOY+QNEon
Content-Type: text/x-diff;
  charset="us-ascii";
  name="2.6.13-mm3-fix-i810fb.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="2.6.13-mm3-fix-i810fb.patch"

--- linux-2.6.13/drivers/video/i810/i810_main.c.ark	2005-09-13 00:31:37.000000000 +0200
+++ linux-2.6.13/drivers/video/i810/i810_main.c	2005-09-13 00:31:54.000000000 +0200
@@ -83,6 +83,8 @@
 	{ 0 },
 };
 
+MODULE_DEVICE_TABLE(pci, i810fb_pci_tbl);
+
 static struct pci_driver i810fb_driver = {
 	.name     =	"i810fb",
 	.id_table =	i810fb_pci_tbl,

--Boundary-00=_ixnRDgMOY+QNEon--
