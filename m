Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262207AbVBVFKE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262207AbVBVFKE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 00:10:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262208AbVBVFKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 00:10:04 -0500
Received: from gate.crashing.org ([63.228.1.57]:27350 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262207AbVBVFJ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 00:09:58 -0500
Subject: Re: POSTing of video cards (WAS: Solo Xgl..)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Dave Airlie <airlied@linux.ie>, dri-devel@lists.sourceforge.net,
       xorg@lists.freedesktop.org,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <9e473391050221204215a079e1@mail.gmail.com>
References: <Pine.LNX.4.58.0502201049480.18753@skynet>
	 <4218BAF0.3010603@tungstengraphics.com>
	 <21d7e997050220150030ea5a68@mail.gmail.com>
	 <9e4733910502201542afb35f7@mail.gmail.com> <1108973275.5326.8.camel@gaston>
	 <9e47339105022111082b2023c2@mail.gmail.com>
	 <1109019855.5327.28.camel@gaston>
	 <9e4733910502211717116a4df3@mail.gmail.com>
	 <1109041968.5412.63.camel@gaston>
	 <9e473391050221204215a079e1@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 22 Feb 2005 16:09:20 +1100
Message-Id: <1109048960.5411.74.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-02-21 at 23:42 -0500, Jon Smirl wrote:
> On Tue, 22 Feb 2005 14:12:48 +1100, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > It's up to each driver to detect wether it's card need to be POSTed or
> > not. Anything else would mean infinite breakage.
> 
> Your approach is that it is a per driver problem. I was taking a
> different tack and looking at it as a BIOS deficiency that should be
> compensated for. There is already code in the kernel for identifying
> the boot video device.

Your assumption is rather specific to a given platform... what if you
have a card with no ROM (embedded system) but your kernel has a copy of
what should be the ROM at hand ? (flash is expensive, heh :)

> I was working on the assumption that all PCI based, VGA class hardware
> that is not the boot device needs to be posted.

That isn't the case on all platforms. Also, I like the flexibility of
having a userland helper since that doesn't "tie" us to the semantics of
an x86 platform & BIOS (we could have an OF emulator too, or whatever
binary program provided by the vendor in userspace to reinit the card
without having to link that with the kernel).

I think my approach is the most flexible in the long run.

> And that the posting should occur before the drivers are
> loaded. In order words the BIOS should have provided initialized
> hardware but since it didn't we can apply a fixup in the PCI driver. I
> also suspect there may be SCSI disk controller cards that need the
> same procedure.

I don't think we have to do these assumptions. It should really be under
driver control.

> I have no strong opinions on how to fix the post problem, I just want
> to make sure the problem is fully discussed by the relevant people and
> a consensus solution is achieved. I'm not sure that all of the core
> kernel developers that might be impacted by this have considered all
> of the options. I would like to try and get a consensus design and
> avoid reimplementing everything ten times.

Agreed.

Ben.


