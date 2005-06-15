Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261531AbVFOTvx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261531AbVFOTvx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 15:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261532AbVFOTvx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 15:51:53 -0400
Received: from colin.muc.de ([193.149.48.1]:64269 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S261531AbVFOTvu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 15:51:50 -0400
Date: 15 Jun 2005 21:51:44 +0200
Date: Wed, 15 Jun 2005 21:51:44 +0200
From: Andi Kleen <ak@muc.de>
To: Jacob Martin <martin@cs.uga.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM:  OOPSes in PREEMPT SMP for AMD Opteron Dual-Core with Memhole Mapping (non tainted kernel)
Message-ID: <20050615195144.GA40993@muc.de>
References: <200506071836.12076.martin@cs.uga.edu> <200506121529.50259.martin@cs.uga.edu> <20050613100604.GA18976@muc.de> <200506131953.16958.martin@cs.uga.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506131953.16958.martin@cs.uga.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2005 at 07:53:16PM +0000, Jacob Martin wrote:
> On Monday 13 June 2005 10:06 am, Andi Kleen wrote:
> > On Sun, Jun 12, 2005 at 03:29:50PM -0400, Jacob Martin wrote:
> > > Hardware memhole mapping never seems to work, or causes lockups right
> > > away.  I need to test it further though.
> > >
> > > I have discovered that with the following features enabled:
> > >
> > > 1.  Software memhole mapping
> > > 2.  Continuous,
> > >
> > > linux sees the entire 4GB of memory.  However, when things start getting
> > > requested from the upper half, there are Oopses generated.  Attached are
> > > two Oopses that occurred under the test scenario described.
> >
> > What happens when you boot with numa=off or with numa=noacpi ?
> 
> You got it!  It seems to be working just fine without it compiled into the 
> kernel.

Not compiled what in the kernel? I just wanted you to boot
the kernel with these options. 


> 
> > The system seems to believe it has memory in an area not covered
> > by mem_map.
> 
> I think you hit it right on the head.
> 
> I enabled NUMA because I had anticipated upgrading later.  So I guess if you 
> don't actually have NUMA set up hardware-wise, and enable this module, then 
> you will have problems.

No, it should work fine in theory. 

> 
> Maybe a simple update to the kernel "K8 NUMA support" Processor feature's help 
> section should be made to note this?  Or, is there something that could be 
> fixed somewhere.  I wouldn't mind helping, it was baffling me for two weeks.

It is something that must be either fixed or workarounded (if it's a bug
in your BIOS, which is quite possible) 

Can you send me the full dmesg from a numa boot again? 

-Andi
