Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129401AbRAPCtN>; Mon, 15 Jan 2001 21:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129406AbRAPCtD>; Mon, 15 Jan 2001 21:49:03 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:44045 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129401AbRAPCsv>; Mon, 15 Jan 2001 21:48:51 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: pre5 VM feedback..
Date: 15 Jan 2001 18:48:32 -0800
Organization: Transmeta Corporation
Message-ID: <940cq0$6fe$1@penguin.transmeta.com>
In-Reply-To: <3A63A9AE.345CBAF3@mandrakesoft.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3A63A9AE.345CBAF3@mandrakesoft.com>,
Jeff Garzik  <jgarzik@mandrakesoft.com> wrote:
>$!@#@! pre6 is already out :)

Yes, and for heavens sake don't use it, because the reiserfs merge got
some dirty inode logic wrong. pre7 fixes just that one line and should
be ok again.

>Anyway, this may be a totally subjective (and incorrect) perception, but
>it seems to me like the recent 2.4.x-test kernels and thereafter start
>swapping things out really quickly.  Case in point:  "diff -urN
>linux.vanilla linux" command swaps out Konqueror and Netscape Mail, even
>though I was using them only a few minutes ago.

Yes. It's really nice for some stuff, but a bit too aggressive for
normal use, I think.

If you want to play with tuning, I'd suggest something like

 - make SWAP_SHIFT bigger (try with 7 instead of 5)

 - do the "self-swap-out" only for __GFP_VM allocations, and add the
   __GFP_VM flag to all page fault allocations (ie __GPF_VM would be a
   flag that says "this allocation will grow my RSS"). 

The latter is kind of debatable - some allocations can't easily be put
in one category or the other (ie page cache growing - do we do it
because of the page cache or because we want to map the page?)

		Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
