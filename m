Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268778AbUHTWWW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268778AbUHTWWW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 18:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268782AbUHTWWW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 18:22:22 -0400
Received: from fw.osdl.org ([65.172.181.6]:50081 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268778AbUHTWWT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 18:22:19 -0400
Date: Fri, 20 Aug 2004 15:25:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: amgta@yacht.ocn.ne.jp, linux-kernel@vger.kernel.org, colpatch@us.ibm.com
Subject: Re: [PATCH] shows Active/Inactive on per-node meminfo
Message-Id: <20040820152551.03a4aee7.akpm@osdl.org>
In-Reply-To: <200408201501.31542.jbarnes@engr.sgi.com>
References: <200408210302.25053.amgta@yacht.ocn.ne.jp>
	<200408201448.22566.jbarnes@engr.sgi.com>
	<200408201501.31542.jbarnes@engr.sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Barnes <jbarnes@engr.sgi.com> wrote:
>
> On Friday, August 20, 2004 2:48 pm, Jesse Barnes wrote:
> > On Friday, August 20, 2004 2:02 pm, mita akinobu wrote:
> > > +	for (i = 0; i < MAX_NR_ZONES; i++) {
> > > +		*active += zones[i].nr_active;
> > > +		*inactive += zones[i].nr_inactive;
> > > +		*free += zones[i].free_pages;
> > > +	}
> > > +}
> > > +
> > > -		*free += zone->free_pages;
> > > +	for_each_pgdat(pgdat) {
> > > +		unsigned long l, m, n;
> > > +		__get_zone_counts(&l, &m, &n, pgdat);
> > > +		*active += l;
> > > +		*inactive += m;
> > > +		*free += n;
> > >  	}
> >
> > Just FYI, loops like this are going to be very slow on a large machine.
> > Iterating over every node in the system involves a TLB miss on every
> > iteration along with an offnode reference and possibly cacheline demotion.
> 
> ...but I see that you're just adding the info to the per-node meminfo files, 
> so it should be ok as long as people access a node's meminfo file from a 
> local cpu.  /proc/meminfo will still hurt a lot though.
> 
> I bring this up because I ran into it once.  I created a file 
> called /proc/discontig which printed out detailed per-node memory stats, one 
> node per line.  On a large system it would literally take several seconds to 
> cat the file due to the overhead of looking at all the pages and zone 
> structures.
> 

So was that an ack, a nack or a quack?

I'll queue the patch up so it doesn't get lost - could you please take a
closer look at the performance implications sometime, let me know?

