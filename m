Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267474AbTBLOmW>; Wed, 12 Feb 2003 09:42:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267471AbTBLOmU>; Wed, 12 Feb 2003 09:42:20 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:52322 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S267459AbTBLOmL>; Wed, 12 Feb 2003 09:42:11 -0500
To: Corey Minyard <cminyard@mvista.com>
Cc: suparna@in.ibm.com, Kenneth Sumrall <ken@mvista.com>,
       linux-kernel@vger.kernel.org, lkcd-devel@lists.sourceforge.net
Subject: Re: Kexec, DMA, and SMP
References: <3E448745.9040707@mvista.com> <m1isvuzjj2.fsf@frodo.biederman.org>
	<3E45661A.90401@mvista.com> <m1d6m1z4bk.fsf@frodo.biederman.org>
	<20030210174243.B11250@in.ibm.com>
	<m18ywoyq78.fsf@frodo.biederman.org> <20030211182508.A2936@in.ibm.com>
	<20030211191027.A2999@in.ibm.com> <3E490374.1060608@mvista.com>
	<20030211201029.A3148@in.ibm.com> <3E4914CA.6070408@mvista.com>
	<m1of5ixgun.fsf@frodo.biederman.org> <3E4A578C.7000302@mvista.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 12 Feb 2003 07:51:33 -0700
In-Reply-To: <3E4A578C.7000302@mvista.com>
Message-ID: <m13cmty2kq.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Corey Minyard <cminyard@mvista.com> writes:

> Eric W. Biederman wrote:
> 
> |Corey Minyard <cminyard@mvista.com> writes:
> |
> |>
> |>You don't understand.  You don't *want* to set aside a block of memory that's
> |>reserved for DMA.  You want to be able to DMA directly into any user address.
> |>Consider demand paging.  The performance would suck if you DMA into some
> |>fixed region then copied to the user address.  Plus you then have another
> |>resource you have to manage in the kernel.  And you still have to change all
> |>the drivers, buffer management, etc. to add a flag that says "I'm going to use
> 
> |>this for DMA" to allocations.  You might as well add the quiesce function,
> it's
> 
> |>probably easier to do.  And it doesn't help if you DMA to static memory
> |>addresses.
> |>
> |>I, too, would like a simpler solution.  I just don't think this is it.
> |
> |
> |You have it backwards.  It is not about reserving a block of memory
> |for DMA.  It is about reserving a block of memory to not do DMA in.
> |Something like 4MB or so.  |
> |The idea is not to let the original kernel touch the reserved block at all.
> |We just put the kernel that kexec will start in that block of memory.
> |
> |Eric
> |
> Ah, it makes much more sense now.  Thank you.  I still don't think it's as easy
> as you think, though.
> Because there's no designation on most memory allocations to give you this
> information.  There's
> GFP_DMA, but according to the docs that's just for x86 ISA DMA devices.  You
> would
> have to hunt down all the memory allocations, figure out of they are DMA targets
> 
> or not, and add a
> flag for that.  I still say it's easier to just add the function to the drivers.

It is trivial if you don't let alloc_pages give the memory to anyone for
any purpose.

Eric
