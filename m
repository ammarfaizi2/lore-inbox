Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751006AbWBVWBV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbWBVWBV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 17:01:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbWBVWBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 17:01:20 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:63205 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751006AbWBVWBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 17:01:19 -0500
Date: Wed, 22 Feb 2006 16:00:37 -0600
From: Dimitri Sivanich <sivanich@sgi.com>
To: Chris Mason <mason@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>, okir@suse.de
Subject: Re: [PATCH] Enable remote RCU callback processing on SMP systems
Message-ID: <20060222220037.GC3734@sgi.com>
References: <20060206145137.GA30059@sgi.com> <200602221523.23739.mason@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602221523.23739.mason@suse.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2006 at 03:23:22PM -0500, Chris Mason wrote:
> Aside from the possible race we talked about in __rcu_process_callbacks, I 
> don't have huge objections here.  But if the underlying problem is the cost 
> of kmem_cache_free, would it be better to limit that instead of trying to 
> push the latency around to specific cpus?

The current problem is the cost of kmem_cache_free.  What this
patch will do (versus limiting the cost of kmem_cache_free, if
that's at all possible) is to protect the cpus configured as
such against other costly sections of code that may be lurking
or that might be added in the future.

