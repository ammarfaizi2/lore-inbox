Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261427AbSIZRsh>; Thu, 26 Sep 2002 13:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261428AbSIZRsh>; Thu, 26 Sep 2002 13:48:37 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:51902 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S261427AbSIZRsf>; Thu, 26 Sep 2002 13:48:35 -0400
Date: Thu, 26 Sep 2002 14:53:42 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: =?ISO-8859-1?Q?Andreas_R=E4cker?= <patch@luckynet.dynu.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5] Single linked lists for Linux, overly complicated
 v2
In-Reply-To: <20020926174124.64E112@hawkeye.luckynet.adm>
Message-ID: <Pine.LNX.4.44L.0209261445450.1837-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Sep 2002, Andreas Räcker wrote:

> +#define INIT_SLIST_HEAD(name)			\
> +	(name->next = name)
> +
> +#define SLIST_HEAD_INIT(name)			\
> +	{ .next = NULL; }
> +
> +#define SLIST_HEAD(type,name)			\
> +	typeof(type) name = SLIST_HEAD_INIT(name)

INIT_SLIST_HEAD still has the old behaviour...


> +#define slist_add_front(_new_in, _head_in)	\

> +#define slist_add(_new_in, _head_in)		\

These two seem to be exactly the same, surely you only need one ?


> +#define slist_del(_entry_in)				\

And what happens when you try to remove an entry from the middle
of the list ?

Also, how do you know which list the entry is removed from ?

> +/**
> + * slist_for_each	-	iterate over a list
> + * @pos:	the pointer to use as a loop counter.
> + * @head:	the head for your list (this is also the first entry).
> + */
> +#define slist_for_each(pos, head)				\
> +	for (pos = head; pos && ({ prefetch(pos->next); 1; });	\
> +	    pos = pos->next)

Are you sure the list head _can_ be the first entry ?

Not having the head of the list in a known place (ie. a fixed
list head) can make a list very hard to find.

> +/**
> + * slist_for_each_round	-	iterate over a round list
> + * @pos:	the pointer to use as a loop counter.
> + * @head:	the head for your list (this is also the first entry).
> + */
> +#define slist_for_each(pos, head)			\

You forgot to rename this define.

> --
> Lightweight Patch Manager, without pine.
> If you have any objections (apart from who I am), tell me
                              ^^^^^^^^^^^^^^^^^^^
I guess that's why we have whois ;)

cheers,

Rik
-- 
A: No.
Q: Should I include quotations after my reply?

http://www.surriel.com/		http://distro.conectiva.com/


