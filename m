Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314835AbSEaXDf>; Fri, 31 May 2002 19:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315276AbSEaXDe>; Fri, 31 May 2002 19:03:34 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:22020 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S314835AbSEaXDd>; Fri, 31 May 2002 19:03:33 -0400
Date: Fri, 31 May 2002 16:02:53 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 5/18] mark swapout pages PageWriteback()
In-Reply-To: <20020531205809.GV1172@dualathlon.random>
Message-ID: <Pine.LNX.4.33.0205311559330.13043-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 31 May 2002, Andrea Arcangeli wrote:
> 
> In short the same way MAP_ANON must pageout correctly, also MAP_SHARED
> must swapout correctly with very vm intensive conditions.

That is true, but it is ignoring the fact that there _are_ real technical 
differences between swap cache mappings and regular shared mappings.

One major difference is the approach to the last user: a last use of a 
shared mapping still needs to write out dirty state, while the last use of 
a swap page is better off noticing that it should just optimize away the 
write, and we can just turn the page back into a dirty anonymous page.

But the differences are much smaller than many of the similarities.

		Linus

