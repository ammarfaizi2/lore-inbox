Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131691AbQLIPYY>; Sat, 9 Dec 2000 10:24:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131728AbQLIPYP>; Sat, 9 Dec 2000 10:24:15 -0500
Received: from isolaweb.it ([213.82.132.2]:11274 "EHLO web.isolaweb.it")
	by vger.kernel.org with ESMTP id <S131691AbQLIPYK>;
	Sat, 9 Dec 2000 10:24:10 -0500
Message-Id: <4.3.2.7.2.20001209152806.00c8e7b0@mail.tekno-soft.it>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Sat, 09 Dec 2000 15:48:05 +0100
To: "David S. Miller" <davem@redhat.com>
From: Roberto Fichera <kernel@tekno-soft.it>
Subject: Re: [PATCH] mm->rss is modified without page_table_lock held
Cc: rasmus@jaquet.dk, torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <200012091232.EAA17524@pizda.ninka.net>
In-Reply-To: <4.3.2.7.2.20001209111347.00c829f0@mail.tekno-soft.it>
 <4.3.2.7.2.20001209111347.00c829f0@mail.tekno-soft.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 13.43 09/12/00 +0100, Rasmus Andersen wrote:

>On Sat, Dec 09, 2000 at 11:25:09AM +0100, Roberto Fichera wrote:
>[...]
> > >+       spin_lock(&mm->page_table_lock);
> > >         mm->rss++;
> > >+       spin_unlock(&mm->page_table_lock);
> > >
> >
> > [...snip...]
> >
> > Why we couldn't use atomic_inc(&mm->rss) here and below, avoiding to wrap
> > the inc with a spin_lock()/spin_unlock() ?
> >
>
>AFAIR, because for some architectures we can't rely on mm->rss fitting in
>an atomic_t. See davem's (somewhat short) post in this thread. Otherwise
>search the archives for the original thread treating this problem.

and At 04.32 09/12/00 -0800, David S. Miller wrote:

>    Date:        Sat, 09 Dec 2000 11:25:09 +0100
>    From: Roberto Fichera <kernel@tekno-soft.it>
>
>    Why we couldn't use atomic_inc(&mm->rss) here and below, avoiding to wrap
>    the inc with a spin_lock()/spin_unlock() ?
>
>atomic_t does not guarentee a large enough range necessary for mm->rss

If we haven't some atomic_t that can be negative we could define atomic_t 
as unsigned long for all arch,
this is sufficient to fitting all the range for the mm->rss.

Roberto Fichera.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
