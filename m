Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314138AbSEXFqo>; Fri, 24 May 2002 01:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317088AbSEXFqn>; Fri, 24 May 2002 01:46:43 -0400
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:16883 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S314138AbSEXFqm>; Fri, 24 May 2002 01:46:42 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15597.54208.157130.609749@wombat.chubb.wattle.id.au>
Date: Fri, 24 May 2002 15:46:40 +1000
To: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: Fix compilation warning in do_mounts.c
X-Mailer: VM 7.03 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
X-Face: .slVUC18R`%{j(W3ztQe~*ATzet;h`*Wv33MZ]*M,}9AP<`+C=U)c#NzI5vK!0^d#6:<_`a
 {#.<}~(T^aJ~]-.C'p~saJ7qZXP-$AY==]7,9?WVSH5sQ}g3,8j>u%@f$/Z6,WR7*E~BFY.Yjw,H6<
 F.cEDj2$S:kO2+-5<]afj@kC!:uw\(<>lVpk)lPZs+2(=?=D/TZPG+P9LDN#1RRUPxdX
Comments: Hyperbole mail buttons accepted, v04.18.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
	change_floppy() is unused if you don't have the floppy device
compiled into the kernel --- so why not #ifdef it out?

===== init/do_mounts.c 1.14 vs edited =====
--- 1.14/init/do_mounts.c	Mon May  6 02:35:44 2002
+++ edited/init/do_mounts.c	Fri May 24 15:46:28 2002
@@ -364,6 +364,7 @@
 	return sys_symlink(path + n + 5, name);
 }
 
+#if defined(BLOCK_DEV_RAM) || defined(CONFIG_BLK_DEV_FD)
 static void __init change_floppy(char *fmt, ...)
 {
 	struct termios termios;
@@ -391,6 +392,7 @@
 		close(fd);
 	}
 }
+#endif
 
 #ifdef CONFIG_BLK_DEV_RAM
 
