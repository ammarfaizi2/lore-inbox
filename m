Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753358AbWKCSSu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753358AbWKCSSu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 13:18:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753423AbWKCSSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 13:18:50 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:51873 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1753358AbWKCSSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 13:18:49 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andi Kleen <ak@suse.de>
Cc: tim.c.chen@linux.intel.com, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: 2.6.19-rc1: x86_64 slowdown in lmbench's fork
References: <1162485897.10806.72.camel@localhost.localdomain>
	<1162570216.10806.79.camel@localhost.localdomain>
	<m1lkmsxwk7.fsf@ebiederm.dsl.xmission.com>
	<200611031847.49222.ak@suse.de>
Date: Fri, 03 Nov 2006 11:18:18 -0700
In-Reply-To: <200611031847.49222.ak@suse.de> (Andi Kleen's message of "Fri, 3
	Nov 2006 18:47:49 +0100")
Message-ID: <m18xisxul1.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

>> So unless there is some other array that is sized by NR_IRQs
>> in the context switch path which could account for this in
>> other ways.  It looks like you just got unlucky.
>
>
> TLB/cache profiling data might be useful?
> My bet would be more on cache effects.

The only way I can see that being true is if some irq was keeping
the cache line warm for something in the process startup.

I have trouble seeing how adding 1K to an already 1K data structure
can cause a cache fault that wasn't happening already.
  
>> The only hypothesis that I can seem to come up with is that maybe
>> you are getting an extra tlb now that you didn't use to.  
>> I think the per cpu area is covered by huge pages but maybe not.
>
> It should be.

Which invalidates the tlb fault hypothesis unless it happens to lie
on the 2MB boundary.

Eric
