Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315253AbSEIX4k>; Thu, 9 May 2002 19:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315260AbSEIX4j>; Thu, 9 May 2002 19:56:39 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:4873 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S315253AbSEIX4h>;
	Thu, 9 May 2002 19:56:37 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200205092356.g49NuTS70861@saturn.cs.uml.edu>
Subject: Re: x86 question: Can a process have > 3GB memory?
To: rml@tech9.net (Robert Love)
Date: Thu, 9 May 2002 19:56:29 -0400 (EDT)
Cc: tchiwam@ees2.oulu.fi (tchiwam), linux-kernel@vger.kernel.org,
        riel@conectiva.com.br (Rik van Riel), gh@us.ibm.com (Gerrit Huizenga),
        ctwhite@us.ibm.com (Clifford White), oliendm@us.ibm.com
In-Reply-To: <1020980411.880.93.camel@summit> from "Robert Love" at May 09, 2002 02:40:10 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love writes:
> On Thu, 2002-05-09 at 14:24, tchiwam wrote:

>> How about other architectures ? like PowerPc.
>> Last calculation I did used 11GB of ram (no swap) on a big Number
>> Muncher... Would it be nice to use the same code for testing on 32
>> architectures with swap ?
>
> All 32-bit architectures have a 4GB address space, 64-bit architectures
> obviously have a much bigger one (depends on the arch how many bits are
> used for the address space).
>
> PPC obviously does not have the dumb physical memory limitations x86
> has, however.

Huh? Unless you mean ppc64, ppc is worse.
On a Mac, you get 2 GB of virtual memory per
process. You get up to 512 MB of physical memory
without highmem support, or usually 4 GB with
highmem support. As with x86, the latest chips
offer a 36-bit (64 GB) physical address space.

Virtual memory layout:

00000000-7fffffff user
80000000-bfffffff waste (for IO on obscure Amiga "upgrade" junk)
c0000000-dfffffff non-paged mapping of 512 MB at phys addr 0
e0000000-ffffffff IO, vmalloc(), etc.

That's not all! Linus recently singled out the PowerPC
MMU for a nice long abusive rant. :-) You get hashed
page tables. You get this:

As with x86, segment registers map a 32-bit virtual
address space onto a larger one. The top 4 bits of
a 32-bit virtual address are used to select a segment,
and the segment provides 24 more address bits to
give you a 52-bit virtual address. Eeeew.
