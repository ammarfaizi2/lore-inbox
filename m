Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262205AbSIZGg0>; Thu, 26 Sep 2002 02:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262206AbSIZGgZ>; Thu, 26 Sep 2002 02:36:25 -0400
Received: from pD9E23892.dip.t-dialin.net ([217.226.56.146]:49892 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S262205AbSIZGgZ>; Thu, 26 Sep 2002 02:36:25 -0400
Date: Thu, 26 Sep 2002 00:42:11 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Peter Chubb <peter@chubb.wattle.id.au>
cc: Lightweight Patch Manager <patch@luckynet.dynu.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Tomas Szepe <szepe@pinerecords.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH][2.5] Single linked lists for Linux
In-Reply-To: <15762.20827.271317.595537@wombat.chubb.wattle.id.au>
Message-ID: <Pine.LNX.4.44.0209260038500.7827-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 26 Sep 2002, Peter Chubb wrote:
> +/**
> + * slist_del -	remove an entry from list
> + * @head:	head to remove it from
> + * @entry:	entry to be removed
> + */
> +#define slist_del(_head, _entry)		\
> +do {						\
> +	(_head)->next = (_entry)->next;		\
> +	(_entry)->next = NULL;			\
> +}

What about

#define slist_del(_head)			\
do {						\
	typeof(_head) _entry = (_head)->next;	\
	(_head)->next = _entry->next;		\
	_entry->next = NULL;			\
} while (0)

> static inline int slist_del(struct slist *head, struct slist *entry)

I don't want to inline (just like once, with list.h) because I want any 
type to match here...

			Thunder
-- 
assert(typeof((fool)->next) == typeof(fool));	/* wrong */

