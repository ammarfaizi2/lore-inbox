Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964863AbWHHM3r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964863AbWHHM3r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 08:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964869AbWHHM3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 08:29:47 -0400
Received: from pfx2.jmh.fr ([194.153.89.55]:15011 "EHLO pfx2.jmh.fr")
	by vger.kernel.org with ESMTP id S964863AbWHHM3q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 08:29:46 -0400
From: Eric Dumazet <dada1@cosmosbay.com>
To: Andi Kleen <ak@suse.de>
Subject: Re: [RFC] NUMA futex hashing
Date: Tue, 8 Aug 2006 14:29:44 +0200
User-Agent: KMail/1.9.1
Cc: Ravikiran G Thirumalai <kiran@scalex86.org>,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       pravin b shelar <pravin.shelar@calsoftinc.com>,
       linux-kernel@vger.kernel.org
References: <20060808070708.GA3931@localhost.localdomain> <200608081210.40334.dada1@cosmosbay.com> <200608081236.15823.ak@suse.de>
In-Reply-To: <200608081236.15823.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608081429.44497.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 August 2006 12:36, Andi Kleen wrote:
> > We may have special case for PRIVATE futexes (they dont need to be
> > chained in a global table, but a process private table)
>
> What do you mean with PRIVATE futex?
>
> Even if the futex mapping is only visible by a single MM mmap_sem is still
> needed to protect against other threads doing mmap.

Hum... I would call that a user error.

If a thread is munmap()ing the vma that contains active futexes, result is 
undefined. Same as today I think (a thread blocked in a FUTEX_WAIT should 
stay blocked)

The point is that private futexes could be managed using virtual addresses, 
and no call to find_extend_vma(), hence no mmap_sem contention.

There could be problem if the same futex (32 bits integer) could be mapped at 
different virtual addresses in the same process.

Eric
