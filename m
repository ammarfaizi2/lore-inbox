Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131466AbRACNFw>; Wed, 3 Jan 2001 08:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131524AbRACNFb>; Wed, 3 Jan 2001 08:05:31 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:26872 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S131466AbRACNF1>; Wed, 3 Jan 2001 08:05:27 -0500
Message-ID: <3A531DD1.F5A691DC@uow.edu.au>
Date: Wed, 03 Jan 2001 23:40:49 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Miles Lane <miles@megapathdsl.net>
CC: Linus Torvalds <torvalds@transmeta.com>,
        David Brownell <david-b@pacbell.net>, linux-kernel@vger.kernel.org
Subject: Re: Prerelease kernel will not hotplug a USB host-controller when it is 
 inserted into a Cardbus slot.
In-Reply-To: <3A53187B.9030601@megapathdsl.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles Lane wrote:
> 
> Hi Linus and Co.,
> 
> I am writing to let you know that in all test12-pre6+ kernels,
> I get a "Bad PCI invocation" error when hotplug attempts to
> handle the insertion of a USB host-controller into a Cardbus
> slot.

That message is coming from your hotplug scripts.

At approximately test12-o'clock the following change was made:

diff -u --recursive --new-file t12p7/linux/drivers/pci/pci.c linux/drivers/pci/pci.c
--- t12p7/linux/drivers/pci/pci.c       Thu Dec  7 15:56:26 2000
+++ linux/drivers/pci/pci.c     Thu Dec  7 12:21:51 2000
@@ -360,9 +360,9 @@
        if (!hotplug_path[0])
                return;
 
-       sprintf(class_id, "PCI_CLASS=%X", pdev->class);
-       sprintf(id, "PCI_ID=%X/%X", pdev->vendor, pdev->device);
-       sprintf(sub_id, "PCI_SUBSYS_ID=%X/%X", pdev->subsystem_vendor, pdev->subsystem_device);
+       sprintf(class_id, "PCI_CLASS=%04X", pdev->class);
+       sprintf(id, "PCI_ID=%04X:%04X", pdev->vendor, pdev->device);
+       sprintf(sub_id, "PCI_SUBSYS_ID=%04X:%04X", pdev->subsystem_vendor, pdev->subsystem_device);
        sprintf(bus_id, "PCI_SLOT_NAME=%s", pdev->slot_name);
 
        i = 0;

So I guess your PCI hotplug script hasn't caught up with this
change in the format of its arguments.

-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
