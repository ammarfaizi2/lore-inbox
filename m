Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277612AbRKACGp>; Wed, 31 Oct 2001 21:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277585AbRKACGg>; Wed, 31 Oct 2001 21:06:36 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:6768 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S277612AbRKACG1>; Wed, 31 Oct 2001 21:06:27 -0500
Date: Thu, 1 Nov 2001 03:06:53 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Ben Smith <ben@google.com>
Cc: Rik van Riel <riel@conectiva.com.br>,
        Daniel Phillips <phillips@bonn-fries.net>,
        linux-kernel@vger.kernel.org
Subject: Re: Google's mm problem - not reproduced on 2.4.13
Message-ID: <20011101030653.X1291@athlon.random>
In-Reply-To: <Pine.LNX.4.33L.0110312341030.2963-100000@imladris.surriel.com> <3BE0AB8D.3040400@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3BE0AB8D.3040400@google.com>; from ben@google.com on Wed, Oct 31, 2001 at 05:55:25PM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2001 at 05:55:25PM -0800, Ben Smith wrote:
> >>>*Just in case* it's oom-related I've asked Ben to try it with one less than
> >>>the maximum number of memory blocks he can allocate.
> >>>
> >>I've run this test with my 3.5G machine, 3 blocks instead of 4 blocks,
> >>and it has the same behavior (my app gets killed, 0-order allocation
> >>failures, and the system stays up.
> >>
> > 
> > If you still have swap free at the point where the process
> > gets killed, or if the memory is file-backed, then we are
> > positive it's a kernel bug.
> 
> This machine is configured without a swap file. The memory is file backed, 

ok fine on this side. so again, what's happening is the equivalent of
mlock lefting those mappings locked. It seems the previous mlock is
forbidding the cache to be released. Otherwise I don't see why the
kernel shouldn't release the cache correctly. So it could be an mlock
bug in the kernel.

Andrea
