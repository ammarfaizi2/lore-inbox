Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129435AbRBLI1P>; Mon, 12 Feb 2001 03:27:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129568AbRBLI04>; Mon, 12 Feb 2001 03:26:56 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:10508 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129435AbRBLI0x>;
	Mon, 12 Feb 2001 03:26:53 -0500
Message-ID: <3A879E35.B1BDF098@mandrakesoft.com>
Date: Mon, 12 Feb 2001 03:26:29 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tobias Ringstrom <tori@tellus.mine.nu>
CC: James Brents <James@nistix.com>, Andrew Morton <andrewm@uow.edu.au>,
        Mark Hahn <hahn@coffee.psychology.mcmaster.ca>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: WOL failure after shutdown
In-Reply-To: <Pine.LNX.4.30.0102120903460.9447-100000@svea.tellus>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tobias Ringstrom wrote:
> 
> On Sun, 11 Feb 2001, James Brents wrote:
> 
> > Sorry, I wrote that in a hurry. Its a 3Com PCI 3c905C Tornado. I can
> > successfully use wakeonlan if I power off the machine immeadiatly after
> > turning it on. Using the shutdown command, which it will when I need it
> > to power back up, it will not work.
> > Im using a wakeonlan cable to my motherboard as well, not using wake
> > through PCI bus.
> > Kernel is 2.4.1
> > I appologize for not providing all required the specs in the original
> > message.
> 
> Try this patch.  It is against the zero-copy version of the driver, but
> I'm sure you can apply it, at least manually, to any 2.4 version.
> 
> Andrew, when can we expect to have WOL working in 2.4?
> 
> +/* Change from D3 (sleep) to D0 (active).
> +   Problem: The Cyclone forgets all PCI config info during the transition! */
> +static void acpi_wake(struct pci_dev *pdev)
[...]

Compare this code with pci_set_power_state() function in
drivers/pci/pci.c.

	Jeff



-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
