Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269414AbTCDQez>; Tue, 4 Mar 2003 11:34:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269412AbTCDQez>; Tue, 4 Mar 2003 11:34:55 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:29457 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S269414AbTCDQeq>; Tue, 4 Mar 2003 11:34:46 -0500
Date: Tue, 4 Mar 2003 08:41:55 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: david.knierim@tekelec.com
cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>, <alexander@netintact.se>,
       Donald Becker <becker@scyld.com>, Greg KH <greg@kroah.com>,
       jamal <hadi@cyberus.ca>, Jeff Garzik <jgarzik@pobox.com>,
       <kuznet@ms2.inr.ac.ru>, <linux-kernel@vger.kernel.org>,
       <raarts@office.netland.nl>, Robert Olsson <Robert.Olsson@data.slu.se>
Subject: Re: PCI init issues
In-Reply-To: <OFDDD85BEC.1AD47C42-ON85256CDF.0059DE8B@nc.tekelec.com>
Message-ID: <Pine.LNX.4.44.0303040833440.14323-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 4 Mar 2003 david.knierim@tekelec.com wrote:
>
>    Here is the full messages output for a system with this problem.   I had
> only provided part of the
> messages file to him earlier.   This is the entire output.

Well, the interesting parts are missing, because your klogd output has 
been truncated due to the huge output from the md layer etc. However, I 
suspect strongly that the issue is in IO_APIC_get_PCI_irq_vector() in 
arch/i386/kernel/io_apic.c, and I would further guess that it's the fact 
that your MP tables don't have the full mapping or we're somehow screwing 
it up.

Can you add a printk() to the case where we return "best_guess" at the end
of that function? We have that fuzzy match thing where if we cannot find
the exact entry in the MP table we instead use the first entry that
matches in everything but the <pin> number, and it would be interesting to
hear if that's the logic that triggers.

It's also quite possible that your MP tables just aren't right, and the
reason XP works on the machine is that XP uses the ACPI irq lookup stuff.  
You could try enabling ACPI bootup support (I've never used it on 2.4.x
myself, but it's required for at least one of my machines and works fine
on 2.5.x).

		Linus

