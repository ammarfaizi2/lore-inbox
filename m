Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271741AbRIJVXQ>; Mon, 10 Sep 2001 17:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271742AbRIJVXH>; Mon, 10 Sep 2001 17:23:07 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:63168 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S271741AbRIJVW4>;
	Mon, 10 Sep 2001 17:22:56 -0400
Date: Mon, 10 Sep 2001 22:23:13 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Daniel Phillips <phillips@bonn-fries.net>,
        Linus Torvalds <torvalds@transmeta.com>
Cc: Andreas Dilger <adilger@turbolabs.com>, Andrea Arcangeli <andrea@suse.de>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: linux-2.4.10-pre5
Message-ID: <1728722119.1000160593@[169.254.198.40]>
In-Reply-To: <20010910211135Z16537-26183+875@humbolt.nl.linux.org>
In-Reply-To: <20010910211135Z16537-26183+875@humbolt.nl.linux.org>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Monday, 10 September, 2001 11:18 PM +0200 Daniel Phillips 
<phillips@bonn-fries.net> wrote:

> We lost 78.5 seconds somewhere.  From the sound of the disk drives, I'd
> say  we lost it to seeking, which physical readahead with a large cache
> would be  able to largely eliminate in this case.

So you only get a large % of your 78.5 seconds back
from pure physical readahead if the files and metadata
are (a) ordered in monitonically increasing disk
locations w.r.t. access order, and (b) physically close (no time
wasted reading in irrelevant data), or you apply some
form of clairvoyance patch :-) An alternative benchmark
would be do dd the /entire/ disk into RAM, then
run your diff on that, and I bet you get the
opposite result.

More serious point: if we retain readahead at a
logical level, you get it for non-physical
files too (e.g. NFS) - I presume this is
the intention. If so, what advantage does
additional physical readahead give you,
given physical ordering is surely no better
(and probably worse than) logical ordering.

--
Alex Bligh
