Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270532AbRHNKdg>; Tue, 14 Aug 2001 06:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270534AbRHNKd1>; Tue, 14 Aug 2001 06:33:27 -0400
Received: from mailgate.indstate.edu ([139.102.15.118]:41981 "EHLO
	mailgate.indstate.edu") by vger.kernel.org with ESMTP
	id <S270532AbRHNKdI>; Tue, 14 Aug 2001 06:33:08 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rich Baum <richbaum@acm.org>
To: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH] fix 2.4.8 compile errors
Date: Tue, 14 Aug 2001 05:32:16 -0500
X-Mailer: KMail [version 1.2.9]
In-Reply-To: <100C620A6B75@coral.indstate.edu>
In-Reply-To: <100C620A6B75@coral.indstate.edu>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <1013D72A35C6@coral.indstate.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the input.  I've fixed this patch to include the fis.

Rich

diff -urN -X dontdiff linux-2.4.8/drivers/net/Config.in 
rb/drivers/net/Config.in
--- linux-2.4.8/drivers/net/Config.in	Sat Aug 11 11:10:07 2001
+++ rb/drivers/net/Config.in	Tue Aug 14 05:21:47 2001
@@ -28,7 +28,9 @@
 
 bool 'Ethernet (10 or 100Mbit)' CONFIG_NET_ETHERNET
 if [ "$CONFIG_NET_ETHERNET" = "y" ]; then
-   dep_bool '  ARM EBSA110 AM79C961A support' CONFIG_ARM_AM79C961A 
$CONFIG_ARCH_EBSA110
+   if [ "$ARCH" = "arm" ]; then
+      dep_bool '  ARM EBSA110 AM79C961A support' CONFIG_ARM_AM79C961A 
$CONFIG_ARCH_EBSA110
+   fi
    if [ "$CONFIG_ARCH_ACORN" = "y" ]; then
       source drivers/acorn/net/Config.in
    fi
diff -urN -X dontdiff linux-2.4.8/drivers/video/Config.in 
rb/drivers/video/Config.in
--- linux-2.4.8/drivers/video/Config.in	Sat Aug 11 11:10:30 2001
+++ rb/drivers/video/Config.in	Mon Aug 13 20:43:46 2001
@@ -103,7 +103,8 @@
    fi
    tristate '  NEC PowerVR 2 display support' CONFIG_FB_PVR2
    dep_bool '    Debug pvr2fb' CONFIG_FB_PVR2_DEBUG $CONFIG_FB_PVR2
-   bool '  Epson 1355 framebuffer support' CONFIG_FB_E1355
+   if [ "$ARCH" = "sh" ]; then
+      bool '  Epson 1355 framebuffer support' CONFIG_FB_E1355
    if [ "$CONFIG_FB_E1355" = "y" ]; then
       hex '    Register Base Address' CONFIG_E1355_REG_BASE a8000000
       hex '    Framebuffer Base Address' CONFIG_E1355_FB_BASE a8200000
