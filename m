Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261968AbREZXDR>; Sat, 26 May 2001 19:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262649AbREZXBc>; Sat, 26 May 2001 19:01:32 -0400
Received: from zeus.kernel.org ([209.10.41.242]:20647 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S262621AbREZXAc>;
	Sat, 26 May 2001 19:00:32 -0400
Date: Sat, 26 May 2001 09:03:58 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Rik van Riel <riel@conectiva.com.br>, Ben LaHaise <bcrl@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.5
In-Reply-To: <20010526173847.C9634@athlon.random>
Message-ID: <Pine.LNX.4.21.0105260900250.3772-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 26 May 2001, Andrea Arcangeli wrote:
> 
> getblk still needs to use SLAB_BUFFER, not sure how many callers will be
> allowed to use SLAB_KERNEL, but certainly the "async" name was not very
> appropriate to indicate if the bh allocation can fail or not.

Note that these days, on reasonable filesystems, getblk() and friends are
only used by meta-data. So on a normal setup that uses the page cache for
data (pretty much everything), you'd probably go from "100% SLAB_BUFFER"
to "less than 10% SLAB_BUFFER".

Which should cut down on the "this can happen under real load" stuff. 

Assuming, of course, that there aren't any other causes. I can imagine
schenarios where the buffer heads are the major cause of problems, and the
fact that Rik special-cased GFP_BUFFER makes me suspect that that is _his_
schenario, but there may be other, less obvious, ways to get into similar
trouble.

MM is hard. No question about it.

		Linus

