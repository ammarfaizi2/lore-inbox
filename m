Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269780AbRHDDlg>; Fri, 3 Aug 2001 23:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269783AbRHDDlQ>; Fri, 3 Aug 2001 23:41:16 -0400
Received: from [63.209.4.196] ([63.209.4.196]:62735 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S269780AbRHDDlK>; Fri, 3 Aug 2001 23:41:10 -0400
Date: Fri, 3 Aug 2001 20:38:49 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ben LaHaise <bcrl@redhat.com>
cc: Daniel Phillips <phillips@bonn-fries.net>,
        Rik van Riel <riel@conectiva.com.br>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: [RFC][DATA] re "ongoing vm suckage"
In-Reply-To: <Pine.LNX.4.33.0108032318330.14842-100000@touchme.toronto.redhat.com>
Message-ID: <Pine.LNX.4.33.0108032036120.15155-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 3 Aug 2001, Ben LaHaise wrote:
>
> No.  Here's the bug in the block layer that was causing the throttling not
> to work.  Leave the logic in, it has good reason -- think of batching of
> io, where you don't want to add just one page at a time.

I absolutely agree on the batching, but this has nothing to do with
batching. The batching code uses "batch_requests", and the fact that we
free the finished requests to another area.

The ll_rw_block() code really _is_ broken. As proven by the fact that it
doesn't even get invoced most of the time.. And the times it _does_ get
invoced is exactly when it shouldn't (guess what the biggest user of
"ll_rw_block()" tends to be? "bread()")

		Linus

