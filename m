Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129781AbQLIPq7>; Sat, 9 Dec 2000 10:46:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131949AbQLIPqt>; Sat, 9 Dec 2000 10:46:49 -0500
Received: from pizda.ninka.net ([216.101.162.242]:32393 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129781AbQLIPql>;
	Sat, 9 Dec 2000 10:46:41 -0500
Date: Sat, 9 Dec 2000 07:00:19 -0800
Message-Id: <200012091500.HAA20614@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: kernel@tekno-soft.it
CC: rasmus@jaquet.dk, torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <4.3.2.7.2.20001209160215.00c901e0@mail.tekno-soft.it> (message
	from Roberto Fichera on Sat, 09 Dec 2000 16:07:03 +0100)
Subject: Re: [PATCH] mm->rss is modified without page_table_lock held
In-Reply-To: <4.3.2.7.2.20001209152806.00c8e7b0@mail.tekno-soft.it>
 <4.3.2.7.2.20001209111347.00c829f0@mail.tekno-soft.it>
 <4.3.2.7.2.20001209111347.00c829f0@mail.tekno-soft.it>
 <4.3.2.7.2.20001209152806.00c8e7b0@mail.tekno-soft.it> <4.3.2.7.2.20001209160215.00c901e0@mail.tekno-soft.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Sat, 09 Dec 2000 16:07:03 +0100
   From: Roberto Fichera <kernel@tekno-soft.it>

   8 bits for a spinlock ? What kind of use we have here ?

Sparc32 (like some other older architectures) do not have a
word atomic update instruction, but it does have a byte spinlock.
To conserve space and implement the atomic update properly, we
use a spinlock in the top byte of the word.

   All arch except Sparc32 don't have this trick.

This may not be true forever.

Also, this sematic was decided upon many eons ago, changing it a month
before 2.4.0 just to deal with this mm->rss atomicity issue is not
going to happen.  The spinlock patch exists, and if nothing better
comes up, we should just use it.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
