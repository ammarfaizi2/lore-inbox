Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274482AbRITNdh>; Thu, 20 Sep 2001 09:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274488AbRITNd2>; Thu, 20 Sep 2001 09:33:28 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:14856 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S274486AbRITNdQ>; Thu, 20 Sep 2001 09:33:16 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: broken VM in 2.4.10-pre9
Date: Thu, 20 Sep 2001 15:40:55 +0200
X-Mailer: KMail [version 1.3.1]
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        ebiederm@xmission.com (Eric W. Biederman),
        rfuller@nsisoftware.com (Rob Fuller), linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
In-Reply-To: <E15k3O2-0005Fr-00@the-village.bc.nu>
In-Reply-To: <E15k3O2-0005Fr-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010920133330Z16274-2757+894@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 20, 2001 02:57 pm, Alan Cox wrote:
> > On September 20, 2001 12:04 am, Alan Cox wrote:
> > > Reverse mappings make linear aging easier to do but are not critical (we
> > > can walk all physical pages via the page map array). 
> > 
> > But you can't pick up the referenced bit that way, so no up aging, only
> > down.
> 
> #1 If you really wanted to you could update a referenced bit in the page
> struct in the fault handling path.

Right, we probably should do that.  But consider that any time this happens a 
reverse map would have eliminated the fault because we wouldn't need to unmap 
the page until we're actually going to free it.

> #2 If a page is referenced multiple times by different processes is the
> behaviour of multiple upward aging actually wrong.

With rmap it's easy to do it either way: either treat the ref bits as if 
they're all or'd together or, perhaps more sensibly, age up by an amount that 
depends on the number of ref bits set, but not as much as UP_AGE * refs.

--
Daniel
