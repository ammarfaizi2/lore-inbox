Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932399AbWDZLTR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932399AbWDZLTR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 07:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932396AbWDZLTR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 07:19:17 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:41878 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932395AbWDZLTQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 07:19:16 -0400
Message-ID: <444F5706.4030805@sgi.com>
Date: Wed, 26 Apr 2006 13:18:30 +0200
From: Jes Sorensen <jes@sgi.com>
User-Agent: Thunderbird 1.5 (X11/20060223)
MIME-Version: 1.0
To: Robin Holt <holt@sgi.com>
CC: Dean Nelson <dcn@sgi.com>, Andrew Morton <akpm@osdl.org>,
       tony.luck@intel.com, avolkov@varma-el.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, paulus@samba.org
Subject: Re: [PATCH] change gen_pool allocator to not touch managed memory
References: <444D1A7E.mailx85W11DZZU@aqua.americas.sgi.com> <20060424181626.09966912.akpm@osdl.org> <20060425155051.GA19248@sgi.com> <444F3990.5030100@sgi.com> <20060426110856.GB19935@lnx-holt.americas.sgi.com>
In-Reply-To: <20060426110856.GB19935@lnx-holt.americas.sgi.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robin Holt wrote:
> On Wed, Apr 26, 2006 at 11:12:48AM +0200, Jes Sorensen wrote:
>>> -	if (status)
>>> -		printk(KERN_WARNING "smp_call_function failed for "
>>> -		       "uncached_ipi_mc_drain! (%i)\n", status);
>>> +	(void) smp_call_function(uncached_ipi_mc_drain, NULL, 0, 1);
>> This thing could in theory fail so having the error check there seems
>> the right thing to me. In either case, please don't (void) the function
>> return (this is a style issue, I know).
> 
> I must be blind.  Both up and smp cases for smp_call_function appear to
> always return 0.  What am I missing?

Not on all architectures, at least PPC can return != 0 - dunno if this
is a realistic case though. If not, maybe the prototype for
smp_call_function() ought to be changed.

Cheers,
Jes
