Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261810AbVB1X3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261810AbVB1X3N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 18:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261815AbVB1X3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 18:29:13 -0500
Received: from peabody.ximian.com ([130.57.169.10]:15312 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261810AbVB1X3I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 18:29:08 -0500
Subject: Re: [RFC] PCI bridge driver rewrite
From: Adam Belay <abelay@novell.com>
To: Jesse Barnes <jbarnes@sgi.com>
Cc: Jon Smirl <jonsmirl@gmail.com>, greg@kroah.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <200502241502.15163.jbarnes@sgi.com>
References: <1109226122.28403.44.camel@localhost.localdomain>
	 <9e473391050223224532239c9d@mail.gmail.com>
	 <1109228638.28403.71.camel@localhost.localdomain>
	 <200502241502.15163.jbarnes@sgi.com>
Content-Type: text/plain
Date: Mon, 28 Feb 2005 18:27:47 -0500
Message-Id: <1109633268.28403.77.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-02-24 at 15:02 -0800, Jesse Barnes wrote:
> On Wednesday, February 23, 2005 11:03 pm, Adam Belay wrote:
> 
> > > Jesse can comment on the specific support needed for multiple legacy IO
> > > spaces.
> >
> > That would be great.  Most of my experience has been with only a couple
> > legacy IO port ranges passing through the bridge.
> 
> Well, I'll give you one, somewhat perverse, example.  On SGI sn2 machines, 
> each host<->pci bridge (either xio<->pci or numalink<->pci) has two pci 
> busses and some additional host bus ports.  The bridges are capable of 
> generating low address bus cycles on both busses simultaneously, so we can do 
> ISA memory access and legacy port I/O on every bus in the system at the same 
> time.
> 
> The main host chipset has no notion of VGA or legacy routing though, so doing 
> a port access to say 0x3c8 is ambiguous--we need a bus to target (though the 
> platform code could provide a 'default' bus for such accesses to go to, this 
> may be what VGA or legacy routing means for us under your scheme).  Likewise, 
> accessing ISA memory space like 0xa0000 needs a bus to target.
> 
> It would be nice if this sort of thing was taken into account in your new 
> model, so that for example we could have the vgacon driver talking to 
> multiple different VGA cards at the same time.
> 
> Thanks,
> Jesse

How can we specify which bus to target?  Also is the legacy IO space
mapped to IO Memory on the other side of the bridge?

Thanks,
Adam


