Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266210AbSKLFOf>; Tue, 12 Nov 2002 00:14:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266212AbSKLFOf>; Tue, 12 Nov 2002 00:14:35 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:65495 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S266210AbSKLFOe>;
	Tue, 12 Nov 2002 00:14:34 -0500
Date: Tue, 12 Nov 2002 05:21:13 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       "'mingo@redhat.com'" <mingo@redhat.com>,
       "'Mark Mielke'" <mark@mark.mielke.cc>, linux-kernel@vger.kernel.org
Subject: Re: Users locking memory using futexes
Message-ID: <20021112052113.GA12452@bjl1.asuk.net>
References: <A46BBDB345A7D5118EC90002A5072C7806CAC920@orsmsx116.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A46BBDB345A7D5118EC90002A5072C7806CAC920@orsmsx116.jf.intel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Perez-Gonzalez, Inaky wrote:
> This raises a good point - I guess we should be doing something like
> checking user limits (against locked memory, 'ulimit -l').

If futexes are limited by user limits, that's going to mean some
threading program gets a surprise when too many threads decide to
block on a resource.  That's really nasty.  (Of course, a program can
get a surprise due to just running out of memory in sys_futex() too,
but that's much rarer).

It would be nice if the futex waitqueues could be re-hashed against
swap entries when pages are swapped out, somehow, but this sounds hard.

-- Jamie
