Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262546AbTDAO3v>; Tue, 1 Apr 2003 09:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262559AbTDAO3v>; Tue, 1 Apr 2003 09:29:51 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:23039 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id <S262546AbTDAO3u>; Tue, 1 Apr 2003 09:29:50 -0500
Date: Tue, 1 Apr 2003 15:43:09 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: CaT <cat@zip.com.au>
cc: Xavier Bestel <xavier.bestel@free.fr>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATCH: allow percentile size of tmpfs (2.5.66 / 2.4.20-pre2)
In-Reply-To: <20030401142317.GC459@zip.com.au>
Message-ID: <Pine.LNX.4.44.0304011536350.1375-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Apr 2003, CaT wrote:
> > 
> > Hardly, it'll overflow in even more cases
> > than CaT's (si.totalram << PAGE_CACHE_SHIFT).
> 
> Yes. I had it initially as Xavier suggested but after thinking about it
> a bit I felt that making the value smaller and -then- bigger was safer.
> 
> > I'll take a look at this later, not right now.
> 
> It is still an unsigned long long int so (AFAIK) it wont overflow till
> it hits 18,446,744,073,709,551,615. Now... if you have that much ram...
> wow! :)

There's plenty of room in unsigned long long size, yes, but si.totalram
is only an unsigned long, so the arithmetic as you have it starts out
overflowing an unsigned long.

I don't know yet what it should say: RH2.96-110 is getting confused
by the do_div(size, 100) I have there (to respect Xavier's point),
and this is definitely _not_ worth adding a compiler dependency for.

Hugh

