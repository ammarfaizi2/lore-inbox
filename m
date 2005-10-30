Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932449AbVJ3AnJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932449AbVJ3AnJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 20:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932505AbVJ3AnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 20:43:08 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:11786 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932404AbVJ3AnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 20:43:06 -0400
Date: Sun, 30 Oct 2005 02:43:04 +0200
From: Adrian Bunk <bunk@stusta.de>
To: kkeil@suse.de, kai.germaschewski@gmx.de
Cc: isdn4linux@listserv.isdn4linux.de, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/isdn/: "extern inline" -> "static inline"
Message-ID: <20051030004304.GQ4180@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"extern inline" doesn't make much sense.

Since there's no pullphone() function this patch removes the dead 
prototype.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/isdn/act2000/act2000.h |    6 +++---
 drivers/isdn/act2000/capi.h    |    2 +-
 drivers/isdn/sc/command.c      |    1 -
 3 files changed, 4 insertions(+), 5 deletions(-)

--- linux-2.6.14-rc5-mm1-full/drivers/isdn/act2000/act2000.h.old	2005-10-30 02:06:09.000000000 +0200
+++ linux-2.6.14-rc5-mm1-full/drivers/isdn/act2000/act2000.h	2005-10-30 02:06:19.000000000 +0200
@@ -181,17 +181,17 @@
 	char regname[35];		/* Name used for request_region     */
 } act2000_card;
 
-extern __inline__ void act2000_schedule_tx(act2000_card *card)
+static inline void act2000_schedule_tx(act2000_card *card)
 {
         schedule_work(&card->snd_tq);
 }
 
-extern __inline__ void act2000_schedule_rx(act2000_card *card)
+static inline void act2000_schedule_rx(act2000_card *card)
 {
         schedule_work(&card->rcv_tq);
 }
 
-extern __inline__ void act2000_schedule_poll(act2000_card *card)
+static inline void act2000_schedule_poll(act2000_card *card)
 {
         schedule_work(&card->poll_tq);
 }
--- linux-2.6.14-rc5-mm1-full/drivers/isdn/act2000/capi.h.old	2005-10-30 02:06:26.000000000 +0200
+++ linux-2.6.14-rc5-mm1-full/drivers/isdn/act2000/capi.h	2005-10-30 02:06:31.000000000 +0200
@@ -330,7 +330,7 @@
 	} msg;
 } actcapi_msg;
 
-extern __inline__ unsigned short
+static inline unsigned short
 actcapi_nextsmsg(act2000_card *card)
 {
 	unsigned long flags;
--- linux-2.6.14-rc5-mm1-full/drivers/isdn/sc/command.c.old	2005-10-30 02:06:39.000000000 +0200
+++ linux-2.6.14-rc5-mm1-full/drivers/isdn/sc/command.c	2005-10-30 02:07:01.000000000 +0200
@@ -43,7 +43,6 @@
                 RspMessage *, int);
 extern int sendmessage(int, unsigned int, unsigned int, unsigned int,
                 unsigned int, unsigned int, unsigned int, unsigned int *);
-extern inline void pullphone(char *, char *);
 
 #ifdef DEBUG
 /*
