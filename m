Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265586AbUFDEkt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265586AbUFDEkt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 00:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265588AbUFDEkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 00:40:49 -0400
Received: from smtp106.mail.sc5.yahoo.com ([66.163.169.226]:25183 "HELO
	smtp106.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265586AbUFDEkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 00:40:47 -0400
Message-ID: <40BFFD4B.1090502@yahoo.com.au>
Date: Fri, 04 Jun 2004 14:40:43 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: Paul Jackson <pj@sgi.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] cpumask 10/10 optimize various uses of new cpumasks
References: <20040603094339.03ddfd42.pj@sgi.com>	 <20040603101115.7f746d98.pj@sgi.com> <1086323259.29381.1036.camel@bach>
In-Reply-To: <1086323259.29381.1036.camel@bach>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> On Fri, 2004-06-04 at 03:11, Paul Jackson wrote:
> 
>>cpumask 10/10 optimize various uses of new cpumasks
>>
>>        Make use of for_each_cpu_mask() macro to simplify and optimize
>>        a couple of sparc64 per-CPU loops.
> 
> 
> This means we can finally do this, too... Yes!
> 
> Name: Cleanup cpumask_t Temporaries
> Status: Booted on 2.6.7-rc2-bk4
> Depends: Misc/cpumask-tour-de-force.patch.gz
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> 
> Paul Jackson's cpumask tour-de-force allows us to get rid of those
> stupid temporaries which we used to hold CPU_MASK_ALL to hand them to
> functions.  This used to break NR_CPUS > BITS_PER_LONG.

Actually I think this was already possible as of a couple of
months ago, but thanks for doing the cleanup :)

Fix was embarrassingly simple as pointed out by Linus:

-#define CPU_MASK_ALL	{ {[0 ... CPU_ARRAY_SIZE-1] = ~0UL} }
-#define CPU_MASK_NONE	{ {[0 ... CPU_ARRAY_SIZE-1] =  0UL} }
+#define CPU_MASK_ALL	((cpumask_t) { {[0 ... CPU_ARRAY_SIZE-1] = ~0UL} })
+#define CPU_MASK_NONE	((cpumask_t) { {[0 ... CPU_ARRAY_SIZE-1] =  0UL} })
