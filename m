Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263844AbTEFO00 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 10:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263845AbTEFO00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 10:26:26 -0400
Received: from franka.aracnet.com ([216.99.193.44]:31957 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263844AbTEFO0W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 10:26:22 -0400
Date: Tue, 06 May 2003 07:38:09 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>, "David S. Miller" <davem@redhat.com>
cc: rusty@rustcorp.com.au, dipankar@in.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kmalloc_percpu
Message-ID: <6940000.1052231887@[10.10.2.4]>
In-Reply-To: <20030506003412.45e0949b.akpm@digeo.com>
References: <20030505235549.5df75866.akpm@digeo.com><20030505.225748.35026531.davem@redhat.com><20030506002229.631a642a.akpm@digeo.com><20030505.231553.68055974.davem@redhat.com> <20030506003412.45e0949b.akpm@digeo.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> As just pointed out by dipankar the only issue is NUMA...
>> so it has to be something more sophisticated than simply
>> kmalloc()[smp_processor_id];
> 
> The proposed patch doesn't do anything about that either.
> 
> +	ptr = alloc_bootmem(PERCPU_POOL_SIZE * NR_CPUS);
> 
> So yes, we need an api which could be extended to use node-affine memory at
> some time in the future.  I think we have that.

You can just call alloc_bootmem_node for each CPU instead. It doesn't 
work on i386 at the moment (well, it'll work but come out of node 0), 
but it probably ought to.

M.

