Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264719AbUFGNVe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264719AbUFGNVe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 09:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264609AbUFGMTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 08:19:25 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:16001 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S264633AbUFGL4g convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 07:56:36 -0400
To: torvalds@osdl.org, akpm@osdl.org, vojtech@ucw.cz,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
Message-Id: <10866093542233@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <10866093543861@twilight.ucw.cz>
Mime-Version: 1.0
Date: Mon, 7 Jun 2004 13:55:54 +0200
Subject: [PATCH 34/39] input: i8042 - kill the timer only after removing interrupt handler
X-Mailer: gregkh_patchbomb_levon_offspring
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input-for-linus

===================================================================

ChangeSet@1.1587.27.14, 2004-05-10 01:40:59-05:00, dtor_core@ameritech.net
  Patch from Sau Dan Lee
  Input: i8042 - kill the timer only after removing interrupt handler,
         otherwise there is a chance that interrupt handler will install
         the timer again and it will trigger after module is unloaded.


 i8042.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

===================================================================

diff -Nru a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
--- a/drivers/input/serio/i8042.c	2004-06-07 13:10:43 +02:00
+++ b/drivers/input/serio/i8042.c	2004-06-07 13:10:43 +02:00
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

