Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130277AbRBZOeV>; Mon, 26 Feb 2001 09:34:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130265AbRBZOcr>; Mon, 26 Feb 2001 09:32:47 -0500
Received: from zeus.kernel.org ([209.10.41.242]:53191 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130237AbRBZO26>;
	Mon, 26 Feb 2001 09:28:58 -0500
Date: Mon, 26 Feb 2001 07:24:35 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mike Galbraith <mikeg@wen-online.de>,
        Linus Torvalds <torvalds@transmeta.com>,
        Shawn Starr <spstarr@sh0n.net>, lkm <linux-kernel@vger.kernel.org>
Subject: Re: [ANOMALIES]: 2.4.2 - __alloc_pages: failed - Patch failed
In-Reply-To: <E14XJvZ-0000rF-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0102260610030.5276-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 26 Feb 2001, Alan Cox wrote:

> > We can add an allocation flag (__GFP_NO_CRITICAL?) which can be used by
> > sg_low_malloc() (and other non critical allocations) to fail previously
> > and not print the message. 
> 
> It is just for debugging. The message can go. If anytbing it would be more
> useful to tack Failed alloc data on the end of /proc/slabinfo

The issue is not the warn message.

Non critical allocations (such as this case of sg_low_malloc()) are trying
to get additional memory to optimize things -- we want the allocator to be
lazy and fail previously instead doing hard work. If kswapd cannot keep up
with the memory pressure, we're surely in a memory shortage state.

Its better to get out of the memory shortage instead running into OOM
because of some optimization, I guess.

Another example of such a flag is swapin readahead.

