Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263326AbSIUPwg>; Sat, 21 Sep 2002 11:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263997AbSIUPwf>; Sat, 21 Sep 2002 11:52:35 -0400
Received: from franka.aracnet.com ([216.99.193.44]:63625 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S263326AbSIUPwf>; Sat, 21 Sep 2002 11:52:35 -0400
Date: Sat, 21 Sep 2002 08:55:13 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Erich Focht <efocht@ess.nec.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
cc: LSE <lse-tech@lists.sourceforge.net>, Ingo Molnar <mingo@elte.hu>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: Re: [Lse-tech] [PATCH 1/2] node affine NUMA scheduler
Message-ID: <595579668.1032598511@[10.10.2.3]>
In-Reply-To: <200209211159.41751.efocht@ess.nec.de>
References: <200209211159.41751.efocht@ess.nec.de>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> The second part of the patch extends the pooling NUMA scheduler to
> have node affine tasks:
>  - Each process has a homenode assigned to it at creation time
>    (initial load balancing). Memory will be allocated from this node.

Hmmm ... I was wondering how you achieved that without modifying
alloc_pages ... until I saw this bit.

 #ifdef CONFIG_NUMA
+#ifdef CONFIG_NUMA_SCHED
+#define numa_node_id() (current->node)
+#else
 #define numa_node_id() _cpu_to_node(smp_processor_id())
+#endif
 #endif /* CONFIG_NUMA */

I'm not convinced it's a good idea to modify this generic function,
which was meant to tell you what node you're running on. I can't
see it being used anywhere else right now, but wouldn't it be better
to just modify alloc_pages instead to use current->node, and leave
this macro as intended? Or make a process_node_id or something?

Anyway, I'm giving your code a quick spin ... will give you some
results later ;-)

M.


