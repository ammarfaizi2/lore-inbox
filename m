Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316210AbSFUEQS>; Fri, 21 Jun 2002 00:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316213AbSFUEQR>; Fri, 21 Jun 2002 00:16:17 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:1667 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S316210AbSFUEQR>; Fri, 21 Jun 2002 00:16:17 -0400
Date: Fri, 21 Jun 2002 00:16:18 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200206210416.g5L4GIx16142@devserv.devel.redhat.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Optimisation for smp_num_cpus loop in hotplug
In-Reply-To: <mailman.1024617156.25656.linux-kernel2news@redhat.com>
References: <mailman.1024617156.25656.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	for (i = 0; i < NR_CPUS; i++) {
> 		if (!cpu_online(i))
> 			continue;
> 
> Since the cpu online map is probably going to be quite sparse,
> could I suggest this alternative, which doesn't have to loop 32 times:

> +#define for_each_cpu(cpu, mask) \
> +       for(mask = cpu_online_map; \
> +           cpu = __ffs(mask), mask != 0; \
> +           mask &= ~(1<<cpu))
> +

This is neat, but I'd like to see it work with O(1) as well.
Mingo's code uses some long bitmaps.

-- Pete
