Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266492AbUALWAq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 17:00:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266494AbUALWAq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 17:00:46 -0500
Received: from mail.ccur.com ([208.248.32.212]:35344 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id S266492AbUALWAm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 17:00:42 -0500
Date: Mon, 12 Jan 2004 17:00:24 -0500
From: Joe Korty <joe.korty@ccur.com>
To: Paul Jackson <pj@sgi.com>
Cc: hch@infradead.org, schwab@suse.de, paulus@samba.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: seperator error in __mask_snprintf_len
Message-ID: <20040112220024.GA12748@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <20040107165607.GA11483@rudolph.ccur.com> <20040107113207.3aab64f5.akpm@osdl.org> <20040108051111.4ae36b58.pj@sgi.com> <16381.57040.576175.977969@cargo.ozlabs.ibm.com> <20040109064619.35c487ec.pj@sgi.com> <je1xq9duhc.fsf@sykes.suse.de> <20040109152533.A25396@infradead.org> <20040109092309.42bb6049.pj@sgi.com> <20040112000923.GA2743@tsunami.ccur.com> <20040112134112.2dd0ec42.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040112134112.2dd0ec42.pj@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 12, 2004 at 01:41:12PM -0800, Paul Jackson wrote:
> A couple of questions on your proposed patch for __mask_snprintf_len()
> in lib/mask.c:
> 
>  1) Why make the MASK_CHUNKSZ a possible (compile time) variable?
>     I can think of a couple good reasons why not to:
>     a] So long as we have the current format, in which each word
>        is _not_ zero filled, then the chunk size needs to be a
>        well known constant, or else the output is ambiguous.
>        For example, an output of "1,0" is ambiguous unless we know
>        a priori that the "0" stands for exactly 32, say, bits.
>     b] Even if we change to a zero filled format, better to just
>        always use the same chunk size, as that is one less detail
>        to confuse user level code.
>     I don't see any reason offhand for needing code that works with
>     more than one chunk size.

MASK_CHUNKSZ is a named constant not a variable.  Once we pick a value
it can never change.  The specified legal values are for 1) varying to
test for algorithmic correctness, and 2) giving the list of values from
which we must pick the permanent value before too much more time goes by.


>  2) Why the trailing "buf[len++] = 0"?  Won't the last snprintf do
>     as much?

No.  snprintf will fill to the end of the buffer and not place the
trailing \0 if it has to.  (I read the vsnprintf code this morning
just to make sure of that).

>  3) This code has quite a bit more detail of bit shifts, masks and
>     arithmetic than before.  Perhaps some is necessary to fix the
>     word order bug I had, perhaps some is only needed to allow for
>     the chunk size to vary.  I'll take a shot at seeing if I can
>     find a less detail-rich expression of this that still gets the
>     word order correct.

I am pretty sure the code is within a hairsbreadth of being minimal.
It will be interesting to find out.

Regards
-- 
"Money can buy bandwidth, but latency is forever" -- John Mashey
Joe
