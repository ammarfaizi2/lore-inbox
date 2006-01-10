Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932078AbWAJHUm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbWAJHUm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 02:20:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750995AbWAJHUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 02:20:10 -0500
Received: from smtp112.sbc.mail.re2.yahoo.com ([68.142.229.93]:6483 "HELO
	smtp112.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750988AbWAJHUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 02:20:07 -0500
Message-Id: <20060110071650.959796000.dtor_core@ameritech.net>
References: <20060110070945.912712000.dtor_core@ameritech.net>
Date: Tue, 10 Jan 2006 02:09:50 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, LKML <linux-kernel@vger.kernel.org>,
       Vernon Mauery <vernux@us.ibm.com>
Subject: [PATCH 5/5] ibmasm: fix input initialization error path
Content-Disposition: inline; filename=ibmasm-register-fix.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Input: ibmasm - fix input initialization error path

Do not try to free device that has already been unregistered,
input_unregister_device() frees it automatically.

Spotted by Vernon Mauery <vernux@us.ibm.com>

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/misc/ibmasm/remote.c |    1 +
 1 files changed, 1 insertion(+)

Index: work/drivers/misc/ibmasm/remote.c
===================================================================
--- work.orig/drivers/misc/ibmasm/remote.c
+++ work/drivers/misc/ibmasm/remote.c
@@ -270,6 +270,7 @@ int ibmasm_init_remote_input_dev(struct 
 
  err_unregister_mouse_dev:
 	input_unregister_device(mouse_dev);
+	mouse_dev = NULL; /* so we don't try to free it again below */
  err_free_devices:
 	input_free_device(mouse_dev);
 	input_free_device(keybd_dev);

