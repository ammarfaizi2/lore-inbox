Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315487AbSFCUTW>; Mon, 3 Jun 2002 16:19:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315483AbSFCUSo>; Mon, 3 Jun 2002 16:18:44 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53263 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315491AbSFCUSH>;
	Mon, 3 Jun 2002 16:18:07 -0400
Message-ID: <3CFBCEB1.DFB6EF61@zip.com.au>
Date: Mon, 03 Jun 2002 13:16:49 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.1-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jan Harkes <jaharkes@cs.cmu.edu>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2/16] list_head debugging
In-Reply-To: <3CF88863.BF3AF0FA@zip.com.au> <20020603135534.GA7668@ravel.coda.cs.cmu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Harkes wrote:
> 
> On Sat, Jun 01, 2002 at 01:40:03AM -0700, Andrew Morton wrote:
> > The patch nulls out the dangling pointers so we get a nice oops at the
> > site of the buggy code.
> ...
> >  static __inline__ void list_del(struct list_head *entry)
> >  {
> >       __list_del(entry->prev, entry->next);
> > +     /*
> > +      * This is debug.  Remove it when the kernel has no bugs ;)
> > +      */
> > +     entry->next = 0;
> > +     entry->prev = 0;
> >  }
> 
> We've had this before, and it breaks some code that removes items from
> lists as follows,
> 
>     list_for_each(p, list)
>         if (condition)
>             list_del(p);

hmm.  I suppose that's sane.

> These would have to either use __list_del, or need to do,
> 
>     for(p = list.next; p != &list;) {
>         struct list_head *n = p->next;
>         if (condition)
>             list_del(p);
>         p = n;
>     }

list_for_each_safe() does this.
