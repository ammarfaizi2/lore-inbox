Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268069AbTAIXOb>; Thu, 9 Jan 2003 18:14:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268065AbTAIXNp>; Thu, 9 Jan 2003 18:13:45 -0500
Received: from [195.208.223.248] ([195.208.223.248]:16256 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S268040AbTAIXN0>; Thu, 9 Jan 2003 18:13:26 -0500
Date: Fri, 10 Jan 2003 02:19:04 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Grant Grundler <grundler@cup.hp.com>, Paul Mackerras <paulus@samba.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>, davidm@hpl.hp.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       greg@kroah.com
Subject: Re: [patch 2.5] 2-pass PCI probing, generic part
Message-ID: <20030110021904.A15863@localhost.park.msu.ru>
References: <20030110010917.A693@localhost.park.msu.ru> <Pine.LNX.4.44.0301091413520.1436-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0301091413520.1436-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Thu, Jan 09, 2003 at 02:16:20PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2003 at 02:16:20PM -0800, Linus Torvalds wrote:
> On Fri, 10 Jan 2003, Ivan Kokshaysky wrote:
> >
> > Note that in most cases PCI-PCI bridges can be safely excluded from
> > pci_read_bases() simply because they have neither regular BARs nor
> > ROM BAR (even though PCI spec allows that).
> 
> This might be a good approach to take regardless - don't read pci-pci 
> bridge BAR (or host-bridge BAR's for that matter), simply because 
> 
>  (a) bridges are more "interesting" than regular devices, and disabling 
>      part of them might be a stupid thing.
>  (b) we're generally not really interested in the end result anyway

PCI-PCI, PCI-ISA bridges - probably, but not host bridges. On x86 they
often have quite a few BARs, like AGP window, AGP MMIO, power management
etc., which we cannot ignore.

OTOH, with that patch we can control probing for any given class of
devices with a 4-5 lines fixups, per architecture. :-)

Ivan.
