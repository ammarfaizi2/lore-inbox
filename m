Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932418AbVIMHAA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932418AbVIMHAA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 03:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932421AbVIMHAA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 03:00:00 -0400
Received: from mail.kroah.org ([69.55.234.183]:54715 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932418AbVIMG77 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 02:59:59 -0400
Date: Mon, 12 Sep 2005 23:59:37 -0700
From: Greg KH <greg@kroah.com>
To: Keith Owens <kaos@sgi.com>
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: 2.6.14-rc1 breaks tg3 on ia64
Message-ID: <20050913065937.GA7849@kroah.com>
References: <20050912.223755.56102921.davem@davemloft.net> <23056.1126592253@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23056.1126592253@kao2.melbourne.sgi.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2005 at 04:17:33PM +1000, Keith Owens wrote:
> On Mon, 12 Sep 2005 22:37:55 -0700 (PDT), 
> "David S. Miller" <davem@davemloft.net> wrote:
> >From: Keith Owens <kaos@sgi.com>
> >Date: Tue, 13 Sep 2005 15:22:17 +1000
> >
> >> 2.6.14-rc1 + kdb on ia64 (SGI Altix).
> >> 
> >> tg3.c:v3.39 (September 5, 2005)
> >> ACPI: PCI Interrupt 0001:01:04.0[A]: no GSI
> >> BRIDGE ERR_STATUS 0x800
> >> BRIDGE ERR_STATUS 0x800
> >> PCI BRIDGE ERROR: int_status is 0x800 for 011c32:slab0:widget15:bus0
> >>     Dumping relevant 011c32:slab0:widget15:bus0 registers for each bit set...
> >>         11: PCI bus device select timeout
> >>             PCI Error Address Register: 0x3000000316808
> >>             PCI Error Address: 0x316808
> >>     PIC Multiple Interrupt Register is 0x800
> >>         11: PCI bus device select timeout
> >> 
> >> Followed by a machine check and reboot :(  2.6.13 worked fine.  Any
> >> ideas which patch to backout this time?
> >
> >Does copying over the 2.6.13 tg3.[ch] driver over into your
> >2.6.14-rc1 tree make it work?
> 
> No, the 2.6.13 driver in 2.6.14-rc1 has exactly the same problem.
> 
> The last time that tg3 broke like this, it was because of the patch
> below, in 2.6.13-rc6.  That was backed out in 2.6.13-rc7.  Was the PCI
> patch (or equivalent) reinstated in 2.6.14-rc1?
> 
> From: John W. Linville <linville@tuxdriver.com>
> Date: Fri, 5 Aug 2005 01:06:10 +0000 (-0700)
> Subject: [PATCH] PCI: restore BAR values after D3hot->D0 for devices that need it
> X-Git-Tag: v2.6.13-rc6
> X-Git-Url: http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=fec59a711eef002d4ef9eb8de09dd0a26986eb77

So does reverting this patch solve the problem?

thanks,

greg k-h
