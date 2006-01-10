Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932083AbWAJHta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbWAJHta (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 02:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932084AbWAJHta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 02:49:30 -0500
Received: from smtp103.sbc.mail.re2.yahoo.com ([68.142.229.102]:24478 "HELO
	smtp103.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932083AbWAJHta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 02:49:30 -0500
Message-Id: <20060110071650.730847000.dtor_core@ameritech.net>
References: <20060110070945.912712000.dtor_core@ameritech.net>
Date: Tue, 10 Jan 2006 02:09:48 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, LKML <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>
Subject: [PATCH 3/5] Input core: prepare for fops constness
Content-Disposition: inline; filename=input-fops.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arjan van de Ven <arjan@infradead.org>

Input: prepare for f_ops constness

Avoid doing assignments to a live ->fops so it can be marked as 'const'.

Signed-off-by: Arjan van de Ven <arjan@infradead.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/input.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: work/drivers/input/input.c
===================================================================
--- work.orig/drivers/input/input.c
+++ work/drivers/input/input.c
@@ -477,8 +477,8 @@ static int __init input_proc_init(void)
 
 	entry->owner = THIS_MODULE;
 	input_fileops = *entry->proc_fops;
+	input_fileops.poll = input_devices_poll;
 	entry->proc_fops = &input_fileops;
-	entry->proc_fops->poll = input_devices_poll;
 
 	entry = create_proc_read_entry("handlers", 0, proc_bus_input_dir, input_handlers_read, NULL);
 	if (!entry)

