Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277084AbRJHTV7>; Mon, 8 Oct 2001 15:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277089AbRJHTVu>; Mon, 8 Oct 2001 15:21:50 -0400
Received: from femail11.sdc1.sfba.home.com ([24.0.95.107]:63165 "EHLO
	femail11.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S277084AbRJHTVf>; Mon, 8 Oct 2001 15:21:35 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
Organization: Boundaries Unlimited
To: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: [OT] testing internet performance, esp latency/drops?
Date: Mon, 8 Oct 2001 11:21:24 -0400
X-Mailer: KMail [version 1.2]
In-Reply-To: <20011008090203.L26223@work.bitmover.com>
In-Reply-To: <20011008090203.L26223@work.bitmover.com>
MIME-Version: 1.0
Message-Id: <01100811212400.07946@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 08 October 2001 12:02, Larry McVoy wrote:
> Merry kernel hackers, we recently installed a T1 line at bitmover.com and
> expected improved performance.  In some places we got it, pings to places
> in the silicon valley are a respectable 5-9 milliseconds.  FTP performance
> is a predictable 180KB/sec, as expected.
>
> However, web browsing sucks.  On about 80% of all links, there is a
> noticable hesitation, between 1-15 seconds, as it looks up the name and as
> it fetches the first page.  After that point, that site will appear to be
> OK.

You're having a DNS problem then.  (You even say it yourself, "as it looks up 
the name"...)  Unless you've got explicit congestion notification support 
turned on, randomly dropped packets would kill your throughput (or at the 
very least the predictability of it).

Where does your DNS server live?  Can you try using another one, or setting 
up a local cacheing one in your subnet and have your system use that?  (I 
think Red Hat 7.1 can do this pretty easily.  I'd make sure it's only bound 
to an address in your local subnet, though.  BIND is a perpetual security 
nightmare, I keep meaning to write something better in Python (it's a UDP 
protocol, how hard could it be?) but I haven't gotten mad enough to make time 
to do it properly...)

For a DNS server with an empty cache, DNS lookup times of 5 seconds or more 
actually aren't that unusual at ALL, considering that an uncached full resove 
from the root nameservers can bounce you off something like five different 
servers along the way, each adding a second or two of latency...  (Gotta love 
nested zone delegations...)

> It sounds to me like return packets are getting dropped a lot.  Which is
> possible, but I'd like to know for sure.
>
> Before I wander off to write a test for this, I'm wondering if anyone
> knows of a test suite or a methodology which works.  I was thinking
> about just coding every reference in bookmarks/history into a driver
> file which drove a connect-o-matic program that timed how fast it
> could connect to each of those sites.  Any comments on that idea?

Seperate out connecting to the sites (by IP) from doing the DNS lookups.  If 
your DNS lookups are the problem, the actually connect is just noise in your 
test.

Try playing around with "dig" for a bit.  It's a DNS swiss army knife, with a 
man page that would do justice to the Acme Kitchen Wonder...

Rob
