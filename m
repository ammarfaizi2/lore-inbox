Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129586AbQKWCtX>; Wed, 22 Nov 2000 21:49:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129529AbQKWCtM>; Wed, 22 Nov 2000 21:49:12 -0500
Received: from [209.249.10.20] ([209.249.10.20]:54982 "EHLO
        freya.yggdrasil.com") by vger.kernel.org with ESMTP
        id <S129514AbQKWCsw>; Wed, 22 Nov 2000 21:48:52 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Wed, 22 Nov 2000 18:18:48 -0800
Message-Id: <200011230218.SAA04398@baldur.yggdrasil.com>
To: jgarzik@mandrakesoft.com
Subject: Re: Patch(?): pci_device_id tables for linux-2.4.0-test11/drivers/block
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>"Adam J. Richter" wrote:
>>         Just to avoid duplication of effort, I am posting this preliminary
>> patch which adds PCI MODULE_DEVICE_TABLE declarations to the three PCI
>> drivers in linux-2.4.0-test11/drivers/block.  In response to input from
>> Christoph Hellwig, I have reduced my threshhold on using named initializers
>> to three entries, although I think that may be going to far, as I would
>> really like to keep the number of files that initialize the pci_device_id
>> arrays this way low so that changing struct pci_device_id remains feasible.

>*This* is the over-engineering attitude I was talking about.  The only
>reason why you are preferring named initializers is because
>pci_device_id MIGHT be changed.  And if it is changed, it makes the
>changeover just tad easier.

	It is also much easier to spot an initialization bug, if, say,
a class is being initialized with a class_mask.  It also make the
code much more self-documenting.  I frequently have to bring up a copy
of include/linux/pci.h to decipher usb_devicde_id tables.

>For that, you ugly up the code and make it
>more difficult to maintain.

	I think this makes it easier to maintain, especially by
driver authors who want to think more about their pet hardware than
how a generic kernel data structure is ordered.

	Also bear in mind that once these drivers are ported to the
new PCI interface, many will use pci_device_id->driver_data, which
will cause all of the entries that are not in "field:value" form to
no longer fit on one line anyhow. 
	

>_I_ am one of the people that works on maintaining these random PCI
>drivers that no one gives a shit about.

	I don't believe that using "field:value" format makes centralized
maintenance harder, but, if you find it that way, you should consider
the position of driver author a driver author who is more
knowledgeable about the hardware and has less repetitive need to
memorize the arrangement of an obscure kernel data structure.  The
__initdata vs __devinitdata for the pci_device_id tables is the same
sort of issue.  I believe that named initializers also make it easier
for developers whose focus is not on the central kernel data structures
to spot and fix bugs and develop new drivers, and that this is a more
scalable approach to kernel development.

	In any case, if you want, I would be happy to send you patches
that include only the changes that do the initilization anonymously.
Until those appear in Linus's releases, I see it is a more definitely
positive contribution on my part to focus on writing pci_device_id
tables for other drivers that lack them.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
