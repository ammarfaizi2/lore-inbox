Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932239AbVI2QnJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbVI2QnJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 12:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbVI2QnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 12:43:09 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:55771 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S932239AbVI2QnH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 12:43:07 -0400
Message-ID: <433C1999.2060201@vc.cvut.cz>
Date: Thu, 29 Sep 2005 18:43:05 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ravikiran G Thirumalai <kiran@scalex86.org>
CC: Andrew Morton <akpm@osdl.org>, Christoph Lameter <clameter@engr.sgi.com>,
       alokk@calsoftinc.com, linux-kernel@vger.kernel.org,
       manfred@colorfullife.com,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       ananth@in.ibm.com, Andi Kleen <ak@suse.de>
Subject: Re: 2.6.14-rc1-git-now still dying in mm/slab - this time line 1849
References: <20050916023005.4146e499.akpm@osdl.org> <432AA00D.4030706@vc.cvut.cz> <20050916230809.789d6b0b.akpm@osdl.org> <432EE103.5020105@vc.cvut.cz> <20050919112912.18daf2eb.akpm@osdl.org> <Pine.LNX.4.62.0509191141380.26105@schroedinger.engr.sgi.com> <20050919122847.4322df95.akpm@osdl.org> <Pine.LNX.4.62.0509191351440.26388@schroedinger.engr.sgi.com> <20050919221614.6c01c2d1.akpm@osdl.org> <43301578.8040305@vc.cvut.cz> <20050928210245.GA3760@localhost.localdomain>
In-Reply-To: <20050928210245.GA3760@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ravikiran G Thirumalai wrote:

Unfortunately I must confirm that it does not fix problem.  But it pointed
out to me another thing - proc_inode_cache stuff is put into caches
BEFORE this code is executed.  So if anything in mm/slab.c relies
on node_to_mask[] being valid (and if it relies on some other things
which are set this late), it probably won't work.
								Petr


> On Tue, Sep 20, 2005 at 03:58:16PM +0200, Petr Vandrovec wrote:
> Index: linux-2.6.14-rc1/arch/x86_64/mm/numa.c
> ===================================================================
> --- linux-2.6.14-rc1.orig/arch/x86_64/mm/numa.c	2005-09-19 17:58:10.000000000 -0700
> +++ linux-2.6.14-rc1/arch/x86_64/mm/numa.c	2005-09-27 01:34:20.000000000 -0700
> @@ -178,7 +178,6 @@
>  		rr++; 
>  	}
>  
> -	set_bit(0, &node_to_cpumask[cpu_to_node(0)]);
>  }
>  
>  #ifdef CONFIG_NUMA_EMU
> @@ -266,9 +265,7 @@
>  
>  __cpuinit void numa_add_cpu(int cpu)
>  {
> -	/* BP is initialized elsewhere */
> -	if (cpu) 
> -		set_bit(cpu, &node_to_cpumask[cpu_to_node(cpu)]);
> +	set_bit(cpu, &node_to_cpumask[cpu_to_node(cpu)]);
>  } 
>  
>  unsigned long __init numa_free_all_bootmem(void) 
> 


