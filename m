Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261840AbTJMSMV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 14:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261844AbTJMSMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 14:12:21 -0400
Received: from imladris.surriel.com ([66.92.77.98]:12487 "EHLO
	imladris.surriel.com") by vger.kernel.org with ESMTP
	id S261840AbTJMSMU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 14:12:20 -0400
Date: Mon, 13 Oct 2003 14:12:07 -0400 (EDT)
From: Rik van Riel <riel@surriel.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH][TRIVIAL] proc_tty_unregister_driver fix
Message-ID: <Pine.LNX.4.55L.0310131410020.27244@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure to unregister the driver with the same name it
was registered with.  Apparently some drivers like to change
driver->driver_name between the procfs registration and the
unregistration, fixes RH bug #49426

diff -urNp linux-5110/fs/proc/proc_tty.c linux-10010/fs/proc/proc_tty.c
--- linux-5110/fs/proc/proc_tty.c	2000-04-22 00:17:57.000000000 +0200
+++ linux-10010/fs/proc/proc_tty.c
@@ -161,7 +161,7 @@ void proc_tty_unregister_driver(struct t
 	if (!ent)
 		return;

-	remove_proc_entry(driver->driver_name, proc_tty_driver);
+	remove_proc_entry(ent->name, proc_tty_driver);

 	driver->proc_entry = 0;
 }
