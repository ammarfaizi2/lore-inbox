Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314330AbSECPib>; Fri, 3 May 2002 11:38:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314339AbSECPia>; Fri, 3 May 2002 11:38:30 -0400
Received: from mail3.aracnet.com ([216.99.193.38]:32705 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S314330AbSECPia>; Fri, 3 May 2002 11:38:30 -0400
Date: Fri, 03 May 2002 08:38:03 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: William Lee Irwin III <wli@holomorphy.com>,
        Andrea Arcangeli <andrea@suse.de>
cc: Daniel Phillips <phillips@bonn-fries.net>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Message-ID: <4056520097.1020415082@[10.10.2.3]>
In-Reply-To: <20020503092643.GR32767@holomorphy.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Have you done testing with 64GB? What sort of failure modes are you
> seeing with it? I've been hearing about more severe failure modes in
> practice on 32GB, Martin, could you comment on this?

I've never gone above 32Gb (yet ;-)). We don't have an SMP platform
that I know of that'll support 64Gb, only the NUMA platforms.

32Gb will boot and work with 1GB KVA, but if you actually want to
use the memory for something, a 2GB KVA seems imperative. It depends
on the workload you're using, but the things we tend to see are:

1. struct page.
2. buffer heads (will look at -aa tree)
3. user page tables (need highpte)
4. LDTs for threads filling the vmalloc space (seems to be fixed in 2.5)

I think the whole struct page issue needs some (complex, hard) work,
but in general, we're getting there. Fast ;-)

M.

PS. BTW, Andrea, your latest highpte looks like you obliterated the
kmap problem I was complaing of, but I've been having massive problems 
with other things which are blocking much of the real testing ... 
sorry about the time lag ;-)
