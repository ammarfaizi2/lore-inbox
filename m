Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261866AbTDUSX2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 14:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbTDUSX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 14:23:28 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:29710 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S261866AbTDUSX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 14:23:27 -0400
Date: Mon, 21 Apr 2003 11:35:31 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: viro@parcelfarce.linux.theplanet.co.uk
cc: Christoph Hellwig <hch@infradead.org>,
       Roman Zippel <zippel@linux-m68k.org>,
       "David S. Miller" <davem@redhat.com>, <Andries.Brouwer@cwi.nl>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] new system call mknod64
In-Reply-To: <20030421182734.GN10374@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.44.0304211132130.3101-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 21 Apr 2003 viro@parcelfarce.linux.theplanet.co.uk wrote:
> > I personally think that anything that uses "dev_t" in _any_ other way than 
> > <major,minor> is fundamentally broken.
> 
> Do you consider internal use of MKDEV-produced constants broken?

Since they are always in canonical format, there is no way for them to 
have the aliasing issue. However, even then they _should_ be careful, 
since it would be very confusing (and bad) if they consider

	0x00010100 	(major 1, minor 256)

to be fundamentally different from

	0x01ff		(major 1, minor 255)

and cause problems that way.

In other words, if I'm a device driver, and I say that I want "range 
0-0xfff" for "major 2", then I had better get _all_ of it. That means that 
I'd better get

	0x0200-0x02ff

_and_

	0x00020100-0x00020fff

and quite frankly, I think that ends up being a lot easier to handle if 
you just always consider it to be a <major,minor> split.

(but as long as the end result is equivalent, who cares?)

			Linus

