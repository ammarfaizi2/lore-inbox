Return-Path: <linux-kernel-owner+w=401wt.eu-S964926AbXAJSVb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964926AbXAJSVb (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 13:21:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964944AbXAJSVb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 13:21:31 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:58049 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S964926AbXAJSVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 13:21:30 -0500
Date: Wed, 10 Jan 2007 10:20:28 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
cc: Srivatsa Vaddagiri <vatsa@in.ibm.com>,
       Benjamin Gilbert <bgilbert@cs.cmu.edu>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Gautham shenoy <ego@in.ibm.com>,
       Andrew Morton <akpm@osdl.org>, Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [patch -mm] slab: use CPU_LOCK_[ACQUIRE|RELEASE]
In-Reply-To: <20070109150615.GF9563@osiris.boeblingen.de.ibm.com>
Message-ID: <Pine.LNX.4.64.0701101012460.21379@schroedinger.engr.sgi.com>
References: <20070108120719.16d4674e.bgilbert@cs.cmu.edu>
 <20070109121738.GC9563@osiris.boeblingen.de.ibm.com> <20070109122740.GC22080@in.ibm.com>
 <20070109150351.GD9563@osiris.boeblingen.de.ibm.com>
 <20070109150615.GF9563@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jan 2007, Heiko Carstens wrote:

> -	case CPU_UP_PREPARE:
> +	case CPU_LOCK_ACQUIRE:
>  		mutex_lock(&cache_chain_mutex);
> +		break;

I have got a bad feeling about upcoming deadlock problems when looking at 
the mutex_lock / unlock code in cpuup_callback in slab.c. Branches 
that just obtain a lock or release a lock? I hope there is some 
control of  what happens between lock acquisition and release?

You are aware that this lock is taken for cache shrinking/destroy, tuning 
of cpu cache sizes, proc output and cache creation? Any of those run on 
the same processor should cause a deadlock.
