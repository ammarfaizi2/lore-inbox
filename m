Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318880AbSIIS6q>; Mon, 9 Sep 2002 14:58:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318887AbSIIS6q>; Mon, 9 Sep 2002 14:58:46 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:4279 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S318880AbSIIS6p>; Mon, 9 Sep 2002 14:58:45 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: <imran.badr@cavium.com>, "'Andrew Morton'" <akpm@digeo.com>
Subject: Re: Calculating kernel logical address ..
Date: Mon, 9 Sep 2002 21:06:18 +0200
X-Mailer: KMail [version 1.3.2]
Cc: <root@chaos.analogic.com>, "'David S. Miller'" <davem@redhat.com>,
       <linux-kernel@vger.kernel.org>
References: <01a801c25831$913c5fd0$9e10a8c0@IMRANPC>
In-Reply-To: <01a801c25831$913c5fd0$9e10a8c0@IMRANPC>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020909190328Z16576-16323+113@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 September 2002 20:49, Imran Badr wrote:
> > You can obtain this info by walking the user's pagetables with
> > get_user_pages().  That give `struct page' pointers, with which
> > all things are possible.
> 
> >As long as you can be sure they won't spontaneously vanish on you.
> 
> >--
> >Daniel
> >-
> >To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >Please read the FAQ at  http://www.tux.org/lkml/
> 
> down(&current->mm->mmap_sem) would help.

Not for anon pages, and how do you know whether it's anon or not before
looking at the page, which may be free by the time you look at it?
In other words, mm->page_table_lock is the one, because it's required
for unmapping a pte, and any mapped page will be forced to hold a count
increment until it gets past that lock.  Without this lock, the results
of pte_page are unstable.

-- 
Daniel
