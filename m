Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286488AbSAFEIx>; Sat, 5 Jan 2002 23:08:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286553AbSAFEIe>; Sat, 5 Jan 2002 23:08:34 -0500
Received: from ip216-26-43-158.dsl.du.teleport.com ([216.26.43.158]:21749 "EHLO
	w-gerrit2") by vger.kernel.org with ESMTP id <S286488AbSAFEI2>;
	Sat, 5 Jan 2002 23:08:28 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: znmeb@aracnet.com (M. Edward Borasky),
        harald.holzer@eunet.at (Harald Holzer), linux-kernel@vger.kernel.org
Reply-To: Gerrit Huizenga <gerrit@us.ibm.com>
From: Gerrit Huizenga <gerrit@us.ibm.com>
Subject: Re: i686 SMP systems with more then 12 GB ram with 2.4.x kernel ? 
In-Reply-To: Your message of Tue, 01 Jan 2002 18:46:40 GMT.
             <E16LTvs-00016I-00@the-village.bc.nu> 
Date: Wed, 02 Jan 2002 13:17:59 -0800
Message-Id: <E16Lslt-0001aG-00@w-gerrit2>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In message <E16LTvs-00016I-00@the-village.bc.nu>, > : Alan Cox writes:

> > 2. Isn't the boundary at 2^30 really irrelevant and the three "correct"
> > zones are (0 - 2^24-1), (2^24 - 2^32-1) and (2^32 - 2^36-1)?
> 
> Nope. The limit for directly mapped memory is 2^30.
 
The limit *per L1 Page Table Base Pointer*, that is.  You could
in theory have a different L1 Page Table base pointer for each
task (including each proc 0 in linux).  You can also pull a few
tricks such as instantiating a 4 GB kernel virtual address space
while in kernel mode (using a virtual windowing mechanism as is used
for high mem today to map in user space for copying in data from
user space if/when needed).  The latter takes some tricky code to
get mapping correct but it wasn't a lot of code in PTX.  Just needed
a lot of careful thought, review, testing, etc.

I don't know if there are real examples of large memory systems
exhausting the ~1 GB of kernel virtual address space on machines
with > 12-32 GB of physical memory (we had this problem in PTX which
created the need for a larger kernel virtual address space in some
contexts).

> > 3. On a system without ISA DMA devices, can DMA and low be merged into a
> > single zone?
> 
> Rarely. PCI vendors are not exactly angels when it comes to implementing
> all 32bits of a DMA transfer

Would be nice to have a config option like "CONFIG_PCI_36" to imply
that all devices on a PAE system were able to access all of memory,
globally removing the need for bounce buffering and allowing a native
PCI setup for mapping memory addresses...

gerrit
