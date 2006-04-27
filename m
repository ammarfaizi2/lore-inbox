Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964975AbWD0IWu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964975AbWD0IWu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 04:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964976AbWD0IWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 04:22:50 -0400
Received: from mta2.cl.cam.ac.uk ([128.232.0.14]:22931 "EHLO mta2.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S964975AbWD0IWt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 04:22:49 -0400
In-Reply-To: <44503AD5.9020605@yahoo.com.au>
References: <200604262203.k3QM3qOC009581@zach-dev.vmware.com> <445009A2.3030305@yahoo.com.au> <445019E7.80900@vmware.com> <44503AD5.9020605@yahoo.com.au>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <6da99325005e79f72b7c45a0228dea39@cl.cam.ac.uk>
Content-Transfer-Encoding: 7bit
Cc: Zachary Amsden <zach@vmware.com>, Pratap Subrahmanyam <pratap@vmware.com>,
       Hugh Dickins <hugh@veritas.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.com>, Jan Beulich <jbeulich@novell.com>
From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Subject: Re: [PATCH 2/2] I386 convert pae wmb to non smp
Date: Thu, 27 Apr 2006 09:21:54 +0100
To: Nick Piggin <nickpiggin@yahoo.com.au>
X-Mailer: Apple Mail (2.623)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 27 Apr 2006, at 04:30, Nick Piggin wrote:

>> The name is pretty confused.  smp_wmb seems to imply an SMP-only 
>> barrier, whereas we want here a write barrier on regular memory.
>
> That is just a compiler barrier (barrier()). A CPU should always be 
> consistent with
> itself so memory ordering doesn't really apply there (hence smp_ 
> prefix, which also
> are compiler barriers, of course).

This would be an issue of consistency between a CPU and its TLB, so I 
doubt the usual self-consistency argument would hold. I would consider 
the TLB as logically external and separate from the core execution 
logic of the CPU. Of course it's an academic point either way since no 
PAE-capable x86 processor ever reorders stores to WB memory -- my 
original point was simply that smp_wmb() is a misleading name in this 
context, even barrier() would be clearer imo, but I'm in no way a Linux 
abstract memory model expert.

  -- Keir

