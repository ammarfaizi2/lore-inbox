Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261746AbVAYA0m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261746AbVAYA0m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 19:26:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbVAXXVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 18:21:25 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:191 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261703AbVAXW4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 17:56:30 -0500
Date: Mon, 24 Jan 2005 17:09:34 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: David Sims <dpsims@virtualdave.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sata_vsc problem.... Please help me.
Message-ID: <20050124190934.GA15501@logos.cnet>
References: <Pine.LNX.4.21.0501241600520.817-100000@ernie.virtualdave.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0501241600520.817-100000@ernie.virtualdave.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2005 at 04:09:08PM -0600, David Sims wrote:
> Hi,
> 
>   With kernel 2.6.10 on Intel (Dell Powervault 745N).... When I insert the
> sata_vsc module via 'modprobe sata_vsc' from the command line, the module
> immediately recognizes the controller card and then enumerates the
> attached disks. During this process I am getting errors logged in syslog
> for each disk as follows:
> 
> Jan 24 13:55:37 linux kernel: irq 3: nobody cared!
> Jan 24 13:55:37 linux kernel:  [<c0128972>] __report_bad_irq+0x22/0x90
> Jan 24 13:55:37 linux kernel:  [<c0128a68>] note_interrupt+0x58/0x90
> Jan 24 13:55:37 linux kernel:  [<c01285f8>] __do_IRQ+0xd8/0xe0
> Jan 24 13:55:37 linux kernel:  [<c0103a7a>] do_IRQ+0x1a/0x30
> Jan 24 13:55:37 linux kernel:  [<c010254a>] common_interrupt+0x1a/0x20
> Jan 24 13:55:37 linux kernel:  [<c0114fc0>] __do_softirq+0x30/0x90
> Jan 24 13:55:37 linux kernel:  [<c0115055>] do_softirq+0x35/0x40
> Jan 24 13:55:37 linux kernel:  [<c0103a7f>] do_IRQ+0x1f/0x30
> Jan 24 13:55:37 linux kernel:  [<c010254a>] common_interrupt+0x1a/0x20
> Jan 24 13:55:37 linux kernel:  [<c0100590>] default_idle+0x0/0x40
> Jan 24 13:55:37 linux kernel:  [<c01005b4>] default_idle+0x24/0x40
> Jan 24 13:55:37 linux kernel:  [<c010063e>] cpu_idle+0x2e/0x40
> Jan 24 13:55:37 linux kernel:  [<c03d277b>] start_kernel+0x15b/0x190
> Jan 24 13:55:37 linux kernel: handlers:
> Jan 24 13:55:37 linux kernel: [<c02471e0>] (ide_intr+0x0/0x120)
> Jan 24 13:55:37 linux kernel: [<c02471e0>] (ide_intr+0x0/0x120)
> Jan 24 13:55:37 linux kernel: [<e08ef250>] (vsc_sata_interrupt+0x0/0xa0
> [sata_vsc])
> Jan 24 13:55:37 linux kernel: Disabling IRQ #3
> 
> and in /proc/interrupts the count for irq3 advances by 500,000 (i.e.,
> 100,000 for the controller and 100,000 for each attached disk).....
> 
> 
>   It seems to me that this driver is initializing itself and enabling
> interrupts before it is fully loaded and ready to deal with them.... 
> 
>   If I insert the module during the boot up process, the machine just
> hangs trying to read/identify the first disk... 
> 
>   Is there a way to disable or ignore these interrupts until the driver is
> fully loaded, the disks are identified and all of the necessary
> housekeeping is finished and the driver is finished loading?? 
>
>   Once the sata_vsc module finishes identifying the attached drives and
> the 'modprobe sata_vsc' returns to the command prompt the errors stop
> coming and it seems to work just fine.... You can fdisk and format the
> disks and all is well... If I could just get it load at boot time I would
> be happy....
> 
>   Any advice would be welcome at this point. ;)


You can use the following to disable the interrupt debugging: 

Documentation/kernel-parameters.txt:

        noirqdebug      [IA-32] Disables the code which attempts to detect and
                        disable unhandled interrupt sources.

But there is definately something wrong with the driver. Jeff?





