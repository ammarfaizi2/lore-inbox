Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129867AbRAABeH>; Sun, 31 Dec 2000 20:34:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131197AbRAABd5>; Sun, 31 Dec 2000 20:33:57 -0500
Received: from sith.mimuw.edu.pl ([193.0.97.1]:15373 "HELO sith.mimuw.edu.pl")
	by vger.kernel.org with SMTP id <S131179AbRAABdk>;
	Sun, 31 Dec 2000 20:33:40 -0500
Date: Mon, 1 Jan 2001 02:05:49 +0100
From: Jan Rekorajski <baggins@sith.mimuw.edu.pl>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] ATM LANE modular build
Message-ID: <20010101020549.A17412@sith.mimuw.edu.pl>
Mail-Followup-To: Jan Rekorajski <baggins@sith.mimuw.edu.pl>,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux 2.4.0-test10 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Due to latest Makefile changes ATM LANE won't build as module.
The following patch fixes it.

--- linux/net/atm/Makefile.orig	Sun Dec 31 17:57:15 2000
+++ linux/net/atm/Makefile	Sun Dec 31 19:04:49 2000
@@ -33,7 +33,13 @@
 obj-y += proc.o
 endif
 
-obj-$(CONFIG_ATM_LANE) += lec.o lane_mpoa_init.o
+ifneq ($(CONFIG_ATM_LANE),n)
+ifneq ($(CONFIG_ATM_LANE),)
+obj-y += lane_mpoa_init.o
+endif
+endif
+
+obj-$(CONFIG_ATM_LANE) += lec.o
 obj-$(CONFIG_ATM_MPOA) += mpoa.o
 
 include $(TOPDIR)/Rules.make

Jan
-- 
Jan Rêkorajski            |  ALL SUSPECTS ARE GUILTY. PERIOD!
baggins<at>mimuw.edu.pl   |  OTHERWISE THEY WOULDN'T BE SUSPECTS, WOULD THEY?
BOFH, MANIAC              |                   -- TROOPS by Kevin Rubio
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
