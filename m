Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262399AbVFIXTZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262399AbVFIXTZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 19:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262417AbVFIXTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 19:19:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49811 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262399AbVFIXTN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 19:19:13 -0400
Date: Thu, 9 Jun 2005 16:20:59 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andreas Koch <koch@esa.informatik.tu-darmstadt.de>
cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       gregkh@suse.de
Subject: Re: PROBLEM: Devices behind PCI Express-to-PCI bridge not mapped
In-Reply-To: <20050609223835.GB26023@erebor.esa.informatik.tu-darmstadt.de>
Message-ID: <Pine.LNX.4.58.0506091617130.2286@ppc970.osdl.org>
References: <Pine.LNX.4.58.0506032149130.1876@ppc970.osdl.org>
 <20050604155742.GA14384@erebor.esa.informatik.tu-darmstadt.de>
 <20050605204645.A28422@jurassic.park.msu.ru>
 <20050606002739.GA943@erebor.esa.informatik.tu-darmstadt.de>
 <20050606184335.A30338@jurassic.park.msu.ru>
 <20050608173409.GA32004@erebor.esa.informatik.tu-darmstadt.de>
 <20050609023639.A7067@jurassic.park.msu.ru> <1118289850.6850.164.camel@gaston>
 <20050609175441.C9187@jurassic.park.msu.ru>
 <20050609175429.GA26023@erebor.esa.informatik.tu-darmstadt.de>
 <20050609223835.GB26023@erebor.esa.informatik.tu-darmstadt.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 10 Jun 2005, Andreas Koch wrote:
>
> I did some more experimentation, and to my great the surprise, the
> serial port on the dock _is_ functioning, even when the rest of the
> dock is dead.

I wonder whether the bridge is effectively a negative decode thing, and 
the only "real" problem is that because the kernel doesn't know that, it 
doesn't know that it can allocate just about any resource at all on the 
other end..

It would be pretty strange, since the PCI spec (afaik, and for pretty
obvious reasons) disallows two negative bridges on the same bus (and you
already have the other mobile bridge there), but it's technically possible
if they just have different priorities for how fast they react to a PCI
address cycle and claim it.

Ivan, can you cook up some silly patch that just marks that one device 
transparent, and see if that "just fixes it".

		Linus
