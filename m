Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261872AbULJXlT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbULJXlT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 18:41:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261874AbULJXlS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 18:41:18 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:40582 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261872AbULJXlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 18:41:14 -0500
Date: Fri, 10 Dec 2004 17:40:37 -0600
From: Robin Holt <holt@sgi.com>
To: Robin Holt <holt@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, davem@davemloft.net,
       yoshfuji@linux-ipv6.org, hirofumi@parknet.co.jp, torvalds@osdl.org,
       dipankar@ibm.com, laforge@gnumonks.org, bunk@stusta.de,
       herbert@apana.org.au, paulmck@ibm.com, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org, gnb@sgi.com
Subject: Re: [RFC] Limit the size of the IPV4 route hash.
Message-ID: <20041210234037.GB25582@lnx-holt.americas.sgi.com>
References: <20041210190025.GA21116@lnx-holt.americas.sgi.com> <20041210114829.034e02eb.davem@davemloft.net> <20041210210006.GB23222@lnx-holt.americas.sgi.com> <20041210130947.1d945422.akpm@osdl.org> <20041210232722.GC24468@lnx-holt.americas.sgi.com> <20041210153848.5acacd0a.akpm@osdl.org> <20041210233700.GA25582@lnx-holt.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041210233700.GA25582@lnx-holt.americas.sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2004 at 05:37:00PM -0600, Robin Holt wrote:
> On Fri, Dec 10, 2004 at 03:38:48PM -0800, Andrew Morton wrote:
> > Robin Holt <holt@sgi.com> wrote:
> > >
> > > > The big risk is that someone has a too-small table for some specific
> > > > application and their machine runs more slowly than it should, but they
> > > > never notice.  I wonder if it would be possible to put a little once-only
> > > > printk into the routing code: "warning route-cache chain exceeded 100
> > > > entries: consider using the rhash_entries boot option".
> > > 
> > > Since the hash gets flushed every 10 seconds, what if we kept track of
> > > the maximum depth reached and when we reach a certain threshold, just
> > > allocate a larger hash and replace the old with the new.  I do like the
> > > printk idea so the admin can prevent inconsistent performance early in
> > > the run cycle for the system.  We could even scale the hash size up based
> > > upon demand.
> > 
> > Once the system has been running for a while, the possibility of allocating
> > a decent number of physically-contiguous pages is basically zero.
> > 
> > If we were to dynamically size it we'd need to either use new data
> > structure (slower) or use vmalloc() (slower and can fragment vmalloc
> > space).
> 
> Why do they need to be physically contiguous?  It is a hash correct?

Sorry, I was asleep at the wheel.  I failed to even grok your second
paragraph.  I will fall back to agreeing with the printk to let the admin
know that something is amiss.

Should we possibly modify the output of /proc/net/rt_cache (or whatever
its name is) to include the hash bucket so people can watch to see how
many bucket collisions their system has?
