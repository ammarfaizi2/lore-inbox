Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262051AbSIYVOV>; Wed, 25 Sep 2002 17:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262052AbSIYVOV>; Wed, 25 Sep 2002 17:14:21 -0400
Received: from adedition.com ([216.209.85.42]:44039 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S262051AbSIYVOU>;
	Wed, 25 Sep 2002 17:14:20 -0400
Date: Wed, 25 Sep 2002 17:17:16 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: Lightweight Patch Manager <patch@luckynet.dynu.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Tomas Szepe <szepe@pinerecords.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH][2.5] Single linked lists for Linux
Message-ID: <20020925171716.A15662@mark.mielke.cc>
References: <20020925205608.1BD86F@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020925205608.1BD86F@hawkeye.luckynet.adm>; from patch@luckynet.dynu.com on Wed, Sep 25, 2002 at 08:56:08PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2002 at 08:56:08PM +0000, Lightweight Patch Manager wrote:
> +#define slist_add_front(_new, _head)		\
> +do {						\
> +	(_new)->next = (_head);			\
> +	(_head) = (_new);			\
> +} while (0)

I suppose it isn't a serious issue, but is it necessary to repeat
'_new' and '_head' in #define?

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

Did you miss "while (0)"?

> +#define slist_del_single(_list)			\
> +	(_list)->next = NULL

Perhaps an outer ()?

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

