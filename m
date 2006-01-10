Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932096AbWAJK5v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbWAJK5v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 05:57:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbWAJK5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 05:57:51 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:26815 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932096AbWAJK5v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 05:57:51 -0500
Date: Tue, 10 Jan 2006 11:58:02 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Reuben Farrelly <reuben-lkml@reub.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-mm2
Message-ID: <20060110105802.GA2785@elte.hu>
References: <20060107052221.61d0b600.akpm@osdl.org> <43BFD8C1.9030404@reub.net> <20060107133103.530eb889.akpm@osdl.org> <43C38932.7070302@reub.net> <20060110104759.GA30546@elte.hu> <20060110105249.GA1528@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060110105249.GA1528@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


an additional patch you could apply is the one below - but it doubt it 
makes a difference.

	Ingo

--
add might_sleep() to the mutex_lock slowpath.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

----

 kernel/mutex.c |    1 +
 1 files changed, 1 insertion(+)

Index: linux/kernel/mutex.c
===================================================================
--- linux.orig/kernel/mutex.c
+++ linux/kernel/mutex.c
@@ -133,6 +133,7 @@ __mutex_lock_common(struct mutex *lock, 
 	struct mutex_waiter waiter;
 	unsigned int old_val;
 
+	might_sleep();
 	debug_mutex_init_waiter(&waiter);
 
 	spin_lock_mutex(&lock->wait_lock);
