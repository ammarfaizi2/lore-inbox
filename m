Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265830AbSKKRSP>; Mon, 11 Nov 2002 12:18:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265844AbSKKRSP>; Mon, 11 Nov 2002 12:18:15 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:4111 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265830AbSKKRSO>; Mon, 11 Nov 2002 12:18:14 -0500
Date: Mon, 11 Nov 2002 09:24:32 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "David S. Miller" <davem@redhat.com>, <geert@linux-m68k.org>,
       Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <dledford@redhat.com>, Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] NCR53C9x ESP: C99 designated initializers
In-Reply-To: <1037019925.2887.21.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0211110915470.1805-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 11 Nov 2002, Alan Cox wrote:
> 
> The stupid thing is we take the lock then call the eh function then drop
> it. You can drop the lock, wait and retake it. I need to fix a couple of
> other drivers to do a proper wait and in much the same way.

Hmm.. I wonder if the thing should disable the queue (plug it) and release 
the lock before calling reset. I assume we don't want any new requests at 
this point anyway, and having the low-level drivers know about stopping 
the queue etc sounds like a bad idea..

Of course, I suspect that it is potentially a bad idea to have the reset
functionality at the SCSI level _at_all_. As usual, the higher layers
don't really know what is going on, and the lower levels on smarter cards
are likely to be doing the right thing on their own, no?

(Yes, we should improve the infrastructure for having per-command timeouts 
etc, but the reset/abort callbacks have always been strange)

		Linus

