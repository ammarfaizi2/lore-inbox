Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751517AbWBVX4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751517AbWBVX4N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 18:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751559AbWBVX4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 18:56:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:15794 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751517AbWBVX4L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 18:56:11 -0500
From: Chris Mason <mason@suse.de>
To: Dimitri Sivanich <sivanich@sgi.com>
Subject: Re: [PATCH] Enable remote RCU callback processing on SMP systems
Date: Wed, 22 Feb 2006 18:56:05 -0500
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>, okir@suse.de
References: <20060206145137.GA30059@sgi.com> <200602221523.23739.mason@suse.de> <20060222220037.GC3734@sgi.com>
In-Reply-To: <20060222220037.GC3734@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602221856.07262.mason@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 22 February 2006 17:00, Dimitri Sivanich wrote:
> On Wed, Feb 22, 2006 at 03:23:22PM -0500, Chris Mason wrote:
> > Aside from the possible race we talked about in __rcu_process_callbacks,
> > I don't have huge objections here.  But if the underlying problem is the
> > cost of kmem_cache_free, would it be better to limit that instead of
> > trying to push the latency around to specific cpus?
>
> The current problem is the cost of kmem_cache_free.  What this
> patch will do (versus limiting the cost of kmem_cache_free, if
> that's at all possible) is to protect the cpus configured as
> such against other costly sections of code that may be lurking
> or that might be added in the future.

Right, but I'm suggesting that we might want to fix kmem_cache_free as well.  
I think your patch has value even with kmem_cache_free fixed.  Given that the 
high cost parts of kmem_cache_free seem to be numa specific, fixing it seems 
like a good idea in general.

-chris
