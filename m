Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265901AbSKTIqG>; Wed, 20 Nov 2002 03:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262190AbSKTIqG>; Wed, 20 Nov 2002 03:46:06 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:35858 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265974AbSKTIpE>;
	Wed, 20 Nov 2002 03:45:04 -0500
Date: Wed, 20 Nov 2002 00:45:32 -0800
From: Greg KH <greg@kroah.com>
To: Samium Gromoff <_deepfire@mail.ru>, David Brownell <david-b@pacbell.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4, 2.5, USB] locking issue
Message-ID: <20021120084532.GD22936@kroah.com>
References: <E18Dmyi-000FRS-00@f16.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E18Dmyi-000FRS-00@f16.mail.ru>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2002 at 05:34:20PM +0300, Samium Gromoff wrote:
>         The possible problem is encountered in ehci-q.c and ehci-sched.c
>   in 2.4.19-pre9 and in one occurence in ehci-q.c of 2.5.47.
> 
>         the offending pattern is the same in both files:
> 
>         if (!list_empty (qtd_list)) {
>  -----------------------8<----------------------------------------------
>                 list_splice (qtd_list, &qh->qtd_list);
>                 qh_update (qh, list_entry (qtd_list->next, struct ehci_qtd, qtd\_list));
>  -----------------------8<----------------------------------------------
>         } else {
>                 qh->hw_qtd_next = qh->hw_alt_next = EHCI_LIST_END;
>         }
> 
> 
>         since list_splice() the qtd_list is diposed of its belongings and
>         immediately in the next line we rely on qtd_list->next to point
>         at an existing list_head.
> 
>         i haven`t noticed any locking out there, and i`m afraid of what
>         could result from a preemption happening between these two lines.

Um, David, any thoughts about this?

thanks,

greg k-h
