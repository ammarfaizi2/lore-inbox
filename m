Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261500AbUL2Hnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbUL2Hnl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 02:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261496AbUL2Hmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 02:42:55 -0500
Received: from smtp802.mail.sc5.yahoo.com ([66.163.168.181]:20655 "HELO
	smtp802.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261431AbUL2Hda (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 02:33:30 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 12/16] Use msecs_to_jiffies in atkbd
Date: Wed, 29 Dec 2004 02:28:40 -0500
User-Agent: KMail/1.6.2
Cc: linux-input@atrey.karlin.mff.cuni.cz, LKML <linux-kernel@vger.kernel.org>
References: <200412290217.36282.dtor_core@ameritech.net> <200412290227.39294.dtor_core@ameritech.net> <200412290228.14155.dtor_core@ameritech.net>
In-Reply-To: <200412290228.14155.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200412290228.41619.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1972, 2004-12-28 00:47:30-05:00, dtor_core@ameritech.net
  Input: use msecs_to_jiffies instead of manually calculating
         delay for Toshiba bouncing keys workaround to the code
         works with HZ != 1000.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 atkbd.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


===================================================================



diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	2004-12-29 01:51:48 -05:00
+++ b/drivers/input/keyboard/atkbd.c	2004-12-29 01:51:48 -05:00
@@ -378,7 +378,7 @@
 					break;
 				case 1:
 					atkbd->last = code;
-					atkbd->time = jiffies + (atkbd->dev.rep[REP_DELAY] * HZ + 500) / 1000 / 2;
+					atkbd->time = jiffies + msecs_to_jiffies(atkbd->dev.rep[REP_DELAY]) / 2;
 					break;
 				case 2:
 					if (!time_after(jiffies, atkbd->time) && atkbd->last == code)
