Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266473AbTCDXrc>; Tue, 4 Mar 2003 18:47:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265285AbTCDXrc>; Tue, 4 Mar 2003 18:47:32 -0500
Received: from slip-12-65-96-191.mis.prserv.net ([12.65.96.191]:26227 "EHLO
	beohost.scyld.com") by vger.kernel.org with ESMTP
	id <S266948AbTCDXr3>; Tue, 4 Mar 2003 18:47:29 -0500
Date: Tue, 4 Mar 2003 18:36:26 -0500 (EST)
From: Donald Becker <becker@scyld.com>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
cc: jamal <hadi@cyberus.ca>, Greg KH <greg@kroah.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Jeff Garzik <jgarzik@pobox.com>, <kuznet@ms2.inr.ac.ru>,
       <david.knierim@tekelec.com>, Robert Olsson <Robert.Olsson@data.slu.se>,
       <linux-kernel@vger.kernel.org>, <alexander@netintact.se>
Subject: Re: PCI init issues
In-Reply-To: <20030305013037.A678@localhost.park.msu.ru>
Message-ID: <Pine.LNX.4.44.0303041827310.974-100000@beohost.scyld.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Mar 2003, Ivan Kokshaysky wrote:

> On Tue, Mar 04, 2003 at 01:16:22PM -0500, Donald Becker wrote:
> > Incorrect.
> > Most quad Tulip boards have the bus bridge wired so that all interrupts
> > are sent on the INTA output of the board.
> 
> This can be true for older cards, but post-1998 hardware must follow
> the spec.
> PCI-to-PCI Bridge Architecture Specification, Rev 1.1, Dec 18, 1998,

The reality is that most quad Tulip boards were designed before 1999,
and therefore act as I described.

Most of the experience is with quad Ethernet adapters, as there are few
other common PCI boards with bus bridges.

> I know for a fact that at least D-Link card mentioned in some reports
> utilizes all four INT# lines, because I have one.

The D-Link board is 

>   Device 0 on a secondary bus will have its INTA# line connected to
>   the INTA# line of the connector. Device 1 will have its INTA# line
>   connected to INTB# of the connector. This sequence continues and
>   then wraps around once INTD# has been assigned."

This seems to be what most x86 BIOSes assume (almost all BIOSes use the
Intel reference code for PCI setup), even from 1995-era machines.
But again, this does not match how _most_ of the quad boards are wired.
Curiously, non-x86 machines usually work fine without the work-around,
meaning that they have a different interpretation.

-- 
Donald Becker				becker@scyld.com
Scyld Computing Corporation		http://www.scyld.com
410 Severn Ave. Suite 210		Scyld Beowulf cluster system
Annapolis MD 21403			410-990-9993

