Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293726AbSCGWLs>; Thu, 7 Mar 2002 17:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310306AbSCGWLj>; Thu, 7 Mar 2002 17:11:39 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:10500 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S310231AbSCGWL3>;
	Thu, 7 Mar 2002 17:11:29 -0500
Date: Thu, 7 Mar 2002 19:10:14 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrew Morton <akpm@zip.com.au>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, <yodaiken@fsmlabs.com>,
        Jeff Dike <jdike@karaya.com>, Benjamin LaHaise <bcrl@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Arch option to touch newly allocated pages
In-Reply-To: <3C87E35E.B841801D@zip.com.au>
Message-ID: <Pine.LNX.4.44L.0203071908380.2181-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Mar 2002, Andrew Morton wrote:

> > 5) the growing in (3) and shrinking in (4) mean that
> >    the readahead size of all streaming IO in the system
> >    gets automatically balanced against each other and
> >    against other memory demand in the system
>
> Doesn't work.
>
> Ah, this is hard to describe.
>
> umm.
>
> a) Suppose that we're getting readahead thrashing.  readahead
>    pages are getting dropped.  So we keep seeking to each
>    file to get new data, so we do a ton of seeking.
>
> b) Suppose that we nicely detect thrashing and reduce the readahead
>    window.  Well, we *still* need to seek to each file to read
>    some blocks.
>
> See?  They're equivalent.  In case a) we're doing more (pointless)
> I/O, but the cost of that is vanishingly small because it's just
> one request.
>
> So what *is* a solution.  Well, there's only so much memory available.
> In either case a) or case b) we're "fairly" distributing that memory
> between all files.  And that's the problem.  *All* the files have too
> small a readahead window.  Which points one at: we need to stop being
> fair. We need to give some files a good readahead window and others
> not.   The "soft pinning" which I propose with GFP_READAHEAD and
> PG_readhead might have that effect, I think.

Actually, it could boil down to something more:

use-once reduces the VM to FIFO order, which suffers from
belady's anomaly so it doesn't matter much how much memory
you throw at it

drop-behind will suffer the same problem once the readahead
memory is too large to keep in the system, but at least the
already-used pages won't kick out readahead pages

regards,

Rik
-- 
<insert bitkeeper endorsement here>

http://www.surriel.com/		http://distro.conectiva.com/

