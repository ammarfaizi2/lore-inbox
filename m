Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287134AbSBDSUI>; Mon, 4 Feb 2002 13:20:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287840AbSBDST7>; Mon, 4 Feb 2002 13:19:59 -0500
Received: from dsl-213-023-038-180.arcor-ip.net ([213.23.38.180]:36756 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S286893AbSBDSTo>;
	Mon, 4 Feb 2002 13:19:44 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Steve Lord <lord@sgi.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: O_DIRECT fails in some kernel and FS
Date: Mon, 4 Feb 2002 19:22:17 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Chris Wedgwood <cw@f00f.org>, Jeff Garzik <garzik@havoc.gtf.org>,
        Chris Mason <mason@suse.com>, Andrea Arcangeli <andrea@suse.de>,
        Andrew Morton <akpm@zip.com.au>, Ricardo Galli <gallir@uib.es>,
        Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <E16XlK0-0007Wu-00@the-village.bc.nu> <1012838546.26363.588.camel@jen.americas.sgi.com>
In-Reply-To: <1012838546.26363.588.camel@jen.americas.sgi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16Xnkv-0004mk-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 4, 2002 05:02 pm, Steve Lord wrote:
> But async I/O itself needs synchronisation (being English in this email ;-)
> to be meaningful. If I issue a bunch of async I/O calls which overlap with
> each other then the outcome is really undefined in terms of what ends up
> on the disk. Scheduling of the actual I/O operations is really no different
> from them being synchronous calls from different user space threads.
> 
> The only questions you can really ask is 'is read atomic with respect to
> write?' and 'are writes atomic with respect to each other?'. So when you
> perform a read it sees data from before or after writes, but never sees
> data from half way through a write. And for multiple write calls the output
> appears as if one write happened after the other, not intermingled
> with each other.

Why is it not ok to have the writes come out intermingled, if that's what the 
user has asked for?  (Implicitly, by not synchronizing the writes.)

> Irix actually takes the viewpoint that it only needs to make a best effort
> at synchronizing between direct I/O and other modes of I/O. Multiple
> direct writers are allowed into a file at once, and direct writers and
> buffered readers are also allowed to operate in parallel. At this point
> coherency is really up to the applications. I am not presenting this as
> a recommended model for linux, just reporting what it does.

I'm having a little trouble with this.  Suppose an application does direct
IO on a file but, unbeknownst to it, some other program has done buffered
IO on the file, so that there are still dirty blocks in the page cache,
waiting to land by surprise on top of unbuffered data.  A third program
may come along to do buffered IO on the file, and find stale blocks in
cache.  Am I missing something here?

-- 
Daniel
