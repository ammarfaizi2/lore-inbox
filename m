Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314675AbSEBRXg>; Thu, 2 May 2002 13:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314674AbSEBRXg>; Thu, 2 May 2002 13:23:36 -0400
Received: from dsl-213-023-038-046.arcor-ip.net ([213.23.38.46]:28575 "EHLO
	starship") by vger.kernel.org with ESMTP id <S314663AbSEBRXe>;
	Thu, 2 May 2002 13:23:34 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Dave Engebretsen <engebret@vnet.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Date: Wed, 1 May 2002 19:24:29 +0200
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20020426192711.D18350@flint.arm.linux.org.uk> <20020502152825.GE10495@krispykreme> <3CD1624C.92FCE62A@vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E172xqA-00025U-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 May 2002 17:59, Dave Engebretsen wrote:
> Anton Blanchard wrote:
> > Also when we do hotplug memory support will discontigmem be able to
> > efficiently handle memory turning up all over the place in the memory
> > map?
>
> On this type of partitioned system where ppc64 runs, there is not much
> administration that could be done to help the problem.  As Anton
> mentioned, when the system has been up for a long time, and memory has
> been moving between partitions which support dynamic memory movement, it
> is assured that memory will become very fragmented.  As more partitions
> on these systems become available, and resources migrate more freely,
> the problem will get worse.
> 
> Whether this management from kernel to hardware addresses is done in the
> hypervisor layer or the OS, the same overhead exists, given todays
> hardware structure for PowerPC servers anyway.  In todays ppc64
> implementation, we just use an array to map from what the kernel sees as
> its address space to what is put in the hardware page table and I/O
> translation tables, thus not requiring any changes in independant code. 
> This does consume some storage, but the highly fragmented nature of our
> platform memory drives this decision.  I would like to see that data
> structure decision left to the archs as different platform design points
> may lead to different mapping decisions.

And it is left up to the arch in my patch, I've simply imposed a little more
order on what, up till now, has been a pretty chaotic corner of the kernel,
and provided a template that satisfies a wider variety of needs than the old
one.

It sounds like the table translation you're doing in the hypervisor is
exactly what I've implemented in the kernel.  One advantage of going with
the kernel's implementation is that you get the benefit of improvements
made to it, for example, the proposed hashing scheme to handle extremely
fragmented physical memory maps.

-- 
Daniel
