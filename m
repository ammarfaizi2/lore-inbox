Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129170AbRBVC1x>; Wed, 21 Feb 2001 21:27:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129693AbRBVC1e>; Wed, 21 Feb 2001 21:27:34 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:58628 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129170AbRBVC1Y>; Wed, 21 Feb 2001 21:27:24 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Linux 2.4.1-ac15
Date: 21 Feb 2001 18:27:00 -0800
Organization: Transmeta Corporation
Message-ID: <971tdk$10p$1@penguin.transmeta.com>
In-Reply-To: <E14VPXZ-0007HS-00@halfway> <E14VXxY-0001wy-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <E14VXxY-0001wy-00@the-village.bc.nu>,
Alan Cox  <alan@lxorguk.ukuu.org.uk> wrote:
>> This is a while back, but I thought the solution Philipp and I came up
>> with was to simply used a rw semaphore for this, which was taken (read
>> only) on page fault if we have to scan the exception table.
>
>We can take page faults in interrupt handlers in 2.4 so I had to use a 
>spinlock, but that sounds the same

Umm? The above doesn't really make sense.

We can take a page fault on the kernel region with the lazy page
directory filling, but that code will just set the PGD entry and exit
without taking any lock at all. So it basically ends up being an
"invisible" event.

Now, if an interrupt handler accesses kernel memory that just isn't
there, that has _always_ taken a page fault, and that case is not new to
2.4.x. In that case you would take the exception table lock, but that is
true in both 2.2.x and in 2.4.x.

		Linus
