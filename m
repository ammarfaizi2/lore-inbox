Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269515AbTCDSrQ>; Tue, 4 Mar 2003 13:47:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269516AbTCDSrQ>; Tue, 4 Mar 2003 13:47:16 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:4365 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S269515AbTCDSrP>; Tue, 4 Mar 2003 13:47:15 -0500
Date: Tue, 4 Mar 2003 10:54:21 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
cc: raarts@office.netland.nl, <david.knierim@tekelec.com>,
       <alexander@netintact.se>, Donald Becker <becker@scyld.com>,
       Greg KH <greg@kroah.com>, jamal <hadi@cyberus.ca>,
       Jeff Garzik <jgarzik@pobox.com>, <kuznet@ms2.inr.ac.ru>,
       <linux-kernel@vger.kernel.org>,
       Robert Olsson <Robert.Olsson@data.slu.se>
Subject: Re: PCI init issues
In-Reply-To: <20030304212648.A6455@jurassic.park.msu.ru>
Message-ID: <Pine.LNX.4.44.0303041046370.1426-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 4 Mar 2003, Ivan Kokshaysky wrote:
>
> Indeed, looks like only pin 0 (INT_A of that card) is connected. :-(

Well, I'd say it looks like the MP table _claims_ that only pin0 is 
connected. Remember: the claim was that this machine worked on WinXP.

So there are at least two potential reasons for that:

 - The MP table is simply wrong, and WinXP gets the routing information 
   from somewhere else (ie most likely ACPI)

 - The MP table is right, and only pin0 is connected, and WinXP only uses 
   pin0 (ie it puts the card in some state where all irqs are shared 
   across all of the four tulip chips).

Maybe somebody can come up with other schenarios.

It would be interesting to hear what "Device Manager" (or whatever it is
called) unde WinXP claims the interrupts are on this machine... Are they
all on irq 48 on XP too? Or has XP gotten magic knowledge somewhere
(ACPI?) and they are on different irq's?

		Linus

