Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbTIZWvN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 18:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbTIZWvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 18:51:13 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:13303 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261731AbTIZWvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 18:51:12 -0400
Date: Sat, 27 Sep 2003 00:50:21 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Armin Schindler <armin@melware.de>
Cc: isdn4linux@listserv.isdn4linux.de,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       gpl-info@spellcast.com
Subject: [PATCH] let ISDN_DRV_SC depend on m
Message-ID: <20030926225021.GH2881@fs.tum.de>
References: <20030925101541.GH15696@fs.tum.de> <Pine.LNX.4.31.0309251331150.21651-100000@phoenix.one.melware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.31.0309251331150.21651-100000@phoenix.one.melware.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 25, 2003 at 01:33:53PM +0200, Armin Schindler wrote:
> On Thu, 25 Sep 2003, Adrian Bunk wrote:
> > I got the link error below in 2.6.0-test5-mm4 (but it doesn't seem to be
> > specific to -mm).
> >
> > It seems some drivers under eicon/ and hardware/eicon/ use the same
> > symbols. Either some symbols should be renamed or Kconfig dependencies
> > should ensure that you can't build two such drivers statically into the
> > kernel at the same time.
> 
> The legacy eicon driver in drivers/isdn/eicon is the old one and will be
> removed as soon as all features went to the new driver.
> Anyway this old driver was never meant to be non-module.
> 
> This patch should do it.

Yes, thanks, this works. The similar patch for ISDN_DRV_SC below is 
needed, too.

> Armin

cu
Adrian

--- linux-2.6.0-test5-mm4-no-smp-2.95/drivers/isdn/sc/Kconfig.old	2003-09-25 19:21:07.000000000 +0200
+++ linux-2.6.0-test5-mm4-no-smp-2.95/drivers/isdn/sc/Kconfig	2003-09-25 19:21:54.000000000 +0200
@@ -3,7 +3,7 @@
 #
 config ISDN_DRV_SC
 	tristate "Spellcaster support"
-	depends on ISDN && ISA
+	depends on ISDN && ISA && m
 	help
 	  This enables support for the Spellcaster BRI ISDN boards.  This
 	  driver currently builds only in a modularized version ( = code which
