Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316663AbSEVS3A>; Wed, 22 May 2002 14:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316659AbSEVS2s>; Wed, 22 May 2002 14:28:48 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:57610 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316643AbSEVS1r>; Wed, 22 May 2002 14:27:47 -0400
Date: Wed, 22 May 2002 11:27:21 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: William Lee Irwin III <wli@holomorphy.com>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        "M. Edward Borasky" <znmeb@aracnet.com>,
        <linux-kernel@vger.kernel.org>, <andrea@suse.de>, <riel@surriel.com>,
        <akpm@zip.com.au>
Subject: Re: Have the 2.4 kernel memory management problems on large machines
In-Reply-To: <E17Aawp-0002Vt-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0205221125020.23621-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 22 May 2002, Alan Cox wrote:
> 
> That assumes you want to page out the page table only after the pages it
> references are paged out. There is no reason I can see for not flushing it
> first.

Dirty state and mixed vma's on the same pmd would make this more complex 
than I really like, but sure..

However, the pmd almost certainly gets re-created very quickly anyway, so 
I seriously doubt you get any real wins.

Remember: the point of swapping stuff out (or just dropping them) is that
we don't need them in the near future. With a 4MB (or 2MB) granularity,
that's not very likely.

		Linus

