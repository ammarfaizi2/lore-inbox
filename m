Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271802AbTGROLe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 10:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271752AbTGROJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 10:09:20 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:27013
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S271761AbTGROIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 10:08:31 -0400
Date: Fri, 18 Jul 2003 15:22:50 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307181422.h6IEMofO017788@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: restore console log level when jbd raises it
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(Vita Samel)

maybe the set function should return the old value instead ?

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test1/fs/jbd/transaction.c linux-2.6.0-test1-ac2/fs/jbd/transaction.c
--- linux-2.6.0-test1/fs/jbd/transaction.c	2003-07-14 14:11:56.000000000 +0100
+++ linux-2.6.0-test1-ac2/fs/jbd/transaction.c	2003-07-15 17:29:25.000000000 +0100
@@ -1088,6 +1088,7 @@
 	transaction_t *transaction = handle->h_transaction;
 	journal_t *journal = transaction->t_journal;
 	struct journal_head *jh = bh2jh(bh);
+	int console_loglevel_saved = console_loglevel;
 
 	jbd_debug(5, "journal_head %p\n", jh);
 	JBUFFER_TRACE(jh, "entry");
@@ -1156,6 +1157,7 @@
 	jbd_unlock_bh_state(bh);
 out:
 	JBUFFER_TRACE(jh, "exit");
+	console_loglevel = console_loglevel_saved;
 	return 0;
 }
 
