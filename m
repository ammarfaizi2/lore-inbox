Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266727AbUFYVXy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266727AbUFYVXy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 17:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266855AbUFYVXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 17:23:54 -0400
Received: from iris-63.mc.com ([63.96.239.5]:34295 "EHLO mc.com")
	by vger.kernel.org with ESMTP id S266727AbUFYVXw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 17:23:52 -0400
Subject: DRAM and PCI devices at same physical address
From: Matt Sexton <sexton@mc.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1088198580.29697.62.camel@dhcp_client-120-140>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 25 Jun 2004 17:23:00 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a dual Xeon system with the Lindenhurst (E7710) chip set and 1 GB
of memory.  In order to reserve a very large block of memory for a
(user-space) device driver I am writing, I pass "mem=XX" to the kernel
at boot time.  Unfortunately, /proc/pci shows two devices now appearing
in the reserved upper memory range.  

For instance, if I set "mem=768M", the following two entries appear in
/proc/pci:

  Bus  0, device   1, function  0:
    System peripheral: PCI device 8086:3594 (Intel Corp.) (rev 4).
      Non-prefetchable 32 bit memory at 0x30000000 [0x30000fff].

  Bus  0, device  31, function  1:
    IDE interface: Intel Corp. 82801EB Ultra ATA Storage Controller (rev
2).
      IRQ 18.
      I/O at 0x14a0 [0x14af].
      Non-prefetchable 32 bit memory at 0x30001000 [0x300013ff].


The devices always appear right after the limit I specify on the kernel
boot line.  If I specify "mem=512M", then the first device appears at
0x20000000.  If I specify nothing, then it appears at 0x40000000.  All
other PCI devices show up at addresses of 0xDD000000 and above.

Is there any way to prevent these devices from showing up in the
physical address range of my reserved memory?

Should they be appearing there at all?  Does Linux make any guarantees
when there is more physical memory than specified by "mem=" ?

Please CC me on any responses.

Thank you,
Matt Sexton
sexton@mc.com


