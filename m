Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965060AbVINHVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965060AbVINHVF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 03:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932654AbVINHVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 03:21:05 -0400
Received: from ozlabs.org ([203.10.76.45]:38608 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932480AbVINHVD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 03:21:03 -0400
Subject: Re: [patch 9/11] net: dst_entry.refcount, use, lastuse to use
	alloc_percpu
From: Rusty Russell <rusty@rustcorp.com.au>
To: "David S. Miller" <davem@davemloft.net>
Cc: kiran@scalex86.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       dipankar@in.ibm.com, bharata@in.ibm.com, shai@scalex86.org,
       netdev@vger.kernel.org
In-Reply-To: <20050913.162748.86496945.davem@davemloft.net>
References: <20050913220737.GA6249@localhost.localdomain>
	 <20050913.151216.48124942.davem@davemloft.net>
	 <20050913231717.GC6249@localhost.localdomain>
	 <20050913.162748.86496945.davem@davemloft.net>
Content-Type: text/plain
Date: Wed, 14 Sep 2005 17:21:02 +1000
Message-Id: <1126682462.7896.103.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-09-13 at 16:27 -0700, David S. Miller wrote:
> From: Ravikiran G Thirumalai <kiran@scalex86.org>
> Date: Tue, 13 Sep 2005 16:17:17 -0700
> 
> > But even 1 Million dst cache entries would be 16+4 MB additional for
> > a 4 cpu box....is that too much?
> 
> Absolutely.
> 
> Per-cpu counters are great for things like single instance
> statistics et al.  But once you start doing them per-object
> that's out of control bloat as far as I'm concerned.

This is why my original per-cpu allocator patch was damn slow, and
GFP_KERNEL only.  I wasn't convinced that high-churn objects are a good
fit for spreading across cpus.

I thought that net devices and modules (which uses a primitive
hard-coded "bigref" currently) were a fair uses for bigrefs, though I'd
like to see some stats.

Cheers,
Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

