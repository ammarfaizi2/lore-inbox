Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277112AbRJDET0>; Thu, 4 Oct 2001 00:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277107AbRJDETK>; Thu, 4 Oct 2001 00:19:10 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:55826 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S277112AbRJDESz>; Thu, 4 Oct 2001 00:18:55 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Linus Torvalds <torvalds@transmeta.com>
Date: Thu, 4 Oct 2001 14:19:13 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15291.58177.900493.276071@notabene.cse.unsw.edu.au>
cc: linux-kernel@vger.kernel.org
Subject: PATCH - gameport_{,un}register_port must be static when inline
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,
 2.4.11-pre2 wont compile with some combinations of sound card drivers
 if CONFIG_INPUT_GAMEPORT is not defined, as every driver than include
 gameport.h causes "gameport_register_port" to be defined as a symbol
 and there is a conflict.

 This patch makes the relevant inline functions "static" to avoid this
 problem.

NeilBrown


--- ./include/linux/gameport.h	2001/10/04 02:45:24	1.1
+++ ./include/linux/gameport.h	2001/10/04 03:51:09	1.2
@@ -74,8 +74,8 @@
 void gameport_register_port(struct gameport *gameport);
 void gameport_unregister_port(struct gameport *gameport);
 #else
-void __inline__ gameport_register_port(struct gameport *gameport) { return; }
-void __inline__ gameport_unregister_port(struct gameport *gameport) { return; }
+static void __inline__ gameport_register_port(struct gameport *gameport) { return; }
+static void __inline__ gameport_unregister_port(struct gameport *gameport) { return; }
 #endif
 
 void gameport_register_device(struct gameport_dev *dev);
