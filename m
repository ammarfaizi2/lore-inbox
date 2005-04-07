Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262373AbVDGBSa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262373AbVDGBSa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 21:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262371AbVDGBQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 21:16:08 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:53162 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S262369AbVDGBPl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 21:15:41 -0400
X-ORBL: [69.107.61.180]
From: David Brownell <david-b@pacbell.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [linux-usb-devel] USB glitches after suspend on ppc
Date: Wed, 6 Apr 2005 18:15:17 -0700
User-Agent: KMail/1.7.1
Cc: Linux-USB <linux-usb-devel@lists.sourceforge.net>,
       Colin Leroy <colin@colino.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       "debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
References: <20050405204449.5ab0cdea@jack.colino.net> <200504061628.05527.david-b@pacbell.net> <1112831456.9568.217.camel@gaston>
In-Reply-To: <1112831456.9568.217.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504061815.19073.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 06 April 2005 4:50 pm, Benjamin Herrenschmidt wrote:
> On Wed, 2005-04-06 at 16:28 -0700, David Brownell wrote:
> > On Wednesday 06 April 2005 4:02 pm, Benjamin Herrenschmidt wrote:
> > > 
> > > > Thanks for the testing update.  I'm glad to know that there seems to
> > > > be only one (minor) glitch that's PPC-specific!
> > > 
> > > Which is just an off-the-shelves NEC EHCI chip.
> > 
> > The wakeup-after-suspend hasn't been reported by anyone else.
> 
> Looks like the root hub is set for triggering wakeups on connect, isn't
> that just a setting in there ? The old Apple ASIC had a bit somewhere to
> control that, but I don't know about the NEC

The NEC chip uses PME# for PCI wakeup, which pci_enable_wake(..., 0)
is supposed to have disabled.  If it's not disabling PME#, that's a
bug in the PCI infrastructure on that platform.  If some other signal
is causing a wakeup, that's a different platform-specific issue.  :)


