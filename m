Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261711AbUGQUqY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbUGQUqY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 16:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbUGQUqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 16:46:24 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:13556 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261711AbUGQUqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 16:46:20 -0400
Date: Sat, 17 Jul 2004 22:46:13 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, Sam Ravnborg <sam@ravnborg.org>,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] move STANDALONE to drivers/base/Kconfig
Message-ID: <20040717204612.GF14733@fs.tum.de>
References: <20040620174632.74e08e09.akpm@osdl.org> <20040621020420.GL27822@fs.tum.de> <20040622053349.GA2738@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040622053349.GA2738@mars.ravnborg.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > This option is in drivers/base/Kconfig, but the similar option 
> > STANDALONE [1] is in init/Kconfig.
> > 
> > Shouldn't buoth be at the same place?
> > What about moving STANDALONE ad let it depend on PREVENT_FIRMWARE_BUILD?
> 
> STANDALONE avoids any drivers not using external firmware.
> PREVENT_FIRMWARE_BUILD just prevents the supplied firmware to be build.
> So no I do not see they should be dependent.
> 
> But for sure they should be located in the same place.
> This is drivers only information and not related to the actual
> maturity of the code - so moving STANDALONE to drivers/base
> makes sense to me.
> Adrian - care to submit a patch?

Sorry for the late answer, the patch is below.

> 	Sam

cu
Adrian




Move STANDALONE from init/Kconfig to drivers/base/Kconfig .
This way, it's besides PREVENT_FIRMWARE_BUILD.


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.8-rc1-mm1-full/init/Kconfig.old	2004-07-17 20:07:03.000000000 +0200
+++ linux-2.6.8-rc1-mm1-full/init/Kconfig	2004-07-17 20:07:39.000000000 +0200
@@ -41,15 +41,6 @@
 
 	  If unsure, say Y
 
-config STANDALONE
-	bool "Select only drivers that don't need compile-time external firmware" if EXPERIMENTAL
-	default y
-	help
-	  Select this option if you don't have magic firmware for drivers that
-	  need it.
-
-	  If unsure, say Y.
-
 config BROKEN
 	bool
 	depends on !CLEAN_COMPILE
--- linux-2.6.8-rc1-mm1-full/drivers/base/Kconfig.old	2004-07-17 20:06:36.000000000 +0200
+++ linux-2.6.8-rc1-mm1-full/drivers/base/Kconfig	2004-07-17 20:07:34.000000000 +0200
@@ -1,5 +1,14 @@
 menu "Generic Driver Options"
 
+config STANDALONE
+	bool "Select only drivers that don't need compile-time external firmware" if EXPERIMENTAL
+	default y
+	help
+	  Select this option if you don't have magic firmware for drivers that
+	  need it.
+
+	  If unsure, say Y.
+
 config PREVENT_FIRMWARE_BUILD
 	bool "Prevent firmware from being built"
 	default y
