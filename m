Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136462AbREDRoV>; Fri, 4 May 2001 13:44:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136470AbREDRoL>; Fri, 4 May 2001 13:44:11 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:6675 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S136462AbREDRoH>; Fri, 4 May 2001 13:44:07 -0400
Date: Fri, 4 May 2001 10:44:00 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Edward Spidre <beamz_owl@yahoo.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Possible PCI subsystem bug in 2.4
In-Reply-To: <m1hez1nmtc.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.4.21.0105041040340.521-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 4 May 2001, Eric W. Biederman wrote:
> 
> There are a couple of options here.
> 1) read the MTRRs unless the BIOS is braindead it will set up that area as
>    write-back.  At any rate we shouldn't ever try to allocate a pci region
>    that is write-back cached.

This one I'd really hesitate to use. We do _not_ want to trust the BIOS
any more than necessary (obviously trusting even the e820 was too much),
and especially wrt MTRR's we know that there are too many buggy bioses
already out there.

> 2) read the memory locations from the northbridge.  It's not possible
>    on every chipset (lack of documentation) but with the linuxBIOS
>    project we code for a couple of them, and we are working on more
>    all of the time.

This will be easy.

In fact, we can easily "mix" different heuristics. Ie we'd do the simple
thing I suggested in setup_arch(), and use that as a "base guess", and
then we can have incremental improvements on that guess that might be
chipset-specific or might depend on other information that is not
necessarily generic (things like existing PCI programming etc).

		Linus

