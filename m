Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276962AbRJCUCW>; Wed, 3 Oct 2001 16:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276963AbRJCUCN>; Wed, 3 Oct 2001 16:02:13 -0400
Received: from h24-78-175-24.vn.shawcable.net ([24.78.175.24]:38529 "EHLO
	oof.localnet") by vger.kernel.org with ESMTP id <S276962AbRJCUCE>;
	Wed, 3 Oct 2001 16:02:04 -0400
Date: Wed, 3 Oct 2001 13:02:04 -0700
From: Simon Kirby <sim@netnation.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ben Greear <greearb@candelatech.com>, jamal <hadi@cyberus.ca>,
        Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Robert Olsson <Robert.Olsson@data.slu.se>,
        Benjamin LaHaise <bcrl@redhat.com>, netdev@oss.sgi.com,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
Message-ID: <20011003130203.A2315@netnation.com>
In-Reply-To: <3BBB31F4.C223E12E@candelatech.com> <Pine.LNX.4.33.0110030920500.9427-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0110030920500.9427-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 03, 2001 at 09:33:12AM -0700, Linus Torvalds wrote:

> Note that the big question here is WHO CARES?
> 
> There are two issues, and they are independent:
>  (a) handling of network packet flooding nicely
>  (b) handling screaming devices nicely.
> 
> First off, some comments:
>  (a) is not a major security issue. If you allow untrusted users full
>      100/1000Mbps access to your internal network, you have _other_
>      security issues, like packet sniffing etc that are much much MUCH
>      worse. So the packet flooding thing is very much a corner case, and
>      claiming that we have a big problem is silly.
> 
>      HOWEVER, (a) _can_ be a performance issue under benchmark load.
>      Benchmarks (unlike real life) are almost always set up to have full
>      network bandwidth access, and can show this issue.

Actually, the way I first started looking at this problem is the result
of a few attacks that have happened on our network.  It's not just a
while(1) sendto(); UDP spamming program that triggers it -- TCP SYN
floods show the problem as well, and _there is no way_ to protect against
this without using syncookies or some similar method that can only be
done on the receiving TCP stack only.

At one point, one of our webservers received 30-40Mbit/sec of SYN packets
sustained for almost 24 hours.  Needless to say, the machine was not
happy.

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]
