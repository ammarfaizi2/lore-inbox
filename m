Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274201AbRISV7t>; Wed, 19 Sep 2001 17:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274200AbRISV7j>; Wed, 19 Sep 2001 17:59:39 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:50949 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S274199AbRISV7f>; Wed, 19 Sep 2001 17:59:35 -0400
Subject: Re: broken VM in 2.4.10-pre9
To: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 19 Sep 2001 23:04:10 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        phillips@bonn-fries.net (Daniel Phillips),
        rfuller@nsisoftware.com (Rob Fuller), linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
In-Reply-To: <m1iteegag6.fsf@frodo.biederman.org> from "Eric W. Biederman" at Sep 19, 2001 03:03:21 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15jpRy-0003yt-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That added to the fact that last time someone ran the numbers linux
> was considerably faster than the BSD for mm type operations when not
> swapping.  And this is the common case.

"Linux VM works wonderfully when nobody is using it" 

Which is rather like the scheduler works well for one task then by three is
making bad decisions.

> But I have not seen the argument that not having reverse maps make it
> undoable.  In fact previous versions of linux seem to put the proof
> that you can get at least reasonable swapping under load without
> reverse page tables.

The last decent Linx VM behaviour was about 2.1.100 or so - which was
without reverse maps. It's been downhill since then. So yes you may be
right.

> So my suggestion was to look at getting anonymous pages backed by what
> amounts to a shared memory segment.  In that vein.  By using an extent
> based data structure we can get the cost down under the current 8 bits
> per page that we have for the swap counts, and make allocating swap
> pages faster.  And we want to cluster related swap pages anyway so
> an extent based system is a natural fit.

Much of this goes away if you get rid of both the swap and anonymous page
special cases. Back anonymous pages with the "whoops everything I write here
vanishes mysteriously" file system and swap with a swapfs

Reverse mappings make linear aging easier to do but are not critical (we
can walk all physical pages via the page map array). 

Alan
