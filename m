Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263174AbRFGVJK>; Thu, 7 Jun 2001 17:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263173AbRFGVJA>; Thu, 7 Jun 2001 17:09:00 -0400
Received: from turnover.lancs.ac.uk ([148.88.17.220]:24827 "EHLO
	helium.chromatix.org.uk") by vger.kernel.org with ESMTP
	id <S263160AbRFGVIu>; Thu, 7 Jun 2001 17:08:50 -0400
Message-Id: <l03130320b7459cd17e98@[192.168.239.105]>
In-Reply-To: <Pine.LNX.4.21.0106071345190.6604-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.21.0106071330060.6510-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 7 Jun 2001 22:08:00 +0100
To: Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: Background scanning change on 2.4.6-pre1
Cc: lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > This is going to make all pages have age 0 on an idle system after some
>> > time (the old code from Rik which has been replaced by this code tried to
>> > avoid that)
>
>There's another reason why I think the patch may be ok even without any
>added logic: not only does it simplify the code and remove a illogical
>heuristic, but there is nothing that really says that "age 0" is
>necessarily very bad.

Here's my take on it.  The point of ageing is twofold - to age down pages
that aren't in use, and to age up pages that *are* in use.  So, pages that
are in use will remain with high ages even when background scanning is
being done, and pages that aren't in use will decay to zero age.

I can't see what's wrong with that.  When we need more memory, it's a Very
Good Thing to know that most of the pages in the system haven't been
accessed in yonks - we know exactly which ones we want to throw out first.

--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)

The key to knowledge is not to rely on people to teach you it.

GCS$/E/S dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$ V? PS
PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r++ y+(*)


