Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262765AbTLNWRv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 17:17:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262776AbTLNWRv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 17:17:51 -0500
Received: from mx1.elte.hu ([157.181.1.137]:21134 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262765AbTLNWRu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 17:17:50 -0500
Date: Sun, 14 Dec 2003 23:17:02 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>, Roland McGrath <roland@redhat.com>
Subject: Re: [patch] Re: Problem with exiting threads under NPTL
In-Reply-To: <Pine.LNX.4.58.0312141353220.1586@home.osdl.org>
Message-ID: <Pine.LNX.4.58.0312142314200.14841@earth>
References: <20031214052516.GA313@vana.vc.cvut.cz> <Pine.LNX.4.58.0312142032310.9900@earth>
 <Pine.LNX.4.58.0312141228170.1478@home.osdl.org> <Pine.LNX.4.58.0312142205050.13533@earth>
 <Pine.LNX.4.58.0312141353220.1586@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-ELTE-SpamVersion: SpamAssassin ELTE 1.0
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 14 Dec 2003, Linus Torvalds wrote:

> Even though the parent ignores SIGCHLD it _can_ be running on another
> CPU in "wait4()". And since we drop the tasklist lock before we do the
> "release_task()" on the leader, and since the leader is still marked
> TASK_ZOMBIE, we may have _two_ different people trying to release it.
> First the parent, and then the last thread that still remembers the
> leader.

are you sure this can happen? eligible_child() does this:

        if (p->exit_signal == -1 && !p->ptrace)
                return 0;

so can the parallel situation really happen?

	Ingo
