Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261393AbUBTTnT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 14:43:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261397AbUBTTmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 14:42:13 -0500
Received: from ida.rowland.org ([192.131.102.52]:22276 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S261376AbUBTTa7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 14:30:59 -0500
Date: Fri, 20 Feb 2004 14:30:58 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Linus Torvalds <torvalds@osdl.org>
cc: "David S. Miller" <davem@redhat.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>, <greg@kroah.com>,
       <akpm@osdl.org>, <linux-usb-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB update for 2.6.3
In-Reply-To: <Pine.LNX.4.58.0402200714270.1107@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.44L0.0402201425520.626-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just to clear up a small disagreement...

On Fri, 20 Feb 2004, Linus Torvalds wrote:

> On Thu, 19 Feb 2004, David S. Miller wrote:
> > On Fri, 20 Feb 2004 18:10:41 +1100
> > Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > 
> > > Hrm... so if the USB device drivers are actually doing the dma mapping
> > > themselves, it make sense for them to pass their own struct device, no ?
> > 
> > That's right, at least that was the idea.
> 
> No. That would be _fundamentally_ wrong.
> 
> There's no way a USB device can do DMA in the first place. It has no DMA 
> controller, and no way to read/write memory except through the USB host.
> 
> So it is the host - and only the host - that matters. Anything else is a 
> bug.

Both of you are right.  Linus is right that USB devices don't do DMA.  
Ben is right that sometimes a USB device _driver_ will set up a DMA 
mapping.  And of course, it is set up on behalf of the corresponding USB 
controller, so the controller's struct device would be passed.

Alan Stern

