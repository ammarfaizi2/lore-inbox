Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932497AbVIMXR1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932497AbVIMXR1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 19:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbVIMXR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 19:17:27 -0400
Received: from serv01.siteground.net ([70.85.91.68]:28819 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1751078AbVIMXR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 19:17:26 -0400
Date: Tue, 13 Sep 2005 16:17:17 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, dipankar@in.ibm.com,
       bharata@in.ibm.com, shai@scalex86.org, rusty@rustcorp.com.au,
       netdev@vger.kernel.org
Subject: Re: [patch 9/11] net: dst_entry.refcount, use, lastuse to use alloc_percpu
Message-ID: <20050913231717.GC6249@localhost.localdomain>
References: <20050913161708.GK3570@localhost.localdomain> <20050913.132442.53540386.davem@davemloft.net> <20050913220737.GA6249@localhost.localdomain> <20050913.151216.48124942.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050913.151216.48124942.davem@davemloft.net>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2005 at 03:12:16PM -0700, David S. Miller wrote:
> From: Ravikiran G Thirumalai <kiran@scalex86.org>
> Date: Tue, 13 Sep 2005 15:07:37 -0700
> ...
> But using bigrefs, no way.  We have enough trouble making the data
> structures small without adding bloat like that.  A busy server can
> have hundreds of thousands of dst cache entries active on it, and they
> chew up enough memory as is.
> 

But even 1 Million dst cache entries would be 16+4 MB additional for a 4 cpu 
box....is that too much?  The alloc_percpu reimplementation interleaves
objects on cache lines, unlike the existing implementation which pads per-cpu
objects to cache lines...

If you are referring to embedded routing devices,
would they use CONFIG_NUMA or CONFIG_SMP?? (bigrefs nicely fold back to
regular atomic_t s on UPs)

Thanks,
Kiran
