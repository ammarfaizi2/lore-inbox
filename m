Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932334AbVJYUHy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932334AbVJYUHy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 16:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932335AbVJYUHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 16:07:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11668 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932334AbVJYUHx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 16:07:53 -0400
Date: Tue, 25 Oct 2005 13:07:42 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Mark Lord <mlord@pobox.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Call for PIIX4 chipset testers
In-Reply-To: <435E8CFE.7060006@pobox.com>
Message-ID: <Pine.LNX.4.64.0510251301540.10477@g5.osdl.org>
References: <Pine.LNX.4.64.0510251042420.10477@g5.osdl.org> <435E8CFE.7060006@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 25 Oct 2005, Mark Lord wrote:
>
> Are these lines of any use?

Yes, that's great.

> If so, I'll try and get it to boot further and dump
> the more detailed info.  That'll take some effort
> (I'm grafting a semi-modern kernel onto an old install).
> ...
> PCI quirk: region 1000-103f claimed by PIIX4 ACPI
> PCI quirk: region 1040-105f claimed by PIIX4 SMB
> PIIX4 devres C PIO at 15e8-15ef
> PIIX4 devres I PIO at 03f0-03f7
> PIIX4 devres J PIO at 002e-002f

You've got three of the "new" devres resources, and judging by the values, 
I'd guess you have an IBM ThinkPad 600 series machine. No?

If it's indeed an IBM ThinkPad, I don't need any more info. It's a 
confirmation of the behaviour that I already saw debugging Alan's machine.

I have no idea what that device at 0x15e8 actually _is_, but just the fact 
that the PCI resource management will know about it means that we now can 
avoid putting anything else at that address. Which is why we want to know 
about these quirks in the first place.

(The two other device resources are just old ISA areas, we'd never have 
put any PCI device in those ranges anyway. But the mysterious 0x15e8 
region was what got me started on this thing).

And if it's something else than a ThinkPad, I'd love to know what it is.

		Linus
