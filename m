Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129716AbRACSnE>; Wed, 3 Jan 2001 13:43:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130075AbRACSmy>; Wed, 3 Jan 2001 13:42:54 -0500
Received: from hermes.mixx.net ([212.84.196.2]:25107 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S129716AbRACSmp>;
	Wed, 3 Jan 2001 13:42:45 -0500
Message-ID: <3A536ADD.BB38E3C7@innominate.de>
Date: Wed, 03 Jan 2001 19:09:33 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-prerelease i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Tobias Ringstrom <tori@tellus.mine.nu>, linux-kernel@vger.kernel.org
Subject: Re: Benchmarking 2.2 and 2.4 using hdparm and dbench 1.1
In-Reply-To: <Pine.LNX.4.21.0101031755090.4448-200000@svea.tellus>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tobias Ringstrom wrote:
> 3) The 2.2 kernels outperform the 2.4 kernels for few clients (see
>    especially the "dbench 1" numbers for the PII-128M.  Oops!

I noticed that too.  Furthermore I noticed that the results of the more
heavily loaded tests on the whole 2.4.0 series tend to be highly
variable (usually worse) if you started by moving the whole disk through
cache, e.g., fsck on a damaged filesystem.

> The reason for doing the benchmarks in the first place is that my 32MB P90
> at home really does perform noticeably worse with samba using 2.4 kernels
> than using 2.2 kernels, and that bugs me.  I have no hard numbers for that
> machine (yet).  If they will show anything extra, I will post them here.
> Btw, has anyone else noticed samba slowdowns when going from 2.2 to 2.4?

Again, yes, I saw that.

> Wow!  You made it all the way down here.  Congratulations!  :-)

Heh.  Yes, then I read it all again backwards.  I'll respectfully bow
out of the benchmarking business now.  :-)

It would be great if you could track the ongoing progress - you could go
so far as to automatically download the latest patch and rerun the
tests.  (We have a script like that here to keep our lxr/cvs tree
current.)  And yes, it gets more important to consider some of the other
usage patterns so we don't end up with self-fullfilling prophecies.

For benchmarking it would be really nice to have a way of emptying
cache, beyond just syncing.  I took a look at that last week and
unfortunately it's not trivial.  The things that have to be touched are
optimized for the steady-state running case and tend to take their
marching orders from global variables and embedded heuristics that you
don't want to mess with.  Maybe I'm just looking at this problem the
wrong way because the shortest piece of code I can imagine for doing
this would be 1-200 lines long and would replicate a lot of the
functionality of page_launder and flush_dirty_pages, in other words it
would be a pain to maintain.

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
