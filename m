Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161019AbWGIPCq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161019AbWGIPCq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 11:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161021AbWGIPCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 11:02:46 -0400
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:62142 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S1161019AbWGIPCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 11:02:45 -0400
Subject: Re: [RFC][PATCH -mm] lockdep.c likely
From: Arjan van de Ven <arjan@linux.intel.com>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <44B0F7D9.8040203@gmail.com>
References: <44B0F7D9.8040203@gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 09 Jul 2006 17:02:33 +0200
Message-Id: <1152457353.3255.60.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-07-09 at 14:34 +0200, Michal Piotrowski wrote:
> Hi,
> 
> I have noticed this
> 
> +unlikely | 53202934|    80576  trace_softirqs_on()@:/usr/src/linux-mm/kernel/lockdep.c@1861
> [..]
> +unlikely | 53202350|    80542  trace_softirqs_off()@:/usr/src/linux-mm/kernel/lockdep.c@1895
> [..]
> +unlikely |272060329|  3784394  trace_hardirqs_on()@:/usr/src/linux-mm/kernel/lockdep.c@1787
> [..]
> +unlikely |361155686|  2959425  check_unlock()@:/usr/src/linux-mm/kernel/lockdep.c@2197
> [..]
> +unlikely |  1821294|  1140788  __lock_acquire()@:/usr/src/linux-mm/kernel/lockdep.c@1977
>  unlikely |        0|  2962331  __lock_acquire()@:/usr/src/linux-mm/kernel/lockdep.c@1965
>  unlikely |        0|  2962035  __lock_acquire()@:/usr/src/linux-mm/kernel/lockdep.c@1962
> +unlikely |361188304|  2961749  __lock_acquire()@:/usr/src/linux-mm/kernel/lockdep.c@1959
> [..]
> +unlikely | 14528808|   413114  debug_check_no_locks_freed()@:/usr/src/linux-mm/kernel/lockdep.c@2607
>  likely   |    92394|      156  lock_kernel()@:/usr/src/linux-mm/lib/kernel_lock.c@70
>  unlikely |        0|   305177  lockdep_init_map()@:/usr/src/linux-mm/kernel/lockdep.c@1927
>  unlikely |        0|   305177  lockdep_init_map()@:/usr/src/linux-mm/kernel/lockdep.c@1925
> +unlikely |  2156369|   305176  lockdep_init_map()@:/usr/src/linux-mm/kernel/lockdep.c@1922
>  unlikely |        0|  4412613  trace_hardirqs_off()@:/usr/src/linux-mm/kernel/lockdep.c@1837
> +unlikely |319757688|  4409721  trace_hardirqs_off()@:/usr/src/linux-mm/kernel/lockdep.c@1834
> 
> in /proc/likely_prof
> 
> I'm not sure of it, but patch below should optimalize it.


this is only likely after you've hit a lockdep message though..

