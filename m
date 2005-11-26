Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbVKZSGv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbVKZSGv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 13:06:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750708AbVKZSGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 13:06:51 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:30437 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1750702AbVKZSGu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 13:06:50 -0500
Message-ID: <4388B5AA.34CE5294@tv-sign.ru>
Date: Sat, 26 Nov 2005 22:21:14 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/2] PF_DEAD: cleanup usage
References: <4385E3FF.C99DBCF5@tv-sign.ru> <20051125051232.GB22230@elte.hu>
	 <Pine.LNX.4.64.0511250950450.13959@g5.osdl.org> <43883D01.8CCB31A6@tv-sign.ru> <Pine.LNX.4.64.0511260949030.13959@g5.osdl.org>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> > So in my opinion PF_DEAD has already slipped into the ->state partly.
> 
> You mis-understand.

Yes.

Ok, I see you point now, thanks.

Oleg.

> PF_DEAD has _always_ been about the task state, in a very serious way. It
> didn't "slip into" it. It always was very much about it.
> 
> The problem is that we touch "task->state" in a _lot_ of places: for
> example, when we take a page fault, we have to clear it, because we can't
> just run with some random task state (see top of __handle_mm_fault).
> 
> PF_DEAD was a "safe haven". It's somewhere that we _don't_ modify the word
> in many places, so it doesn't get lost, and we can do sanity checking (ie
> we can have things like "BUG_ON(tsk->flags & PF_DEAD)" to make sure that
> the task really is valid in a few places.
> 
> Now, arguably the task struct handling is solid enough that maybe we don't
> need this any more. But this is what it was all about: it was hidden away
> in a non-obvious place exactly _because_ we wanted it hidden away
> somewhere where the normal ops wouldn't ever touch it.
> 
>                         Linus
