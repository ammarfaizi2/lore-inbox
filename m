Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264238AbTLYJie (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 04:38:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264241AbTLYJie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 04:38:34 -0500
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:43955 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264238AbTLYJic (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 04:38:32 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Andrew Morton <akpm@osdl.org>, GCS <gcs@lsc.hu>
Subject: Re: 2.6.0-mm1 - Patch 2/2 - mousedev-dont-stop
Date: Thu, 25 Dec 2003 04:14:57 -0500
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, Peter Osterlund <petero2@telia.com>
References: <20031224095921.GA8147@lsc.hu> <200312250411.55881.dtor_core@ameritech.net> <200312250413.32822.dtor_core@ameritech.net>
In-Reply-To: <200312250413.32822.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312250414.58598.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

===================================================================


ChangeSet@1.1525, 2003-12-25 03:56:28-05:00, dtor_core@ameritech.net
  Input: correctly perform PS/2 (mousedev) emulation for touchpads
         generating absolute events (do not stop with the first
         client)


 mousedev.c |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)


===================================================================



diff -Nru a/drivers/input/mousedev.c b/drivers/input/mousedev.c
--- a/drivers/input/mousedev.c	Thu Dec 25 03:57:50 2003
+++ b/drivers/input/mousedev.c	Thu Dec 25 03:57:50 2003
@@ -148,14 +148,16 @@
 					break;
 
 				case EV_KEY:
+					if (code == BTN_TOUCH && test_bit(BTN_TOOL_FINGER, handle->dev->keybit)) {
+						/* Handle touchpad data */
+						list->touch = value;
+						if (!list->touch)
+							list->pkt_count = 0;
+						break;
+					}
+
 					switch (code) {
-						case BTN_TOUCH: /* Handle touchpad data */
-							if (test_bit(BTN_TOOL_FINGER, handle->dev->keybit)) {
-								list->touch = value;
-								if (!list->touch)
-									list->pkt_count = 0;
-								return;
-							}
+						case BTN_TOUCH:
 						case BTN_0:
 						case BTN_FORWARD:
 						case BTN_LEFT:   index = 0; break;
