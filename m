Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261595AbSJ2F4e>; Tue, 29 Oct 2002 00:56:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261596AbSJ2F4e>; Tue, 29 Oct 2002 00:56:34 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:6303 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S261595AbSJ2F4d>; Tue, 29 Oct 2002 00:56:33 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 28 Oct 2002 22:12:20 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] Re: [PATCH] Updated sys_epoll now with man pages
In-Reply-To: <Pine.LNX.4.33L2.0210282137280.13581-100000@dragon.pdx.osdl.net>
Message-ID: <Pine.LNX.4.44.0210282203100.1002-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Oct 2002, Randy.Dunlap wrote:

> Yes, I knew that and I thought about it while typing, but
> my dynamic RAM was too dynamic and not being refreshed often
> enough.  Thanks for doing it for me.

I knew it, I already sent you the links before :)


> BTW, I didn't mean unpopular for the epoll patch, I meant
> unpopular in general, especially for development kernel patches:
> if every new feature required docs along with it, it might slow
> down Linux development by one day, but help out everyone in
> the long run (tm?).

I do agree Randy about comments, don't get me wrong. But you know what my
job condition is :) Looking at the kernel source though, you find
something like :

	/* add the fd to the interest set */
	do_add_fd_to_the_interest_set();

and then you have the code that really would need comments completely
naked. While, again, I do agree that comments are completely missing in
the patch, I'm not that kind of guy that would like a function like :

static struct epitem *ep_find_nl(struct eventpoll *ep, int fd)
{
    struct epitem *dpi = NULL;
    struct list_head *lsthead, *lnk;

    lsthead = &ep->hash[fd & ep->hmask];
    list_for_each(lnk, lsthead) {
        dpi = list_entry(lnk, struct epitem, llink);

        if (dpi->pfd.fd == fd) break;
        dpi = NULL;
    }

    DNPRINTK(3, (KERN_INFO "[%p] eventpoll: ep_find(%d) -> %p\n", current, fd, dpi));

    return dpi;
}

commented with "search an fd inside the hash". What a comment like that
adds to this code ?




- Davide




