Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261411AbSKKWQ5>; Mon, 11 Nov 2002 17:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261448AbSKKWQ5>; Mon, 11 Nov 2002 17:16:57 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:33445 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261411AbSKKWQ4>; Mon, 11 Nov 2002 17:16:56 -0500
Subject: Re: [PATCH] NCR53C9x ESP: C99 designated initializers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "David S. Miller" <davem@redhat.com>, geert@linux-m68k.org,
       Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       dledford@redhat.com, Jens Axboe <axboe@suse.de>
In-Reply-To: <Pine.LNX.4.44.0211110915470.1805-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0211110915470.1805-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 11 Nov 2002 22:48:17 +0000
Message-Id: <1037054898.4648.59.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-11-11 at 17:24, Linus Torvalds wrote:
> 
> On 11 Nov 2002, Alan Cox wrote:
> > 
> > The stupid thing is we take the lock then call the eh function then drop
> > it. You can drop the lock, wait and retake it. I need to fix a couple of
> > other drivers to do a proper wait and in much the same way.
> 
> Hmm.. I wonder if the thing should disable the queue (plug it) and release 
> the lock before calling reset. I assume we don't want any new requests at 
> this point anyway, and having the low-level drivers know about stopping 
> the queue etc sounds like a bad idea..

Thats already being dealt with. The eh handler is a seperate thread
called after things are reasonably sane so that it can attempt recovery
and do so in a sleeping context if need be. The eh ones are actually
very except for the fact they take the lock before calling

