Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265197AbTCCPEE>; Mon, 3 Mar 2003 10:04:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265339AbTCCPED>; Mon, 3 Mar 2003 10:04:03 -0500
Received: from rth.ninka.net ([216.101.162.244]:51593 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S265197AbTCCPEB>;
	Mon, 3 Mar 2003 10:04:01 -0500
Subject: Re: PCI init issues
From: "David S. Miller" <davem@redhat.com>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: jamal <hadi@cyberus.ca>, Greg KH <greg@kroah.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       "Alexey N. Kuznetsov" <kuznet@ms2.inr.ac.ru>, david.knierim@tekelec.com,
       Robert Olsson <Robert.Olsson@data.slu.se>,
       Donald Becker <becker@scyld.com>, linux-kernel@vger.kernel.org,
       alexander@netintact.se
In-Reply-To: <20030303151412.A15195@jurassic.park.msu.ru>
References: <20030302121050.F61365@shell.cyberus.ca> 
	<20030303151412.A15195@jurassic.park.msu.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Mar 2003 08:01:15 -0800
Message-Id: <1046707275.16884.3.camel@rth.ninka.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-03-03 at 04:14, Ivan Kokshaysky wrote:
> > Q2: Should we really be dependent on bios this bad?
> 
> We certainly shouldn't wrt PCI IO and MMIO allocations, but irq routing
> appears to be so horribly overcomplexed on x86 that dependence on
> BIOS seems almost unavoidable here...
> Other architectures don't have such kind of problems, BTW.

Actually, for issues like that one Jamal is pointing out, I believe
there is something we can do.

What varies so much from motherboard to motherboard on x86 is how
the interrupts are wired up.  So for example, this tells us that
PCI slot X maps to x86 IRQ Y.  If we know that, we can figure out
where his deeply bridged tulips will send IRQs.

If the mp tables don't give exactly this kind of information,
then Ivan is right :(

Anyone know if FreeBSD fares better in situations like this?
What do they do if so?

