Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932555AbWCPDm6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932555AbWCPDm6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 22:42:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932604AbWCPDm6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 22:42:58 -0500
Received: from smtp.osdl.org ([65.172.181.4]:46992 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932555AbWCPDm5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 22:42:57 -0500
Date: Wed, 15 Mar 2006 19:40:06 -0800
From: Andrew Morton <akpm@osdl.org>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] for_each_possible_cpu [1/19] defines
 for_each_possible_cpu
Message-Id: <20060315194006.17dd9e24.akpm@osdl.org>
In-Reply-To: <20060316122110.c00f4181.kamezawa.hiroyu@jp.fujitsu.com>
References: <20060316122110.c00f4181.kamezawa.hiroyu@jp.fujitsu.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:
>
> Now,
>  for_each_cpu() is for-loop cpu over cpu_possible_map.
>  for_each_online_cpu is for-loop cpu over cpu_online_map.
>  .....for_each_cpu() looks bad name.
> 
>  This patch renames for_each_cpu() as for_each_possible_cpu().
>

Sane.

>  I also wrote patches to replace all for_each_cpu with for_each_possible_cpu.
>  please confirm....
> 
>  BTW, when HOTPLUC_CPU is not suppoted, using for_each_possible_cpu()
>  should be avoided, I think.

Sometimes.  Sometimes it's valid though - allocating (small amounts of)
per-cpu storage, summing up per-cpu counters (poorly), etc.

>  -#define for_each_cpu(cpu)	  for_each_cpu_mask((cpu), cpu_possible_map)
>  +#define for_each_possible_cpu(cpu)  for_each_cpu_mask((cpu), cpu_possible_map)

Nope, I'll change this to

#define for_each_cpu(cpu)	  for_each_cpu_mask((cpu), cpu_possible_map)
#define for_each_possible_cpu(cpu)  for_each_cpu_mask((cpu), cpu_possible_map)

So both are valid.  That way

a) The kernel continues to compile at each step of the patch series
   (important!) and

b) We can remove for_each_cpu() later on, after all the various
   out-of-tree usages have been converted.

