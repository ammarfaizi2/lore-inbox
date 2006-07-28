Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161285AbWG1UcE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161285AbWG1UcE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 16:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161286AbWG1UcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 16:32:04 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:17652 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1161284AbWG1UcC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 16:32:02 -0400
Subject: Re: A better interface, perhaps: a timed signal flag
From: Steven Rostedt <rostedt@goodmis.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Theodore Tso <tytso@mit.edu>, Neil Horman <nhorman@tuxdriver.com>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Segher Boessenkool <segher@kernel.crashing.org>,
       Dave Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
       a.zummo@towertech.it, jg@freedesktop.org
In-Reply-To: <1154118962.13509.185.camel@localhost.localdomain>
References: <44C67E1A.7050105@zytor.com>
	 <20060725204736.GK4608@hmsreliant.homelinux.net>
	 <44C6842C.8020501@zytor.com> <20060725222547.GA3973@localhost.localdomain>
	 <70FED39F-E2DF-48C8-B401-97F8813B988E@kernel.crashing.org>
	 <20060725235644.GA5147@localhost.localdomain> <44C6B117.80300@zytor.com>
	 <20060726002043.GA5192@localhost.localdomain>
	 <20060726144536.GA28597@thunk.org>
	 <1154093606.19722.11.camel@localhost.localdomain>
	 <20060728145210.GA3566@thunk.org>
	 <1154104885.13509.142.camel@localhost.localdomain>
	 <1154105089.19722.23.camel@localhost.localdomain>
	 <1154116918.13509.162.camel@localhost.localdomain>
	 <1154117532.19722.32.camel@localhost.localdomain>
	 <1154118962.13509.185.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 28 Jul 2006 16:31:16 -0400
Message-Id: <1154118676.19722.41.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-28 at 21:36 +0100, Alan Cox wrote:
> Ar Gwe, 2006-07-28 am 16:12 -0400, ysgrifennodd Steven Rostedt:

So what language does the above come from ;-) "Ar Gwe" "ysgrifennodd" ?

> > what the kernel does with wake_up.  That way you can sleep till another
> > process/thread is done with what it was doing and wake up the other task
> > when done, without the use of signals.  Or is there something that
> > already does this?
> 
> futex and sys5 semaphore both do this. The latter is very portable but a
> bit less efficient.

semaphore is a bit awkward for this (I have implemented it for this type
of purpose and it really feels like a hack).

How can this be implemented with futex??  Let me make another scenario.
If you have a task sleeping and it needs to be woken when some other
task needs it (kind of like a kthread) but it doesn't know what task
will wake it.  A futex is like a mutex where it has one owner, so you
can sleep till the owner awakes it, but you don't know who the owner is.

I really like the way the kernel has the wake_up_process function, and
it is vary handy to have for even user space.  Right now the most common
way to do it is semaphores (yuck!) or signals.  Both are very heavy and
I don't really see why a new interface can't be introduced.  Yes, it
breaks portability, but it if becomes a standard, then others  will port
to it (and maybe it will become a new POSIX standard :)

-- Steve


