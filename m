Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262174AbTIMUGi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 16:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262177AbTIMUGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 16:06:38 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:13469 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S262174AbTIMUGh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 16:06:37 -0400
Message-ID: <3F6378B0.8040606@colorfullife.com>
Date: Sat, 13 Sep 2003 22:06:08 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, Robert Love <rml@tech9.net>,
       dipankar@in.ibm.com
Subject: Re: [patch] Make slab allocator work with SLAB_MUST_HWCACHE_ALIGN
References: <20030910081654.GA1129@llm08.in.ibm.com> <1063208464.700.35.camel@localhost> <20030911055428.GA1140@llm08.in.ibm.com> <20030911110853.GB3700@llm08.in.ibm.com> <3F60A08A.7040504@colorfullife.com> <20030912085921.GB1128@llm08.in.ibm.com>
In-Reply-To: <20030912085921.GB1128@llm08.in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ravikiran G Thirumalai wrote:

>I am working on a simplistic allocator for alloc_percpu which
>1. Minimises cache footprint (simple pointer arithmetic to get to each cpus 
>   version
>2. Does numa aware allocation
>3. Does not fragment
>4. Is simple and extends simple pointer arithmetic to get to cpus offsets
>
>I wouldn't be using the slab at all because using slabs would mean using
>NR_CPUs pointers and one extra dereference which is bad as we had found out
>earlier.  But I guess slab will have to do node local allocations for
>other applications.
>  
>
Interesting. Slab internally uses lots of large per-cpu arrays. 
Alltogether something like around 40 kB/cpu. Right now implemented with 
NR_CPUs pointers. In the long run I'll try to switch to your allocator.

But back to the patch that started this thread: Do you still need the 
ability to set an explicit alignment for slab allocations? If yes, then 
I'd polish my patch, double check all kmem_cache_create callers and then 
send the patch to akpm. Otherwise I'd wait - the patch is not a bugfix.

--
    Manfred

