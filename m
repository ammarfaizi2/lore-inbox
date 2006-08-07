Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750820AbWHGViD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbWHGViD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 17:38:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750853AbWHGViD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 17:38:03 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:1494 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750820AbWHGViB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 17:38:01 -0400
Date: Mon, 7 Aug 2006 17:37:50 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Andrew Morton <akpm@osdl.org>
cc: Nate Diller <nate.diller@gmail.com>, axboe@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] [2/3] add list_merge to list.h
In-Reply-To: <20060803222204.f369e6da.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0608071733330.27060@gandalf.stny.rr.com>
References: <5c49b0ed0608031915g2c1fc44ch623a7657b994bf9c@mail.gmail.com>
 <20060803222204.f369e6da.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 3 Aug 2006, Andrew Morton wrote:

> On Thu, 3 Aug 2006 19:15:15 -0700
> "Nate Diller" <nate.diller@gmail.com> wrote:
>
> > +/**
> > + * list_merge - merge two headless lists
> > + * @list: the new list to merge.
> > + * @head: the place to add it in the first list.
> > + *
> > + * This is similar to list_splice(), except it merges every item onto @list,
> > + * not excluding @head itself.  It is a noop if @head already immediately
> > + * preceeds @list.
>
> "precedes"
>
> > + */
> > +static inline void list_merge(struct list_head *list, struct list_head *head)
> > +{
> > +	struct list_head *last = list->prev;
> > +	struct list_head *at = head->next;
> > +
> > +	list->prev = head;
> > +	head->next = list;
> > +
> > +	last->next = at;
> > +	at->prev = last;
> > +}
>
> Interesting.  I didn't realise that none of the existing functions could do
> this.  I wonder if we can flesh the comment out a bit: define "headless" a
> little more verbosely.
>
> Should we call it list_splice_headless() or something?  list_merge is a bit
> vague.
>

Yes, please do explicitly mention headless.  I could see someone using
this for something with a head and causing some strange bugs.

Also, it might be a good idea to get rid of the "head" in the parameter.
Perhaps call it "start" or something else.  It's a little confusing to
have a headless list operation that calls the start of a list "head".

-- Steve

