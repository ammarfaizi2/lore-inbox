Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265636AbRGHJnQ>; Sun, 8 Jul 2001 05:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266830AbRGHJnH>; Sun, 8 Jul 2001 05:43:07 -0400
Received: from anchor-post-33.mail.demon.net ([194.217.242.91]:45318 "EHLO
	anchor-post-33.mail.demon.net") by vger.kernel.org with ESMTP
	id <S265636AbRGHJnC>; Sun, 8 Jul 2001 05:43:02 -0400
Date: Sun, 8 Jul 2001 10:42:55 +0100
From: "Robert J.Dunlop" <rjd@xyzzy.clara.co.uk>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: stelian.pop@fr.alcove.com, m.ashley@unsw.edu.au, jun1m@mars.dti.ne.jp,
        t-kinjo@tc4.so-net.ne.jp, tridge@valinux.com,
        linux-kernel@vger.kernel.org
Subject: Re: PATCH: linux-2.4.7-pre3/drivers/char/sonypi.c would hang some non-Sony notebooks
Message-ID: <20010708104255.B1441@xyzzy.clara.co.uk>
In-Reply-To: <20010707180414.A3456@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010707180414.A3456@adam.yggdrasil.com>; from adam@yggdrasil.com on Sun, Jul 08, 2001 at 09:30:44AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

First off, it works for me on my VAIO PCG-Z600NE.


On Sun, Jul 08, 2001 at 09:30:44AM +0100, Adam J. Richter wrote:
> 	The pci_device_id tables in linux-2.4.7-pre3/drivers/char/sonypi.c
> claims that the driver wants to be loaded on all computers that have
> an that have a PCI device with vendor id PCI_VENDOR_ID_INTEL and
...
> "lspci -v" on my Sony Vaio Picturebook, I see that, while none of the
> PCI devices have Sony's vendor ID, a number of them have Sony's
> vendor ID as their subsystem vendor ID's.  So, I have implemented the


Just a niggle however. This still isn't a very good test to finding a
Sony laptop. What'll happen on machines that have any sort of Sony
plugin device ?

How's about we test for a machine that has a host bridge with the Sony
subvendor ID, rather than any device.


WARNING!! untested code.

static int __init sonypi_init_module(void) {
    struct pci_dev *dev;

    if ((dev = pci_find_class(PCI_CLASS_BRIDGE_HOST << 8, NULL)) == NULL)
	return -ENODEV;		/* Bizzare. No host bridge */

    if (dev->subsystem_vendor != PCI_VENDOR_ID_SONY)
	return -ENODEV;         /* Not a Sony machine */

    return pci_module_init(&sonypi_driver);
}


I guess this'll still pickup Sony desktops.
Perhaps we need a survey of lspci -nv results for sony and non-sony
machines ?


-- 
        Bob Dunlop
        rjd@xyzzy.clara.co.uk
        www.xyzzy.clara.co.uk
