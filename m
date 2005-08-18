Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932243AbVHRPWD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbVHRPWD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 11:22:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932245AbVHRPWD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 11:22:03 -0400
Received: from gw1.cosmosbay.com ([62.23.185.226]:52875 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S932243AbVHRPWB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 11:22:01 -0400
Message-ID: <4304A6DF.6040703@cosmosbay.com>
Date: Thu, 18 Aug 2005 17:18:55 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
CC: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: idle task's task_t allocation on NUMA machines
References: <20050818140829.GB8123@implementation.labri.fr>
In-Reply-To: <20050818140829.GB8123@implementation.labri.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Thu, 18 Aug 2005 17:18:57 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Samuel Thibault a écrit :
> Hi,
> 
> Currently, the task_t structure of the idle task is always allocated
> on CPU0, hence on node 0: while booting, for each CPU, CPU 0 calls
> fork_idle(), hence copy_process(), hence dup_task_struct(), hence
> alloc_task_struct(), hence kmem_cache_alloc(), which picks up memory
> from the allocation cache of the current CPU, i.e. on node 0.
> 
> This is a bad idea: every write needs be written back to node 0 at some
> time, so that node 0 can get a small bit busy especially when other
> nodes are idle.
> 
> A solution would be to add to copy_process(), dup_task_struct(),
> alloc_task_struct() and kmem_cache_alloc() the node number on which
> allocation should be performed. This might also be useful if performing
> node load balancing at fork(): one could then allocate task_t directly
> on the new node. It might also be useful when allocating data for
> another node.
> 
> Regards,
> Samuel

An idle task should block itself, hence not touching its task_t structure very much.

I believe IRQ stacks are also allocated on node 0, that seems more serious.

Eric
