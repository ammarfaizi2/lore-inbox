Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316007AbSEJTGz>; Fri, 10 May 2002 15:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316008AbSEJTGy>; Fri, 10 May 2002 15:06:54 -0400
Received: from NEVYN.RES.CMU.EDU ([128.2.145.6]:21632 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id <S316007AbSEJTGx>;
	Fri, 10 May 2002 15:06:53 -0400
Date: Fri, 10 May 2002 15:06:51 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Mark Gross <mgross@unix-os.sc.intel.com>
Cc: linux-kernel@vger.kernel.org, mark.gross@intel.com, mark@thegnar.org,
        vamsi@in.ibm.com, efocht@ess.nec.de
Subject: Re: [PATCH] multithreaded coredumps for elf exeecutables for O(1) scheduler
Message-ID: <20020510190650.GA1722@nevyn.them.org>
Mail-Followup-To: Mark Gross <mgross@unix-os.sc.intel.com>,
	linux-kernel@vger.kernel.org, mark.gross@intel.com,
	mark@thegnar.org, vamsi@in.ibm.com, efocht@ess.nec.de
In-Reply-To: <200205101624.g4AGOSw16928@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2002 at 09:24:14AM -0400, Mark Gross wrote:
> 
> Attached is my current patch for creating multithreaded core dump files,
> that works with the O(1) scheduler.
>  
> This is a continuation of the work posted by Vamsi Krishna back on 3/21/02.
> I'm sorry for the delay.  The problem of suspending the other thread
> processes for the duration of the core dump was a challenging problem with
> the O(1) scheduler.
>  
> Most of the patch is the same as that posted on 3/21/02 with some minor
> fixes and the rebasing to the 2.5.14 kernel.  The interesting bits are in
> the additions to sched.c to pause and resume the thread processes under the 
> O(1) scheduler.
>  
> Here I'm leveraging the work of Eric Foct for the process migration, to
> temporarily migrate the thread processes I need suspended to a "phantom
> runqueue".  This is just an additional run queue that has no cpu.  When I'm
> finish with the core dump I migrate them off the phantom run queue and
> continue processing whatever exit processing they do.
>  
> I tried a number of approaches to process pausing that didn't quite work 
> before I settled on the attached implementation.

That's a very interesting approach... I like it.

> This work has been unit test on a 2 way and 4 way SMP systems with no
> lockups so far.  YMMV.
>  
> Note: GDB 5.x will work with the core files created with this patch, provided
> the libpthread that gets loaded at gdb debug time is stripped of symbols. 
> 
> Run strip on your libpthread so files and things should work fine for you.  

Or use GDB 5.2.



-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
