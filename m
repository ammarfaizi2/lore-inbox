Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271842AbRIEIEh>; Wed, 5 Sep 2001 04:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271827AbRIEIE1>; Wed, 5 Sep 2001 04:04:27 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:43524 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S271822AbRIEIES>; Wed, 5 Sep 2001 04:04:18 -0400
Message-ID: <3B95DC37.A7FF9966@idb.hist.no>
Date: Wed, 05 Sep 2001 10:03:03 +0200
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.4.10-pre4 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: "Grover, Andrew" <andrew.grover@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: lilo vs other OS bootloaders was: FreeBSD makes progress
In-Reply-To: <4148FEAAD879D311AC5700A0C969E89006CDE0E2@orsmsx35.jf.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Grover, Andrew" wrote:
> 
> > >  ANdreas Dilger wrote:
> > > > Win2K even abstracts all SMP/UP code into a module (the
> > HAL) and loads this
> > > > at boot, thus using the same kernel for both.
> >
> > >     the only possibility of this shows how ugly is SMP in win2k...
> >
> > Not necessarily. More likely the difference between SMP and
> > UP is marketing-only and both have the overhead of SMP
> > locking, etc..
> 
> No, they don't do this by running an SMP kernel on UP, they do it by
> abstracting functions that care about SMP into another module.
> 
> Here's Linux:
> 
> Drivers (SMP agnostic)
> Kernel (SMP/UP specific)
> 
Linux modules are not agnostic, they too are SMP specific.
Because a module may use spinlocks.

Modules should really be compiled with the kernel.  They are an
intersting way to save some memory, they are not a way of
distributing drivers or anything like that.

> I'm not advocating anything similar for Linux, I'm just saying it's an
> interesting thought experiment - what if the SMP-ness of a machine was
> abstracted from the kernel proper? How much of the kernel really cares, or
> really *should* care about SMP/UP?
> 
> For one thing, it would get rid of the hundreds of "#ifdef CONFIG_SMP"s in
> the kernel. ;-)

You would also get rid of performance.  The agnostic kernel would be
slower than simply running the SMP kernel on UP.

Here's why:
You can easily make an "agnostic kernel & modules" by changing the
spinlocks to function calls.  Then you'll provide a null stub call site
for running UP, and the real spinlock code for running SMP.

Unfortunately, this gives the overhead of a function call, both for SMP
and for UP.  This overhead is usually _bigger_ than the overhead of a
inlined spinlock.

So if you aim for a simple distribution - go for SMP.  The loss on UP is
small. I have haerd of cases when the SMP setup code fails on UP
when smp hardware is missing.  You could of course work to eliminate
that.

Helge Hafting
