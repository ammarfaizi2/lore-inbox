Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131219AbQKRCpC>; Fri, 17 Nov 2000 21:45:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131341AbQKRCox>; Fri, 17 Nov 2000 21:44:53 -0500
Received: from freya.yggdrasil.com ([209.249.10.20]:62369 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S131219AbQKRCog>; Fri, 17 Nov 2000 21:44:36 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Fri, 17 Nov 2000 18:14:24 -0800
Message-Id: <200011180214.SAA06997@adam.yggdrasil.com>
To: jgarzik@mandrakesoft.com
Subject: Re: sunhme.c patch for new PCI interface (UNTESTED)
Cc: davem@redhat.com, linux-kernel@vger.kernel.org, willy@meta-x.org,
        wtarreau@yahoo.fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:
>[...] the cost of incorrectly
>using __initdata when __devinitdata was correct is that the user's
>KERNEL WILL CRASH when the notebook is inserted or removed from such a
>docking station, even when the kernel is built with CONFIG_HOTPLUG.

	 My statement above, without some missing qualification, is wrong.
I should have qualified this statement more carefully.  (I'm sure the
flames are already in the mail about this.)  The kernel will crash in
any case if the relevant driver does not support hot plugging.and the
notebook is being removed with the PCI driver still loaded.

	For drivers that do not support hot plugging, we could use
__initdata instead of __devinitdata, since they will crash in any
case.  However, violating the instructions in Documentation/pci.txt
("The ID table array should be marked __devinitdata") in this way
will provoke a slew of driver bugs as the over one hundred remaining
PCI drivers are converted to the new PCI interface and some authors
overlook the need to change the MODULE_DEVICE_TABLE storage class.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
