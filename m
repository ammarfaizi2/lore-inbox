Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136403AbREINEQ>; Wed, 9 May 2001 09:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136400AbREINEF>; Wed, 9 May 2001 09:04:05 -0400
Received: from mail.ntplx.net ([204.213.176.10]:43960 "EHLO mail.ntplx.net")
	by vger.kernel.org with ESMTP id <S136401AbREINDe>;
	Wed, 9 May 2001 09:03:34 -0400
Message-ID: <3AF93F2B.8EC5F912@ntplx.net>
Date: Wed, 09 May 2001 08:59:23 -0400
From: Benedict Bridgwater <bennyb@ntplx.net>
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.2.15-4mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.4-ac5 aic7xxx causes hang on my machine
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Gibbs wrote:

> >I have a dual ppro 200MHZ W6LI motherboard.  I put 2.4.4-ac5 on last
> >night, and the machine hung at Freeing unused Kernel memory.  I
> >selectively backed off what I thought were relevant patches.  I got to
> >aic7xxx, and ac5 without it worked. I attached /proc/scsi/aic7xxx/0.
>
> This problem was fixed in rev. 6.1.13 of the aic7xxx driver.

Is this the same bug that would have caused SCSI timeouts/retries on an
Adaptec 2940 UW with a stock 2.4.3 kernel (Mandrake 8.0/Redhat 7.1)?
I've been trying to install Mandrake 8.0 from a  CD to a HD both
attached to a 2940 UW (Intel 440 FX motherboard), and the install took
hours of mostly zero CD/HD activity time, although it eventually
completed (the install fails to boot, though).

This has been reported to both Mandrake and Redhat:

http://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=29555

I've been trying to find out if there's a fix (if it's aic7xxx 6.1.13
that's great!), but Redhat seem to believe it's a 2.4 kernel PCI bug:

Doug Ledford, from bugzilla:

> For clarification sake, it's not that the BIOS is mapping IRQ's wrong, and it's
> not that we have lost any functionality since the 2.2 kernel PCI code.  Quite
> the opposite, it's that PCI functionality has been added since the 2.2 kernel. 
> Specifically, the 2.4 kernel supports the notion of hot-plug PCI devices.  That
> requires that the kernel PCI layer know about/assign all the address space and
> IRQ resources to the various slots so that if sometime after booting up someone
> adds a new PCI card that has a PCI bridge chip, then the PCI layer has to be
> able to assign I/O and IRQ resources to the bridge chip itself, and those I/O
> and IRQ resources have to come from the pool of resources already allocated to
> the bus that the card was plugged into.  So, in order to insure that we will
> always be able to accept a hot plug card, the PCI layer in the 2.4 kernel now
> re-organizes those PCI resources at boot time to make sure that it is possible
> to plug a card with a PCI bridge chip into every PCI slot if the user so
> wishes.  In this process, the PCI code in the 2.4 kernel is evidently messing up
> the IRQ assignment on the Adaptec chipset.  This *only* happens on the L440GX
> motherboard from Intel as far as we can tell, and the root cause of the mistake
> hasn't been isolated any further than what I've told you here.  The reason that
> enabling SMP or UP-IOAPIC support solves the problem is that when IOAPIC support
> is enabled (which happens automatically with SMP support, or explicitly with UP
> kernels if you turn on UP-IOAPIC support), it runs *after* the PCI resource
> allocation code, and it re-routes the interrupts according the the computers MP
> table.  By doing that, it undoes whatever mistake the PCI code is making, and
> things work.  *THIS IS NOT A FIX*  The fact that it undoes the mistake the PCI
> code makes does not make the PCI code any better!  The PCI code still needs
> fixed.

Ben

Please CC any reply to bennyb@ntplx.net (I'm not a member of the list)
