Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264918AbUAJIsf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 03:48:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264919AbUAJIrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 03:47:18 -0500
Received: from smtp810.mail.sc5.yahoo.com ([66.163.170.80]:53384 "HELO
	smtp810.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264918AbUAJIrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 03:47:05 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Gunter =?iso-8859-1?q?K=F6nigsmann?= <gunter.koenigsmann@gmx.de>,
       Gunter =?iso-8859-1?q?K=F6nigsmann?= <gunter@peterpall.de>
Subject: Re: [PATCH 2/2] Psmouse log and discard timed out bytes
Date: Sat, 10 Jan 2004 03:46:03 -0500
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>,
       Andrew Morton <akpm@osdl.org>
References: <Pine.LNX.4.53.0401091101170.1050@calcula.uni-erlangen.de> <200401100344.03758.dtor_core@ameritech.net> <200401100345.17211.dtor_core@ameritech.net>
In-Reply-To: <200401100345.17211.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401100346.04660.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

===================================================================


ChangeSet@1.1513, 2004-01-10 02:52:04-05:00, dtor_core@ameritech.net
  Input: psmouse - if keyboard controller reports a timeout or a parity error
         do not try to process the byte, log the problem and drop it early.


 psmouse-base.c |    7 +++++++
 1 files changed, 7 insertions(+)


===================================================================



diff -Nru a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
--- a/drivers/input/mouse/psmouse-base.c	Sat Jan 10 03:23:08 2004
+++ b/drivers/input/mouse/psmouse-base.c	Sat Jan 10 03:23:08 2004
@@ -121,6 +121,13 @@
 	if (psmouse->state == PSMOUSE_IGNORE)
 		goto out;
 
+	if (flags & (SERIO_PARITY|SERIO_TIMEOUT)) {
+		printk(KERN_WARNING "psmouse.c: bad data from KBC -%s%s\n",
+			flags & SERIO_TIMEOUT ? " timeout" : "",
+			flags & SERIO_PARITY ? " bad parity" : "");
+		goto out;
+	}
+
 	if (psmouse->acking) {
 		switch (data) {
 			case PSMOUSE_RET_ACK:
