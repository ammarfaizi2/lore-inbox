Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265736AbUATVYd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 16:24:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265748AbUATVYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 16:24:33 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:30953 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265736AbUATVYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 16:24:32 -0500
Date: Tue, 20 Jan 2004 22:24:21 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: dri-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] disallow DRM on 386
Message-ID: <20040120212421.GF12027@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following compile error in 2.6.1-mm5 with X86_CMPXCHG=n.
This problem is not specific to -mm, and it always occurs when you 
include support for the 386 cpu (oposed to the 486 or later cpus) since 
in this case X86_CMPXCHG=n and therefoore cmpxchg isn't defined in 
include/asm-i386/system.h .

The patch below disallows DRM if X86_CMPXCHG=n.

Please apply
Adrian

--- linux-2.6.1-mm5/drivers/char/drm/Kconfig.old	2004-01-20 14:42:27.000000000 +0100
+++ linux-2.6.1-mm5/drivers/char/drm/Kconfig	2004-01-20 14:43:02.000000000 +0100
@@ -6,6 +6,7 @@
 #
 config DRM
 	bool "Direct Rendering Manager (XFree86 4.1.0 and higher DRI support)"
+	depends on !X86 || X86_CMPXCHG
 	help
 	  Kernel-level support for the Direct Rendering Infrastructure (DRI)
 	  introduced in XFree86 4.0. If you say Y here, you need to select
