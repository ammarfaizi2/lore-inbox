Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262330AbUBYA6Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 19:58:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262253AbUBYA6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 19:58:16 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:30178 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S262330AbUBYA6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 19:58:14 -0500
From: Darren Williams <dsw@gelato.unsw.edu.au>
To: Manfred Spraul <manfred@colorfullife.com>
Date: Wed, 25 Feb 2004 11:58:04 +1100
Cc: LKML <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: [BUG] 2.6.3 Slab corruption: errors are triggered when memory exceeds 2.5GB (correction)
Message-ID: <20040225005804.GE18070@cse.unsw.EDU.AU>
References: <403AF155.1080305@colorfullife.com> <20040223225659.4c58c880.akpm@osdl.org> <403B8C78.2020606@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <403B8C78.2020606@colorfullife.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Manfred

I have updated to the latest bk and new output can be found at:
http://quasar.cse.unsw.edu.au/~dsw/public-files/lemon-debug/
kern-log-bk

Also I am quite confident that it is not a hardware problem.

I took a look at alloc_skb(..) and there is a reference to
an atomic_t token with this being the most suspect

150> atomic_set(&(skb_shinfo(skb)->dataref), 1);

Not sure though.

Darren


On Tue, 24 Feb 2004, Manfred Spraul wrote:

> Andrew Morton wrote:
> 
> >Actually, it's often caused by someone doing atomic_dec_and_test() against
> >something which was already freed.
> >
> The previous user is always kfree_skbmem - I would be surprised if there 
> are atomic operations against the skb data area.
> 
> Darren, could you try the latest bk snapshot? Linus yesterday merged a 
> patch that hexdumps the affected bytes. We must try to find a pattern - 
> always same offset into a page, always same physical address, always 
> same offset into the object, etc.
> 
> --
>    Manfred
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--------------------------------------------------
Darren Williams <dsw AT gelato.unsw.edu.au>
Gelato@UNSW <www.gelato.unsw.edu.au>
--------------------------------------------------
