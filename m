Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317600AbSFIMC4>; Sun, 9 Jun 2002 08:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317601AbSFIMC4>; Sun, 9 Jun 2002 08:02:56 -0400
Received: from loewe.cosy.sbg.ac.at ([141.201.2.12]:60903 "EHLO
	loewe.cosy.sbg.ac.at") by vger.kernel.org with ESMTP
	id <S317600AbSFIMCy>; Sun, 9 Jun 2002 08:02:54 -0400
Date: Sun, 9 Jun 2002 14:02:50 +0200 (MET DST)
From: "Thomas 'Dent' Mirlacher" <dent@cosy.sbg.ac.at>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
cc: Lightweight patch manager <patch@luckynet.dynu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH][2.5] introduce list_move macros
In-Reply-To: <87sn3wy8p2.fsf@devron.myhome.or.jp>
Message-ID: <Pine.GSO.4.05.10206091358360.16324-100000@mausmaki.cosy.sbg.ac.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Jun 2002, OGAWA Hirofumi wrote:

> Lightweight patch manager <patch@luckynet.dynu.com> writes:
> 
> > This is the only _global_ patch about the list_move macros, which means 
> > introducing them. Here they are:
> > 
> > --- linus-2.5/include/linux/list.h	Sun Jun  9 04:17:14 2002
> > +++ thunder-2.5/include/linux/list.h	Sun Jun  9 05:07:02 2002
> > @@ -174,6 +174,24 @@
> >  	for (pos = (head)->next, n = pos->next; pos != (head); \
> >  		pos = n, n = pos->next)
> >  
> > +/**
> > + * list_move           - move a list entry from a right after b
> > + * @list       the entry to move
> > + * @head       the entry to move after
> > + */
> > +#define list_move(list,head) \
> > +        list_del(list); \
> > +        list_add(list,head)
> > +
> > +/**
> > + * list_move_tail      - move a list entry from a right before b
> > + * @list       the entry to move
> > + * @head       the entry that will come after ours
> > + */
> > +#define list_move(list,head) \
>                 ^^^^
> Probably typo.  list_move_tail.
> 
> > +        list_del(list); \
> > +        list_add_tail(list,head)
> > +
> >  #endif /* __KERNEL__ || _LVM_H_INCLUDE */
> >  
> >  #endif
> 
> 	if (check_something(x))
> 		list_move(p, head);
> 
> In the above case, these seems unsafe. So, shouldn't these use
> `do {} while(0)' or `inline function'?

another possible solution would be:

static __inline__ void list_move(list_t *list, struct list_t *head)
{
	__list_del(list->prev, list->next);
	list_add(list, head);
}

static __inline__ void list_move_tail(list_t *list, struct list_t *head)
{
	__list_del(list->prev, list->next);
	list_add_tail(list, head);
}

this gets rid of the problem described above,
	adds inline advantages
	removes zeroing of entry->(next|prev) ... which is not needed for move

	tm
-- 
in some way i do, and in some way i don't.

