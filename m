Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262422AbTJNLdc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 07:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262432AbTJNLdc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 07:33:32 -0400
Received: from smtrly01.smartm.com ([158.116.149.131]:51467 "EHLO
	smtrly01.smartm.com") by vger.kernel.org with ESMTP id S262422AbTJNLd3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 07:33:29 -0400
Message-ID: <903E17B6FF22A24C96B4E28C2C0214D70104BDD4@sr-bng-exc01.int.tsbu.net>
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: "Daheriya, Adarsh" <Adarsh.Daheriya@fci.com>
To: "'scottm@somanetworks.com'" <scottm@somanetworks.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: 
Date: Tue, 14 Oct 2003 17:07:31 +0530
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
X-OriginalArrivalTime: 14 Oct 2003 11:32:21.0234 (UTC) FILETIME=[D4D10520:01C39246]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi Scott,

i am using your hot swap driver for one of our boards here. I have
back-ported the driver to 2.4.18 kernel.

the problem is as follows -
i have a board in the system slot of the chassis for which i am running the
hot swap driver.
when i hot insert another board (the configuration is given later) on some
peripheral slot, i am not able to allocate resources for some of the devices
beyond that.

the hot swapped board has got a bridge that provides two pmc slots. I have
two bridges on these pmc slots and they provide 3 pci slots each. I have two
82559 (e100) ethernet cards beyond the two bridges, one 82559 for each. it
looks something like this

peripheral slot ----------- P2P Bridge (Sentinel) -- P2P Bridge (21154) --
82559 (resources  are  allocated)
                                                                  |
			                              -- P2P Bridge (21154)
-- 82559 (resources NOT allocated)

i am able to assign the resources for the first 82559 correctly and it
works, but for the other 81559 i am not able to assign resources.

the following dump will help to see that the driver is trying to assign
resources to the other 82559 from a wrong resource tree.
(The debug messages are added by me.)

----------------------------------------------------------------------------
-------------------------------
cpci_hotplug: cpci_configure_dev - enter
cpci_hotplug: assigning resource [0] (0000-0fff)
checking bus resource new (0000-0fff) of size 1000 with min 38000000
resources root->flags 0200 new->flags 0200
find_resource:root->start: 00000000 root->end:000fffff
find_resource: new->start: 38000000  new->end: 000fffff
allocate resource (prefetching) 0(38000000-fffff) failed.
  PCI: FAILED to allocate resource 0(38000000-fffff) for 05:08.0
cpci_hotplug: assigning resource [1] (0000-003f)
checking bus resource new (0000-003f) of size 0040 with min 1000
resources root->flags 0100 new->flags 0101
find_resource:root->start: 00000000 root->end:00000fff
find_resource: new->start: 00001000  new->end: 00000fff
allocate resource (prefetching) 1(1000-0fff) failed.
  PCI: FAILED to allocate resource 1(1000-0fff) for 05:08.0
cpci_hotplug: assigning resource [2] (0000-1ffff)
checking bus resource new (0000-1ffff) of size 20000 with min 38000000
resources root->flags 0200 new->flags 0200
find_resource:root->start: 00000000 root->end:000fffff
find_resource: new->start: 38000000  new->end: 000fffff
allocate resource (prefetching) 2(38000000-fffff) failed.
  PCI: FAILED to allocate resource 2(38000000-fffff) for 05:08.0
cpci_hotplug: finished assigning resources for 05:08.0
----------------------------------------------------------------------------
------------------------------------

Could you please give me some feed back to resolve this issue.

Regards,
-Adarsh.
