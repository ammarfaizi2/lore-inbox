Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263789AbUECQju@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263789AbUECQju (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 12:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263790AbUECQju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 12:39:50 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:752 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263789AbUECQjq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 12:39:46 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: linux-kernel@vger.kernel.org, paulmck@us.ibm.com
Subject: Re: RCU scaling on large systems
Date: Mon, 3 May 2004 09:39:11 -0700
User-Agent: KMail/1.6.1
Cc: Jack Steiner <steiner@sgi.com>
References: <20040501120805.GA7767@sgi.com> <20040502182811.GA1244@us.ibm.com>
In-Reply-To: <20040502182811.GA1244@us.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405030939.11707.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, May 2, 2004 11:28 am, Paul E. McKenney wrote:
> From your numbers below, I would guess that if you have at least
> 8 CPUs per NUMA node, a two-level tree would suffice.  If you have
> only 4 CPUs per NUMA node, you might well need a per-node level,
> a per-4-nodes level, and a global level to get the global lock
> contention reduced sufficiently.

Actually, only 2, but it sounds like your approach would work.

> Cute!  However, it is not clear to me that this approach is
> compatible with real-time use of RCU, since it results in CPUs
> processing their callbacks less frequently, and thus getting
> more of them to process at a time.

I think it was just a proof-of-concept--the current RCU design obviously 
wasn't designed with this machine in mind :).

> But it is not clear to me that anyone is looking for realtime
> response from a 512-CPU machine (yow!!!), so perhaps this
> is not a problem...

There are folks that would like realtime (or close to realtime) response on 
such systems, so it would be best not to do anything that would explicitly 
prevent it.

> This patch certainly seems simple enough, and I would guess that
> "jiffies" is referenced often enough that it is warm in the cache
> despite being frequently updated.
>
> Other thoughts?

On a big system like this though, won't reading jiffies frequently be another 
source of contention?

Jesse
