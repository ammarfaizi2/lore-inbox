Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262905AbSKJBoJ>; Sat, 9 Nov 2002 20:44:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262908AbSKJBoJ>; Sat, 9 Nov 2002 20:44:09 -0500
Received: from h-64-105-136-52.SNVACAID.covad.net ([64.105.136.52]:37803 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S262905AbSKJBoI>; Sat, 9 Nov 2002 20:44:08 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sat, 9 Nov 2002 17:50:42 -0800
Message-Id: <200211100150.RAA27228@baldur.yggdrasil.com>
To: grundler@dsl2.external.hp.com
Subject: Re: [parisc-linux] Untested port of parisc_device to generic device interface
Cc: andmike@us.ibm.com, hch@lst.de, James.Bottomley@steeleye.com,
       linux-kernel@vger.kernel.org, mochel@osdl.org,
       parisc-linux@lists.parisc-linux.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant Grundler writes:
>Documentation/driver-model/overview.txt:
>| Note also that it is at the _end_ of struct pci_dev. This is
>| to make people think about what they're doing when switching between the bus
>| driver and the global driver; and to prevent against mindless casts between
>| the two.
>
>Until this changes, I don't see this as a useful replacement for
>either PCI or parisc devices. The "mindless casts" can be fixed.
>But without the ability to easily go from generic device type to
>bus specific type, people will just get lost in the maze of pointers.

	linux-2.5.46/include/linux/kernel.h already defines
container_of(ptr_to_element, parent_struct, element_name).

>From <linux/pci.h>:
#define to_pci_dev(n) container_of(n, struct pci_dev, dev)

>From <linux/usb.h>:
#define to_usb_device(d) container_of(d, struct usb_device, dev)

>From <asm-parisc/hardware.h> with my parisc device patch:
static inline struct parisc_device *to_parisc_dev(struct device *dev)
{
        return container_of(dev, struct parisc_device, device);
}

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Miplitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
