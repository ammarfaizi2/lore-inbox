Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319585AbSH2XNd>; Thu, 29 Aug 2002 19:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319587AbSH2XNd>; Thu, 29 Aug 2002 19:13:33 -0400
Received: from coffee.Psychology.McMaster.CA ([130.113.218.59]:6018 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S319585AbSH2XNb>; Thu, 29 Aug 2002 19:13:31 -0400
Date: Thu, 29 Aug 2002 19:25:19 -0400 (EDT)
From: Mark Hahn <hahn@physics.mcmaster.ca>
X-X-Sender: <hahn@coffee.psychology.mcmaster.ca>
To: James Di Toro <jditoro3@coastalcreditllc.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Passing kernel parameters
In-Reply-To: <5.1.0.14.0.20020829150955.02adf008@imap.coastalcreditllc.com>
Message-ID: <Pine.LNX.4.33.0208291905350.15955-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Unfortunately this is not working.  dmesg for ide still shows the following:
>          ide: Assuming 33MHz system bus speed for PIO modes; override with 
> idebus=xx
> 
> despite the fact that I've specified 'idebus=66' and the following lines note:
> 
>          VP_IDE: VIA vt82c596b (rev 12) IDE UDMA66 controller on pci00:07.1

note that it says *system* bus speed.  that is, the clock fed to the IDE 
controller (usually the PCI clock, 33 MHz).  this is NOT the transfer mode!

by lying to the driver that "idebus=66", all you accomplish is making your 
transfers half the speed they should be.  the driver says 
	"since the clock period is 15ns, and I want (say) udma33
	(16b every 60ns), I'll tell the controler to do 16b every 4 clocks."

alas, the real period is 30ns, so you get 16b every 120ns.  voila, udma16 ;(

summary: don't lie to the driver; the default is probably correct.

regards, mark hahn.

