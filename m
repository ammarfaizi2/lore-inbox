Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262593AbTEFL4E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 07:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262601AbTEFL4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 07:56:04 -0400
Received: from elin.scali.no ([62.70.89.10]:23697 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id S262593AbTEFLz7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 07:55:59 -0400
Subject: Re: The disappearing sys_call_table export.
From: Terje Eggestad <terje.eggestad@scali.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <m1n0i09ugv.fsf@frodo.biederman.org>
References: <1052122784.2821.4.camel@pc-16.office.scali.no>
	 <20030505092324.A13336@infradead.org>
	 <1052127216.2821.51.camel@pc-16.office.scali.no>
	 <20030505112531.B16914@infradead.org> <m17k94bkh0.fsf@frodo.biederman.org>
	 <1052208877.15887.13.camel@pc-16.office.scali.no>
	 <m13cjsbfc7.fsf@frodo.biederman.org>
	 <1052220098.15887.24.camel@pc-16.office.scali.no>
	 <m1n0i09ugv.fsf@frodo.biederman.org>
Content-Type: text/plain
Organization: Scali AS
Message-Id: <1052222909.15887.44.camel@pc-16.office.scali.no>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 06 May 2003 14:08:30 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-05-06 at 13:37, Eric W. Biederman wrote:
> Terje Eggestad <terje.eggestad@scali.com> writes:
> > 
> > The problem I've got happen when an app registers the memory with the
> > driver, releases the memory back to the kernel thru sbrk(-n) or
> > munmap()s it. Then get new memory thru sbrk(+n) or mmap() which then get
> > the same vaddr. 
> > 
> > mapping from vaddr to phys addr happen at the registration point. 
> 
> I was talking about an method that does not require a registration
> point.  So it sounds like we are talking past each other on this one.
>  
> > Querying the kernel for a vaddrs  phys addr every time it's used is too
> > costly. There is a better explanantion in a earlier post. 
> 
> There are 2 possible interfaces to get a vaddr to phys addr mapping.
> 1) Register the memory area and pin it down.
> 2) MMap from memory allocated by the driver.
>    In this case the driver is told about every mmap and unmap.
> 
> So I believe that baring the strange issues with hooking malloc
> to call a mmap function on your driver 2 is the correct solution.
> 

Well, since the memory is already alloc'ed as normal user memory, it
gotta be 1), which require a registration point. 
 

> > > That can be handled in user space by querying the mmaped region.  But
> > > if the card does not have the smarts to do the virtual to physical
> > > translation, or at the very least limit the set of physical pages a
> > > user space a do DMA to/from that is a fundamental security issue and
> > > means all of the optimizations are not safe.  And you must enter/exit
> > > the kernel to send a DMA transaction.
> > > 
> > 
> > send/recv don't need kernel interaction on high perf interconnects.
> 
> Agreed.  I was simply mention the requires for that to be safe.
> 
> > > So far the only fortran issues I have seen that could affect malloc
> > > are adding extra under scores.  What issue are you running into?
> > > 
> > 
> > Some don't use (g)libc, but do syscalls directly.
> 
> That is clearly broken code.  A user space application compiled statically is
> one thing.  Directly putting syscalls in libraries other than libc is
> quite bad.  And I currently cannot think of an excuse for it.
> Especially as that will ensure you use the slow syscall path on recent
> kernels. 
> 

Agree, come to think about it, if you write code in fortran it's broken
by default ;-) 

The thing is of course that pesky customers have fortran code they need
to run, and as long there is no g90, and g77 performance sucks, there is
only commercial fortran compilers in play....  


> Eric


TJ


-- 
_________________________________________________________________________

Terje Eggestad                  mailto:terje.eggestad@scali.no
Scali Scalable Linux Systems    http://www.scali.com

Olaf Helsets Vei 6              tel:    +47 22 62 89 61 (OFFICE)
P.O.Box 150, Oppsal                     +47 975 31 574  (MOBILE)
N-0619 Oslo                     fax:    +47 22 62 89 51
NORWAY            
_________________________________________________________________________

