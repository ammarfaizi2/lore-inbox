Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264864AbTGCBuk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 21:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264929AbTGCBuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 21:50:40 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:17851 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S264864AbTGCBub
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 21:50:31 -0400
Date: Wed, 2 Jul 2003 19:04:45 -0700
From: Larry McVoy <lm@bitmover.com>
To: Mel Gorman <mel@csn.ul.ie>, Daniel Phillips <phillips@arcor.de>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC] My research agenda for 2.7
Message-ID: <20030703020445.GA4379@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Mel Gorman <mel@csn.ul.ie>, Daniel Phillips <phillips@arcor.de>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <200306250111.01498.phillips@arcor.de> <200306262100.40707.phillips@arcor.de> <Pine.LNX.4.53.0306262030500.5910@skynet> <200306270222.27727.phillips@arcor.de> <Pine.LNX.4.53.0306271345330.14677@skynet> <20030702211055.GC13296@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030702211055.GC13296@matchmail.com>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 02, 2003 at 02:10:55PM -0700, Mike Fedyk wrote:
> On Fri, Jun 27, 2003 at 02:00:42PM +0100, Mel Gorman wrote:
> > You're right, I will need to write a proper RFC one way or the other. I
> > was thinking of using slabs because that way there wouldn't be need to
> > scan all of mem_map, just a small number of slabs. I have no basis for
> > this other than hand waving gestures though.
> 
> Mel,
> 
> This sounds much like something I was reading from Larry McVoy using page
> objects (like one level higher in magnatude than pages).
> 
> I don't remember the URL, but there was something pretty extensive from
> Larry already explaining the concept.

If we're thinking about the same thing, the basic idea was to store
information into a higher level object and make more intelligent paging
decisions based on the higher level object.  In my brain, since I'm a
SunOS guy, that means that you store information in the vnode (inode)
which reflects the status of all pages backed by this inode.

Instead of trying to figure out what to do at the page level, you figure
out what to do at the object level.  

Some postings about this:

http://groups.google.com/groups?q=topvn+mcvoy&hl=en&lr=&ie=UTF-8&oe=UTF-8&selm=3cgeu9%24h96%40fido.asd.sgi.com&rnum=1

http://groups.google.com/groups?q=vnode+mcvoy&start=10&hl=en&lr=&ie=UTF-8&oe=UTF-8&selm=l0ojgnINN59t%40appserv.Eng.Sun.COM&rnum=12

I can't find the writeup that you are thinking about.  I know what you mean,
there was a discussion of paging algs and I went off about how scanning a
page a time is insane.  If someone finds the URL let me know.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
