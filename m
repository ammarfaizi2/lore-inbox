Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263434AbTIWWfq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 18:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263439AbTIWWfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 18:35:45 -0400
Received: from palrel10.hp.com ([156.153.255.245]:38563 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S263434AbTIWWfl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 18:35:41 -0400
Date: Tue, 23 Sep 2003 15:35:40 -0700
From: Grant Grundler <iod00d@hp.com>
To: "David S. Miller" <davem@redhat.com>
Cc: bcrl@kvack.org, tony.luck@intel.com, davidm@hpl.hp.com,
       davidm@napali.hpl.hp.com, peter@chubb.wattle.id.au, ak@suse.de,
       peterc@gelato.unsw.edu.au, linux-ns83820@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: NS83820 2.6.0-test5 driver seems unstable on IA64
Message-ID: <20030923223540.GA10490@cup.hp.com>
References: <DD755978BA8283409FB0087C39132BD101B01194@fmsmsx404.fm.intel.com> <20030923142925.A16490@kvack.org> <20030923185104.GA8477@cup.hp.com> <20030923115122.41b7178f.davem@redhat.com> <20030923203819.GB8477@cup.hp.com> <20030923134529.7ea79952.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030923134529.7ea79952.davem@redhat.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 23, 2003 at 01:45:29PM -0700, David S. Miller wrote:
> Intel actually optimizes this on the P4, what is your
> response to that?  Is Intel wasting they time? :-)

nono...but Intel doesn't have a choice on x86.
They have to optimize for the binaries that are out there.
Compatibility is everything in that market space.

And someone at Intel obviously agrees the newer architectures
should support misaligned access in SW since ever RISC chip
they've built (starting with i860, ~1989) does it that way.

> It's needed on every access to every TCP and IP header portion
> for the case we're talking about in this thread, where the network
> device driver gives the networking a packet that ends up with
> unaligned IP and TCP headers.

Yeah, I don't use most LAN features (PPPoE, VLAN, Appletalk, etc).
I naively thought there must be a subset everyone uses...but defining
that subset sounds like a rat hole I shouldn't go near.

> I once considered adding some get_unaligned() uses to the TCP option
> parsing code, guess who rejected that patch?  It wasn't me, it was
> Linus himself and I came to learn that he's right on this one.

I'm not totally comfortable with that. The NICs I care about seem to
"bias the buffer address" to compensate for some "common case".
Seems like those cases would be cheaper (and more portable) to add
the get_unaligned() calls in the networking stack....I don't know
though really.

thanks,
grant
