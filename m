Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268085AbTAJBB5>; Thu, 9 Jan 2003 20:01:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268089AbTAJBB5>; Thu, 9 Jan 2003 20:01:57 -0500
Received: from palrel11.hp.com ([156.153.255.246]:34243 "HELO palrel11.hp.com")
	by vger.kernel.org with SMTP id <S268085AbTAJBB4>;
	Thu, 9 Jan 2003 20:01:56 -0500
Date: Thu, 9 Jan 2003 17:09:06 -0800
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Paul Mackerras <paulus@samba.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>, davidm@hpl.hp.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       greg@kroah.com
Subject: Re: [patch 2.5] 2-pass PCI probing, generic part
Message-ID: <20030110010906.GC18141@cup.hp.com>
References: <20030110021904.A15863@localhost.park.msu.ru> <Pine.LNX.4.44.0301091531260.1506-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301091531260.1506-100000@penguin.transmeta.com>
User-Agent: Mutt/1.4i
From: grundler@cup.hp.com (Grant Grundler)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2003 at 03:35:32PM -0800, Linus Torvalds wrote:
> The only real reason to worry about BAR sizing is really to do resource
> discovery in order to make sure that out bridges have sufficiently big
> windows for the IO regions. Agreed?

yes. And eventually to make sure regions don't overlap.

> And that should be a non-issue especially on a host bridge, since we 
> almost certainly don't want to reprogram the bridge windows there anyway.

Current PARISC servers do not allocate MMIO/IO resources for all PCI devices.
Only boot devices are configured. Fortunately, default MMIO/IO address
space assigned to Host bridges seems to work - at least I've not heard
anyone complain (yet). But no one has tried PCI expansion chassis or
cards with massive (> 64MB) MMIO BARs.

Because of PCI hotplug, rumor is ia64 firmware folks want to do
the same thing in the near future.

> So I'd like to make the _default_ be to probe the minimal possible, 
> _especially_ for host bridges. Then, the PCI quirks could be used to 
> expand on that default.

That's reasonable.
pci arch code also has hooks to fixup host bridge resources.

thanks,
grant
