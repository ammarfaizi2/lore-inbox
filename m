Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281817AbRLQSN5>; Mon, 17 Dec 2001 13:13:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281841AbRLQSNj>; Mon, 17 Dec 2001 13:13:39 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:35665 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S281817AbRLQSNb>; Mon, 17 Dec 2001 13:13:31 -0500
Date: Mon, 17 Dec 2001 19:13:00 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: GOTO Masanori <gotom@debian.org>, Andrew Morton <akpm@zip.com.au>,
        Suresh Gopalakrishnan <gsuresh@cs.rutgers.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: O_DIRECT wierd behavior..
Message-ID: <20011217191300.L2431@athlon.random>
In-Reply-To: <20011217181840.G2431@athlon.random> <Pine.LNX.4.21.0112171757530.2812-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.21.0112171757530.2812-100000@localhost.localdomain>; from hugh@veritas.com on Mon, Dec 17, 2001 at 06:07:47PM +0000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2001 at 06:07:47PM +0000, Hugh Dickins wrote:
> On Mon, 17 Dec 2001, Andrea Arcangeli wrote:
> > 
> > I'm unsure (it's basically a matter of API, not something a kernel
> > developer can choose liberally), and the SuSv2 is not saying anything about
> > O_SYNC failures in the write(2) manapge, but I guess it would be at
> > least saner to put the "pos" backwards if we fail osync but we just
> > written something (so if we previously advanced pos).
> 
> I don't have references to back me up, don't take my word for it:
> but I'm sure that the correct behaviour for a partially successful
> read or write in any UNIX is that it return the count done, O_SYNC
> or not, and file position should match that count; only when none
> has been done is -1 returned with errno set.  Most implementations will
> get this wrong in one corner or another, but that's how it should be.

that's how linux handles it and as said incidentally it really looked
intentional to me as well (and Andrew's patch to return error even if
something was written without at least updating "pos" looked wrong). but
without any change ala Andrew, we cannot get errors back from O_SYNC if
at least one byte was written successfully to the cache (not to disk).
So I also see Andrew's point in doing those changes...

Andrea
