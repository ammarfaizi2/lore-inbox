Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314654AbSEBRBU>; Thu, 2 May 2002 13:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314655AbSEBRBT>; Thu, 2 May 2002 13:01:19 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:37368 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S314654AbSEBRBR>;
	Thu, 2 May 2002 13:01:17 -0400
Message-ID: <3CD1624C.92FCE62A@vnet.ibm.com>
Date: Thu, 02 May 2002 10:59:08 -0500
From: Dave Engebretsen <engebret@vnet.ibm.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Daniel Phillips <phillips@bonn-fries.net>
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
In-Reply-To: <20020426192711.D18350@flint.arm.linux.org.uk> <E171aOa-0001Q6-00@starship> <20020429153500.B28887@dualathlon.random> <E172K9n-0001Yv-00@starship> <20020501042341.G11414@dualathlon.random> <20020501180547.GA1212440@sgi.com> <20020502011750.M11414@dualathlon.random> <20020502002010.GA14243@krispykreme> <20020502030113.Q11414@dualathlon.random> <20020502152825.GE10495@krispykreme>
X-MIMETrack: Itemize by SMTP Server on d27ml101/27/M/IBM(Release 5.0.10 |March 22, 2002) at
 05/02/2002 12:00:32 PM,
	Serialize by Router on d27ml101/27/M/IBM(Release 5.0.10 |March 22, 2002) at
 05/02/2002 12:00:35 PM,
	Serialize complete at 05/02/2002 12:00:35 PM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Blanchard wrote:
> 
> > more than 256LV available in LVM], a sane partitioning requires you to
> > have at least a partition for /usr large 1 giga, depends what you're
> > doing of course, but requiring sane partitioning it's an admin problem
> > not a kernel problem IMHO).
> 
> Its not a NUMA machine, its one that allows shared processor logical
> partitions. While I would prefer the hypervisor to give each partition
> a nice memory map (and internally maintain a mapping to real memory)
> it does not. I can imagine if the machine has been up for many months
> memory could become very fragmented.
> 
> Also when we do hotplug memory support will discontigmem be able to
> efficiently handle memory turning up all over the place in the memory
> map?
> 
> Anton

On this type of partitioned system where ppc64 runs, there is not much
administration that could be done to help the problem.  As Anton
mentioned, when the system has been up for a long time, and memory has
been moving between partitions which support dynamic memory movement, it
is assured that memory will become very fragmented.  As more partitions
on these systems become available, and resources migrate more freely,
the problem will get worse.

Whether this management from kernel to hardware addresses is done in the
hypervisor layer or the OS, the same overhead exists, given todays
hardware structure for PowerPC servers anyway.  In todays ppc64
implementation, we just use an array to map from what the kernel sees as
its address space to what is put in the hardware page table and I/O
translation tables, thus not requiring any changes in independant code. 
This does consume some storage, but the highly fragmented nature of our
platform memory drives this decision.  I would like to see that data
structure decision left to the archs as different platform design points
may lead to different mapping decisions.

Dave.
