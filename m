Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273644AbRIQPjc>; Mon, 17 Sep 2001 11:39:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273646AbRIQPjW>; Mon, 17 Sep 2001 11:39:22 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:13067 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S273644AbRIQPjN>; Mon, 17 Sep 2001 11:39:13 -0400
Date: Mon, 17 Sep 2001 08:38:37 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jan Harkes <jaharkes@cs.cmu.edu>
cc: Daniel Phillips <phillips@bonn-fries.net>, <linux-kernel@vger.kernel.org>
Subject: Re: broken VM in 2.4.10-pre9
In-Reply-To: <20010917011157.A22989@cs.cmu.edu>
Message-ID: <Pine.LNX.4.33.0109170835310.8836-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 17 Sep 2001, Jan Harkes wrote:
>
> >  - COW issue mentioned above. Probably trivially fixed by something like
>
> The COW is triggered by a pagefault, so the page will be accessed and
> the hardware bits (both accessed and dirty) should get set automatically.

No.

The point is that yes, the bits are set in the _page_table_, but we've
never set them on the physical page.

And the COW fault will switch the page table entry to a new page, so if we
don't set the referenced bit on the physical page at that time, we _never_
will.

		Linus

