Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130530AbQLISs4>; Sat, 9 Dec 2000 13:48:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130592AbQLISsi>; Sat, 9 Dec 2000 13:48:38 -0500
Received: from isolaweb.it ([213.82.132.2]:19212 "EHLO web.isolaweb.it")
	by vger.kernel.org with ESMTP id <S130085AbQLISsC>;
	Sat, 9 Dec 2000 13:48:02 -0500
Message-Id: <4.3.2.7.2.20001209190705.00cb29e0@mail.tekno-soft.it>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Sat, 09 Dec 2000 19:11:57 +0100
To: "David S. Miller" <davem@redhat.com>
From: Roberto Fichera <kernel@tekno-soft.it>
Subject: Re: [PATCH] mm->rss is modified without page_table_lock held
Cc: rasmus@jaquet.dk, torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <200012091500.HAA20614@pizda.ninka.net>
In-Reply-To: <4.3.2.7.2.20001209160215.00c901e0@mail.tekno-soft.it>
 <4.3.2.7.2.20001209152806.00c8e7b0@mail.tekno-soft.it>
 <4.3.2.7.2.20001209111347.00c829f0@mail.tekno-soft.it>
 <4.3.2.7.2.20001209111347.00c829f0@mail.tekno-soft.it>
 <4.3.2.7.2.20001209152806.00c8e7b0@mail.tekno-soft.it>
 <4.3.2.7.2.20001209160215.00c901e0@mail.tekno-soft.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 07.00 09/12/00 -0800, David S. Miller wrote:

>    Date: Sat, 09 Dec 2000 16:07:03 +0100
>    From: Roberto Fichera <kernel@tekno-soft.it>
>
>    8 bits for a spinlock ? What kind of use we have here ?
>
>Sparc32 (like some other older architectures) do not have a
>word atomic update instruction, but it does have a byte spinlock.
>To conserve space and implement the atomic update properly, we
>use a spinlock in the top byte of the word.

There's any possibility ;-) to define it as

typedef struct { volatile char spinlock, volatile long counter } atomic_t;

>Also, this sematic was decided upon many eons ago, changing it a month
>before 2.4.0 just to deal with this mm->rss atomicity issue is not
>going to happen.  The spinlock patch exists, and if nothing better
>comes up, we should just use it.

Indeed! You are right! I was thinking to optimize it, using a 
spinlock/unlock we spent
several time for a inc.

Roberto Fichera.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
