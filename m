Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315214AbSHIRst>; Fri, 9 Aug 2002 13:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315260AbSHIRss>; Fri, 9 Aug 2002 13:48:48 -0400
Received: from hdfdns02.hd.intel.com ([192.52.58.11]:37115 "EHLO
	mail2.hd.intel.com") by vger.kernel.org with ESMTP
	id <S315214AbSHIRsm>; Fri, 9 Aug 2002 13:48:42 -0400
Message-ID: <25282B06EFB8D31198BF00508B66D4FA03EA5706@fmsmsx114.fm.intel.com>
From: "Seth, Rohit" <rohit.seth@intel.com>
To: "'Daniel Phillips'" <phillips@arcor.de>,
       Linus Torvalds <torvalds@transmeta.com>
Cc: frankeh@watson.ibm.com, davidm@hpl.hp.com,
       David Mosberger <davidm@napali.hpl.hp.com>,
       "David S. Miller" <davem@redhat.com>, gh@us.ibm.com,
       Martin.Bligh@us.ibm.com, wli@holomorphy.com,
       linux-kernel@vger.kernel.org
Subject: RE: large page patch (fwd) (fwd)
Date: Fri, 9 Aug 2002 10:51:55 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Daniel Phillips [mailto:phillips@arcor.de]
> Sent: Friday, August 09, 2002 10:12 AM
> To: Linus Torvalds
> Cc: frankeh@watson.ibm.com; davidm@hpl.hp.com; David 
> Mosberger; David S.
> Miller; gh@us.ibm.com; Martin.Bligh@us.ibm.com; wli@holomorphy.com;
> linux-kernel@vger.kernel.org
> Subject: Re: large page patch (fwd) (fwd)
> 
> 
> On Friday 09 August 2002 18:51, Linus Torvalds wrote:
> > On Fri, 9 Aug 2002, Daniel Phillips wrote:
> > > Slab allocations would not have GFP_DEFRAG (I mistakenly 
> wrote GFP_LARGE 
> > > earlier) and so would be allocated outside ZONE_LARGE.
> > 
> > .. at which poin tyou then get zone balancing problems.
> > 
> > Or we end up with the same kind of special zone that we 
> have _anyway_ in
> > the current large-page patch, in which case the point of 
> doing this is
> > what?
> 
> The current large-page patch doesn't have any kind of 
> defragmentation in the 
> special zone and that memory is just not available for other 
> uses.  The thing 
> is, when demand for large pages is low the zone should be 
> allowed to fragment.
> 

You are right that as long as the pages are in large page pool they are not
available for other regualr purposes.  Though the current implementation
basically allows on-demand moving of pages between large_page and other
regular pools using sysctl interface.   The issue is really not forced (in
the sense that large pages are freed only if they are available and vice
versa).  And it will not be an issue where demand for large pages is low.
Theoritically you can extend this support in pageout daemon to find out if
it can retrieve some free large pages (for environments where expectations
are that most of the memory will be used for large pages but actual usage is
not as per the expectations. Though I doubt if those environments will
occur, but bad configurations are always there)  The current approach really
allows the large page/regular_page movement without doing too much of house
cleaning.  It is likely that once a large page goes back to general pool, it
will not easy to replenish the large_page pool because of fragmentation in
regular memory pool (for memory starved machines.  For the scenarios where
sometime the machine is running low on regular memory and sometimes on
large_pages....probably it would be a good idea to add in more RAM in these
cases.).
> 
