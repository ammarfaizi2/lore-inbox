Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750788AbVH1UXY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbVH1UXY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 16:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750793AbVH1UXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 16:23:24 -0400
Received: from [81.2.110.250] ([81.2.110.250]:11757 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1750788AbVH1UXX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 16:23:23 -0400
Subject: Re: Telling Linux that a SATA device has gone away
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E1E9TET-0003Hc-00@chiark.greenend.org.uk>
References: <20050826144250.GA12816@srcf.ucam.org>
	 <20050826144250.GA12816@srcf.ucam.org>
	 <1125070980.4958.102.camel@localhost.localdomain>
	 <E1E9TET-0003Hc-00@chiark.greenend.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 28 Aug 2005 21:51:42 +0100
Message-Id: <1125262302.11018.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is there any hope of 2.6 gaining IDE hotswap? Given how easy it is to
> capture removal events with ACPI, it would be nice to be able to do
> something useful with it (rather than just tending to crash the machine)

For the SATA layer I see no real barriers. The core scsi code/block code
can handle it all now without the trickery 2.4-ac IDE had to do. The
scsi layer itself is happy with drive hot unplug (witness just how much
better 2.6 USB storage is than 2.4).

Handling drive removal is essetially a case of not issuing more commands
to it and cleaning up the others as they error out, something the layer
handles ok.

New drive attachment means running the entire probe state machine for
the drive and the essential commands (figure out the modes, clipping,
power management, set up modes etc). Thats more complex for PATA where
adding one drive can require reprogramming the other.

Porting the 2.4 old IDE code is probably 2-3 weeks work and I doubt
worth it long term.

