Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750776AbVJQQiT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbVJQQiT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 12:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbVJQQiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 12:38:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13530 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750776AbVJQQiS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 12:38:18 -0400
Date: Mon, 17 Oct 2005 09:38:04 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, davej@redhat.com
Subject: Re: [PATCH] libata: fix broken Kconfig setup
In-Reply-To: <4353CF7E.1090404@pobox.com>
Message-ID: <Pine.LNX.4.64.0510170930420.23590@g5.osdl.org>
References: <20051017044606.GA1266@havoc.gtf.org> <Pine.LNX.4.64.0510170754500.23590@g5.osdl.org>
 <4353C42A.3000005@pobox.com> <Pine.LNX.4.64.0510170848180.23590@g5.osdl.org>
 <4353CF7E.1090404@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 17 Oct 2005, Jeff Garzik wrote:
> 
> The only operational difference between CONFIG_SCSI_SATA=y and
> CONFIG_SCSI_SATA=m is that CONFIG_SCSI_SATA=m restricts the drivers from being
> compiled in -- a silly and needless restriction.
> 
> The elimination of 'y' as an option should propagate from CONFIG_SCSI.

Sure. You can do it that way too, as I mentioned in the original mail 
about why it was ugly.

But the point is:

 WHY?

Your insistence on CONFIG_SCSI_SATA being a boolean only results in uglier 
configuration, for no gain. And it's not even TRUE. It's only true if you 
consider it to be a "do we support SATA or not" thing. It's not true if 
you consider it "how do we support SATA" thing.

In other words, a tristate makes total sense, if you say that 
CONFIG_SCSI_SATA describes how SATA is supported.

> Agreed this is a _theoretical_ problem.

But it's just another sign of you thinking about that config variable the 
wrong way.

> CONFIG_SCSI_SATA is just a switch to enable listing a set of drivers, just
> like CONFIG_NET_PCI (which I note is a bool), CONFIG_NET_ISA (a bool), ...

No it's not.

CONFIG_NET_BOOL is not a tristate, because it can't be a module. There's 
nothing that forces network drivers to be modules only. Same goes for 
NET_ISA.

In contrast, CONFIG_SCSI=m _does_ force SATA drivers to be module only. 

See? They are not the same at all.

> At that point it seems easier to solve at the Kconfig level, perhaps defining
> CONFIG_SATA_INTEL_COMBINED at the end.

Sure, that makes sense.

>  And then with the quirk issue out of
> the way, CONFIG_SCSI_SATA becomes purely a boolean enable/disable-this-menu
> switch.

No it does not. You continue to ignore the fact that it's not an 
enable/disable thing. It's a "can we enable SATA drivers" vs "can we 
enable SATA drivers as modules" vs "do we do any SATA drivers at all?" 
thing.

A tristate.

Adding the SCSI config is a pure hack because you refuse to see the fact 
that CONFIG_SCSI_SATA _is_ a tristate. Thinking it is a boolean causes you 
to then have to mix in other issues.

		Linus
