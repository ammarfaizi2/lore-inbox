Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135832AbRDTJGb>; Fri, 20 Apr 2001 05:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135833AbRDTJGX>; Fri, 20 Apr 2001 05:06:23 -0400
Received: from gate.terreactive.ch ([212.90.202.121]:6134 "HELO
	toe.terreactive.ch") by vger.kernel.org with SMTP
	id <S135832AbRDTJGM>; Fri, 20 Apr 2001 05:06:12 -0400
Message-ID: <3ADFFB56.A9C84A2@tac.ch>
Date: Fri, 20 Apr 2001 11:03:18 +0200
From: Roberto Nibali <ratz@tac.ch>
Organization: terreActive
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4-pre1 i686)
X-Accept-Language: en, de-CH, zh-CN
MIME-Version: 1.0
To: Ion Badulescu <ionut@cs.columbia.edu>
CC: linux-kernel@vger.kernel.org, Andrew Morton <andrewm@uow.edu.au>
Subject: Re: Fix for Donald Becker's DP83815 network driver (v1.07)
In-Reply-To: <Pine.LNX.4.33.0104192241060.4771-100000@age.cs.columbia.edu>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The UP-APIC wouldn't help much since there really aren't other processors
> available to share the load.

Hmm, but doesn't the code in 2.4.x improve the hard IRQ signal delivery
even for UP systems with a local APIC table? I have an APIC aware board
but I have only got 1 CPU on it and I currently need to run 2.2 kernel.
But if you tell me that there is not much help, I'm ok with that, as 
long as it wouldn't be better with APIC support :)
 
> On the other hand, this is not as bad as it looks. In fact, it will
> function rather well and with relatively little overhead if all configured
> interfaces are seeing traffic on a regular basis. The IRQ dispatcher will
> simply call all registered interrupt routines, and most of them will end
> up doing something useful.

Aha, thanks for the information. Indeed you're right because I'm running
boxes with such a configuration which have already 100+ days uptime under
heavy network load.

> Well.. Space.c is a dinozaur. However, this is the 2.2 series and no more
> surgery will happen on this kernel, at least normally.

So, what is your suggestion: Does this limitation do any harm or can I
live with that and still run 16 eth devices and safely disregard the
"early initialization ..." ?
 
> Have you tried loading the drivers as modules? You might have more luck
> with that approach. Space.c was designed at a time when having 4 NIC's in
> a PC was "pushing the limits"...

Yes, I've tried it but the problem is, that I've hundreds of nodes and about
a dozen of different node setups, some with 1 NIC, some with 1 NIC and 1 quad
board, up to some with 3 NICs and 3 quadboards. I've developed an own distro
which has one kernel. Since I can't make the correct modules get loaded without
mucking around with the /etc/modules.conf, I need to compile-in the drivers. 
I'd be happy if the ethif_probe() could call the request_module() and load the
correct module and initialize the ethX. As of now I would need to adjust the
/etc/modules.conf according to the amount of quadboards I have put into my
node. Or did I miss the concept of /etc/modules.conf?
 
> Because, again, this is legacy code. It works, it does the job, that's it.
> All this crap is gone in 2.4.

I'll be porting my distribution to 2.4.x soon I think :)
 
> Like I said, try the modules approach. If that doesn't work, I'll take a
> closer look (and maybe borrow a few quads from work so I can actually test
> the code...)

Your driver works now and for me now need to mark it experimental. It also
works statically built into the kernel up to 4 quadboards. I hacked Space.c
and enhanced the ``static struct device ethX_dev = { };'' stuff. 

Roberto Nibali, ratz

-- 
mailto: `echo NrOatSz@tPacA.cMh | sed 's/[NOSPAM]//g'`
