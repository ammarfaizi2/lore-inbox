Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262726AbTCPS71>; Sun, 16 Mar 2003 13:59:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262727AbTCPS71>; Sun, 16 Mar 2003 13:59:27 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:36842 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S262726AbTCPS70>; Sun, 16 Mar 2003 13:59:26 -0500
Date: Sun, 16 Mar 2003 20:10:13 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, "Martin J. Bligh" <mbligh@aracnet.com>
Subject: 2.5.64-mm8: link error with CONFIG_NUMA and !CONFIG_SMP
Message-ID: <20030316191012.GG10253@fs.tum.de>
References: <20030316024239.484f8bda.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030316024239.484f8bda.akpm@digeo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get many errors at the final linking when compiling a kernel with
CONFIG_NUMA enabled but CONFIG_SMP disabled:

<--  snip  -->

...
/home/bunk/linux/kernel-2.5/linux-2.5.64-mm8/include/asm/topology.h:41: 
undefined reference to `cpu_2_node'
...

<--  snip  -->

the problem is that include/asm-i386/topology.h says:

<--  snip  -->

...
#ifdef CONFIG_NUMA
...
extern volatile int cpu_2_node[];
...

<--  snip  -->

but cpu_2_node is in arch/i386/kernel/smpboot.c that only gets included 
with CONFIG_SMP.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

