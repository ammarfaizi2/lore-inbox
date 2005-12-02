Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750882AbVLBSYf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750882AbVLBSYf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 13:24:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750920AbVLBSYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 13:24:35 -0500
Received: from serv01.siteground.net ([70.85.91.68]:3748 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1750882AbVLBSYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 13:24:34 -0500
Date: Fri, 2 Dec 2005 10:24:27 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org, shai@scalex86.org
Subject: Re: [discuss] Re: [patch 3/3] x86_64: Node local PDA -- allocate node local memory for pda
Message-ID: <20051202182427.GA3727@localhost.localdomain>
References: <20051202081028.GA5312@localhost.localdomain> <20051202082309.GC5312@localhost.localdomain> <43900BE3.5080000@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43900BE3.5080000@cosmosbay.com>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2005 at 09:54:59AM +0100, Eric Dumazet wrote:
> Ravikiran G Thirumalai a écrit :
> >Patch uses a static PDA array early at boot and reallocates processor PDA
> >with node local memory when kmalloc is ready, just before pda_init.
> >The boot_cpu_pda is needed sice the cpu_pda is used even before pda_init 
> >for
> >that cpu is called (to set the static per-cpu areas offset table etc)
> >
> 
> That sounds great.
> 
> I have only have one suggestion : If kernel is not NUMA, then maybe we 
> should avoid one indirection to get the pda, and avoid some code too.
>

Sure, but there is no extra indirection with the fastpath routines like
read_pda, write_pda and friends with the current patch.  
Places where cpu_pda[] is accessed by the array name are not really
important -- except for the static per_cpu_offset of another cpu.  But
still it might be worth it (considering that people use 
per_cpu(var, smp_processor_id()), instead of __get_cpu_var in many places).  
I will incorporate this.

Thanks,
Kiran
