Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271222AbTHCR57 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 13:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271223AbTHCR57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 13:57:59 -0400
Received: from almesberger.net ([63.105.73.239]:1808 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S271222AbTHCR55 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 13:57:57 -0400
Date: Sun, 3 Aug 2003 14:57:37 -0300
From: Werner Almesberger <werner@almesberger.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org,
       Nivedita Singhvi <niv@us.ibm.com>
Subject: Re: TOE brain dump
Message-ID: <20030803145737.B10280@almesberger.net>
References: <20030802140444.E5798@almesberger.net> <3F2BF5C7.90400@us.ibm.com> <3F2C0C44.6020002@pobox.com> <20030802184901.G5798@almesberger.net> <3F2CAE61.7070401@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F2CAE61.7070401@pobox.com>; from jgarzik@pobox.com on Sun, Aug 03, 2003 at 02:40:33AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Really fast, really long pipes in practice don't exist for 99.9% of all 
> Internet users.

It matters to some right now, i.e. the ones who are interested
in TOE in the first place. (And there also those who try to
tweak TCP to actually work over such links. Right now, its
congestion control doesn't scale that well.) Also, IT has been
good at making all that elitarian high-performance gear
available to the common people rather quickly, and I don't see
that changing. The Crisis just alters the pace a little.

> When you approach traffic levels that push you want to offload most of 
> the TCP net stack, then TCP isn't the right solution for you anymore, 
> all things considered.

No. Ironically, TCP is almost always the right solution. 
Sometimes people try to use something else. Eventually, their
protocol wants to go over WANs or something that looks
suspiciously like a WAN (MAN or such). At that point, they
usually realize that TCP provides exactly the functionality
they need.

In theory, one could implement the same functionality in other
protocols. There was even talk at IETF to support a generic
congestion control manager for this purpose. That was many
years ago, and I haven't seen anything come out of this.

So it seems that, by the time your protocol grows up to want
to play in the real world, it wants to be so much like TCP
that you're better off using TCP.

The amusing bit here is to watch all the "competitors" pop
up, grow, fail, and eventually die.

> The Linux net stack just isn't built to be offloaded.

Yes ! And that's not a flaw of the stack, but it's simply a
fact of life. I think that no "real life" stack can be
offloaded (in the traditional sense).

> And I can't see ASIC and firmware 
> designers being excited about implementing netfilter on a PCI card :)

And when they're done with netfilter, you can throw IPsec,
IPv6, or traffic control at them. Eventually, you'll wear
them down ;-)

> Unfortunately some vendors seem to choosing TOE option #3:  TCP offload 
> which introduces many limitations (connection limits, netfilter not 
> supported, etc.) which Linux never had before.

That's when that little word "no" comes into play, i.e.
when their modifications to the stack show up on netdev
or linux-kernel. Dave Miller seems to be pretty good at
saying "no". I hope he keeps on being good at this ;-)

> There is one interesting TOE solution, that I have yet to see created: 
> run Linux on an embedded processor, on the NIC.

That's basically what I've been talking about all the
while :-)

> The Linux OS driver interface becomes a virtual interface
> with a large MTU,

Probably not. I think you also want to push some
knowledge of where the data ultimately goes to the NIC.
This could be something like sendfile, something new, or
just a few bytes of user space code.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina     werner@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
