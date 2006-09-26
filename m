Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751177AbWIZLsP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbWIZLsP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 07:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbWIZLsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 07:48:15 -0400
Received: from mga03.intel.com ([143.182.124.21]:15027 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S1751160AbWIZLsO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 07:48:14 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,219,1157353200"; 
   d="scan'208"; a="123077870:sNHT36550983"
Message-ID: <4519137A.2050008@intel.com>
Date: Tue, 26 Sep 2006 19:48:10 +0800
From: "bibo,mao" <bibo.mao@intel.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
CC: tony.luck@intel.com, akpm@osdl.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, y-goto@jp.fujitsu.com
Subject: Re: [BUGFIX][PATCH] cpu to node relationship fixup take2 [2/2] map
 cpu to node
References: <20060922152702.4b01c192.kamezawa.hiroyu@jp.fujitsu.com>	<45190D99.20605@intel.com> <20060926203925.ee98a4ae.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060926203925.ee98a4ae.kamezawa.hiroyu@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yes, the hot-fix works for me now :)

thanks
bibo,mao

KAMEZAWA Hiroyuki wrote:
> 
> Uh... sorry. How about this hot-fix ?
> 
> -Kame
> =========
> 
> 
> Non-NUMA case should be handled...
> 
> Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
> 
> Index: linux-2.6.18/arch/ia64/kernel/topology.c
> ===================================================================
> --- linux-2.6.18.orig/arch/ia64/kernel/topology.c	2006-09-26 20:31:25.000000000 +0900
> +++ linux-2.6.18/arch/ia64/kernel/topology.c	2006-09-26 20:34:03.000000000 +0900
> @@ -36,10 +36,8 @@
>  	 */
>  	if (!can_cpei_retarget() && is_cpu_cpei_target(num))
>  		sysfs_cpus[num].cpu.no_control = 1;
> -#ifdef CONFIG_NUMA
>  	map_cpu_to_node(num, node_cpuid[num].nid);
>  #endif
> -#endif
>  
>  	return register_cpu(&sysfs_cpus[num].cpu, num);
>  }
> Index: linux-2.6.18/include/asm-ia64/numa.h
> ===================================================================
> --- linux-2.6.18.orig/include/asm-ia64/numa.h	2006-09-26 20:31:25.000000000 +0900
> +++ linux-2.6.18/include/asm-ia64/numa.h	2006-09-26 20:33:49.000000000 +0900
> @@ -69,6 +69,8 @@
>  
>  
>  #else /* !CONFIG_NUMA */
> +#define map_cpu_to_node(cpu, nid)	do{}while(0)
> +#define unmap_cpu_from_node(cpu, nid)	do{}while(0)
>  
>  #define paddr_to_nid(addr)	0
>  
> 
> 
> 
