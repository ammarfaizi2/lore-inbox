Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317140AbSGNUt3>; Sun, 14 Jul 2002 16:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317141AbSGNUt2>; Sun, 14 Jul 2002 16:49:28 -0400
Received: from coffee.Psychology.McMaster.CA ([130.113.218.59]:41189 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S317140AbSGNUtX>; Sun, 14 Jul 2002 16:49:23 -0400
Date: Sun, 14 Jul 2002 16:58:11 -0400 (EDT)
From: Mark Hahn <hahn@physics.mcmaster.ca>
X-X-Sender: <hahn@coffee.psychology.mcmaster.ca>
To: BALBIR SINGH <balbir.singh@wipro.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Pentium IV cache line size
In-Reply-To: <009c01c22b10$4934e6b0$290806c0@wipro.com>
Message-ID: <Pine.LNX.4.33.0207141629380.21492-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think the patch is correct and should be applied.

P4 SMP alignment should be 128B, and that seems to be the main
use of this constant.  I'd *love* to see the spurious "L1" removed - 
in fact, there's already SMP_CACHE_BYTES, which should be used instead.
maybe just CACHE_SHIFT/BYTES, since alignment is used for uni, too.

perhaps a janitor/trivial patch for 2.5?


> >From Pentium IV, System Programming Guide, Section 9.1, Page 9-2,
> Table 9-1. Order # 245472

dueling references!  mine are from the p4 and xeon opt guide.  page 7-9:
Key Practices of Thread Synchronization:
...
	- Place each synchronization variable alone, 
	separated by 128 byte or in a separate cache line.

see also table 1.1.  I'm not sure it matters whether you consider lines 128B
or 64B; the fact that cacheline reads always happen at 128B is probably
the dominant concern.  table 1.1 page 7-18 ("placement of shared
synchonization variable") repeats this.

