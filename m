Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262519AbUKXHei@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262519AbUKXHei (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 02:34:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262333AbUKXHdf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 02:33:35 -0500
Received: from smtp810.mail.sc5.yahoo.com ([66.163.170.80]:16233 "HELO
	smtp810.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262486AbUKXHVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 02:21:39 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 8/11] atkbd: use msecs_to_jiffies
Date: Wed, 24 Nov 2004 02:10:46 -0500
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200411240205.10502.dtor_core@ameritech.net> <200411240209.49593.dtor_core@ameritech.net> <200411240210.21043.dtor_core@ameritech.net>
In-Reply-To: <200411240210.21043.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200411240210.49162.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1963, 2004-11-24 00:47:02-05:00, dtor_core@ameritech.net
  Input: use msecs_to_jiffies instead of manually calculating
         delay for Toshiba bouncing keys workaround to the code
         works with HZ != 1000.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 atkbd.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


===================================================================



diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	2004-11-24 01:53:21 -05:00
+++ b/drivers/input/keyboard/atkbd.c	2004-11-24 01:53:21 -05:00
@@ -378,7 +378,7 @@
 					break;
 				case 1:
 					atkbd->last = code;
-					atkbd->time = jiffies + (atkbd->dev.rep[REP_DELAY] * HZ + 500) / 1000 / 2;
+					atkbd->time = jiffies + msecs_to_jiffies(atkbd->dev.rep[REP_DELAY]) / 2;
 					break;
 				case 2:
 					if (!time_after(jiffies, atkbd->time) && atkbd->last == code)
