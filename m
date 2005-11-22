Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964946AbVKVO0w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964946AbVKVO0w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 09:26:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964950AbVKVO0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 09:26:52 -0500
Received: from havoc.gtf.org ([69.61.125.42]:9859 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S964946AbVKVO0w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 09:26:52 -0500
Date: Tue, 22 Nov 2005 09:26:48 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Dave Airlie <airlied@gmail.com>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: today's graphics (was Re: [RFC] Small PCI core patch)
Message-ID: <20051122142648.GB24997@havoc.gtf.org>
References: <20051121225303.GA19212@kroah.com> <20051121230136.GB19212@kroah.com> <1132616132.26560.62.camel@gaston> <21d7e9970511211647r4df761a2l287715368bf89eb6@mail.gmail.com> <1132623268.20233.14.camel@localhost.localdomain> <1132626478.26560.104.camel@gaston> <1132669546.20233.49.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1132669546.20233.49.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2005 at 02:25:45PM +0000, Alan Cox wrote:
> On Maw, 2005-11-22 at 13:27 +1100, Benjamin Herrenschmidt wrote:
> > On the other hand, there is little justification not to open source at
> > least the kernel & basic mode setting part. It's all plumbing and mode
> > setting stuff, monitor detection, etc... it's not part of any of the big
> > added value or IP stuff that can be found in the 3D engine.
> 
> I would concur. Although one of the problems as I understand it is the
> upcoming cards no longer have a 2D engine.

Yep.

Current technology is completely programmable GPUs, with an ISA just
like x86 or PPC processors have an ISA.

Programmable shaders -- aka JIT-compiled GLSL code -- are the order of
the day.  2D and the static 3D pipeline are entirely implemented in
terms of these instructions.

Allen Akin noted that graphics regularly goes through generic/specific
hardware cycles.  At the moment, we are in the 'generic' point in the
cycle; thus, one can look at the older Rendition processors (docs
available to XFree86 hackers) for a moderate example of how to deal with
current ATI and NVIDIA cards.

So today's cards, it's all about transferring code (GPU microcode)
and data (textures, vertexes, etc.) to and from the card.  Remote
execution one could call it.  Or RPC :)

I've proposed to Intel, and would like to talk to ATI/NVIDIA, about
seeing what can be done to standardize the REALLY DUMB components, like
the DMA interface to transfer code and data.

	Jeff


