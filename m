Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265648AbRGGCJz>; Fri, 6 Jul 2001 22:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265670AbRGGCJp>; Fri, 6 Jul 2001 22:09:45 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:52486 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S265648AbRGGCJb>;
	Fri, 6 Jul 2001 22:09:31 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15174.28411.880918.56634@tango.paulus.ozlabs.org>
Date: Sat, 7 Jul 2001 12:07:55 +1000 (EST)
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: [PATCH] fix compile error in imsttfb.c
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As it currently stands, drivers/video/imsttfb.c will give a compile
error if FBCON_HAS_CFB32 is defined.  This patch fixes that.

There used to be a declaration of `i' which was only used if
FBCON_HAS_CFB32 was defined.  I suspect that somebody was compiling
without FBCON_HAS_CFB32 and saw an unused variable warning from gcc
and decided to take out the declaration.  This patch will avoid that
warning.

Linus, please apply.

Paul.

diff -urN linux/drivers/video/imsttfb.c linuxppc_2_4/drivers/video/imsttfb.c
--- linux/drivers/video/imsttfb.c	Thu Jul  5 14:46:16 2001
+++ linuxppc_2_4/drivers/video/imsttfb.c	Thu Jul  5 10:58:09 2001
@@ -1278,10 +1278,11 @@
 				break;
 #endif
 #ifdef FBCON_HAS_CFB32
-			case 32:
-				i = (regno << 8) | regno;
+			case 32: {
+				int i = (regno << 8) | regno;
 				p->fbcon_cmap.cfb32[regno] = (i << 16) | i;
 				break;
+			}
 #endif
 		}
 
