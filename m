Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266069AbUGOAjQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266069AbUGOAjQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 20:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266129AbUGOAic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 20:38:32 -0400
Received: from mail.kroah.org ([69.55.234.183]:38784 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266069AbUGOAUH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 20:20:07 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.8-rc1
In-Reply-To: <10898507032799@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Wed, 14 Jul 2004 17:18:24 -0700
Message-Id: <10898507032467@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1784.12.7, 2004/07/14 16:19:51-07:00, mika@osdl.org

[PATCH] Upgrade security/root_plug.c to new module parameter syntax

Hi again,

Still doing my compile, and got this:

 CC [M]  security/root_plug.o
security/root_plug.c:39: warning: missing initializer
security/root_plug.c:39: warning: (near initialization for `__parm_vendor_id.addr')
security/root_plug.c:42: warning: missing initializer
security/root_plug.c:42: warning: (near initialization for `__parm_product_id.addr')
security/root_plug.c:48: warning: missing initializer
security/root_plug.c:48: warning: (near initialization for `__parm_debug.addr')

Simply upgrading root_plug to use the new module parameter syntax seemed to do
the trick. I made the debug writable, the others just readable to root.


Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 security/root_plug.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)


diff -Nru a/security/root_plug.c b/security/root_plug.c
--- a/security/root_plug.c	2004-07-14 17:10:54 -07:00
+++ b/security/root_plug.c	2004-07-14 17:10:54 -07:00
@@ -36,16 +36,16 @@
 static int vendor_id = 0x0557;
 static int product_id = 0x2008;
 
-MODULE_PARM(vendor_id, "h");
+module_param(vendor_id, uint, 0400);
 MODULE_PARM_DESC(vendor_id, "USB Vendor ID of device to look for");
 
-MODULE_PARM(product_id, "h");
+module_param(product_id, uint, 0400);
 MODULE_PARM_DESC(product_id, "USB Product ID of device to look for");
 
 /* should we print out debug messages */
 static int debug = 0;
 
-MODULE_PARM(debug, "i");
+module_param(debug, bool, 0600);
 MODULE_PARM_DESC(debug, "Debug enabled or not");
 
 #if defined(CONFIG_SECURITY_ROOTPLUG_MODULE)

