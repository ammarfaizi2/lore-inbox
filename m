Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268115AbUJJEwr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268115AbUJJEwr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 00:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268120AbUJJEwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 00:52:47 -0400
Received: from smtp801.mail.sc5.yahoo.com ([66.163.168.180]:10613 "HELO
	smtp801.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268115AbUJJEwn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 00:52:43 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [OOPS+PATCH 2.6] Fix oops in parkbd
Date: Sat, 9 Oct 2004 23:52:38 -0500
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, Vojtech Pavlik <vojtech@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200410092352.39785.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When converting to dynamic serio allocation I messed up parkbd
causing it to Oops when registering its serio port.

-- 
Dmitry


===================================================================


ChangeSet@1.1961, 2004-10-09 08:09:54-05:00, dtor_core@ameritech.net
  Input: parkbd - zero-fill allocated serio structure to
         prevent Oops when registering port.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 parkbd.c |    1 +
 1 files changed, 1 insertion(+)


===================================================================



diff -Nru a/drivers/input/serio/parkbd.c b/drivers/input/serio/parkbd.c
--- a/drivers/input/serio/parkbd.c	2004-10-09 23:49:06 -05:00
+++ b/drivers/input/serio/parkbd.c	2004-10-09 23:49:06 -05:00
@@ -160,6 +160,7 @@
 
 	serio = kmalloc(sizeof(struct serio), GFP_KERNEL);
 	if (serio) {
+		memset(serio, 0, sizeof(struct serio));
 		serio->type = parkbd_mode;
 		serio->write = parkbd_write,
 		strlcpy(serio->name, "PARKBD AT/XT keyboard adapter", sizeof(serio->name));
