Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262287AbUCBWpD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 17:45:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262278AbUCBWnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 17:43:53 -0500
Received: from fed1mtao08.cox.net ([68.6.19.123]:52382 "EHLO
	fed1mtao08.cox.net") by vger.kernel.org with ESMTP id S262299AbUCBWlr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 17:41:47 -0500
Date: Tue, 2 Mar 2004 15:41:46 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: George Anzinger <george@mvista.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kgdb-bugreport@lists.sourceforge.net,
       "Amit S. Kale" <amitkale@emsyssoft.com>
Subject: Re: [Kgdb-bugreport] [PATCH] Kill kgdb_serial
Message-ID: <20040302224146.GJ20227@smtp.west.cox.net>
References: <20040302213901.GF20227@smtp.west.cox.net> <40450468.2090700@mvista.com> <20040302221106.GH20227@smtp.west.cox.net> <20040302223143.GE1225@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040302223143.GE1225@elf.ucw.cz>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2004 at 11:31:43PM +0100, Pavel Machek wrote:

> Hi!
> 
> > > Tom Rini wrote:
> > > >Hello.  The following interdiff kills kgdb_serial in favor of function
> > > >names.  This only adds a weak function for kgdb_flush_io, and documents
> > > >when it would need to be provided.
> > > 
> > > It looks like you are also dumping any notion of building a kernel that can 
> > > choose which method of communication to use for kgdb at run time.  Is this 
> > > so?
> > 
> > Yes, as this is how Andrew suggested we do it.  It becomes quite ugly if
> > you try and allow for any 2 of 3 methods.
> 
> I do not think that having kgdb_serial is so ugly. Are there any other
> uglyness associated with that?

Yes, switching from one of 3 choices to the other.  It's not as simple
as 8250 or eth.  It's 8250 or eth or arch for things which don't depend
on other initcalls.
This leads to things in the PPC code like:
#ifdef CONFIG_KGDB_8250
	extern ...
	kgdb_serial = &kgdb8250_serial;
#elif defined(CONFIG_PPC_SIMPLE_SERIAL)
	kgdb_serial = &kgdbppc_serial;
#endif

And then all kgdb_arch_init's have to have kgdb_serial =
&kgdb8250_serial, for it to work prior to the initcall setting it.

-- 
Tom Rini
http://gate.crashing.org/~trini/
