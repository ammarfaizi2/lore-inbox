Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264256AbSIVOxr>; Sun, 22 Sep 2002 10:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264258AbSIVOxr>; Sun, 22 Sep 2002 10:53:47 -0400
Received: from franka.aracnet.com ([216.99.193.44]:25997 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S264256AbSIVOxq>; Sun, 22 Sep 2002 10:53:46 -0400
Date: Sun, 22 Sep 2002 07:57:05 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Erich Focht <efocht@ess.nec.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
cc: LSE <lse-tech@lists.sourceforge.net>, Ingo Molnar <mingo@elte.hu>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: Re: [Lse-tech] [PATCH 1/2] node affine NUMA scheduler
Message-ID: <70114038.1032681424@[10.10.2.3]>
In-Reply-To: <200209221245.30798.efocht@ess.nec.de>
References: <200209221245.30798.efocht@ess.nec.de>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> OK, I see your point and I agree that numa_node_is() should be similar to
> smp_processor_id(). I'll change the alloc_pages instead.
> 
> Do you think it makes sense to get memory from the homenode only for
> user processes? Many kernel threads have currently the wrong homenode,
> for some of them it's unclear which homenode they should have...

Well yes ... if you can keep things pretty much on their home nodes.
That means some sort of algorithm for updating it, which may be fairly
complex (and doesn't currently seem to work, but maybe that's just 
because I only have 1 pool)
 
> There is an alternative idea (we discussed this at OLS with Andrea, maybe
> you remember): allocate memory from the current node and keep statistics
> on where it is allocated. Determine the homenode from this (from time to
> time) and schedule accordingly. This eliminates the initial load balancing
> and leaves it all to the scheduler, but has the drawback that memory can
> be somewhat scattered across the nodes. Any comments?

Well, that's a lot simpler. Things should end up running on their home
node, and thus will allocate pages from their home node, so it should
be self-re-enforcing. The algorithm for the home node is then implicitly
worked out from the scheduler itself, and its actions, so it's one less
set of stuff to write. Would suggest we do this at first, to keep things
as simple as possible so you have something mergeable.

M.

