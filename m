Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262170AbUCLPL1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 10:11:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262178AbUCLPL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 10:11:27 -0500
Received: from fed1mtao01.cox.net ([68.6.19.244]:10952 "EHLO
	fed1mtao01.cox.net") by vger.kernel.org with ESMTP id S262170AbUCLPLZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 10:11:25 -0500
Date: Fri, 12 Mar 2004 08:11:24 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Amit S. Kale" <amitkale@emsyssoft.com>
Cc: George Anzinger <george@mvista.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@suse.cz>, kgdb-bugreport@lists.sourceforge.net
Subject: Re: [KGDB PATCH][7/7] Move debugger_entry()
Message-ID: <20040312151123.GB14472@smtp.west.cox.net>
References: <20040227212301.GC1052@smtp.west.cox.net> <200403031115.44125.amitkale@emsyssoft.com> <4050D92B.7000802@mvista.com> <200403121012.34861.amitkale@emsyssoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403121012.34861.amitkale@emsyssoft.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2004 at 10:12:34AM +0530, Amit S. Kale wrote:
> On Friday 12 Mar 2004 2:54 am, George Anzinger wrote:
> > Amit S. Kale wrote:
> > > On Wednesday 03 Mar 2004 6:38 am, George Anzinger wrote:
> > >>Amit S. Kale wrote:
> > >>>OK to checkin.
> > >>>
> > >>>-Amit
> > >>>
> > >>>On Saturday 28 Feb 2004 3:24 am, Tom Rini wrote:
> > >>>>Hello.  When we use kgdboe, we can't use it until do_basic_setup() is
> > >>>>done. So we have two options, not allow kgdboe to use the initial
> > >>>>breakpoint or move debugger_entry() to be past the point where kgdboe
> > >>>>will be usable. I've opted for the latter, as if an earlier breakpoint
> > >>>>is needed you can still use serial and throw
> > >>>>kgdb_schedule_breakpoint/breakpoint where desired.
> > >>>>
> > >>>>--- linux-2.6.3-rc4/init/main.c	2004-02-17 09:51:19.000000000 -0700
> > >>>>+++ linux-2.6.3-rc4-kgdb/init/main.c	2004-02-17 11:33:51.854388988
> > >>>> -0700 @@ -581,6 +582,7 @@ static int init(void * unused)
> > >>>>
> > >>>>	smp_init();
> > >>>>	do_basic_setup();
> > >>>>+	debugger_entry();
> > >>
> > >>It would be nice to not need this.  Could it be a side effect of
> > >>configuring the interface or some such so we don't have to patch
> > >>init/main.c
> > >
> > > I attempted doing this when I was trying to code a netpoll independent
> > > ethernet interface. I couldn't do without it. I needed one hook to kgdb
> > > in init to mark completion of smp_init. If an interface was ready, that
> > > hook called breakpoint. A similar hook was placed in interface
> > > initialization code, it called breakpoint, if kgdb core was ready on
> > > account of smp_init completion.
> >
> > I guess the real question is why do you need to wait so long?  What is it
> > that needs to be done prior to this call?
> 
> 2.4.x kgdb legacy code! That was needed in some early 2.4 kgdbs. Perhaps we 
> can move it earlier now. If someone tests the patch on an smp machine and 
> confirms that it works, I'll be happy change it.

It's only legacy code under the following conditions (with current code):
- You don't care about getting an initial break from kgdboe (fixable...)
- kgdb_arch_init sets up kgdb_serial to an I/O that is suitably used
  early on.

-- 
Tom Rini
http://gate.crashing.org/~trini/
