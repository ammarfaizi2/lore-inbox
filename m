Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261783AbTDUSdL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 14:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261805AbTDUSdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 14:33:11 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:35343 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S261783AbTDUSch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 14:32:37 -0400
Date: Mon, 21 Apr 2003 11:44:59 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Christoph Hellwig <hch@infradead.org>
cc: Roman Zippel <zippel@linux-m68k.org>, "David S. Miller" <davem@redhat.com>,
       <Andries.Brouwer@cwi.nl>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] new system call mknod64
In-Reply-To: <20030421193546.A10287@infradead.org>
Message-ID: <Pine.LNX.4.44.0304211141590.9109-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 21 Apr 2003, Christoph Hellwig wrote:
> 
> Just think s/major/dev_lo/g and s/minor/dev_hi/g.  This is the
> represantation for a legacy protocol.  Just because fat thinks
> of a filename as 8+3 Linux filenames don't have to be that format.

Yes, we could make dev_t's internally be always 32+32, and do the
marshalling at stat() time. That would actually be my preferred approach, 
and would solve some of the problems with using "dev_t" as an opaque type 
right now (ie it would solve the "discontiguous region" issue.

> Umm, no.  You're far to major/minor biased to realized live get a lot
> sipler for use if we don't do any complicated mapping of old dev_t
> to the larger dev_t.

We HAVE to do the mapping somewhere. Old applications only use the lower 
16 bits, and that's just something that MUST NOT be broken. 

The question is only _where_ (not whether) we do the mapping. Right now we 
keep "dev_t" in teh same format as we give back to user space, and thus we 
always map into that format internally. But we don't have to: we can have 
an internal format that is different from the one we show users.

		Linus

