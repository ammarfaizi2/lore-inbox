Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261799AbTIYLd6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 07:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261809AbTIYLd6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 07:33:58 -0400
Received: from moutng.kundenserver.de ([212.227.126.189]:53744 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261799AbTIYLd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 07:33:56 -0400
Date: Thu, 25 Sep 2003 13:33:53 +0200 (MEST)
From: Armin Schindler <armin@melware.de>
To: Adrian Bunk <bunk@fs.tum.de>
cc: <isdn4linux@listserv.isdn4linux.de>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: [PATCH] Re: 2.6 eicon/ and hardware/eicon/ drivers using the same
 symbols
In-Reply-To: <20030925101541.GH15696@fs.tum.de>
Message-ID: <Pine.LNX.4.31.0309251331150.21651-100000@phoenix.one.melware.de>
Organization: Cytronics & Melware
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Sep 2003, Adrian Bunk wrote:
> I got the link error below in 2.6.0-test5-mm4 (but it doesn't seem to be
> specific to -mm).
>
> It seems some drivers under eicon/ and hardware/eicon/ use the same
> symbols. Either some symbols should be renamed or Kconfig dependencies
> should ensure that you can't build two such drivers statically into the
> kernel at the same time.

The legacy eicon driver in drivers/isdn/eicon is the old one and will be
removed as soon as all features went to the new driver.
Anyway this old driver was never meant to be non-module.

This patch should do it.

Armin



--- linux-2.5/drivers/isdn/eicon/Kconfig.orig	Thu Sep 25 13:28:07 2003
+++ linux-2.5/drivers/isdn/eicon/Kconfig	Thu Sep 25 13:27:01 2003
@@ -13,7 +13,7 @@
 choice
 	prompt "Eicon active card support"
 	optional
-	depends on ISDN_DRV_EICON && ISDN
+	depends on ISDN_DRV_EICON && ISDN && m

 config ISDN_DRV_EICON_DIVAS
 	tristate "Eicon driver"

