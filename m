Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267794AbTBKMkD>; Tue, 11 Feb 2003 07:40:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267796AbTBKMkD>; Tue, 11 Feb 2003 07:40:03 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:24999 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267794AbTBKMkC>;
	Tue, 11 Feb 2003 07:40:02 -0500
Date: Tue, 11 Feb 2003 18:25:08 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Corey Minyard <cminyard@mvista.com>, Kenneth Sumrall <ken@mvista.com>,
       linux-kernel@vger.kernel.org, lkcd-devel@lists.sourceforge.net
Subject: Re: Kexec, DMA, and SMP
Message-ID: <20030211182508.A2936@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <3E448745.9040707@mvista.com> <m1isvuzjj2.fsf@frodo.biederman.org> <3E45661A.90401@mvista.com> <m1d6m1z4bk.fsf@frodo.biederman.org> <20030210174243.B11250@in.ibm.com> <m18ywoyq78.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <m18ywoyq78.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Mon, Feb 10, 2003 at 10:56:43AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2003 at 10:56:43AM -0700, Eric W. Biederman wrote:
> Suparna Bhattacharya <suparna@in.ibm.com> writes:
[snip]
> 
> Not primarily.  Instead I am trying to address the possibility that
> DMA is overwriting the recovery code due to a device not being shutdown
> properly.  Though it would happen to cover many cases of the wrong
> memory address being passed to a device.
> 
[snip]
> 
> The other piece that a reserved area of memory is that you can
> simplify the other cases because you don't need to do anything
> before the dump because everything is preserved.
> 
[snip]

> Yes, for the same reasons.   I am definitely not trying to address the
> case of buggy hardware.
> 
[snip]
> 
> And I am certain that with a preserved memory area we can
> preserve everything without compression.
> 

OK, I see where you are coming from. It is an interesting
possibility, if you know how to pull it off for various 
architectures, and the working area that the new kernel needs 
to do operate to the extent of issuing the writeout is not 
too big (i.e.  doesn't take away too much memory from the 
operational kernel). Perhaps we could hide this memory from 
the normal kernel virtual address space most of the time, so 
its less susceptable to software corruption (i.e. besides
physical access via DMA).

At the same time we do want to quiesce / stop the DMA as 
soon as possible to get a dump that reflects the 
contents of memory at the concerned instant as closely as 
possible. And in the buggy case we want to stop any 
malfunctioning DMA (writes) immediately to minimize 
damage.

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India

