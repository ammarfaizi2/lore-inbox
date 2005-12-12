Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751168AbVLLKC1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbVLLKC1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 05:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbVLLKC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 05:02:27 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:28645 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1751168AbVLLKC0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 05:02:26 -0500
Date: Mon, 12 Dec 2005 02:02:11 -0800
From: Paul Jackson <pj@sgi.com>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au,
       Simon.Derr@bull.net, ak@suse.de, clameter@sgi.com
Subject: Re: [PATCH] Cpuset: rcu optimization of page alloc hook
Message-Id: <20051212020211.1394bc17.pj@sgi.com>
In-Reply-To: <439D39A8.1020806@cosmosbay.com>
References: <20051211233130.18000.2748.sendpatchset@jackhammer.engr.sgi.com>
	<439D39A8.1020806@cosmosbay.com>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Please do use __read_mostly for new kmem_cache :
> 
> static kmem_cache_t *cpuset_cache __read_mostly;

Is there any downside to this?  I ask because accesses through
this 'cpuset_cache' pointer are rather infrequent - only when
the sysadmin or the batch scheduler is creating or removing
cpusets, which for the purposes of 'back of the envelope'
estimates, might be once a minute or less.  Further, it is
not at all a performance critical path.

So I really don't give a dang if it takes a few milliseconds
to pick up this pointer, at least so far as cpusets matters.

That said, would you still advise marking this __read_mostly?


Andrew wrote:
> We've been shuffling towards removing kmem_cache_t in favour of `struct
> kmem_cache',

So I suppose what I should really have is:

  static struct kmem_cache *cpuset_cache __read_mostly;

??

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
