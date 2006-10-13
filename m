Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751819AbWJMTHI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751819AbWJMTHI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 15:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751816AbWJMTHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 15:07:07 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19120 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751795AbWJMTHE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 15:07:04 -0400
Date: Fri, 13 Oct 2006 12:06:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Akinobu Mita" <akinobu.mita@gmail.com>
Cc: linux-kernel@vger.kernel.org, ak@suse.de, "Don Mullis" <dwm@meer.net>,
       Valdis.Kletnieks@vt.edu
Subject: Re: [patch 7/7] stacktrace filtering for fault-injection
 capabilities
Message-Id: <20061013120639.cd07ac4b.akpm@osdl.org>
In-Reply-To: <961aa3350610131112l141b782ey281e068116411cbf@mail.gmail.com>
References: <20061012074305.047696736@gmail.com>
	<452df23e.44ca1e09.1a7f.780f@mx.google.com>
	<20061012142004.a111ca6a.akpm@osdl.org>
	<20061013180039.GD29079@localhost>
	<961aa3350610131112l141b782ey281e068116411cbf@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Oct 2006 03:12:23 +0900
"Akinobu Mita" <akinobu.mita@gmail.com> wrote:

> 2006/10/14, Akinobu Mita <akinobu.mita@gmail.com>:
> 
> > > > --- work-fault-inject.orig/lib/Kconfig.debug
> > > > +++ work-fault-inject/lib/Kconfig.debug
> > > > @@ -472,6 +472,8 @@ config LKDTM
> > > >
> > > >  config FAULT_INJECTION
> > > >     bool
> > > > +   select STACKTRACE
> > > > +   select FRAME_POINTER
> > > >
> > > >  config FAILSLAB
> > > >     bool "fault-injection capabilitiy for kmalloc"
> > > >
> > >
> > > Is the selection of FRAME_POINTER really needed?  The fancy new unwinder
> > > is supposed to be able to handle frame-pointerless unwinding?
> >
> > As I wrote in another reply, There are two type of implementation of
> > this stacktrace filter.
> >
> > - using STACKTRACE + FRAME_POINTER
> > - using new unwinder (STACK_UNWIND)
> >
> > The stacktrace with using new unwinder without FRAME_POINTER is much
> > slower than STACKTRACE + FRAME_POINTER.
> >
> 
> Maybe I should drop new unwinder support for now.

I'd say it should stay.  It'll be a lot more accurate once everything is
sorted out.  And hopefully the new unwinder will get sped up.

Plus I don't think performance matters a lot here: if you want to test the
e100 driver with fault injection, the whole test would take about three
seconds.  After that, you've exercised every code path in the driver.  So
if enabling range-based fault injection increases that to 300 seconds, it is
still practical.
