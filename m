Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263057AbTKJJJk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 04:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263077AbTKJJJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 04:09:40 -0500
Received: from nagatino-gw.corbina.net ([195.14.53.90]:41979 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S263057AbTKJJJi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 04:09:38 -0500
Date: Mon, 10 Nov 2003 12:12:25 +0300
From: Alex Tomas <bzzz@bzzz.linuxhacker.ru>
To: Alex Lyashkov <shadow@itt.net.ru>
Cc: Jan Kara <jack@suse.cz>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Herbert Poetzl <herbert@13thfloor.at>
Subject: Re: [BUG] journal handler reference count breaked and fs deadlocked
Message-Id: <20031110121225.19daf448.bzzz@bzzz.linuxhacker.ru>
In-Reply-To: <200311092334.01957.shadow@itt.net.ru>
References: <200311092334.01957.shadow@itt.net.ru>
Organization: HOME
X-Mailer: Sylpheed version 0.9.6claws (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

what system did that time? mount options?

On Sun, 9 Nov 2003 23:34:00 +0200
Alex Lyashkov <shadow@itt.net.ru> wrote:

> Hello All
> 
> I try locate what are point where fs deadlocked.
> after recompile kernel with debug jbd and set debug level to 100 i log kernel 
> via serial console
> after deadlock - i see in log
> ==============
> journal.c, 581): log_start_commit: JBD: requesting commit 501252/501251
> (journal.c, 608): log_wait_commit: JBD: want 501252, j_commit_sequence=501251
> (journal.c, 263): kjournald: kjournald wakes
> (journal.c, 238): kjournald: commit_sequence=501251, commit_request=501252
> (journal.c, 242): kjournald: OK, requests differ
> (commit.c, 81): journal_commit_transaction: JBD: starting commit of 
> transaction 501252
> (commit.c, 87): journal_commit_transaction: wait updates.......
> (transaction.c, 567): do_get_write_access: buffer_head c79f2e70, force_copy 0
> (revoke.c, 375): journal_cancel_revoke: journal_head c79f2e70, cancelling 
> revoke
> (transaction.c, 567): do_get_write_access: buffer_head c79f2e70, force_copy 0
> (revoke.c, 375): journal_cancel_revoke: journal_head c79f2e70, cancelling 
> revoke
> (transaction.c, 1104): journal_dirty_metadata: journal_head c79f2e70
> (transaction.c, 1392): journal_stop: h_ref 2 -> 1
> ==============
> i think it`s reason fs deadlocked, because wait query not be waked :-\
> if i right - it very big problem on ext3..
> other logs\infos can be created after request....
> 
> 
> -- 
> With best regards,
> Alex
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
