Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966117AbWKODzG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966117AbWKODzG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 22:55:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966118AbWKODzG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 22:55:06 -0500
Received: from smtp.osdl.org ([65.172.181.4]:14059 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S966117AbWKODzE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 22:55:04 -0500
Date: Tue, 14 Nov 2006 19:54:38 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David Miller <davem@davemloft.net>
cc: jeff@garzik.org, linux-kernel@vger.kernel.org, tiwai@suse.de
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
In-Reply-To: <20061114.192117.112621278.davem@davemloft.net>
Message-ID: <Pine.LNX.4.64.0611141935390.3349@woody.osdl.org>
References: <Pine.LNX.4.64.0611141846190.3349@woody.osdl.org>
 <20061114.190036.30187059.davem@davemloft.net> <Pine.LNX.4.64.0611141909370.3349@woody.osdl.org>
 <20061114.192117.112621278.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 14 Nov 2006, David Miller wrote:
> 
> > Yours was still an example of "nice". And it had absolutely nothing
> > to do with the _PROBLEM_.
> 
> Understood.

Btw, before somebody thinks I hate MSI - I'd absolutely _love_ for it to 
work, because I think MSI has the potential of getting rid of a lot of irq 
routing problems.

And that's more than just a "nice" - we've obviously had issues with 
machines not working right because we didn't get the magic PIRQ tables or 
ACPI crud right. 

So I'd actually be thrilled if we could use MSI more. (And here, "MSI" 
should be considered to also include "MSI-X" etc - please, no language 
lawyering).

> Given current experience maybe white-lists are in fact the way
> to go.

The thing that worries me is that I can well believe that the Intel NB/SB 
combination gets MSI 100% correct, and I'd love to whitelist it.

HOWEVER - that's only true on systems with no other PCI bridges. Even if 
you have an Intel NB/SB, what about other bridges in that same system, and 
the devices behind them? 

Now, I think that a MSI thing should look like a PCI write to a magic 
address (I'm really not very up on it, so correct me if I'm wrong), and 
thus maybe bridges are bound to get it right, and the only thing we really 
need to worry about is the host bridge. Maybe. In that case, it might be 
sensible to have a host-bridge white-table, and if we know all Intel 
bridges that claim to support MSI do so correctly, then maybe we can just 
say "ok, always enable it for Intel host bridges".

But right now I'm not convinced we really know what all goes wrong. Maybe 
it's just broken NVidia and AMD bridges. But maybe it's also individual 
devices that continue to (for example) raise _both_ the legacy IRQ line 
_and_ send an MSI request.

Maybe even Intel host bridges have all the same troubles with that, and 
the reason we haven't seen it is that _usually_ an Intel host bridge goes 
together with certain Intel MSI-capable chips (ie e1000, Intel HDA etc). 
So for all we know, it's not necessarily the Intel host bridge that is the 
magic thing to make things work, it could be something that just has a 
high _correlation_ with an Intel host bridge.

So call me a nervous nellie. 

		Linus
