Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162217AbWKPCYZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162217AbWKPCYZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 21:24:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162216AbWKPCYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 21:24:25 -0500
Received: from gate.crashing.org ([63.228.1.57]:2444 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1162217AbWKPCYY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 21:24:24 -0500
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Miller <davem@davemloft.net>, jeff@garzik.org,
       linux-kernel@vger.kernel.org, tiwai@suse.de
In-Reply-To: <Pine.LNX.4.64.0611141935390.3349@woody.osdl.org>
References: <Pine.LNX.4.64.0611141846190.3349@woody.osdl.org>
	 <20061114.190036.30187059.davem@davemloft.net>
	 <Pine.LNX.4.64.0611141909370.3349@woody.osdl.org>
	 <20061114.192117.112621278.davem@davemloft.net>
	 <Pine.LNX.4.64.0611141935390.3349@woody.osdl.org>
Content-Type: text/plain
Date: Thu, 16 Nov 2006 13:22:56 +1100
Message-Id: <1163643776.5940.338.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> HOWEVER - that's only true on systems with no other PCI bridges. Even if 
> you have an Intel NB/SB, what about other bridges in that same system, and 
> the devices behind them? 

Well... MSIs are just normal stores as far as PCI is concerned. Thus, if
you have P2P bridges in your system and they can't get store ordering
right, I think you have a much bigger problem than getting MSIs wrong.

I think the problem is mostly with host bridges doing crappy stuffs like
decoding MSIs up front and sending them to the CPU out of order or
HT<->PCI (or some home made backbone <-> PCI) bridges where MSIs gets
turned into something else with potentially ordering breakage at the
transformation point or the upstream bus.

> Now, I think that a MSI thing should look like a PCI write to a magic 
> address (I'm really not very up on it, so correct me if I'm wrong), and 
> thus maybe bridges are bound to get it right, and the only thing we really 
> need to worry about is the host bridge. 

Host bridges or something <-> PCI (something = HT, or some of the fancy
NB<->SB links other vendors use).

> Maybe. In that case, it might be sensible to have a host-bridge white-table,
> and if we know all Intel 
> bridges that claim to support MSI do so correctly, then maybe we can just 
> say "ok, always enable it for Intel host bridges".
> 
> But right now I'm not convinced we really know what all goes wrong. Maybe 
> it's just broken NVidia and AMD bridges. But maybe it's also individual 
> devices that continue to (for example) raise _both_ the legacy IRQ line 
> _and_ send an MSI request.

Yeah, well, the later can be solved in software by masking the LSI when
MSI is enabled for a device.

Cheers,
Ben.


