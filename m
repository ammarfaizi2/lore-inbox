Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314671AbSEBRqv>; Thu, 2 May 2002 13:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314672AbSEBRqv>; Thu, 2 May 2002 13:46:51 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:58045 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S314671AbSEBRqu>;
	Thu, 2 May 2002 13:46:50 -0400
Message-ID: <3CD16CFA.B103817D@vnet.ibm.com>
Date: Thu, 02 May 2002 11:44:42 -0500
From: Dave Engebretsen <engebret@vnet.ibm.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
In-Reply-To: <20020426192711.D18350@flint.arm.linux.org.uk> <20020502152825.GE10495@krispykreme> <3CD1624C.92FCE62A@vnet.ibm.com> <E172xqA-00025U-00@starship>
X-MIMETrack: Itemize by SMTP Server on d27ml101/27/M/IBM(Release 5.0.10 |March 22, 2002) at
 05/02/2002 12:46:11 PM,
	Serialize by Router on d27ml101/27/M/IBM(Release 5.0.10 |March 22, 2002) at
 05/02/2002 12:46:13 PM,
	Serialize complete at 05/02/2002 12:46:13 PM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> And it is left up to the arch in my patch, I've simply imposed a little more
> order on what, up till now, has been a pretty chaotic corner of the kernel,
> and provided a template that satisfies a wider variety of needs than the old
> one.

Yep, got that - just reenforcing the point.

> It sounds like the table translation you're doing in the hypervisor is
> exactly what I've implemented in the kernel.  One advantage of going with
> the kernel's implementation is that you get the benefit of improvements
> made to it, for example, the proposed hashing scheme to handle extremely
> fragmented physical memory maps.
> 

I should clarify a bit -- we run on two different hypervisor
interfaces.  The iSeries interface leaves this translation work to the
OS.  In that case Linux has an array translation lookup which is
analogous to your patch.  We just managed to hide everything in
arch/ppc64 by doing this lookup when inserting hashed page table and I/O
table mappings.  Other than at that low level, the remappings are
transparent to Linux -- it just sees a nice big flat physical address
space.

On pSeries, the hypervisor does the translation work under the covers,
but as you point out, Linux doesn't get the chance to play with
different mapping schemes.  Then again, that does simplify my life ...

Dave.
