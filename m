Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317595AbSFILsp>; Sun, 9 Jun 2002 07:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317596AbSFILso>; Sun, 9 Jun 2002 07:48:44 -0400
Received: from mail.parknet.co.jp ([210.134.213.6]:62480 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S317595AbSFILso>; Sun, 9 Jun 2002 07:48:44 -0400
To: Lightweight patch manager <patch@luckynet.dynu.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH][2.5] introduce list_move macros
In-Reply-To: <Pine.LNX.4.44.0206090508330.22407-100000@hawkeye.luckynet.adm>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 09 Jun 2002 20:48:09 +0900
Message-ID: <87sn3wy8p2.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lightweight patch manager <patch@luckynet.dynu.com> writes:

> This is the only _global_ patch about the list_move macros, which means 
> introducing them. Here they are:
> 
> --- linus-2.5/include/linux/list.h	Sun Jun  9 04:17:14 2002
> +++ thunder-2.5/include/linux/list.h	Sun Jun  9 05:07:02 2002
> @@ -174,6 +174,24 @@
>  	for (pos = (head)->next, n = pos->next; pos != (head); \
>  		pos = n, n = pos->next)
>  
> +/**
> + * list_move           - move a list entry from a right after b
> + * @list       the entry to move
> + * @head       the entry to move after
> + */
> +#define list_move(list,head) \
> +        list_del(list); \
> +        list_add(list,head)
> +
> +/**
> + * list_move_tail      - move a list entry from a right before b
> + * @list       the entry to move
> + * @head       the entry that will come after ours
> + */
> +#define list_move(list,head) \
                ^^^^
Probably typo.  list_move_tail.

> +        list_del(list); \
> +        list_add_tail(list,head)
> +
>  #endif /* __KERNEL__ || _LVM_H_INCLUDE */
>  
>  #endif

	if (check_something(x))
		list_move(p, head);

In the above case, these seems unsafe. So, shouldn't these use
`do {} while(0)' or `inline function'?
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
