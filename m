Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264683AbSJ3ENS>; Tue, 29 Oct 2002 23:13:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264684AbSJ3ENS>; Tue, 29 Oct 2002 23:13:18 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:27807 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S264683AbSJ3ENR>; Tue, 29 Oct 2002 23:13:17 -0500
X-AuthUser: davidel@xmailserver.org
Date: Tue, 29 Oct 2002 20:29:11 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Andrew Morton <akpm@digeo.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sys_epoll 0.14 ...
In-Reply-To: <3DBF5C1C.5ACD296A@digeo.com>
Message-ID: <Pine.LNX.4.44.0210292028170.1457-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Oct 2002, Andrew Morton wrote:

> They are a reasonable addition to the list library.  They
> should be implemented as:
>
> /*
>  * kernel-doc description goes here
>  */
> static inline struct list_head *list_first(struct list_head *list)
> {
> 	if (list_empty(list))
> 		return NULL;
> 	return list->next;
> }
>
> But it shouldn't be quietly snuck in as part of epoll.   Everyone in
> the world uses list.h.
>
> Given that they are used in just a handful of places in epoll and nowhere
> else in the kernel it is a little hard to justify adding them.
>
> Unless people leap out and say "I've always wanted one of them" it would
> be best to redo epoll to use
>
> 	while (!list_empty(list)) {
> 		item = list_entry(list, ...);
> 		list_del(item->list);
> 		...
> 	}
>
> or one of the other eighty-seven list helpers which we already have.

Ok, let's drop them off ...



- Davide


