Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284809AbRLKBzO>; Mon, 10 Dec 2001 20:55:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284800AbRLKBzE>; Mon, 10 Dec 2001 20:55:04 -0500
Received: from mpdr0.detroit.mi.ameritech.net ([206.141.239.206]:56211 "EHLO
	mailhost.det.ameritech.net") by vger.kernel.org with ESMTP
	id <S284788AbRLKByr>; Mon, 10 Dec 2001 20:54:47 -0500
Date: Mon, 10 Dec 2001 20:52:54 -0500 (EST)
From: volodya@mindspring.com
Reply-To: volodya@mindspring.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: mm question
In-Reply-To: <E16DYCI-0003Zn-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.20.0112102048390.18728-100000@node2.localnet.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 10 Dec 2001, Alan Cox wrote:

> > Right, but instead of trying to balance cache available memory and swap
> > my swapper will only be concerned whether the page can be evicted and
> > whether it is from the address range I want.
> 
> You want to rewrite the entire vm to have back pointers ? Right now you
> can't find pages in an address range. Its all driven from the virtual side
> without reverse lookup tables.
> 

You are right I don't want to rewrite vm. But I can go thru virtual side
taking note of the physical address. I.e. base the decision to try and
free pages not on how old the page is but on what it's physical address
is.

You see, I don't want to find a few pages in 16mb range in 512mb system.

I want to find a few pages _outside_ 64mb range in a 512mb system. 
So if I free 70mb I _will_ be able to find at least 2mb in my desired
range. In fact I won't have to free that much as they it will work is
"try to free the page", "if succeed do not return to memory pool but
instead give to the 'special region list'"

Does this make sense ?

                         Vladimir Dergachev

