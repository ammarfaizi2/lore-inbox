Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964886AbWIVUKa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964886AbWIVUKa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 16:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964887AbWIVUK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 16:10:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:21641 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964886AbWIVUK3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 16:10:29 -0400
X-Authenticated: #31060655
Message-ID: <45144343.7080404@gmx.net>
Date: Fri, 22 Sep 2006 22:10:43 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.7) Gecko/20060911 SUSE/1.0.5-1.1 SeaMonkey/1.0.5
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Suspend-devel list <suspend-devel@lists.sourceforge.net>,
       "Benjamin A. Okopnik" <ben@linuxgazette.net>
Subject: [PATCH] radeonfb supend/resume support for Acer Aspire 2010
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben,

the patch below has been tested by Benjamin Okopnik and makes
suspend-to-RAM work for him perfectly on his Acer Aspire 2010.
Without this patch, a total lockup happens on resume.

I hope the patch is still in the merge window for 2.6.19.

Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/

This patch adds suspend/resume support for the graphics chip in the
Acer Aspire 2010: ATI Technologies Inc RV350 [Mobility Radeon 9600 M10]
01:00.0 0300: 1002:4e50 (prog-if 00 [VGA])
        Subsystem: 1025:0061
        Flags: bus master, 66MHz, medium devsel, latency 128, IRQ 16
        Memory at a8000000 (32-bit, prefetchable) [size=128M]
        I/O ports at c100 [size=256]
        Memory at e0010000 (32-bit, non-prefetchable) [size=64K]
        [virtual] Expansion ROM at a0000000 [disabled] [size=128K]
        Capabilities: [58] AGP version 2.0
        Capabilities: [50] Power Management version 2

Signed-off-by: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@mgx.net>


--- a/drivers/video/aty/radeon_pm.c	2006-09-22 02:53:06.000000000 +0200
+++ b/drivers/video/aty/radeon_pm.c	2006-09-22 02:55:15.000000000 +0200
@@ -86,6 +86,9 @@
 	BUGFIX("Samsung P35",
 	       PCI_VENDOR_ID_SAMSUNG, 0xc00c,
 	       radeon_pm_off, radeon_reinitialize_M10),
+	BUGFIX("Acer Aspire 2010",
+	       PCI_VENDOR_ID_AI, 0x0061,
+	       radeon_pm_off, radeon_reinitialize_M10),
 	{ .ident = NULL }
 };
 


