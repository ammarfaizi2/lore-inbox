Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268227AbUIHPGW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268227AbUIHPGW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 11:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268382AbUIHPFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 11:05:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4495 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268227AbUIHPD3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 11:03:29 -0400
Date: Wed, 8 Sep 2004 16:03:22 +0100
From: Matthew Wilcox <willy@debian.org>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Matthew Wilcox <willy@debian.org>, Jesse Barnes <jbarnes@engr.sgi.com>,
       lkml <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: multi-domain PCI and sysfs
Message-ID: <20040908150322.GN642@parcelfarce.linux.theplanet.co.uk>
References: <9e4733910409041300139dabe0@mail.gmail.com> <200409041527.50136.jbarnes@engr.sgi.com> <9e47339104090415451c1f454f@mail.gmail.com> <200409041603.56324.jbarnes@engr.sgi.com> <20040905230425.GU642@parcelfarce.linux.theplanet.co.uk> <9e473391040905165048798741@mail.gmail.com> <20040906014058.GV642@parcelfarce.linux.theplanet.co.uk> <9e47339104090715585fa4f8af@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e47339104090715585fa4f8af@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2004 at 06:58:53PM -0400, Jon Smirl wrote:
> How many active VGA devices can I have in this system 1 or 4? If the
> answer is 4, how do I independently address each VGA card? If the
> answer is one, you can see why I want a pci0000 node to hold the
> attribute for turning it off and on.

Each root bridge has the ability to route the VGA memory space.  I imagine
only one has that bit set at a time.

> How many simultaneous VGA devices does this system allow?

I don't think HP supports a configuration other than having the VGA
device on the AGP bus, but there's no reason one couldn't put a VGA
device in every PCI-X slot, is there?

> Does a PCI domain imply separate PCI IO address spaces, or does it
> just mean separate PCI Config spaces?

It only requires separate config space.  In practice, you may well
get separate IO port space and/or memory space per domain, or even per
root bus.  On PA-RISC, we extend the IO port space to 24 bit and use
the top 8 bits to determine which PCI root bus we're talking to.

> Can an x86 machine use separate PCI IO address spaces?

I think some of the NUMAQ stuff can have separate IO port space, but
you'd have to ask someone familiar with the architecture like Martin
Bligh or Bill Irwin.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
