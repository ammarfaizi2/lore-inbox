Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266882AbUBEV31 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 16:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266883AbUBEV3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 16:29:23 -0500
Received: from grassmarket.ucs.ed.ac.uk ([129.215.166.64]:36855 "EHLO
	grassmarket.ucs.ed.ac.uk") by vger.kernel.org with ESMTP
	id S266889AbUBEV2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 16:28:06 -0500
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Reply-To: s0348365@sms.ed.ac.uk
Organization: University of Edinburgh
To: Lenar =?iso-8859-1?q?L=F5hmus?= <lenar@vision.ee>,
       Arjen Verweij <A.Verweij2@ewi.tudelft.nl>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.2-mm1 aka "Geriatric Wombat"
Date: Thu, 5 Feb 2004 21:30:30 +0000
User-Agent: KMail/1.6
References: <20040205014405.5a2cf529.akpm@osdl.org> <200402051357.04005.s0348365@sms.ed.ac.uk> <4022505B.1020900@vision.ee>
In-Reply-To: <4022505B.1020900@vision.ee>
Cc: Luis Miguel =?iso-8859-1?q?Garc=EDa?= <ktech@wanadoo.es>,
       linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402052130.30344.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 February 2004 14:16, you wrote:
> Alistair John Strachan wrote:
> >On Thursday 05 February 2004 09:44, Andrew Morton wrote:
> >
> >
> >Still doesn't boot on my nForce 2 system, hangs while probing PDC RAID
> > card. Confirmed from 2.6.2-rc3-mm1 that it was likely related to ACPI
> > changes, but reverting bk-acpi.patch makes no difference.
> >
> >I'd like to test mainline, but I'm using gcc 3.4 snapshot, so I'll try
> > later today with 2.6.2 + linus.patch.
>
> Same here, hangs probing hpt366 ide controller. After some time says:
>
> hde: lost interrupt
>
> boots ok with pci=noacpi
>
> Lenar

This fix doesn't work for me because I get problems if I disable ACPI IRQ 
routing and still have apic enabled. Normally these problems would be 
gracefully solved, but my USB HCD complains about not having been assigned an 
IRQ.

This ACPI problem is definitely present in mainline, so this is a regression 
at least on my nForce 2.

If this is helpful, in 2.6.2-rc1-mm1 I would see:

..MPBIOS bug: 8254 timer not connected to IO-APIC.

This error seemed to be harmless and made no difference to the kernel while 
booting. It's been like that since latter 2.5 kernels, so that's quite a long 
time. The board is an EPoX 8RDA+ in case this is a vendor bug.

Now, instead, I see (in 2.6.2 and 2.6.2-mm1):

IOAPIC[0]: Invalid reference to IRQ 0

Later my kernel hangs when detecting hde, as described in another thread.
pci=noacpi allows me to get to init, but it breaks my USB HCD.

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/AI Undergraduate
contact:    7/10 Darroch Court,
            University of Edinburgh.
