Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751700AbWCBXKR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751700AbWCBXKR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 18:10:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751688AbWCBXKD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 18:10:03 -0500
Received: from atlrel6.hp.com ([156.153.255.205]:10396 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S1751195AbWCBXJj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 18:09:39 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Adam Belay <ambx1@neo.rr.com>
Subject: [PATCH 5/9] ns558: adjust pnp_register_driver signature
Date: Thu, 2 Mar 2006 16:09:37 -0700
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@suse.cz>,
       Matthieu Castet <castet.matthieu@free.fr>,
       Li Shaohua <shaohua.li@intel.com>, Andrew Morton <akpm@osdl.org>,
       Vojtech Pavlik <vojtech@ucw.cz>
References: <200603021601.27467.bjorn.helgaas@hp.com>
In-Reply-To: <200603021601.27467.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603021609.37525.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the assumption that pnp_register_driver() returns the number of
devices claimed.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work-mm4/drivers/input/gameport/ns558.c
===================================================================
--- work-mm4.orig/drivers/input/gameport/ns558.c	2006-03-02 12:40:45.000000000 -0700
+++ work-mm4/drivers/input/gameport/ns558.c	2006-03-02 12:43:58.000000000 -0700
@@ -256,9 +256,10 @@
 
 static int __init ns558_init(void)
 {
-	int i = 0;
+	int i = 0, err;
 
-	if (pnp_register_driver(&ns558_pnp_driver) >= 0)
+	err = pnp_register_driver(&ns558_pnp_driver);
+	if (!err)
 		pnp_registered = 1;
 
 /*
