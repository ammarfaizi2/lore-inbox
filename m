Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265215AbUGQQpA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265215AbUGQQpA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 12:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266182AbUGQQpA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 12:45:00 -0400
Received: from mtvcafw.SGI.COM ([192.48.171.6]:29390 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S265215AbUGQQo7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 12:44:59 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH] reduce inter-node balancing frequency
Date: Sat, 17 Jul 2004 12:44:11 -0400
User-Agent: KMail/1.6.2
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       John Hawkes <hawkes@sgi.com>
References: <200407151829.20069.jbarnes@engr.sgi.com> <200407161045.38983.jbarnes@engr.sgi.com> <40F8965E.6070809@yahoo.com.au>
In-Reply-To: <40F8965E.6070809@yahoo.com.au>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407171244.11008.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, July 16, 2004 11:00 pm, Nick Piggin wrote:
> Out of interest, what sort of performance problems are you seeing with
> this high rate of global balancing? I have a couple of patches to cut down
> runqueue locking to almost zero in interrupt paths, although I imagine the
> main problem you are having is pulling a cacheline off every remote CPU
> when calculating runqueue loads?

John might remember the details, I didn't get a backtrace this time.  When we 
boot with the default values on a 512p system, it livelocks shortly after 
init starts.  I *think* what's happening is that a the global rebalance value 
is shorter than the time it takes to do the global rebalance, due to 
cacheline contention.

Jesse
