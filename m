Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261317AbSJ1PxH>; Mon, 28 Oct 2002 10:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261318AbSJ1PxH>; Mon, 28 Oct 2002 10:53:07 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:6310 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S261317AbSJ1PxG>;
	Mon, 28 Oct 2002 10:53:06 -0500
Date: Mon, 28 Oct 2002 15:59:21 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Andi Kleen <ak@suse.de>, eggert@twinsun.com, linux-kernel@vger.kernel.org
Subject: Re: nanosecond file timestamp resolution in filesystems, GNU make, etc.
Message-ID: <20021028155921.GA16929@bjl1.asuk.net>
References: <20021028151309.GB16546@bjl1.asuk.net> <Pine.GSO.3.96.1021028161702.977I-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1021028161702.977I-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej W. Rozycki wrote:
> > It's already there.  The kernel stat64() syscall has a flags argument,
> > which is unused at the moment.  I presume it's for this purpose.
> 
>  Hmm, I haven't thought of this argument to be used this way.  Actually it
> isn't currently initialized by glibc in any way, which makes its utility
> questionable.

You are right.  I just checked dietlibc and uclibc - neither of them
initialise the flags argument.  It should be deleted from the kernel,
because nobody can use it.

On the bright side (for my specific request of st_resolution), it
seems every architecture has a different size reserved for st_dev and
st_rdev in struct stat64:

	- i386: 12 bytes (8 bytes used by Glibc)
	- SPARC: 8 bytes (all needed for 8 byte dev_t, but space elsewhere)
	- ARM:  12 bytes
	- MIPS: 16 bytes (!)
	- S390: 12 bytes
	- Alpha: not obvious what's used - is int 64 bits wide on Alpha?
                 if it's not, other changes need for 64-bit dev_t anyway.

All the architectures I've looked at have two words available in
struct stat64, if they have struct stat64, but the available space is
in different places for each architecture.

-- Jamie

