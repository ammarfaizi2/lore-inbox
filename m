Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273214AbSISV2g>; Thu, 19 Sep 2002 17:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273392AbSISV2A>; Thu, 19 Sep 2002 17:28:00 -0400
Received: from mx2.elte.hu ([157.181.151.9]:43430 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S273214AbSISV1J>;
	Thu, 19 Sep 2002 17:27:09 -0400
Date: Thu, 19 Sep 2002 23:39:36 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: William Lee Irwin III <wli@holomorphy.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] generic-pidhash-2.5.36-J2, BK-curr
In-Reply-To: <Pine.LNX.4.33.0209191429410.1360-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.44.0209192337240.17366-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 19 Sep 2002, Linus Torvalds wrote:

> I'm also applying the session handling changes to tty_io.c as a separate
> changeset, since the resulting code is certainly cleaner and reading
> peoples areguments and looking at the code have made me think it _is_
> correct after all.

yes, i too think it's correct. In fact this is partly proven by one piece
of code in the old tty_io.c file:

void disassociate_ctty(int on_exit)
[...]
        read_lock(&tasklist_lock);
        for_each_process(p)
                if (p->session == current->session)
                        p->tty = NULL;
        read_unlock(&tasklist_lock);

ie. if the SID-based iteration is incorrect, then the above code is 
incorrect already - but we never saw any problems in this area.

	Ingo

