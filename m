Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262351AbUEKG3S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262351AbUEKG3S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 02:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262398AbUEKG2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 02:28:18 -0400
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:34424 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262351AbUEKGZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 02:25:09 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 8/9] New set of input patches - 13-i8042-unload.patch
Date: Tue, 11 May 2004 01:10:57 -0500
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200405110101.42805.dtor_core@ameritech.net> <200405110109.11506.dtor_core@ameritech.net> <200405110110.09376.dtor_core@ameritech.net>
In-Reply-To: <200405110110.09376.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200405110111.03332.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1587.20.14, 2004-05-10 01:40:59-05:00, dtor_core@ameritech.net
  Patch from Sau Dan Lee
  Input: i8042 - kill the timer only after removing interrupt handler,
         otherwise there is a chance that interrupt handler will install
         the timer again and it will trigger after module is unloaded.


 i8042.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)


===================================================================



diff -Nru a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
--- a/drivers/input/serio/i8042.c	Tue May 11 00:58:55 2004
+++ b/drivers/input/serio/i8042.c	Tue May 11 00:58:55 2004
@@ -1047,8 +1047,6 @@
 		sysdev_class_unregister(&kbc_sysclass);
 	}
 
-	del_timer_sync(&i8042_timer);
-
 	i8042_controller_cleanup();
 
 	if (i8042_kbd_values.exists)
@@ -1061,6 +1059,7 @@
 		if (i8042_mux_values[i].exists)
 			serio_unregister_port(i8042_mux_port + i);
 
+	del_timer_sync(&i8042_timer);
 	tasklet_kill(&i8042_tasklet);
 
 	i8042_platform_exit();
