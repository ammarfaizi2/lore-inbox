Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261341AbSIZQIF>; Thu, 26 Sep 2002 12:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261362AbSIZQIE>; Thu, 26 Sep 2002 12:08:04 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:50700 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S261341AbSIZQIC>; Thu, 26 Sep 2002 12:08:02 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15763.12828.613912.98830@laputa.namesys.com>
Date: Thu, 26 Sep 2002 20:13:16 +0400
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Lightweight Patch Manager <patch@luckynet.dynu.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rik van Riel <riel@connectiva.com.br>
Subject: Re: [PATCH][2.5] Single linked lists for Linux, overly complicated but working
In-Reply-To: <20020926160028.C221C3@hawkeye.luckynet.adm>
References: <20020926160028.C221C3@hawkeye.luckynet.adm>
X-Mailer: VM 7.07 under 21.5  (beta6) "bok choi" XEmacs Lucid
X-Antipastobozoticataclysm: Bariumenemanilow
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lightweight Patch Manager writes:
 > This is an overly complicated version,  I guess I'll have a better one
 > once I've got my noodles in. Wait an hour, I'll be back.
 > 
 > And BTW, I got the luckynet address fixed, you can send me again...
 > 
 > --- /dev/null	Wed Dec 31 17:00:00 1969
 > +++ slist-2.5/include/linux/slist.h	Thu Sep 26 09:57:25 2002
 > @@ -0,0 +1,139 @@
 > +#ifdef __KERNEL__
 > +#ifndef _LINUX_SLIST_H
 > +#define _LINUX_SLIST_H
 > +
 > +#include <asm/processor.h>
 > +
 > +/*
 > + * Type-safe single linked list helper-functions.
 > + * (originally taken from list.h)
 > + *
 > + * Thomas 'Dent' Mirlacher, Daniel Phillips,
 > + * Andreas Bogk, Thunder from the hill
 > + */
 > +
 > +#define INIT_SLIST_HEAD(name)			\
 > +	(name->next = name)
 > +
 > +#define SLIST_HEAD_INIT(name)			\
 > +	name
 > +
 > +#define SLIST_HEAD(type,name)			\
 > +	typeof(type) name = INIT_SLIST_HEAD(name)
 > +
 > +/**
 > + * slist_add_front - add a new entry at the first slot, moving the old head
 > + *		     to the second slot
 > + * @new:	new entry to be added
 > + * @head:	head of the single linked list
 > + *
 > + * Insert a new entry before the specified head.
 > + * This is good for implementing stacks.
 > + */
 > +
 > +#define slist_add_front(_new, _head)		\
 > +do {						\
 > +	(_new)->next = (_head);			\
 > +	(_head) = (_new);			\
 > +} while (0)

Can these macros be updated to only evaluate their arguments once? By
use of "typeof" maybe? Otherwise, slist_add_front(foo++, bar()) is going
to lead to strange things.

 > +
 > +/**
 > + * slist_add - add a new entry

[...]

Nikita.
