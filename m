Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263977AbTAJHvQ>; Fri, 10 Jan 2003 02:51:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263991AbTAJHvQ>; Fri, 10 Jan 2003 02:51:16 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:28461 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S263977AbTAJHvP>; Fri, 10 Jan 2003 02:51:15 -0500
To: grundler@cup.hp.com (Grant Grundler)
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Paul Mackerras <paulus@samba.org>,
       davidm@hpl.hp.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       greg@kroah.com
Subject: Re: [patch 2.5] 2-pass PCI probing, generic part
References: <20030110021904.A15863@localhost.park.msu.ru>
	<Pine.LNX.4.44.0301091531260.1506-100000@penguin.transmeta.com>
	<20030110010906.GC18141@cup.hp.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 10 Jan 2003 00:56:17 -0700
In-Reply-To: <20030110010906.GC18141@cup.hp.com>
Message-ID: <m1y95tzbdq.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

grundler@cup.hp.com (Grant Grundler) writes:

> On Thu, Jan 09, 2003 at 03:35:32PM -0800, Linus Torvalds wrote:
> > The only real reason to worry about BAR sizing is really to do resource
> > discovery in order to make sure that out bridges have sufficiently big
> > windows for the IO regions. Agreed?
> 
> yes. And eventually to make sure regions don't overlap.
> 
> > And that should be a non-issue especially on a host bridge, since we 
> > almost certainly don't want to reprogram the bridge windows there anyway.
> 
> Current PARISC servers do not allocate MMIO/IO resources for all PCI devices.
> Only boot devices are configured. Fortunately, default MMIO/IO address
> space assigned to Host bridges seems to work - at least I've not heard
> anyone complain (yet). But no one has tried PCI expansion chassis or
> cards with massive (> 64MB) MMIO BARs.

For what it is worth these cards exist though.
Quadris cards have a 256MB bar, and dolphin cards default to having a 512MB bar.
Both are high performance I/O adapters.

> Because of PCI hotplug, rumor is ia64 firmware folks want to do
> the same thing in the near future.

If someone leaves a big enough hole for hotplug cards I guess it can work...
How you define a potential boot device, and what it saves you to not assign
it resources I don't know.  

I am still recovering from putting a 256MB bar and 4GB of ram in a 4GB hole,
with minimal loss on x86, so my imagination of what can be sanely done
on a 64bit arch may be a little stunted..

Eric

