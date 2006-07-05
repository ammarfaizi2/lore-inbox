Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964856AbWGEUxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964856AbWGEUxo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 16:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964903AbWGEUxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 16:53:44 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:34709 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S964856AbWGEUxn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 16:53:43 -0400
Message-ID: <44AC26DA.1010901@drzeus.cx>
Date: Wed, 05 Jul 2006 22:53:46 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
CC: Len Brown <len.brown@intel.com>, LKML <linux-kernel@vger.kernel.org>,
       Adam Belay <ambx1@neo.rr.com>
Subject: Re: ACPIPNP and too large IO resources
References: <44AB608F.1060903@drzeus.cx> <200607051047.40734.bjorn.helgaas@hp.com>
In-Reply-To: <200607051047.40734.bjorn.helgaas@hp.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn Helgaas wrote:
> Thanks for the report!
>   

Np. Gave me an excuse to try out git bisect. ;)

> It sounds like this might be the same problem as
>     http://bugzilla.kernel.org/show_bug.cgi?id=6292
>
> In short, you probably have a bridge device that consumes the
> entire 0x0-0xffff I/O port range and produces some or all of that
> range for downstream PNP devices.  PNP doesn't know what to do
> with these windows that are both consumed by the bridge and made
> available to downstream devices, so it just marks them as being
> already reserved.
>   

Ah, that explains things.

> Matthieu Castet wrote a nice patch (attached) that makes PNP just
> ignore those windows.  Can you try it and see whether it fixes
> the problem you're seeing?  This patch is already in -mm, but not
> yet in mainline.  We might need to consider this patch as
> 2.6.18 material if it resolves your problem.  I suspect many
> people will see the same problem.
>   

The patch works nicely and removes all memory and io regions for the PCI
bridge but for the range 0xcf8-0xcff.

Thanks
Pierre

