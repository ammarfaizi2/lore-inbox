Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261867AbULJX2T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261867AbULJX2T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 18:28:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261869AbULJX2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 18:28:19 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:19840 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261867AbULJX2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 18:28:15 -0500
Date: Fri, 10 Dec 2004 17:27:22 -0600
From: Robin Holt <holt@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Robin Holt <holt@sgi.com>, davem@davemloft.net, yoshfuji@linux-ipv6.org,
       hirofumi@parknet.co.jp, torvalds@osdl.org, dipankar@ibm.com,
       laforge@gnumonks.org, bunk@stusta.de, herbert@apana.org.au,
       paulmck@ibm.com, netdev@oss.sgi.com, linux-kernel@vger.kernel.org,
       gnb@sgi.com
Subject: Re: [RFC] Limit the size of the IPV4 route hash.
Message-ID: <20041210232722.GC24468@lnx-holt.americas.sgi.com>
References: <20041210190025.GA21116@lnx-holt.americas.sgi.com> <20041210114829.034e02eb.davem@davemloft.net> <20041210210006.GB23222@lnx-holt.americas.sgi.com> <20041210130947.1d945422.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041210130947.1d945422.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2004 at 01:09:47PM -0800, Andrew Morton wrote:
> Robin Holt <holt@sgi.com> wrote:
> >  Can we agree that a linear calculation based on num_physpages is probably
> >  not the best algorithm.  If so, should we make it a linear to a limit or
> >  a logarithmically decreasing size to a limit?  How do we determine that
> >  limit point?
> 
> An initial default of N + M * log2(num_physpages) would probably give a
> saner result.
> 
> The big risk is that someone has a too-small table for some specific
> application and their machine runs more slowly than it should, but they
> never notice.  I wonder if it would be possible to put a little once-only
> printk into the routing code: "warning route-cache chain exceeded 100
> entries: consider using the rhash_entries boot option".

Since the hash gets flushed every 10 seconds, what if we kept track of
the maximum depth reached and when we reach a certain threshold, just
allocate a larger hash and replace the old with the new.  I do like the
printk idea so the admin can prevent inconsistent performance early in
the run cycle for the system.  We could even scale the hash size up based
upon demand.

Thanks,
Robin
