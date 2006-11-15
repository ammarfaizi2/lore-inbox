Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965823AbWKOHYY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965823AbWKOHYY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 02:24:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932828AbWKOHYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 02:24:23 -0500
Received: from gate.crashing.org ([63.228.1.57]:32944 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932823AbWKOHYX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 02:24:23 -0500
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
Cc: torvalds@osdl.org, jeff@garzik.org, linux-kernel@vger.kernel.org,
       tiwai@suse.de
In-Reply-To: <20061114.200719.38322619.davem@davemloft.net>
References: <Pine.LNX.4.64.0611141846190.3349@woody.osdl.org>
	 <20061114.190036.30187059.davem@davemloft.net>
	 <1163563260.5940.205.camel@localhost.localdomain>
	 <20061114.200719.38322619.davem@davemloft.net>
Content-Type: text/plain
Date: Wed, 15 Nov 2006 18:23:40 +1100
Message-Id: <1163575420.5940.223.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-11-14 at 20:07 -0800, David Miller wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Date: Wed, 15 Nov 2006 15:01:00 +1100
> 
> > Out of curiosity. Are you sure there is no case of stupid bridge
> > converting the MSI into some APIC/whatever interrupt for the CPU
> > potentially before all previous DMA have been fully pushed to the
> > coherent domain (still in some internal store queue for example) ?
> 
> That would really suck, wouldn't it :)
> 
> However, they have to do all the work of processing the memory
> transation that the MSI is on the PCI bus, I don't think they would go
> so far out of their way to reorder things even if they converted the
> MSI packet into a PIN to the APIC, for example.

That would suck and not surprise me that much in fact... Take the Apple
bridge... it's unclear at which point they actually decode the MSI and
HT interrupts (the later are just internally converted to MSI-like
stores) to turn them into toggling of MPIC lines, but it probably
happens as an MMIO slave on the main xbar and I'm not 100% certain it
provides ordering vs. the previous stores to memory as they are in the
coherent domain and the MMIO is not. I just hope very much :-) Because
the store queue to memory can re-order on U4.

Ben.


