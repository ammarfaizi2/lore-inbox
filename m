Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261963AbUCAINS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 03:13:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262270AbUCAINS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 03:13:18 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:21700 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S261963AbUCAINL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 03:13:11 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: Daniel Jacobowitz <dan@debian.org>, Tom Rini <trini@kernel.crashing.org>
Subject: Re: [Kgdb-bugreport] [PATCH][3/3] Update CVS KGDB's wrt connect / detach
Date: Mon, 1 Mar 2004 13:42:53 +0530
User-Agent: KMail/1.5
Cc: kernel list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>,
       kgdb-bugreport@lists.sourceforge.net
References: <20040225213626.GF1052@smtp.west.cox.net> <20040226144155.GQ1052@smtp.west.cox.net> <20040226160523.GB28873@nevyn.them.org>
In-Reply-To: <20040226160523.GB28873@nevyn.them.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403011342.53980.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 26 Feb 2004 9:35 pm, Daniel Jacobowitz wrote:
> On Thu, Feb 26, 2004 at 07:41:55AM -0700, Tom Rini wrote:
> > On Thu, Feb 26, 2004 at 01:44:49PM +0530, Amit S. Kale wrote:
> > > On Thursday 26 Feb 2004 3:23 am, Tom Rini wrote:
> > > > The following patch fixes a number of little issues here and there,
> > > > and ends up making things more robust.
> > > > - We don't need kgdb_might_be_resumed or kgdb_killed_or_detached.
> > > >   GDB attaching is GDB attaching, we haven't preserved any of the
> > > >   previous context anyhow.
> > >
> > > If gdb is restarted, kgdb has to remove all breakpoints. Present kgdb
> > > does that in the code this patch removes:
> > >
> > > -		if (remcom_in_buffer[0] == 'H' && remcom_in_buffer[1] == 'c') {
> > > -			remove_all_break();
> > > -			atomic_set(&kgdb_killed_or_detached, 0);
> > > -			ok_packet(remcom_out_buffer);
> > >
> > > If we don't remove breakpoints, they stay in kgdb without gdb not
> > > knowing it and causes consistency problems.
> >
> > Er, what do you mean 'restarted' ?  If gdb somehow disconnects 'detach'
> > or ^D^D, remove_all_break() gets called.  Is there another way for gdb
> > to somehow disconnect that I don't know of?
>
> Yes.  See the disconnect command in recent GDB versions.
>
> > > > - Don't try and look for a connection in put_packet, after we've
> > > > tried to put a packet.  Instead, when we receive a packet, GDB has
> > > > connected.
> > >
> > > We have to check for gdb connection in putpacket or else following
> > > problem occurs.
> > >
> > > 1. kgdb console messages are to be put.
> > > 2. gdb dies
> >
> > As in doesn't cleanly remove itself?
>
> Seg faults, for instance.

That's something easily recognizable. There are worse situations where gdb has 
to be killed.

GDB sometimes goes into an infinite loop of stub communications, doesn't 
respond to Ctrl+C and has to be killed. It's rare, though.

-Amit

