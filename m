Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270677AbTGNONH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 10:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270671AbTGNONB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 10:13:01 -0400
Received: from proxy.povodiodry.cz ([62.77.115.11]:40628 "HELO pc11.op.pod.cz")
	by vger.kernel.org with SMTP id S270677AbTGNOMd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 10:12:33 -0400
From: "Vitezslav Samel" <samel@mail.cz>
Date: Mon, 14 Jul 2003 16:27:19 +0200
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: [JBD] [PATCH] don't print all kernel messages to console
Message-ID: <20030714142719.GA8431@pc11.op.pod.cz>
Mail-Followup-To: Andrew Morton <akpm@digeo.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi!

   Starting with 2.5.73 kernel spits all messages also to console. Problem is
in fs/jbd/transaction.c:journal_dirty_metadata(). There is call to
console_verbose() but current state of console logging is not saved. To fix
this you can remove offending call or apply attached patch. Please, forward
either solution to the Linus' tree.

	Cheers,
		Vita Samel


diff -urN clean-2.6.0-test1/fs/jbd/transaction.c linux-2.6.0-test1/fs/jbd/transaction.c
--- clean-2.6.0-test1/fs/jbd/transaction.c	Mon Jul 14 13:52:46 2003
+++ linux-2.6.0-test1/fs/jbd/transaction.c	Mon Jul 14 13:56:18 2003
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
 
