Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261596AbSJWAEr>; Tue, 22 Oct 2002 20:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261623AbSJWAEr>; Tue, 22 Oct 2002 20:04:47 -0400
Received: from packet.digeo.com ([12.110.80.53]:30671 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261596AbSJWAEq>;
	Tue, 22 Oct 2002 20:04:46 -0400
Message-ID: <3DB5E909.7F2AF339@digeo.com>
Date: Tue, 22 Oct 2002 17:10:49 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: New panic (io-apic / timer?) going from 2.5.44 to 2.5.44-mm1
References: <440550000.1035330723@flay>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Oct 2002 00:10:49.0144 (UTC) FILETIME=[A42C4380:01C27A28]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" wrote:
> 
> Hmmm ... 2.5.43-mm2 and 2.5.44 work fine, but 2.5.44-mm1 (and mm2)
> panic consistently on boot for a 16 way NUMA-Q.
> 
> Normally this box will boot with TSC on or off. If anyone has any pointers as
> to what's changed in the mm patchset going from 43-mm2 to 44-mm1 that
> might have touched this area (I can't see anything), please poke me in the
> eye. Otherwise I'll just keep digging into it ....
> 


Is possibly the code which defers the allocation of the per-cpu
memory until the secondary processors are being brought online.

I've decided to toss that.  It's causing some grief for architectures,
and only buys us 10k * (NR_CPUS - nr-cpus) worth of memory anyway.

Well.  It would be useful for NUMA to be able to place the per-cpu storage
into node-local memory.  But the code doesn't do that.  It just uses
kmalloc on the boot cpu, and we don't have an alloc_pages_for_another_cpu()
API..
