Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267574AbSLFHhg>; Fri, 6 Dec 2002 02:37:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267577AbSLFHhg>; Fri, 6 Dec 2002 02:37:36 -0500
Received: from h-64-105-35-8.SNVACAID.covad.net ([64.105.35.8]:40099 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S267574AbSLFHhf>; Fri, 6 Dec 2002 02:37:35 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Thu, 5 Dec 2002 23:41:38 -0800
Message-Id: <200212060741.XAA06036@adam.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] generic device DMA implementation
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Miller wrote:
>I think it's a huge error to try and move the DMA stuff into
>the generic device interfaces _AND_ change semantics and arguments
>at the same time.

	Nobody is talking about changing the existing pci_xxx
interface.  For the new dma_xxx routines, I think it would actually be
an error to wait to make the particular changes we are discussing,
because now there when there is no compatability to break and, less
importantly, because having it in 2.6.0 from the start might make one
less #ifdef for those people who want to try to maintain a
multi-version "2.6.x" device driver.  (Notice that I try to describe
underlying advantages or disadvantages when I advocate something.)

	People have already given a lot of thought to the modest
difference in the dma_xxx interface being discussed.  These change
will eliminate a difficulty in supporting devices on inconsistent-only
machines, I real problem that was partly induced by the original
pci_alloc_consistent interface.

	Six months ago, I posted proposal to turn scatterlists into
linked lists to reduce copying and translation between certain IO
list formats.  David responded "Now is not the time for this, when we
finally have the generic struct device stuff, then you can start doing
DMA stuff at the generic layer" in this posting:
http://marc.theaimsgroup.com/?l=linux-kernel&m=102501406027125&w=2

	I think that David is erring too much on the side of
stagnation right now.  I hope he'll understand this in future.  In the
meantime, I'd be in favor of continuing to work this into a clean
patch that everyone else likes and then asking Linus to integrate that
with or without David's blessing if nobody identifies any real
technical problems with it, at least if nobody else objects.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
