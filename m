Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286126AbRLJAzz>; Sun, 9 Dec 2001 19:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286127AbRLJAzq>; Sun, 9 Dec 2001 19:55:46 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:51981 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S286126AbRLJAzg>; Sun, 9 Dec 2001 19:55:36 -0500
Date: Sun, 9 Dec 2001 16:57:29 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [RFC] Scheduler queue implementation ...
In-Reply-To: <E16DEdR-0008Tn-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.40.0112091647360.996-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Dec 2001, Alan Cox wrote:

> > What we lose is the mm ( + 1) goodness() but the eventual cost of
> > switching mm is melted inside the long execution time ( 50-60 ms ) typical
> > of CPU bound tasks ( note that matching MMs does not mean matching cache
> > image ).
>
> The mm matching and keeping an mm on the same cpu is critical for a lot of
> applications (your 50ms execution time includes 2ms loading the cache from
> the other CPU in some cases). Keeping the same mms together on the processor
> is critical for certain platforms (eg ARM) but not for x86 so much.

Alan, you're mixing switch mm costs with cache image reload ones.
Note that equal mm does not mean matching cache image, at all.
I would say that they're completely unrelated.
By having only two queues maintain the implementation simple and solves
99% of common/extraordinary cases.
The cost of a tlb flush become "meaningful" for I/O bound tasks where
their short average run time is not sufficent to compensate the tlb flush
cost, and this is handled correctly/like-usual inside the I/O bound queue.




- Davide




