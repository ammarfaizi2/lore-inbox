Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261952AbUCLEwa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 23:52:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261961AbUCLEwa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 23:52:30 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:13748 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S261952AbUCLEw1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 23:52:27 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: George Anzinger <george@mvista.com>, Tom Rini <trini@kernel.crashing.org>
Subject: Re: [Kgdb-bugreport] [PATCH] Kill kgdb_serial
Date: Fri, 12 Mar 2004 10:22:05 +0530
User-Agent: KMail/1.5
Cc: Pavel Machek <pavel@ucw.cz>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kgdb-bugreport@lists.sourceforge.net
References: <20040302213901.GF20227@smtp.west.cox.net> <20040311230004.GN5169@smtp.west.cox.net> <4050FA42.3040006@mvista.com>
In-Reply-To: <4050FA42.3040006@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403121022.05578.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 12 Mar 2004 5:16 am, George Anzinger wrote:
> Tom Rini wrote:
> > On Thu, Mar 11, 2004 at 02:53:34PM -0800, George Anzinger wrote:
> >>Tom Rini wrote:
> >>>On Thu, Mar 11, 2004 at 01:33:40PM -0800, George Anzinger wrote:
> >>>>Tom Rini wrote:
> >>>>>>I am afraid I don't quite understand what he was saying other than
> >>>>>>early init stuff.  On of the problems with trying early init stuff,
> >>>>>> by the way, is that a lot of things depend on having alloc up and
> >>>>>> that happens rather late in the game.
> >>>>>
> >>>>>I assume you aren't talking about kgdb stuff here (or what would be
> >>>>> the point of going so early) but I believe he was talking about
> >>>>> allowing for stuff that could be done early, to be done early.
> >>>>
> >>>>One of the issues with the UART set up is registering the interrupt
> >>>>handler with the kernel.  It will fail if alloc is not up.  The -mm
> >>>> patch does two things with this.  a) It tries every getchar to
> >>>> register the interrupt handler, and b) it has a module init entry to
> >>>> register it. This last will happen late in the bring up and is safe. 
> >>>> a) is there to get it ASAP if you are actually using kgdb during the
> >>>> bring up.
> >>>
> >>>There's two ways to look at this.
> >>>- All the more reason to acknowledge that the earliest you can safely
> >>> get into KGDB is point X, where X is where alloc works,
> >>
> >>Just to get ^C to work?  I would rather give it up entirely!
> >>
> >>> mappings done
> >>> if needed, etc, etc, and IFF we change things slightly in kgdboe so
> >>> that it can call kgdb_schedule_breakpoint() if it needs to as an
> >>> initial break, and handle setting kgdb_serial to the serial driver in
> >>> kgdb_arch_init, or something, and remove all of the extra kludges to
> >>> get us a few lines / function calls earlier on.
> >>>- More and more special cases.
> >>
> >>How about a command line set up ASAP which calls a driver entry to do the
> >>break. The driver being serial does it NOW, but being some thing that
> >> needs additional resources, just sets a flag to break when it gets them
> >> and returns. Seems rather simple.
> >
> > This sounds a lot like what I passed along from dwmw2 a week ago. :)
>
> Must be something wrong here.  We seem to be agreeing :)

You bet!

-Amit

