Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273065AbRJQARr>; Tue, 16 Oct 2001 20:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273176AbRJQARh>; Tue, 16 Oct 2001 20:17:37 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:35918 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S273108AbRJQAR2>; Tue, 16 Oct 2001 20:17:28 -0400
Date: Wed, 17 Oct 2001 02:12:42 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: rwhron@earthlink.net
Cc: linux-kernel@vger.kernel.org, ltp-list@lists.sourceforge.net
Subject: Re: VM test on 2.4.13-pre3aa1 (compared to 2.4.12-aa1 and 2.4.13-pre2aa1)
Message-ID: <20011017021242.S2380@athlon.random>
In-Reply-To: <20011016081639.A209@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20011016081639.A209@earthlink.net>; from rwhron@earthlink.net on Tue, Oct 16, 2001 at 08:16:39AM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2001 at 08:16:39AM -0400, rwhron@earthlink.net wrote:
> 
> Summary:
> 
> Wall clock time for this test has dropped dramatically (which
> is good) over the last 3 Andrea Arcangeli patched kernels.

:) I worked the last two days to make it faster under swap, it's nice to
see that your tests also confirm that.  I'm only scared it swaps too
much when swap is not used but if this sorts out to be the case it will
be very easy to fix. And a very minor bit of very seldom background
pagetable scanning shouldn't hurt anyways. So far on my desktop it seems
not to swap too much.

> mp3blaster sounds less pleasant though.

A (very) optimistic theory could be that the increase of the swap
throughput is decreasing the bandiwth available to read the mp3 8). Do
you swap on the same physical disk where you keep the mp3? But it maybe
that I'm blocking too easily waiting for I/O completion instead, or that
the mp3blast routines needed for the playback are been swapped out,
dunno with only this info. You can rule out the "mp3blast is been
swapped out" by running mp3blast after an mlockall. And you can avoid
the disk bandwith problems by putting the mp3 in a separate disk.

So far I received very good feedback about 2.4.13pre3aa1 [also Luigi's
and Mario's problems gone away completly] (I'm also happy myself on my
machine). It may need further tuning but I'd hope it's only a matter of
changing some line of code.

>  3  3  0  47424   3788   1172   1412 860 40228   892 40236  789   819  12  23  66
>  0  5  1  90244   1656   1184   1416 1032 39568  1076 39572  653   425   6   5  89

those swapins could be due mp3blast that is getting swapped out
continously while it sleeps.  Not easy for the vm to understand it has
to stay in cache and it makes sense it gets swapped out faster, the
faster the swap rate is. Could you also make sure to run mp3blast with
-20 priority and the swap-hog at +19 priority just in case?

thanks for feedback!

Andrea
