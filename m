Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284935AbRLKJHd>; Tue, 11 Dec 2001 04:07:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284938AbRLKJHX>; Tue, 11 Dec 2001 04:07:23 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:15670 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S284935AbRLKJHM>; Tue, 11 Dec 2001 04:07:12 -0500
To: volodya@mindspring.com
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Rik van Riel <riel@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: mm question
In-Reply-To: <Pine.LNX.4.20.0112102048390.18728-100000@node2.localnet.net>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 11 Dec 2001 01:47:06 -0700
In-Reply-To: <Pine.LNX.4.20.0112102048390.18728-100000@node2.localnet.net>
Message-ID: <m1snaiuos5.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

volodya@mindspring.com writes:

> On Mon, 10 Dec 2001, Alan Cox wrote:
> 
> > > Right, but instead of trying to balance cache available memory and swap
> > > my swapper will only be concerned whether the page can be evicted and
> > > whether it is from the address range I want.
> > 
> > You want to rewrite the entire vm to have back pointers ? Right now you
> > can't find pages in an address range. Its all driven from the virtual side
> > without reverse lookup tables.
> > 
> 
> You are right I don't want to rewrite vm. But I can go thru virtual side
> taking note of the physical address. I.e. base the decision to try and
> free pages not on how old the page is but on what it's physical address
> is.
> 
> You see, I don't want to find a few pages in 16mb range in 512mb system.
> 
> I want to find a few pages _outside_ 64mb range in a 512mb system. 
> So if I free 70mb I _will_ be able to find at least 2mb in my desired
> range. In fact I won't have to free that much as they it will work is
> "try to free the page", "if succeed do not return to memory pool but
> instead give to the 'special region list'"
> 
> Does this make sense ?

There is actually a cheap trick that will achieve what you want.
Allocate pages.  If you allocate a page in the 0-64mb range keep
it allocated until you have allocated your 300KB > 64mb.  After
you have all of the pages you want free the extra pages in 0-64mb that
you didn't want...

Eric
