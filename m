Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130998AbRABMKB>; Tue, 2 Jan 2001 07:10:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129962AbRABMJw>; Tue, 2 Jan 2001 07:09:52 -0500
Received: from sith.mimuw.edu.pl ([193.0.97.1]:33028 "HELO sith.mimuw.edu.pl")
	by vger.kernel.org with SMTP id <S129859AbRABMJ3>;
	Tue, 2 Jan 2001 07:09:29 -0500
Date: Tue, 2 Jan 2001 12:41:42 +0100
From: Jan Rekorajski <baggins@sith.mimuw.edu.pl>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Makefile fix for FORE 200e and a typo in lec.c
Message-ID: <20010102124142.A2640@sith.mimuw.edu.pl>
Mail-Followup-To: Jan Rekorajski <baggins@sith.mimuw.edu.pl>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux 2.4.0-prerelease i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
The Fore dirver in 2.4.0-prerelease just does not build
with the current makefile. This patch fixes it (works for me):

--- linux/drivers/atm/Makefile.orig	Tue Jan  2 10:18:25 2001
+++ linux/drivers/atm/Makefile	Tue Jan  2 12:00:05 2001
@@ -46,7 +46,7 @@
   endif
 endif
 
-obj-$(CONFIG_ATM_FORE200E) += fore200e.o $(FORE200E_FW_OBJS)
+obj-$(CONFIG_ATM_FORE200E) += fore_200e.o
 
 include $(TOPDIR)/Rules.make


Second thing, there is a typo in net/atm/lec.c:

--- linux/net/atm/lec.c.orig	Sat Dec 30 20:19:13 2000
+++ linux/net/atm/lec.c	Tue Jan  2 12:06:34 2001
@@ -857,7 +857,7 @@
         for (i = 0; i < MAX_LEC_ITF; i++) {
                 if (dev_lec[i] != NULL) {
                         priv = (struct lec_priv *)dev_lec[i]->priv;
-                        unregister_trdev(dev_lec[i]);
+                        unregister_netdev(dev_lec[i]);
                         kfree(dev_lec[i]);
                         dev_lec[i] = NULL;
                 }

And, just in case you missed it, modular LEC fix:

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
