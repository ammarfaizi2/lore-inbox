Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263468AbTECXdC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 19:33:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263473AbTECXb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 19:31:57 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:59915 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP id S263477AbTECXbp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 19:31:45 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10520054473225@movementarian.org>
Subject: [PATCH 6/8] OProfile update
In-Reply-To: <10520054473909@movementarian.org>
From: John Levon <levon@movementarian.org>
X-Mailer: gregkh_patchbomb
Date: Sun, 4 May 2003 00:44:07 +0100
Content-Transfer-Encoding: 7BIT
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
X-Spam-Score: -6.3 (------)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19C6fn-000JiP-Ng*SAwl7j304SE*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We were doing del_timer_sync() on shutdown, but not ensuring that any queued work
was done as well.

diff -Naur -X dontdiff linux-cvs/drivers/oprofile/buffer_sync.c linux-me/drivers/oprofile/buffer_sync.c
--- linux-cvs/drivers/oprofile/buffer_sync.c	2003-04-05 18:44:49.000000000 +0100
+++ linux-me/drivers/oprofile/buffer_sync.c	2003-05-03 20:10:44.000000000 +0100
@@ -147,6 +170,8 @@
 	profile_event_unregister(EXIT_MMAP, &exit_mmap_nb);
 	profile_event_unregister(EXEC_UNMAP, &exec_unmap_nb);
 	del_timer_sync(&sync_timer);
+	/* timer might have queued work, make sure it's completed. */
+	flush_scheduled_work();
 }
 
  

