Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268668AbUHTTHD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268668AbUHTTHD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 15:07:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268662AbUHTTEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 15:04:44 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:61589 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S268678AbUHTTC4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 15:02:56 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: mita akinobu <amgta@yacht.ocn.ne.jp>
Subject: Re: [PATCH] shows Active/Inactive on per-node meminfo
Date: Fri, 20 Aug 2004 15:01:31 -0400
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Matthew Dobson <colpatch@us.ibm.com>
References: <200408210302.25053.amgta@yacht.ocn.ne.jp> <200408201448.22566.jbarnes@engr.sgi.com>
In-Reply-To: <200408201448.22566.jbarnes@engr.sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408201501.31542.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, August 20, 2004 2:48 pm, Jesse Barnes wrote:
> On Friday, August 20, 2004 2:02 pm, mita akinobu wrote:
> > +	for (i = 0; i < MAX_NR_ZONES; i++) {
> > +		*active += zones[i].nr_active;
> > +		*inactive += zones[i].nr_inactive;
> > +		*free += zones[i].free_pages;
> > +	}
> > +}
> > +
> > -		*free += zone->free_pages;
> > +	for_each_pgdat(pgdat) {
> > +		unsigned long l, m, n;
> > +		__get_zone_counts(&l, &m, &n, pgdat);
> > +		*active += l;
> > +		*inactive += m;
> > +		*free += n;
> >  	}
>
> Just FYI, loops like this are going to be very slow on a large machine.
> Iterating over every node in the system involves a TLB miss on every
> iteration along with an offnode reference and possibly cacheline demotion.

...but I see that you're just adding the info to the per-node meminfo files, 
so it should be ok as long as people access a node's meminfo file from a 
local cpu.  /proc/meminfo will still hurt a lot though.

I bring this up because I ran into it once.  I created a file 
called /proc/discontig which printed out detailed per-node memory stats, one 
node per line.  On a large system it would literally take several seconds to 
cat the file due to the overhead of looking at all the pages and zone 
structures.

Jesse

