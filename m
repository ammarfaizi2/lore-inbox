Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269696AbTHKJR0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 05:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271380AbTHKJR0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 05:17:26 -0400
Received: from lidskialf.net ([62.3.233.115]:49539 "EHLO beyond.lidskialf.net")
	by vger.kernel.org with ESMTP id S269696AbTHKJRY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 05:17:24 -0400
From: Andrew de Quincey <adq_dvb@lidskialf.net>
To: Andrew Morton <akpm@osdl.org>, Benjamin Weber <shawk@gmx.net>
Subject: Re: [BUG mm-tree of test2/test3] nforce2-acpi-fixes breaks via ide controller
Date: Mon, 11 Aug 2003 10:17:22 +0100
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl,
       akpm@digeo.com
References: <1060533632.3886.19.camel@athxp.bwlinux.de> <20030810143220.0a4d1e69.akpm@osdl.org>
In-Reply-To: <20030810143220.0a4d1e69.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308111017.23100.adq_dvb@lidskialf.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Since the test2-mm1 sources I get the following error during boot:
> >
> > VP_IDE: IDE controller at PCI slot 0000:00:11.1
> > VP_IDE: (ide_setup_pci_device:) Could not enable device.
> >
> > This results in not being able to use DMA for any devices connected to
> > my IDE controller. Hdparm says permission denied when I do a hdparm -d1
> > /dev/hda e.g.
> >
> > I checked with a vanilla kernel and everything is working fine there.
> > Going through the broken-out patches from Andrew Morton I found the one
> > patch that caused the above behavior: nforce2-acpi-fixes.patch

Hi, thanks for tracking down the problem

Can you send me: 
a dmesg with the patch (i.e. when it fails (essential))
a dmesg without the patch (i.e. when it succeeds)
the output of /proc/interrupts (when it fails (if possible)) 
the output of /proc/interrupts (when it succeeds) 
the output of /proc/acpi/dsdt
the output of lspci -vvv

(the last two can be either with or without the patch)

Sorry about the long list, but this is what I need to diagnose these problems.


> > I do not know why it should interfere with my via stuff, but it does. A
> > vanilla test3 kernel is working fine as well, whereas test3-mm1 shows
> > the same error as before with test2-mmX.
>
> Me either.  Unfortunately that patch does five different things so we
> cannot easily narrow it down further.

Yeah, I know. My next patch is likely to have to do even more unfortunately. 
Found quite a number more issues with IRQs.

