Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292207AbSBBDCx>; Fri, 1 Feb 2002 22:02:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292208AbSBBDCn>; Fri, 1 Feb 2002 22:02:43 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10248 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292207AbSBBDCf>;
	Fri, 1 Feb 2002 22:02:35 -0500
Message-ID: <3C5B56A4.B762948F@zip.com.au>
Date: Fri, 01 Feb 2002 19:01:56 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>,
        vandrove@vc.cvut.cz, torvalds@transmeta.com, garzik@havoc.gtf.org,
        linux-kernel@vger.kernel.org, paulus@samba.org, davidm@hpl.hp.com,
        ralf@gnu.org
Subject: Re: [PATCH] Re: crc32 and lib.a (was Re: [PATCH] nbd in 2.5.3 does
In-Reply-To: <20020131.145904.41634460.davem@redhat.com> <E16WQYs-0003Ux-00@the-village.bc.nu>,
		<E16WQYs-0003Ux-00@the-village.bc.nu> <20020202021242.GA6770@tapu.f00f.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
> 
> On Thu, Jan 31, 2002 at 11:24:10PM +0000, Alan Cox wrote:
> 
>     Because 100 4K drivers suddenly becomes 0.5Mb. There are those of
>     us trying to stuff Linux into embedded devices who if anything
>     want more configuration options not people taking stuff out.
> 
> Well, I'm more or less in agreement here, especially when working with
> small embedded devices which have a few (say 16 or 32) MB of RAM for
> EVERYTHING, kernel, userspace AND filesystems.
> 
> However, I wonder if we can't have the linker remove unnecessary and
> unreferences objects, functions and variables?

We can.  Graham Stoney had all this going against 2.2.  See

http://www.google.com/search?q=stoney+ffunction-sections&hl=en&start=10&sa=N
http://www.cs.helsinki.fi/linux/linux-kernel/Year-2000/2000-29/0415.html

>     What I'd much rather see if this is an issue is:
> 
>     bool        'Do you want to customise for a very small system'
> 
> _IF_ the linker can remove things, it would simplify this too --- we
> could if a few important places produce code slightly differently to
> favour speed over size and not reference various things.  Also, the
> above option would turn-off inlining as that seems to makie quite a
> difference at times (BTW, I'm not sure about this, but it seems gcc
> and C99 don't agree with static/extern inline semantics?)

The kernel doesn't link when you compile with -fno-inline because of all
the `extern inline' qualifiers.  These need to be converted to `static
inline'.    Jim Houston has a script which does this.  See

	http://www.uwsg.iu.edu/hypermail/linux/kernel/0201.3/0888.html

It would be rather good if we could get that script run across the
tree - no-inline has its uses at times.

-
