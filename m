Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262827AbUACJHP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 04:07:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265941AbUACJGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 04:06:21 -0500
Received: from smtp811.mail.sc5.yahoo.com ([66.163.170.81]:51283 "HELO
	smtp811.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265942AbUACJEb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 04:04:31 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH 7/7] SiS AUX port
Date: Sat, 3 Jan 2004 04:03:44 -0500
User-Agent: KMail/1.5.4
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200401030350.43437.dtor_core@ameritech.net> <200401030402.16745.dtor_core@ameritech.net> <200401030403.03783.dtor_core@ameritech.net>
In-Reply-To: <200401030403.03783.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401030403.45760.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

===================================================================


ChangeSet@1.1577, 2004-01-03 02:54:28-05:00, dtor_core@ameritech.net
  Input: Do not ignore AUX port if chipset fails to disable it
         (SiS seems to have trouble disabling AUX port, other
          than that the port works fine).


 i8042.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)


===================================================================



diff -Nru a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
--- a/drivers/input/serio/i8042.c	Sat Jan  3 03:10:31 2004
+++ b/drivers/input/serio/i8042.c	Sat Jan  3 03:10:31 2004
@@ -598,8 +598,10 @@
 	
 	if (i8042_command(&param, I8042_CMD_AUX_DISABLE))
 		return -1;
-	if (i8042_command(&param, I8042_CMD_CTL_RCTR) || (~param & I8042_CTR_AUXDIS))
-		return -1;	
+	if (i8042_command(&param, I8042_CMD_CTL_RCTR) || (~param & I8042_CTR_AUXDIS)) {
+		printk(KERN_WARNING "Failed to disable AUX port, but continuing anyway... Is this a SiS?\n");
+		printk(KERN_WARNING "If AUX port is really absent please use the 'i8042.noaux' option.\n");
+	}
 
 	if (i8042_command(&param, I8042_CMD_AUX_ENABLE))
 		return -1;
