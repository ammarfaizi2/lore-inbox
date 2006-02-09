Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965113AbWBIIlp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965113AbWBIIlp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 03:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750828AbWBIIlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 03:41:45 -0500
Received: from liaag2ag.mx.compuserve.com ([149.174.40.158]:9653 "EHLO
	liaag2ag.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1750798AbWBIIlo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 03:41:44 -0500
Date: Thu, 9 Feb 2006 03:32:55 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH] percpu data: only iterate over possible CPUs
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Jackson <pj@sgi.com>, heiko.carstens@de.ibm.com, wli@holomorphy.com,
       ak@muc.de, mingo@elte.hu, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, riel@redhat.com,
       Eric Dumazet <dada1@cosmobay.com>
Message-ID: <200602090335_MC3-1-B7FA-621E@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060208204502.12513ae5.akpm@osdl.org>

On Wed, 8 Feb 2006 at 20:45:02 -0800, Andrew Morton wrote:

> > Its even documented in line 332 of include/linux/cpumask.h
> > 
> >   *  #ifdef CONFIG_HOTPLUG_CPU
> >   *     cpu_possible_map - all NR_CPUS bits set
> 
> That seems a quite bad idea.  If we know which CPUs are possible we should
> populate cpu_possible_map correctly, whether or not CONFIG_HOTPLUG_CPU is
> set.

I don't think that's, um, "possible."  Even if you could discover how many
empty sockets there were in a system, someone might be able to hotplug
a board with more of them on it.  And there's no way to tell how many CPUs
to reserve for each socket anyway, e.g. AMD has already announced quad-core
processors.

But what really surprised me is that for_each_cpu() actually walks
cpu_possible_map and not cpu_present_map as I had assumed.  This violates
the Principle Of Least Surprise.  Maybe renaming for_each_cpu to
for_each_possible_cpu might be a good idea?

-- 
Chuck
"Equations are the Devil's sentences."  --Stephen Colbert

