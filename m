Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282918AbRLGQou>; Fri, 7 Dec 2001 11:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282916AbRLGQo0>; Fri, 7 Dec 2001 11:44:26 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:4613 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S282907AbRLGQoL>; Fri, 7 Dec 2001 11:44:11 -0500
Date: Fri, 7 Dec 2001 19:43:47 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Kurt Garloff <garloff@suse.de>,
        Linux kernel list <linux-kernel@vger.kernel.org>,
        linux-alpha@vger.kernel.org, debian-alpha@lists.debian.org,
        axp-list@redhat.com, suse-axp@suse.com
Cc: Jay Estabrook <Jay.Estabrook@compaq.com>
Subject: Re: IDE DMA on AXP & barriers
Message-ID: <20011207194347.A2718@jurassic.park.msu.ru>
In-Reply-To: <20011206061315.J13427@garloff.etpnet.phys.tue.nl> <20011206125935.A3930@jurassic.park.msu.ru> <20011207132505.B4229@garloff.etpnet.phys.tue.nl> <20011207170341.A9959@jurassic.park.msu.ru> <20011207154815.A14011@garloff.etpnet.phys.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011207154815.A14011@garloff.etpnet.phys.tue.nl>; from garloff@suse.de on Fri, Dec 07, 2001 at 03:48:15PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2001 at 03:48:15PM +0100, Kurt Garloff wrote:
> > Hmm, it seems to be a pyxis bug; the hardware workaround exists, but
> > I guess that it might be not implemented properly on early miatas.
> > This also explains why I don't have that problem on lx164 and sx164.
> > >From pyxis manual:
> > "A.1 Read Page Problem
> >  PCI DMA reads that attempt to cross 8K page boundaries cause data corruption
> >  problems. A fix has been implemented with an Altera 7032 and two Pericom
> >  PI5C3400 bus switches and a diode."
> 
> Hey, where did you find that manual? I could not find one at Compaq's web
> site.

IIRC, few years ago someone posted a link on axp-list, and I picked it up.
Anyway, I've placed it on
ftp://ftp.park.msu.ru/ink/docs/21174_SI.pdf

> How do I recognize the broken PYXIS in software? (Except for waiting for
> your hard disk to be corrupted?)

Put the chip into PCI loopback mode, read some memory (crossing the
page boundary) via direct PCI window and check for corruption -
perhaps this will work.

> Unfortunately, I see no 21174 on my PCI bus where I could just check the
> revision.

Checking the revision won't help - that bug should be fixed with some
off-chip logic.

> Or should I just put an #ifdef CONFIG_ALPHA_PYXIS in my patch?
> What about the users of generic alpha kernels?

#ifdef CONFIG_ALPHA_PYXIS won't work for them.

> Or a config option?

Maybe...
Jay, your opinion? Perhaps you have the info which systems are affected?

Ivan.
