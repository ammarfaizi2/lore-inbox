Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132573AbRDKNRE>; Wed, 11 Apr 2001 09:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132574AbRDKNQy>; Wed, 11 Apr 2001 09:16:54 -0400
Received: from indyio.rz.uni-sb.de ([134.96.7.3]:51327 "EHLO
	indyio.rz.uni-sb.de") by vger.kernel.org with ESMTP
	id <S132573AbRDKNQo>; Wed, 11 Apr 2001 09:16:44 -0400
Message-ID: <3AD45930.92524F01@stud.uni-saarland.de>
Date: Wed, 11 Apr 2001 13:16:32 +0000
From: Studierende der Universitaet des Saarlandes 
	<masp0008@stud.uni-sb.de>
Reply-To: manfred@colorfullife.com
Organization: Studierende Universitaet des Saarlandes
X-Mailer: Mozilla 4.08 [en] (X11; I; Linux 2.0.36 i686)
MIME-Version: 1.0
To: kowalski@datrix.co.za
CC: linux-kernel@vger.kernel.org
Subject: icache > dentry cache. memory leak? Re: Fwd: Re: memory usage - dentry_cache
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> To possbile answer my own question: 
> if I do a can on /proc/slabinfo I get on the machine with "MISSING" memory: 
> ---- 
> slabinfo - version: 1.1 (SMP) 
> --- cut out 
> inode_cache 920558 930264 480 116267 116283 1 : 124 6 
> --- cut out 
> dentry_cache 557245 638430 128 21281 21281 1 : 252 126 
> 
You've found the missing memory: the fifth number is the number of pages
allocated for a cache: 125000 pages or 500 MB.

The first number is the number of allocated objects, the second number
is the total number of objects (the difference are preallocated
dentries/inodes to speed up further allocations and internal
fragmentation)
the third number is the size in bytes of one structure, then the number
of pages in use, and the total number of pages (the difference are
freeable pages that can be free by the memory pressure code)

The odd thing is that the inode cache is nearly twice as large as the
dentry cache.
Does that indicate a memory leak?

--
	Manfred
