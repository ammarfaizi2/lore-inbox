Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263933AbUCZFHs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 00:07:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263941AbUCZFHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 00:07:48 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:41855 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263933AbUCZFHr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 00:07:47 -0500
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: William Lee Irwin III <wli@holomorphy.com>, colpatch@us.ibm.com,
       linux-kernel@vger.kernel.org, mbligh@aracnet.com, akpm@osdl.org,
       haveblue@us.ibm.com
Subject: Re: [PATCH] nodemask_t x86_64 changes [5/7] 
In-reply-to: Your message of "Tue, 23 Mar 2004 20:11:01 -0800."
             <20040323201101.3427494c.pj@sgi.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 26 Mar 2004 16:06:34 +1100
Message-ID: <6562.1080277594@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Mar 2004 20:11:01 -0800, 
Paul Jackson <pj@sgi.com> wrote:
>I still don't know how I will fix the CPU_MASK_ALL static initializor in
>the multi-word case - since I can't put runtime code in it.

#define NR_CPUS_WORDS ((NR_CPUS+BITS_PER_LONG-1)/BITS_PER_LONG)
#define NR_CPUS_UNDEF (NR_CPUS_WORDS*BITS_PER_LONG-NR_CPUS)

#if NR_CPUS_UNDEF == 0
#define CPU_MASK_ALL { [0 ... NR_CPUS_WORDS-1] = ~0UL }
#else
#define CPU_MASK_ALL { [0 ... NR_CPUS_WORDS-2] = ~0UL, ~0UL << NR_CPUS_UNDEF }
#endif

