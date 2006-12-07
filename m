Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031866AbWLGIxx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031866AbWLGIxx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 03:53:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031859AbWLGIxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 03:53:53 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:40552 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031866AbWLGIxw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 03:53:52 -0500
X-Originating-Ip: 74.102.209.62
Date: Thu, 7 Dec 2006 03:49:27 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Randy Dunlap <randy.dunlap@oracle.com>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] Restructure Device Driver menu entries
In-Reply-To: <20061206121223.2c7c0c7b.randy.dunlap@oracle.com>
Message-ID: <Pine.LNX.4.64.0612070345440.6261@localhost.localdomain>
References: <Pine.LNX.4.64.0612060514210.7300@localhost.localdomain>
 <20061206121223.2c7c0c7b.randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Dec 2006, Randy Dunlap wrote:

> On Wed, 6 Dec 2006 09:33:46 -0500 (EST) Robert P. J. Day wrote:
>
> >
> >   This is a *proposed* restructuring of the DD menu so that one can
> > see and select/de-select entire submenus without having to enter each
> > submenu.    It's also immediately obvious visually which submenus are
> > currently active.
> >
> >   Based on Randy Dunlap's earlier suggestion, it uses the kbuild
> > "menuconfig" feature.  I changed only those sub-entries that matched
> > an obvious pattern (that is, selectable in their entirety).  If there
> > was *anything* slightly different about that sub-entry, I left it
> > alone.  (That doesn't mean that those sub-entries can't be similarly
> > tweaked with a minimum of effort, I was just keeping it simple for
> > now.)
> >
> >   Finally, if this structure is used, there's still a good deal of
> > cleanup that can be done on each Kconfig file.  For example, if most
> > of the mtd Kconfig file is now surrounded by
>
> The FUSION part has a dependency that I'll leave for you:
>
> Warning! Found recursive dependency: FUSION FUSION_SPI FUSION
>
> reported by any "make *config".

ah, quite right, i missed that.  that's because the fusion Kconfig
file starts with:

menu "Fusion MPT device support"

config FUSION
	bool
	default n

config FUSION_SPI
	tristate "Fusion MPT ScsiHost drivers for SPI"
	depends on PCI && SCSI   <-- not dependent on FUSION
	select FUSION
	select SCSI_SPI_ATTRS
	...

  for now, then, i'm just going to remove the FUSION menu change from
the upcoming patch and decide what to do about it later.  as i
mentioned, i wanted this first patch to restructure entries that
required nothing more than the obvious rewrite.  upcoming patch ...
uh, upcoming shortly.

rday
