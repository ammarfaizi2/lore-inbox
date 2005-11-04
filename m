Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750775AbVKDRus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbVKDRus (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 12:50:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbVKDRus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 12:50:48 -0500
Received: from mail.kroah.org ([69.55.234.183]:27042 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750775AbVKDRur (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 12:50:47 -0500
Date: Fri, 4 Nov 2005 09:49:51 -0800
From: Greg KH <gregkh@suse.de>
To: "David S. Miller" <davem@davemloft.net>
Cc: macro@linux-mips.org, stern@rowland.harvard.edu,
       linux-kernel@vger.kernel.org
Subject: Re: post-2.6.14 USB change breaks sparc64 boot
Message-ID: <20051104174951.GA14957@suse.de>
References: <20051103.093328.74747521.davem@davemloft.net> <Pine.LNX.4.55.0511031738390.24109@blysk.ds.pg.gda.pl> <20051104.094053.118921373.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051104.094053.118921373.davem@davemloft.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2005 at 09:40:53AM -0800, David S. Miller wrote:
> From: "Maciej W. Rozycki" <macro@linux-mips.org>
> Date: Thu, 3 Nov 2005 17:46:20 +0000 (GMT)
> 
> > On Thu, 3 Nov 2005, David S. Miller wrote:
> > 
> > > Perhaps pci_fixup_final would be a more appropriate time to run this
> > > USB host controller fixup?  One downside to this is that such calls
> > > would not be invoked for hot-plugged USB host controller devices.
> > 
> >  This might actually want to be split to disable legacy stuff as soon as
> > possible to prevent a flood of interrupts, sending SMIs and what not else.  
> > That just requires poking at the PCI config space.  Whatever's the rest
> > could be done later.  I guess hot-plugged USB host controllers are not
> > configured for legacy support, so the early bits should not matter for
> > them.
> 
> Would anyone mind if I pushed to Linus the following fix, at
> least for now?  Thanks.

No objection from me, if this fixes your machines.

> diff-tree 834843a8562e6614768d8c8b8a23d94d98af7360 (from 06024f217d607369f0ee0071034ebb03071d5fb2)
> Author: David S. Miller <davem@sunset.davemloft.net>
> Date:   Fri Nov 4 09:38:18 2005 -0800
> 
>     [USB]: Make early handoff a final fixup instead of a header one.
>     
>     At header fixup time, it is not yet legal to ioremap() PCI
>     device registers, yet that is what this quirk code needs to
>     do.
>     
>     Signed-off-by: David S. Miller <davem@davemloft.net>

Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
