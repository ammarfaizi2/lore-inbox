Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288810AbSATQxg>; Sun, 20 Jan 2002 11:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288814AbSATQx0>; Sun, 20 Jan 2002 11:53:26 -0500
Received: from pcow058o.blueyonder.co.uk ([195.188.53.98]:15123 "EHLO
	blueyonder.co.uk") by vger.kernel.org with ESMTP id <S288810AbSATQxK>;
	Sun, 20 Jan 2002 11:53:10 -0500
Date: Sun, 20 Jan 2002 16:53:58 +0000
From: Chris Wilson <jakdaw@lists.jakdaw.org>
To: linux-kernel@vger.kernel.org
Subject: 2.4.17 Hard Lockup w. PDC20268
Message-Id: <20020120165358.632817a3.jakdaw@lists.jakdaw.org>
Organization: Hah!
X-Mailer: Sylpheed version 0.6.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

        I'm getting hard lockups when if I try to do any heavy IO on
drives connected to a PDC20268 UDMA-100 controller and my motherboards
onboard VIA IDE chipset.

for a in hda hdc hde hdg; do dd if=/dev/$a of=/dev/null bs=1M & done

.. will lock the system in a second or so. No oops, no nothing. Magic
SysRq doesn't work. Activity on just hde & hdg (which are on the promise
controller) is fine - as is activty just on the VIA controller... but
heavy disk IO on both at the same time just locks it up.

My system is Dual PIII-700 with 1gig RAM
Mobo is VIA based:
 00:00.0 Host bridge: VIA Technologies, Inc. VT82C691 [Apollo PRO] (rev c4)
 00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3 AGP]
 00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 22)
 00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 10)
 00:07.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 10)
 00:07.3 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 10)
 00:07.4 SMBus: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
The promise card is a PDC20268 UDMA-100 "TX2"

Problem appears with both Uniprocessor or SMP kernel. Although it takes a
few more seconds on the uniprocessor kernel. I've tried enabling the NMI
watchdog but cannot get an OOPS out of it.

I've only just got the card so I've not tried older/different kernels yet.

Any suggestions anyone?

Also I've noticed that when using a striped (using LVM) filesystem over
two 100gig drives on the promise card I can achieve about 70-75 MB/sec
when writing (the disks each do 40MB/sec according to hdparm -t) but only
50MB/sec when reading. I know that the VIA chipset has been slagged off in
the past for having pants PCI performance - but is it really this bad?

Regards,

Chris

-- 
Chris Wilson
jakdaw@lists.jakdaw.org







