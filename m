Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132057AbREIUwx>; Wed, 9 May 2001 16:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132318AbREIUwd>; Wed, 9 May 2001 16:52:33 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:15378 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S132057AbREIUwV>; Wed, 9 May 2001 16:52:21 -0400
Date: Wed, 9 May 2001 16:52:24 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: <proski@fonzie.nine.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Pete Zaitcev <zaitcev@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Patch to make ymfpci legacy address 16 bits
In-Reply-To: <3AF9A726.BF819B30@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0105091627440.5113-100000@fonzie.nine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jeff!

Thanks for your very (!!!) fast response :-)

> > http://www.red-bean.com/~proski/linux/ymfpci_pm.diff
>
> Why not use pci_driver::{suspend,resume} ?

I'm just a bit conservative. There are several drivers that don't use this
mechanism, notably trident and maestro. Do you think it's safe to switch
all sound drivers to the mechanism you are proposing?

I'm worried about a comment in maestro.c:

                /*
                 * we'd also like to find out about
                 * power level changes because some biosen
                 * do mean things to the maestro when they
                 * change their power state.
                 */

If we switch to pci_driver::{suspend,resume}, will it ever be possible to
add support for any messages other than PM_SUSPEND and PM_RESUME? Probably
yes, but only in the PCI driver dispatches them.

By the way, I don't like the way how pm_unregister_all() is used in
several sound drivers. If a unit is removed its power manager callback
remains registered until the module is unloaded.

> In ACPI land the kernel should save and restore the PCI device config
> space and the PCI bus config space.  It is probably that similar is
> necessary under APM.

I have never seen any sound driver doing that. I also know that PCI
settings are saved by some BIOSes on some hardware.

I'm sorry if I put it wrong. Perhaps I should have added a few IMHO.

PS. The 0x20 bit in 0x40 is not set if I load CVS ALSA drivers, even if I
set it before loading the driver. It's a problem with the kernel driver
only and should be fixed IMHO.

-- 
Regards,
Pavel Roskin

