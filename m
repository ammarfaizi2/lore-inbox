Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266319AbUGOUuO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266319AbUGOUuO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 16:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266322AbUGOUuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 16:50:14 -0400
Received: from colin2.muc.de ([193.149.48.15]:22794 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S266319AbUGOUuE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 16:50:04 -0400
Date: 15 Jul 2004 22:50:01 +0200
Date: Thu, 15 Jul 2004 22:50:01 +0200
From: Andi Kleen <ak@muc.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: netdev@oss.sgi.com, irda-users@lists.sourceforge.net, jt@hpl.hp.com,
       the_nihilant@autistici.org, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Drop ISA dependencies from IRDA drivers
Message-ID: <20040715205001.GA2527@muc.de>
References: <m34qo96x8m.fsf@averell.firstfloor.org> <40F6B547.7050800@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40F6B547.7050800@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2004 at 12:48:07PM -0400, Jeff Garzik wrote:
> Andi Kleen wrote:
> >http://bugme.osdl.org/show_bug.cgi?id=3077
> >
> >Some IRDA chipsets currently don't work on x86-64, because
> >they're dependent on CONFIG_ISA and x86-64 doesn't set this.
> >CONFIG_ISA means real ISA slots, and I doubt these chips
> >come on real ISA cards, so I just removed the bogus 
> >dependency.
> 
> Honestly, the issue and patch need more thought, IMO.
> 
> Regardless of theory, CONFIG_ISA is currently also used to indicate 
> legacy ISA devices that are today integrated into southbridges.

I don't think so. I did most of the original CONFIG_ISA annotations
and I only added it to real ISA devices.

And the LPC devices in southbridges are normally not marked
CONFIG_ISA. 

> 
> And with legacy ISA devices still around, I don't see a whole lot of 
> value in differentiating between "I have ISA slots" and "I have ISA 
> devices".

There is great value. Basically most ISA drivers are not 64bit 
clean (if they even still work on i386 which is also often doubtful
in 2.6) and it is a great way for 64bit archs to get rid of a lot 
of not working code.

-Andi
