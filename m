Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261897AbUCLEm6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 23:42:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbUCLEm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 23:42:57 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:23219 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S261897AbUCLEmz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 23:42:55 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: George Anzinger <george@mvista.com>
Subject: Re: [KGDB PATCH][7/7] Move debugger_entry()
Date: Fri, 12 Mar 2004 10:12:34 +0530
User-Agent: KMail/1.5
Cc: Tom Rini <trini@kernel.crashing.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@suse.cz>, kgdb-bugreport@lists.sourceforge.net
References: <20040227212301.GC1052@smtp.west.cox.net> <200403031115.44125.amitkale@emsyssoft.com> <4050D92B.7000802@mvista.com>
In-Reply-To: <4050D92B.7000802@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403121012.34861.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 12 Mar 2004 2:54 am, George Anzinger wrote:
> Amit S. Kale wrote:
> > On Wednesday 03 Mar 2004 6:38 am, George Anzinger wrote:
> >>Amit S. Kale wrote:
> >>>OK to checkin.
> >>>
> >>>-Amit
> >>>
> >>>On Saturday 28 Feb 2004 3:24 am, Tom Rini wrote:
> >>>>Hello.  When we use kgdboe, we can't use it until do_basic_setup() is
> >>>>done. So we have two options, not allow kgdboe to use the initial
> >>>>breakpoint or move debugger_entry() to be past the point where kgdboe
> >>>>will be usable. I've opted for the latter, as if an earlier breakpoint
> >>>>is needed you can still use serial and throw
> >>>>kgdb_schedule_breakpoint/breakpoint where desired.
> >>>>
> >>>>--- linux-2.6.3-rc4/init/main.c	2004-02-17 09:51:19.000000000 -0700
> >>>>+++ linux-2.6.3-rc4-kgdb/init/main.c	2004-02-17 11:33:51.854388988
> >>>> -0700 @@ -581,6 +582,7 @@ static int init(void * unused)
> >>>>
> >>>>	smp_init();
> >>>>	do_basic_setup();
> >>>>+	debugger_entry();
> >>
> >>It would be nice to not need this.  Could it be a side effect of
> >>configuring the interface or some such so we don't have to patch
> >>init/main.c
> >
> > I attempted doing this when I was trying to code a netpoll independent
> > ethernet interface. I couldn't do without it. I needed one hook to kgdb
> > in init to mark completion of smp_init. If an interface was ready, that
> > hook called breakpoint. A similar hook was placed in interface
> > initialization code, it called breakpoint, if kgdb core was ready on
> > account of smp_init completion.
>
> I guess the real question is why do you need to wait so long?  What is it
> that needs to be done prior to this call?

2.4.x kgdb legacy code! That was needed in some early 2.4 kgdbs. Perhaps we 
can move it earlier now. If someone tests the patch on an smp machine and 
confirms that it works, I'll be happy change it.

The earlier kgdb is initialized, the better it is.

-Amit

>
> On the other hand, I have a late call (I use module init) to set up the
> interrupt handler for the UART, which needs to happen after malloc is
> working. This, however, does not cause, of it self, a break.
>
> > -Amit
> >
> >>-g
> >>
> >>>>	prepare_namespace();
> >>>
> >>>-
> >>>To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> >>>in the body of a message to majordomo@vger.kernel.org
> >>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>>Please read the FAQ at  http://www.tux.org/lkml/
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> > in the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/

