Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317253AbSFGOTL>; Fri, 7 Jun 2002 10:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317281AbSFGOTK>; Fri, 7 Jun 2002 10:19:10 -0400
Received: from 196-41-175-250.mtnns.net ([196.41.175.250]:2317 "EHLO
	penguin.wetton.prism.co.za") by vger.kernel.org with ESMTP
	id <S317253AbSFGOTK>; Fri, 7 Jun 2002 10:19:10 -0400
Date: Fri, 7 Jun 2002 16:17:05 +0200
From: Bernd Jendrissek <berndj@prism.co.za>
To: linux-kernel@vger.kernel.org
Cc: akpm@zip.com.au
Subject: Re: [patch 2/16] list_head debugging
Message-ID: <20020607161705.V2270@prism.co.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[sorry for the nonexistent In-Reply-To/whatever headers - cutting&pasting]

Andrew Morton wrote:
>   A common and very subtle bug is to use list_heads which aren't on any
>   lists. It causes kernel memory corruption which is observed long after
>   the offending code has executed.
>
>   The patch nulls out the dangling pointers so we get a nice oops at the
>   site of the buggy code.

I'm not current with the kernel tree, but will one such oops occur in
netfilter?  See

http://lists.samba.org/pipermail/netfilter-announce/2002/000010.html

Hmm, no.  A DoS maybe?

>   --- 2.5.19/include/linux/list.h~list-debug Sat Jun 1 01:18:05 2002
>   +++ 2.5.19-akpm/include/linux/list.h Sat Jun 1 01:18:05 2002
>   @@ -94,6 +94,11 @@ static __inline__ void __list_del(struct
>    static __inline__ void list_del(struct list_head *entry)
>    {
>            __list_del(entry->prev, entry->next);
>   + /*
>   + * This is debug. Remove it when the kernel has no bugs ;)
>   + */
>   + entry->next = 0;
>   + entry->prev = 0;
>    }
>
>    /**

Bernd Jendrissek
