Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264192AbUFQXiH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264192AbUFQXiH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 19:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264197AbUFQXiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 19:38:07 -0400
Received: from out014pub.verizon.net ([206.46.170.46]:31470 "EHLO
	out014.verizon.net") by vger.kernel.org with ESMTP id S264192AbUFQXiD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 19:38:03 -0400
Date: Thu, 17 Jun 2004 21:07:51 +0000
From: Eric Buddington <ebuddington@verizon.net>
To: linux-kernel@vger.kernel.org
Subject: SATA 3112 errors on 2.6.7
Message-ID: <20040617210751.GA28519@pool-141-154-165-127.wma.east.verizon.net>
Reply-To: ebuddington@wesleyan.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Organization: ECS Labs
X-Eric-Conspiracy: there is no conspiracy
X-Authentication-Info: Submitted using SMTP AUTH at out014.verizon.net from [141.154.165.127] at Thu, 17 Jun 2004 18:38:02 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kind people,

I believe this bug has been reported previously, but I will risk
repetition. (c.f. http://lkml.org/lkml/2004/5/22/124 and
http://www.uwsg.iu.edu/hypermail/linux/kernel/0404.0/0736.html)

Partial hardware list:

Athlon 950
00:00.0 Host bridge: Silicon Integrated Systems [SiS] 730 Host (rev 02)
00:0e.0 RAID bus controller: CMD Technology Inc: Unknown device 3112 (rev 02)
00:0f.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
00:0f.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)

I mention the bttv card, since it generates a lot of PCI traffic and
may tax the system a bit.

Under kernels 2.6.6-mm5 and 2.6.7, I get the following errors after a
few hours or days (no obvious trigger or pattern), which hang most of
the machine (Alt-SysRq still works, machine still pings, but shells
and sshd2 freeze):

----------------------------
ata1: DMA timeout, stat 0x1
ATA: abnormal status 0x58 on port 0xCF819087
scsi0: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 03 ca 47 00 00 00 00
Current sda: sense key Medium Error
Additional sense: Unrecovered read error - auto reallocate failed
end_request: I/O error, dev sda, sector 248391
ATA: abnormal status 0x58 on port 0xCF819087
ATA: abnormal status 0x58 on port 0xCF819087
ATA: abnormal status 0x58 on port 0xCF819087
----------------------------

Reiserfsck and badblocks both report that everything is just ducky
(though reiserfs replays some transactions on reboot, of course). The
freeze has happened about half a dozen times so far.

I am willing to test patches and report back.  I will try moving the
SATA card to another slot in the meantime (as it was sharing an
interrupt with an (idle) audio card).

Eric Buddington
