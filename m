Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271844AbRIQQen>; Mon, 17 Sep 2001 12:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271809AbRIQQed>; Mon, 17 Sep 2001 12:34:33 -0400
Received: from ns.ithnet.com ([217.64.64.10]:13830 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S271834AbRIQQeW>;
	Mon, 17 Sep 2001 12:34:22 -0400
Date: Mon, 17 Sep 2001 18:34:33 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, <ast@domdv.de>
Subject: Re: broken VM in 2.4.10-pre9
Message-Id: <20010917183433.5b992e74.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.33.0109170846050.8847-100000@penguin.transmeta.com>
In-Reply-To: <20010917173555.460c8ea3.skraw@ithnet.com>
	<Pine.LNX.4.33.0109170846050.8847-100000@penguin.transmeta.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Sep 2001 08:51:54 -0700 (PDT) Linus Torvalds
<torvalds@transmeta.com> wrote:

> 
> On Mon, 17 Sep 2001, Stephan von Krawczynski wrote:
> >
> > - cpu load goes pretty high (11-12 according to xosview)during several
> > occasions, upto the point where you cannot even move the mouse. Compared to
an
> > once tested ac-version it is not _that_ nice. I have some problems cat'ing
> > /proc/meminfo, too. I takes sometimes pretty long (minutes).
> 
> It's not really CPU load - the loadaverage in Linux (and some other UNIXes
> too) also accounts for disk wait.

Well, what I meant was: compared to the _same_ situation and test bed, the load
seems "pretty high". ac versions are somewhat lower in this setup.

> > - the meminfo shows me great difference to former versions in the balancing
of
> > inact_dirty and active. This pre10 tends to have a _lot_ more inact_dirty
pages
> > than active (compared to pre9 and before) in my test. I guess this is
intended
> > by this (used-once) patch. So take this as a hint, that your work performs
as
> > expected.
> 
> No, I think they are related, and bad. I suspect it just means that pages
> really do not get elevated to the active list, and it's probably _too_
> unwilling to activate pages. That's bad too - it means that the inactive
> list is the one solely responsible for working set changes, and the VM
> won't bother with any other pages. Which also leads to bad results..

Hm, remember my setup: I read a lot from CD, write it to disk and read a lot
from nfs and write it to disk. Basically both are read once - write once
setups, so the pages are touched once (or worst twice) at maximum, so I see a
good chance none of them ever make it to the active list, according to your
state explanation from previous posts. And thats what I see (I guess). If I do
a CD compare (read disk, read CD and compare) I see lots of pages walk over to
active. And that again looks as you told before. I think it does work as you
said.
Anyway I cannot "feel" a difference in performance (maybe even worse than
before), but it _looks_ cleaner. How about taking it as a first step in the
cleanup direction? :-)

Regards, Stephan

