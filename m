Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264960AbUHJPcr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264960AbUHJPcr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 11:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267486AbUHJPcq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 11:32:46 -0400
Received: from fmr05.intel.com ([134.134.136.6]:63146 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S264960AbUHJPaP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 11:30:15 -0400
Subject: Re: 2.6.8-rc4-mm1 : Hard freeze due to ACPI
From: Len Brown <len.brown@intel.com>
To: eric.valette@free.fr
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Karol Kozimor <sziwan@hell.org.pl>
In-Reply-To: <4118A500.1080306@free.fr>
References: <41189098.4000400@free.fr>  <4118A500.1080306@free.fr>
Content-Type: text/plain
Organization: 
Message-Id: <1092151779.5028.40.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 10 Aug 2004 11:29:39 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-10 at 06:35, Eric Valette wrote:
> Eric Valette wrote:
> > I tried 2.6.8-rc4-mm1 on my ASUS L3800C laptop (radeon 7500),
> defined > CONFIG_FB_MODE_HELPERS and I have got a hard freeze when
> starting X and 
> > framebuffer console with a lot of yellow dot on the bottom screen. 
> > Suddently I hear the fan meaning the machine is dead
> 
> OK I've reverted the most suspect change 
> (remove-unconditional-pci-acpi-irq-routing.patch) and it did not fix
> the 
> problem. As Karol Kozimor suspected ACPI, I then tried with acpi=off
> and then it boot but I will burn my CPU as fans are ACPI controlled...
> 
> So it is probably due to the bk-acpi.patch and more precisely the 
> difference between what was in 2.6.8-rc3-mm1 and 2.6.8-rc4-mm1.
> 
> Len, any proposal as candidate patches to revert?

bk-acpi.patch is unchanged between 2.6.8-rc3-mm1 to 2.6.8-rc3-mm2
So it would be interesting if you ran 2.6.8-rc3-mm2 to see if
something else broke your system at that point, or if the breakage
happened later.

>From 2.6.8-rc3-mm2 to 2.6.8-rc4-mm1 there are only two additional
patches in bk-acpi.patch.  I don't expect them to have any effect on
your system, they are these two:

asus_acpi.c from Karol
http://linux-acpi.bkbits.net:8080/linux-acpi-test-2.6.7/gnupatch@4117a219yRjkVomavWT8WoMdRg7KHA

pci_link.c - resume fix from Nathan
http://linux-acpi.bkbits.net:8080/linux-acpi-test-2.6.7/gnupatch@41114fe37ez5dnzmR96KT2DHr4-elA

I'll poke around the mm patch to see if anything else looks suspicious.

cheers,
-Len


