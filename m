Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262745AbTKIVed (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 16:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262746AbTKIVed
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 16:34:33 -0500
Received: from [212.86.245.254] ([212.86.245.254]:48257 "EHLO umka.bear.com.ua")
	by vger.kernel.org with ESMTP id S262745AbTKIVea (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 16:34:30 -0500
Content-Type: text/plain; charset=US-ASCII
From: Alex Lyashkov <shadow@itt.net.ru>
Organization: Home
To: Jan Kara <jack@suse.cz>
Subject: [BUG] journal handler reference count breaked and fs deadlocked
Date: Sun, 9 Nov 2003 23:34:00 +0200
User-Agent: KMail/1.4.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Herbert Poetzl <herbert@13thfloor.at>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200311092334.01957.shadow@itt.net.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All

I try locate what are point where fs deadlocked.
after recompile kernel with debug jbd and set debug level to 100 i log kernel 
via serial console
after deadlock - i see in log
==============
journal.c, 581): log_start_commit: JBD: requesting commit 501252/501251
(journal.c, 608): log_wait_commit: JBD: want 501252, j_commit_sequence=501251
(journal.c, 263): kjournald: kjournald wakes
(journal.c, 238): kjournald: commit_sequence=501251, commit_request=501252
(journal.c, 242): kjournald: OK, requests differ
(commit.c, 81): journal_commit_transaction: JBD: starting commit of 
transaction 501252
(commit.c, 87): journal_commit_transaction: wait updates.......
(transaction.c, 567): do_get_write_access: buffer_head c79f2e70, force_copy 0
(revoke.c, 375): journal_cancel_revoke: journal_head c79f2e70, cancelling 
revoke
(transaction.c, 567): do_get_write_access: buffer_head c79f2e70, force_copy 0
(revoke.c, 375): journal_cancel_revoke: journal_head c79f2e70, cancelling 
revoke
(transaction.c, 1104): journal_dirty_metadata: journal_head c79f2e70
(transaction.c, 1392): journal_stop: h_ref 2 -> 1
==============
i think it`s reason fs deadlocked, because wait query not be waked :-\
if i right - it very big problem on ext3..
other logs\infos can be created after request....


-- 
With best regards,
Alex
