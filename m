Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262039AbVFUORX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262039AbVFUORX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 10:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262066AbVFUOQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 10:16:56 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:21412 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262039AbVFUOPI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 10:15:08 -0400
Subject: Re: PATCH: IDE - sensible probing for PCI systems
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org
In-Reply-To: <Pine.LNX.4.61L.0506211422190.9446@blysk.ds.pg.gda.pl>
References: <1119356601.3279.118.camel@localhost.localdomain>
	 <Pine.LNX.4.61L.0506211422190.9446@blysk.ds.pg.gda.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1119363150.3325.151.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 21 Jun 2005 15:12:32 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-06-21 at 14:42, Maciej W. Rozycki wrote:
> On Tue, 21 Jun 2005, Alan Cox wrote:
> 
> > Old ISA/VESA systems sometimes put tertiary IDE controllers at addresses
> > 0x1e8, 0x168, 0x1e0 or 0x160. Linux thus probes these addresses on x86
> > systems. Unfortunately some PCI systems now use these addresses for
> > other purposes which leads to users seeing minute plus hangs during boot
> > or even crashes.
> 
>  Are these addresses visible in BARs?

Sometimes but often not. They tend to be below the PCI range used by the
systems but belonging to onboard "magic"

>  FYI, for MIPS for machines with a PCI bus we only probe for ISA IDE ports 
> on if there's a PCI-ISA or PCI-EISA bridge somewhere there.  This might be 
> a good idea for the i386 and probably any platform using PCI as well.

The primary/secondary ISA ports show up in PC systems because of the PCI
IDE class devices being in compatibility mode not native mode (so you
can still run old OS's). There are also a couple of older weird cases.

The PCI layer code is smart enough to figure out when a PCI and an ISA
probe find the same device and to put the entire thing together properly
so that aspect of it is ok.

For the 3rd and higher ports probing them isn't safe on a PCI box
regardless of the presence of ISA bridges so I don't think we need the
extra complexity - or am I missing something ?

