Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269728AbUICSNR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269728AbUICSNR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 14:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269680AbUICSKA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 14:10:00 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:20120 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S269710AbUICSGf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 14:06:35 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH] add PCI ROMs to sysfs
Date: Fri, 3 Sep 2004 11:06:08 -0700
User-Agent: KMail/1.7
Cc: Jon Smirl <jonsmirl@yahoo.com>, Greg KH <greg@kroah.com>,
       Matthew Wilcox <willy@debian.org>, Martin Mares <mj@ucw.cz>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <20040903014048.60310.qmail@web14922.mail.yahoo.com> <200409031027.46354.jbarnes@engr.sgi.com> <200409031045.14499.jbarnes@engr.sgi.com>
In-Reply-To: <200409031045.14499.jbarnes@engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409031106.08715.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, September 3, 2004 10:45 am, Jesse Barnes wrote:
> On Friday, September 3, 2004 10:27 am, Jesse Barnes wrote:
> > On Thursday, September 2, 2004 6:40 pm, Jon Smirl wrote:
> > > This is a repost of the pci-sysfs-rom-22.patch. No one has made any
> > > comments on this version. All previous objections have been addressed.
> > > Any objections to sending it upstream?
> >
> > Hm, the last one I tried worked fine, but this one makes my qla card stop
> > working, but not right way.  The system gets to init and then falls over,
> > maybe when it starts doing writes?  The last version I tried seems to
> > work ok though.  Has something changed in the PCI layer that would affect
> > this?
>
> It looks like hald is reading the rom attribute at boot, which either
> disables decode for the qla mmio registers or otherwise panics.  Bad hald.

After disabling hald, things are ok.  I can read ROMs that have been mapped 
correctly.  The problem was that sn2 doesn't map all ROMs by default, so the 
qla card, which has a ROM, had it's resource structure filled with the value 
in its BARs, which was of course not a usable CPU address.  I can fix that 
for sn2, so the patch is ok with me.

Jesse
