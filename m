Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267652AbUBTGIB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 01:08:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267656AbUBTGIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 01:08:00 -0500
Received: from gate.crashing.org ([63.228.1.57]:39593 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S267667AbUBTGH5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 01:07:57 -0500
Subject: Re: [BK PATCH] USB update for 2.6.3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       Linux-USB <linux-usb-devel@lists.sourceforge.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0402192156240.2244@ppc970.osdl.org>
References: <20040220012802.GA16523@kroah.com>
	 <Pine.LNX.4.58.0402192156240.2244@ppc970.osdl.org>
Content-Type: text/plain
Message-Id: <1077256996.20789.1091.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 20 Feb 2004 17:03:16 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-02-20 at 16:58, Linus Torvalds wrote:
> On Thu, 19 Feb 2004, Greg KH wrote:
> > 
> > Here are some USB patches for 2.6.3.  Here are the main types of changes:
> > 	- switch usb code to use dmapools instead of pcipools which
> > 	  makes the embedded people happy.
> 
> However, this makes the ppc64 people very unhappy.
> 
> I've just yesterday and today switched my main home machine to be ppc64, 
> and this will not compile for me. Bad boy!
> 
> (And I haven't used ppc64 enough to be able to make sense of the DMA 
> setup, so I can't even fix it myself yet. Aaarghh!)

Hehe ;)

Well, last I heard, people here were trying to make that work, but
still, our dma mapping API will probably want the device passed in
to be a pci_dev...

The problem with the generic API is that it makes it difficult
for us to actually go back to the PCI device hosting the USB
device we get passed in... Which we what we want (our IO MMU
setup is based on what PCI device is there, for PCI at least,
for VIO, it's a bit different, but the idea is the same).

A while ago, I've advertised making this API a set of function
pointers attached to the struct device inherited from the bus
parent, so the core code just set one for the root PCIs and
everybody inherits them.... But of course, since x86 isn't
affected, nobody cared ;)

I think the "generic" DMA API is just not suitable at the moment
to be really used. It gets passed "generic" struct device, which,
due to the way Pat designed it, are almost useless alone (we
can't quite match them to anything and don't have any kind of
"inheritance" of methods via function pointers). There is no
simple hook for archs to carry informations attached to struct
devices neither, etc...

Ben


