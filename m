Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266623AbSKUNfo>; Thu, 21 Nov 2002 08:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266631AbSKUNfo>; Thu, 21 Nov 2002 08:35:44 -0500
Received: from ns.suse.de ([213.95.15.193]:38414 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S266623AbSKUNfn>;
	Thu, 21 Nov 2002 08:35:43 -0500
Date: Thu, 21 Nov 2002 14:42:50 +0100
From: Andi Kleen <ak@suse.de>
To: Dave Jones <davej@codemonkey.org.uk>, Andi Kleen <ak@suse.de>,
       Margit Schubert-While <margit@margit.com>, linux-kernel@vger.kernel.org
Subject: Re: L1_CACHE_SHIFT value for P4 ?
Message-ID: <20021121134250.GA31081@wotan.suse.de>
References: <4.3.2.7.2.20021121130236.00b15370@mail.dns-host.com.suse.lists.linux.kernel> <p73y97nt6fp.fsf@oldwotan.suse.de> <20021121132302.GD9883@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021121132302.GD9883@suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2002 at 01:23:02PM +0000, Dave Jones wrote:
> On Thu, Nov 21, 2002 at 02:10:02PM +0100, Andi Kleen wrote:
> 
>  > The P4 has 128byte L2 cache lines (2^7). The L1 apparently has smaller lines.
> 
> Not mine:
> 
> L2 unified cache:
> 	Size: 512KB	Sectored, 8-way associative.
> 	line size=64 bytes.
> 
> Someone (Manfred?) pointed out a chapter in the P4 system programmer guide about
> this last time I brought it up. I forget the reasoning, I'll see if I can dig it out..

The only reference I was able to find was in the Intel Technology Journal,
which says the L2 cache has a 128 byte cache line.

http://developer.intel.com/technology/itj/q12001/articles/art_2.htm
-> "Netburst microarchitecture" -> Level 2 Instruction and Data Cache
"The L2 cache is organized as an 8-way set-associative cache with 128 bytes 
per cache line. These 128-byte cache lines consist of two 64-byte sectors. 
A miss in the L2 cache typically initiates two 64-byte access requests to the 
system bus to fill both halves of the cache line. The L2 cache is a write-back 
cache that allocates new cache lines on load or store misses. "

It is refering to the older 256K cached P4, but I doubt they changed it.
Your cache reporting may refer to the 64byte sectors or is just wrong
(would not be the first time that has happened - some P4 versions also
misreported their TLB size) 

For cache colouring purposes you need to use the 128 byte unit.

-Andi

-Andi
> 
> 		Dave
> 
> -- 
> | Dave Jones.        http://www.codemonkey.org.uk
> | SuSE Labs
