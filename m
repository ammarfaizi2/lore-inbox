Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265092AbTARV0H>; Sat, 18 Jan 2003 16:26:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265093AbTARV0H>; Sat, 18 Jan 2003 16:26:07 -0500
Received: from franka.aracnet.com ([216.99.193.44]:56719 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S265092AbTARV0G>; Sat, 18 Jan 2003 16:26:06 -0500
Date: Sat, 18 Jan 2003 13:34:21 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Theurer <habanero@us.ibm.com>
cc: Christoph Hellwig <hch@infradead.org>, Robert Love <rml@tech9.net>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>,
       Erich Focht <efocht@ess.nec.de>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [Lse-tech] NUMA sched -> pooling scheduler (inc HT)
Message-ID: <559200000.1042925659@titus>
In-Reply-To: <550960000.1042923260@titus>
References: <Pine.LNX.4.44.0301171607510.10244-100000@localhost.localdomain> <270920000.1042822723@titus> <550960000.1042923260@titus>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mmm... seems I may have got the ordering of the cpus wrong.
Something like this might work better in sched_topo_ht.h
(yeah, it's ugly. I don't care).

static inline int pool_to_cpu_mask (int pool)
{
	return ( (1UL << pool) || (1UL << cpu_sibling_map[pool]));
}

static inline cpu_to_pool (int cpu)
{
	return min(cpu, cpu_sibling_map[cpu]);
}

Thanks to Andi, Zwane, and Bill for the corrective baseball bat strike.
I changed the macros to inlines to avoid the risk of double eval.

M.

