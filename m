Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316250AbSEVQhK>; Wed, 22 May 2002 12:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316255AbSEVQhJ>; Wed, 22 May 2002 12:37:09 -0400
Received: from mail3.aracnet.com ([216.99.193.38]:48877 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S316250AbSEVQhI>; Wed, 22 May 2002 12:37:08 -0400
Date: Wed, 22 May 2002 09:36:35 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: William Lee Irwin III <wli@holomorphy.com>
cc: "M. Edward Borasky" <znmeb@aracnet.com>, linux-kernel@vger.kernel.org,
        andrea@suse.de, riel@surriel.com, torvalds@transmeta.com,
        akpm@zip.com.au
Subject: Re: Have the 2.4 kernel memory management problems on large machines been fixed?
Message-ID: <1406543793.1022060194@[10.10.2.3]>
In-Reply-To: <20020522160731.GC14918@holomorphy.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> pte-highmem isn't enough. On an 8GB machine it's already dead. Sharing
> is required just to avoid running out of space period. IIRC Dave
> McCracken has been working on daniel's original pte sharing patch.

Depends on the workload, but yes.

>> 5. kmap
>> 	Persistent kmap sucks, and the global systemwide TLB flushes
>> 	scale as O(1/N^2) with the number of CPUs. Enlarging the kmap 
>> 	area helps a little, but really we need to stop doing this to
>> 	ourselves. I will have a patch (hopefully within a week) to do 
>> 	per-task kmap, based on the	UKVA patch that Dave McCracken has
>> 	already implemented.
> 
> O(1/N^2)? wouldn't that get progressively better as the number of cpu's
> grows without bound?

Cost of TLB flush on 1 cpu = 1. Number of CPUs = N. Cost of systemwide
TLB flush = N. Assuming we actually use those CPUs in a comparable way, 
we do N times as many global tlbflushes per second with N cpus. This N^2.
Or that's my reckoning, anyway.

M.

