Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262901AbUBZRoc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 12:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262905AbUBZRoc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 12:44:32 -0500
Received: from fed1mtao06.cox.net ([68.6.19.125]:34038 "EHLO
	fed1mtao06.cox.net") by vger.kernel.org with ESMTP id S262901AbUBZRoX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 12:44:23 -0500
Date: Thu, 26 Feb 2004 10:44:21 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Amit S. Kale" <amitkale@emsyssoft.com>,
       kernel list <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@suse.cz>, kgdb-bugreport@lists.sourceforge.net
Subject: Re: [Kgdb-bugreport] [PATCH][3/3] Update CVS KGDB's wrt connect / detach
Message-ID: <20040226174421.GT1052@smtp.west.cox.net>
References: <20040225213626.GF1052@smtp.west.cox.net> <20040225214343.GG1052@smtp.west.cox.net> <20040225215309.GI1052@smtp.west.cox.net> <200402261344.49261.amitkale@emsyssoft.com> <20040226144155.GQ1052@smtp.west.cox.net> <20040226160523.GB28873@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040226160523.GB28873@nevyn.them.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 26, 2004 at 11:05:23AM -0500, Daniel Jacobowitz wrote:

> On Thu, Feb 26, 2004 at 07:41:55AM -0700, Tom Rini wrote:
> > On Thu, Feb 26, 2004 at 01:44:49PM +0530, Amit S. Kale wrote:
> > 
> > > On Thursday 26 Feb 2004 3:23 am, Tom Rini wrote:
> > > > The following patch fixes a number of little issues here and there, and
> > > > ends up making things more robust.
> > > > - We don't need kgdb_might_be_resumed or kgdb_killed_or_detached.
> > > >   GDB attaching is GDB attaching, we haven't preserved any of the
> > > >   previous context anyhow.
> > > 
> > > If gdb is restarted, kgdb has to remove all breakpoints. Present kgdb does 
> > > that in the code this patch removes:
> > > 
> > > -		if (remcom_in_buffer[0] == 'H' && remcom_in_buffer[1] == 'c') {
> > > -			remove_all_break();
> > > -			atomic_set(&kgdb_killed_or_detached, 0);
> > > -			ok_packet(remcom_out_buffer);
> > > 
> > > If we don't remove breakpoints, they stay in kgdb without gdb not knowing it 
> > > and causes consistency problems.
> > 
> > Er, what do you mean 'restarted' ?  If gdb somehow disconnects 'detach'
> > or ^D^D, remove_all_break() gets called.  Is there another way for gdb
> > to somehow disconnect that I don't know of?
> 
> Yes.  See the disconnect command in recent GDB versions.

Ack.  Does gdb do anything to see if the rmote side will support being
left hanging?

> > > > - Don't try and look for a connection in put_packet, after we've tried
> > > >   to put a packet.  Instead, when we receive a packet, GDB has
> > > >   connected.
> > > 
> > > We have to check for gdb connection in putpacket or else following problem 
> > > occurs.
> > > 
> > > 1. kgdb console messages are to be put.
> > > 2. gdb dies
> > 
> > As in doesn't cleanly remove itself?
> 
> Seg faults, for instance.

That's what I was figuring.  Does gdbserver handle things like this (gdb
up and dying in the middle of a session, disconnecting without warning)
well?

-- 
Tom Rini
http://gate.crashing.org/~trini/
