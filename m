Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261907AbREYVNf>; Fri, 25 May 2001 17:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261910AbREYVNZ>; Fri, 25 May 2001 17:13:25 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:11281 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261907AbREYVNT>; Fri, 25 May 2001 17:13:19 -0400
Date: Fri, 25 May 2001 14:12:48 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [with-PATCH-really] highmem deadlock removal, balancing & cleanup
In-Reply-To: <Pine.LNX.4.33.0105251659290.10469-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.31.0105251410040.7867-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 25 May 2001, Rik van Riel wrote:
>
> OK, shoot me.  Here it is again, this time _with_ patch...

I'm not going to apply this as long as it plays experimental games with
"shrink_icache()" and friends. I haven't seen anybody comment on the
performance on this, and I can well imagine that it would potentially
shrink the dcache too aggressively when there are lots of inactive-dirty
pages around, where page_launder is the right thing to do, and shrinking
icache/dcache might not be.

I'd really like to avoid having the MM stuff fluctuate too much. Have
people tested this under different loads etc?

		Linus

