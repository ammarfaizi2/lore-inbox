Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261430AbSIZSUu>; Thu, 26 Sep 2002 14:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261431AbSIZSUu>; Thu, 26 Sep 2002 14:20:50 -0400
Received: from pD9E23892.dip.t-dialin.net ([217.226.56.146]:4584 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S261430AbSIZSUs>; Thu, 26 Sep 2002 14:20:48 -0400
Date: Thu, 26 Sep 2002 12:26:40 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Rik van Riel <riel@conectiva.com.br>
cc: =?ISO-8859-1?Q?Andreas_R=E4cker?= <patch@luckynet.dynu.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5] Single linked lists for Linux, overly complicated
 v2
In-Reply-To: <Pine.LNX.4.44L.0209261445450.1837-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.44.0209261213360.7827-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 26 Sep 2002, Rik van Riel wrote:
> INIT_SLIST_HEAD still has the old behaviour...

I'm now after both behaviors...

#define INIT_SLIST_HEAD(name)                   \
        (name->next = NULL)

#define INIT_SLIST_LOOP(name)			\
	(name->next = name)

> > +#define slist_add_front(_new_in, _head_in)	\
> 
> > +#define slist_add(_new_in, _head_in)		\
> 
> These two seem to be exactly the same, surely you only need one ?

No, they're not.

(tab-width=8)

	slist_add
|-------------------------------|
| head		->	after	|
|				|
|	   new			|
|-------------------------------|	new->next = head->next
| head		->	after	|
|			  ^	|
|			 new	|
|-------------------------------|	head->next = new
| head	-> new	->	after	|
|-------------------------------|

	slist_add_front
|-------------------------------|
| head		->	after	|
|				|
|	   new			|
|-------------------------------|	new->next = head
| new	-> head ->	after	|
|-------------------------------|	head = new
| head	-> next	->	after	|
|-------------------------------|

(Just to have something drawn...)

> > +#define slist_del(_entry_in)				\
> 
> And what happens when you try to remove an entry from the middle
> of the list ?

Well, I can only try to preserve the pointer target, since I don't have a 
previous entry. (Thus the overly complicated slist_del.)

> Also, how do you know which list the entry is removed from ?

It's the one which previously contained it...

I don't know whether I should like the list header aproach.

It's not bad for either circular lists or such which will have to be gone 
through only once, as using slist_pop().

> Not having the head of the list in a known place (ie. a fixed
> list head) can make a list very hard to find.

But you see we have the problem that there is no such thing as a 
predeclared structure for it. The only thing we can rely on is a chain of 
structures which alltogether have a ->next field pointing to another 
structure of presumably the same type.

> You forgot to rename this define.

Yes, I've forgotten two things there. They are fixed in my file, which I 
won't post right now (in order not to pollute the list too much with 
patches. It's that fix plus a forgotten _in.)

> > If you have any objections (apart from who I am), tell me
>                               ^^^^^^^^^^^^^^^^^^^
> I guess that's why we have whois ;)

Oh, that was just for Jes Soerensen, who kept asking.

			Thunder
-- 
assert(typeof((fool)->next) == typeof(fool));	/* wrong */

