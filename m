Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261894AbVAZBs1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261894AbVAZBs1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 20:48:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261915AbVAZBs1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 20:48:27 -0500
Received: from ernie.virtualdave.com ([198.216.116.246]:51218 "EHLO
	ernie.virtualdave.com") by vger.kernel.org with ESMTP
	id S261894AbVAZBrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 20:47:51 -0500
Date: Tue, 25 Jan 2005 19:47:49 -0600 (CST)
From: David Sims <dpsims@virtualdave.com>
To: linux-kernel@vger.kernel.org
Subject: Re: sata_vsc, sata_core problem.... Please help me. (another clue)
Message-ID: <Pine.LNX.4.21.0501251943240.9764-100000@ernie.virtualdave.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Mon, Jan 24, 2005 at 02:03:38PM -0600, David Sims wrote:
> > Hi,
> > 
> >   With kernel 2.6.10 on Intel (Dell Powervault 745N).... When I insert the
> > sata_vsc module via 'modprobe sata_vsc' from the command line, the module
> > immediately recognizes the controller card and when it then enumerates the
> > attached disks, I am getting errors logged in syslog for each disk as
> > follows:
> > 
> > Jan 24 13:55:37 linux kernel: irq 3: nobody cared!
> > Jan 24 13:55:37 linux kernel:  [<c0128972>] __report_bad_irq+0x22/0x90
> > Jan 24 13:55:37 linux kernel:  [<c0128a68>] note_interrupt+0x58/0x90
> > Jan 24 13:55:37 linux kernel:  [<c01285f8>] __do_IRQ+0xd8/0xe0
> > Jan 24 13:55:37 linux kernel:  [<c0103a7a>] do_IRQ+0x1a/0x30
> > Jan 24 13:55:37 linux kernel:  [<c010254a>] common_interrupt+0x1a/0x20
> > Jan 24 13:55:37 linux kernel:  [<c0114fc0>] __do_softirq+0x30/0x90
> > Jan 24 13:55:37 linux kernel:  [<c0115055>] do_softirq+0x35/0x40
> > Jan 24 13:55:37 linux kernel:  [<c0103a7f>] do_IRQ+0x1f/0x30
> > Jan 24 13:55:37 linux kernel:  [<c010254a>] common_interrupt+0x1a/0x20
> > Jan 24 13:55:37 linux kernel:  [<c0100590>] default_idle+0x0/0x40
> > Jan 24 13:55:37 linux kernel:  [<c01005b4>] default_idle+0x24/0x40
> > Jan 24 13:55:37 linux kernel:  [<c010063e>] cpu_idle+0x2e/0x40
> > Jan 24 13:55:37 linux kernel:  [<c03d277b>] start_kernel+0x15b/0x190
> > Jan 24 13:55:37 linux kernel: handlers:
> > Jan 24 13:55:37 linux kernel: [<c02471e0>] (ide_intr+0x0/0x120)
> > Jan 24 13:55:37 linux kernel: [<c02471e0>] (ide_intr+0x0/0x120)
> > Jan 24 13:55:37 linux kernel: [<e08ef250>] (vsc_sata_interrupt+0x0/0xa0
> > [sata_vsc])
> > Jan 24 13:55:37 linux kernel: Disabling IRQ #3
> > 
> > 
> >   It seems to me that this driver is initializing itself and enabling
> > interrupts before it is fully loaded and ready to deal with them.... 
> > 
> >   If I insert the module during the boot up process, the machine just
> > hangs trying to read/identify the first disk... 
> > 
> >   Is there a way to disable or ignore these interrupts until the driver is
> > fully loaded, the disks are identified and all of the necessary
> > housekeeping is finished and the driver is finished loading?? 
> > 
> > Once the sata_vsc module finishes identifying the attached drives and
> > the 'modprobe sata_vsc' returns to the command prompt the errors stop
> > coming and it seems to work just fine.... You can fdisk and format the
> > disks and all is well... If I could just get it load at boot time I
> > would be happy....
> >
> > Any advice would be welcome at this point. ;)
> >
> > TIA,
> >
> > Dave Sims
> 
> 
> Sorry, but I really don't have any clues at this point.  The driver is
> really more a set of subroutines, and most of this stuff is done by the
> libata and scsi i/f.
> 
> jeremy
> 

Hi again,

  This may sound like a dumb idea, but I decided to remove all the disks
from the SATA controller and fiddle with the module a
bit... So... Interestingly enough, the module loads without a peep both at
the command line AND when autoloading from rc.modules AND when builtin to
a monolithic kernel!! So... The interrupt problem is coming when the
controller tries to enumerate its disks... I have verified this by
unloading the module, installing one disk, and then reinserting the
module... I get 200,000 additional interrupts on IRQ3 in /proc/interrupts
and the normal error message shown above logged to syslog for the one
disk... 

  What do you think about that??

Dave


