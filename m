Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264012AbUCZL50 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 06:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264024AbUCZL5Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 06:57:25 -0500
Received: from holomorphy.com ([207.189.100.168]:5260 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264012AbUCZL5X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 06:57:23 -0500
Date: Fri, 26 Mar 2004 03:57:02 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Keith Owens <kaos@sgi.com>
Cc: Paul Jackson <pj@sgi.com>, colpatch@us.ibm.com,
       linux-kernel@vger.kernel.org, mbligh@aracnet.com, akpm@osdl.org,
       haveblue@us.ibm.com
Subject: Re: [PATCH] nodemask_t x86_64 changes [5/7]
Message-ID: <20040326115702.GV791@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Keith Owens <kaos@sgi.com>, Paul Jackson <pj@sgi.com>,
	colpatch@us.ibm.com, linux-kernel@vger.kernel.org,
	mbligh@aracnet.com, akpm@osdl.org, haveblue@us.ibm.com
References: <20040323201101.3427494c.pj@sgi.com> <6562.1080277594@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6562.1080277594@kao2.melbourne.sgi.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Mar 2004 20:11:01 -0800, Paul Jackson <pj@sgi.com> wrote:
>> I still don't know how I will fix the CPU_MASK_ALL static initializor in
>> the multi-word case - since I can't put runtime code in it.

On Fri, Mar 26, 2004 at 04:06:34PM +1100, Keith Owens wrote:
> #define NR_CPUS_WORDS ((NR_CPUS+BITS_PER_LONG-1)/BITS_PER_LONG)

This looks suspiciously like BITS_TO_LONGS(NR_CPUS) =)

On Fri, Mar 26, 2004 at 04:06:34PM +1100, Keith Owens wrote:
> #define NR_CPUS_UNDEF (NR_CPUS_WORDS*BITS_PER_LONG-NR_CPUS)
> #if NR_CPUS_UNDEF == 0
> #define CPU_MASK_ALL { [0 ... NR_CPUS_WORDS-1] = ~0UL }
> #else
> #define CPU_MASK_ALL { [0 ... NR_CPUS_WORDS-2] = ~0UL, ~0UL << NR_CPUS_UNDEF }
> #endif

Hmm, shouldn't that last one be ~0UL >> NR_CPUS_UNDEF?


-- wli
