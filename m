Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130517AbRCISZT>; Fri, 9 Mar 2001 13:25:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130519AbRCISZJ>; Fri, 9 Mar 2001 13:25:09 -0500
Received: from waste.org ([209.173.204.2]:14603 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S130517AbRCISYz>;
	Fri, 9 Mar 2001 13:24:55 -0500
Date: Fri, 9 Mar 2001 12:23:54 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Helge Hafting <helgehaf@idb.hist.no>
cc: Manoj Sontakke <manojs@sasken.com>, <linux-kernel@vger.kernel.org>
Subject: Re: quicksort for linked list
In-Reply-To: <3AA89624.46DBADD7@idb.hist.no>
Message-ID: <Pine.LNX.4.30.0103091217000.5548-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Mar 2001, Helge Hafting wrote:

> Manoj Sontakke wrote:
> >
> > 1. Is quicksort on doubly linked list is implemented anywhere? I need it
> > for sk_buff queues.
>
> I cannot see how the quicksort algorithm could work on a doubly
> linked list, as it relies on being able to look
> up elements directly as in an array.
>
> You can probably find algorithms for sorting a linked list, but
> it won't be quicksort.

Here ya go (wrote this a few years ago):

// This function is so cool.
template<class T>
void list<T>::qsort(iter l, iter r, cmpfunc *cmp, void *data)
{
        if(l==r) return;

        iter i(l), p(l);

        for(i++; i!=r; i++)
                if(cmp(*i, *l, data)<0)
                        i.swap(++p);

        l.swap(p);
        qsort(l, p, cmp, data);
        qsort(++p, r, cmp, data);
}

Iters are essentially list pointers with increment operations. This is a
fairly direct adaptation of the quicksort in K&R, actually.

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

