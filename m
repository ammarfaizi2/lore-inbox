Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268061AbTAIXyi>; Thu, 9 Jan 2003 18:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268065AbTAIXyh>; Thu, 9 Jan 2003 18:54:37 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:6415 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268061AbTAIXy3>; Thu, 9 Jan 2003 18:54:29 -0500
Date: Thu, 9 Jan 2003 15:35:32 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Grant Grundler <grundler@cup.hp.com>, Paul Mackerras <paulus@samba.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>, <davidm@hpl.hp.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <greg@kroah.com>
Subject: Re: [patch 2.5] 2-pass PCI probing, generic part
In-Reply-To: <20030110021904.A15863@localhost.park.msu.ru>
Message-ID: <Pine.LNX.4.44.0301091531260.1506-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 10 Jan 2003, Ivan Kokshaysky wrote:
> 
> PCI-PCI, PCI-ISA bridges - probably, but not host bridges. On x86 they
> often have quite a few BARs, like AGP window, AGP MMIO, power management
> etc., which we cannot ignore.

Oh, but we _can_ ignore it.

All those things are stuff that if the kernel doesn't use them, the kernel 
doesn't even need to know they are there. 

Sure, if we support AGP, we need to see the aperture size etc, but then 
we'd have the AGP driver just do the "pci_enable_dev()" thing to work it 
out.

The only real reason to worry about BAR sizing is really to do resource
discovery in order to make sure that out bridges have sufficiently big
windows for the IO regions. Agreed?

And that should be a non-issue especially on a host bridge, since we 
almost certainly don't want to reprogram the bridge windows there anyway.

So I'd like to make the _default_ be to probe the minimal possible, 
_especially_ for host bridges. Then, the PCI quirks could be used to 
expand on that default.

		Linus

