Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbUCAQbT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 11:31:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261359AbUCAQbT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 11:31:19 -0500
Received: from fed1mtao04.cox.net ([68.6.19.241]:58812 "EHLO
	fed1mtao04.cox.net") by vger.kernel.org with ESMTP id S261358AbUCAQbR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 11:31:17 -0500
Date: Mon, 1 Mar 2004 09:31:16 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Amit S. Kale" <amitkale@emsyssoft.com>
Cc: George Anzinger <george@mvista.com>,
       kernel list <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@suse.cz>, kgdb-bugreport@lists.sourceforge.net
Subject: Re: [Kgdb-bugreport] [PATCH][3/3] Update CVS KGDB's wrt connect / detach
Message-ID: <20040301163116.GS1052@smtp.west.cox.net>
References: <20040225213626.GF1052@smtp.west.cox.net> <200402261344.49261.amitkale@emsyssoft.com> <403E8180.1060008@mvista.com> <200403011406.17015.amitkale@emsyssoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403011406.17015.amitkale@emsyssoft.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01, 2004 at 02:06:17PM +0530, Amit S. Kale wrote:
> On Friday 27 Feb 2004 5:00 am, George Anzinger wrote:
> > Amit S. Kale wrote:
> > > On Thursday 26 Feb 2004 3:23 am, Tom Rini wrote:
> > >>- Don't try and look for a connection in put_packet, after we've tried
> > >>  to put a packet.  Instead, when we receive a packet, GDB has
> > >>  connected.
> > >
> > > We have to check for gdb connection in putpacket or else following
> > > problem occurs.
> > >
> > > 1. kgdb console messages are to be put.
> > > 2. gdb dies
> > > 3. putpacket writes the packet and waits for a '+'
> >
> > Oops!  Tom, this '+' will be sent under interrupt and while kgdb is not
> > connected.  Looks like it needs to be passed through without causing a
> > breakpoint.  Possible salvation if we disable interrupts while waiting for
> > the '+' but I don't think that is a good idea.
> 
> Yes. That's why I added a paramter to putpacket to skip causing a breakpoint 
> when not required.

The problem, and I think I've fixed it, is you always need to look for a
packet when you're sending one (think of gdb going away on you, you
don't really know what you'll be sending when it does), and you can only
look for a '$'.  That's what I've committed now does.

-- 
Tom Rini
http://gate.crashing.org/~trini/
