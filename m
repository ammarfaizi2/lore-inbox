Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280480AbRKJFYs>; Sat, 10 Nov 2001 00:24:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280496AbRKJFYj>; Sat, 10 Nov 2001 00:24:39 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:14606 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S280480AbRKJFY2>;
	Sat, 10 Nov 2001 00:24:28 -0500
Date: Sat, 10 Nov 2001 16:20:06 +1100
From: Anton Blanchard <anton@samba.org>
To: "David S. Miller" <davem@redhat.com>
Cc: ak@suse.de, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: speed difference between using hard-linked and modular drives?
Message-ID: <20011110162006.C767@krispykreme>
In-Reply-To: <20011109064540.A13498@wotan.suse.de> <20011108.220444.95062095.davem@redhat.com> <20011109073946.A19373@wotan.suse.de> <20011108.231632.18311891.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011108.231632.18311891.davem@redhat.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Hi,

> It _IS_ a big deal.  Fetching _ONE_ hash chain cache line
> is always going to be cheaper than fetching _FIVE_ to _TEN_
> page struct cache lines while walking the list.

Exactly, the reason I found the pagecache hash was too small was because
__find_page_nolock was one of the worst offenders when doing zero copy
web serving of a large dataset.

> Even if prefetch would kill all of this overhead (sorry, it won't), it
> is _DUMB_ and _STUPID_ to bring those _FIVE_ to _TEN_ cache lines into
> the processor just to lookup _ONE_ page.

Yes you cant expect prefetch to help you when you use the data 10
instructions after you issue the prefetch. (ie walking the hash chain)

Anton
