Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262776AbSJRCHM>; Thu, 17 Oct 2002 22:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262786AbSJRCHM>; Thu, 17 Oct 2002 22:07:12 -0400
Received: from zero.aec.at ([193.170.194.10]:26895 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id <S262776AbSJRCHL>;
	Thu, 17 Oct 2002 22:07:11 -0400
Date: Fri, 18 Oct 2002 04:12:42 +0200
From: Andi Kleen <ak@muc.de>
To: Mark Gross <markgross@thegnar.org>
Cc: Andi Kleen <ak@muc.de>, Ingo Molnar <mingo@elte.hu>,
       Alexander Viro <viro@math.psu.edu>,
       S Vamsikrishna <vamsi_krishna@in.ibm.com>,
       Ulrich Drepper <drepper@redhat.com>, linux-kernel@vger.kernel.org,
       NPT library mailing list <phil-list@redhat.com>
Subject: Re: [patch] thread-aware coredumps, 2.5.43-C3
Message-ID: <20021018021242.GA15853@averell>
References: <200210081627.g98GRZP18285@unix-os.sc.intel.com> <Pine.LNX.4.44.0210171009240.12653-100000@localhost.localdomain> <m33cr4pn56.fsf@averell.firstfloor.org> <200210171835.21647.markgross@thegnar.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210171835.21647.markgross@thegnar.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2002 at 03:35:21AM +0200, Mark Gross wrote:
> On Thursday 17 October 2002 06:10 pm, Andi Kleen wrote:
> > Ingo Molnar <mingo@elte.hu> writes:
> >
> >
> > [...]
> >
> > This is not directly related to mt coredumps, but for anybody hacking the
> > core dumper:
> >
> > it would be cool if error code/trapno were included in the coredump in some
> > elf note. It has always annoyed me that these were lost and they can
> > be very useful to diagnose crashes that are caused by kernel problems.
> >
> > -Andi
> 
> What more do you want?  You have all the registers, the mm and at least a 
> dissasembly of the code, you even have the signr in the NT_PRSTATUS section.

I want the x86 CPU error code, which often has interesting clues on the problem.
trapno would be useful too. I suspect other CPUs have similar extended
state for exceptions.

I usually hack my kernel to printk() it, but having it in the coredump
would be more general and you can look at it later.

Eventually (in a future kernel) I would love to have the exception
handler save the last branch debugging registers of the CPU and the let the
core dumper put that into the dump too.  Then you could easily
figure out what the program did shortly before the crash.

-Andi
