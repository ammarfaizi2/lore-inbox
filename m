Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261783AbUCBXwm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 18:52:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261793AbUCBXwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 18:52:42 -0500
Received: from fed1mtao07.cox.net ([68.6.19.124]:41689 "EHLO
	fed1mtao07.cox.net") by vger.kernel.org with ESMTP id S261783AbUCBXwj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 18:52:39 -0500
Date: Tue, 2 Mar 2004 16:52:38 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: George Anzinger <george@mvista.com>
Cc: Pavel Machek <pavel@ucw.cz>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kgdb-bugreport@lists.sourceforge.net,
       "Amit S. Kale" <amitkale@emsyssoft.com>
Subject: Re: [Kgdb-bugreport] [PATCH] Kill kgdb_serial
Message-ID: <20040302235238.GN20227@smtp.west.cox.net>
References: <20040302213901.GF20227@smtp.west.cox.net> <40450468.2090700@mvista.com> <20040302221106.GH20227@smtp.west.cox.net> <20040302223143.GE1225@elf.ucw.cz> <20040302230018.GL20227@smtp.west.cox.net> <40451CCA.4070907@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40451CCA.4070907@mvista.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2004 at 03:46:19PM -0800, George Anzinger wrote:
> Tom Rini wrote:
> >On Tue, Mar 02, 2004 at 11:31:43PM +0100, Pavel Machek wrote:
> >
> >
> >>Hi!
> >>
> >>
> >>>>Tom Rini wrote:
> >>>>
> >>>>>Hello.  The following interdiff kills kgdb_serial in favor of function
> >>>>>names.  This only adds a weak function for kgdb_flush_io, and documents
> >>>>>when it would need to be provided.
> >>>>
> >>>>It looks like you are also dumping any notion of building a kernel that 
> >>>>can choose which method of communication to use for kgdb at run time.  
> >>>>Is this so?
> >>>
> >>>Yes, as this is how Andrew suggested we do it.  It becomes quite ugly if
> >>>you try and allow for any 2 of 3 methods.
> >>
> >>I do not think that having kgdb_serial is so ugly. Are there any other
> >>uglyness associated with that?
> >
> >
> >More precisely:
> >http://lkml.org/lkml/2004/2/11/224
> 
> Andrew seems to be comming from the point of view of a developer rather 
> than a developer/ maintainer.
> 
> So, the counter argument is the user who is sending the thing into the 
> field and wants to send just one binary kernel to all locations.  But then 
> he needs to debug some problem that will work fine over the lan and later 
> one that requires an early connection which the lan can not, as yet, do.  I 
> agree that for you or me, this is not an issue, but what of the IT folks...

The IT person should be beaten for shipping KGDB on a production system?
:)

Regardless, it's not that we offer (nor does the -mm version, from what
I read of it) eth or serial at any point, it simply allows for serial to
be used and a switchover to eth.  And if kgdb is attached at the time,
it's a 'fun' gdb session (or at least is was when I was trying it out in
-mm and then in my own version).

The real problem is that you start getting quite complex when you allow
for a system to be kgdb eth, or 8250, or some arch serial driver, or
some other I/O driver, and so on.  PPC has 3, and I don't see it getting
smaller from there.

And with both of those points, I don't think it's worth the trouble that
point 2 is, given the limitations of point 1.

-- 
Tom Rini
http://gate.crashing.org/~trini/
