Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932108AbVLBE6y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbVLBE6y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 23:58:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbVLBE6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 23:58:54 -0500
Received: from dsl081-060-252.sfo1.dsl.speakeasy.net ([64.81.60.252]:55716
	"EHLO vitelus.com") by vger.kernel.org with ESMTP id S932108AbVLBE6x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 23:58:53 -0500
Date: Thu, 1 Dec 2005 20:58:53 -0800
From: Aaron Lehmann <aaronl@vitelus.com>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Promise SATA oops
Message-ID: <20051202045853.GD3677@vitelus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running 2.6.14.2 on an x86_64 (Athlon X2, i.e. SMP) with a Promise
TX4 SATAII 150 controller. The night I set up the machine, I got a
Promise-related oops (null pointer dereference IIRC), but was foolish
enough not to write it down.  Since then, the machine has been
unstable, and I've suspected the same thing is recurring, but since I
use X it's very difficult to actually get at the oops. I ended up
setting up a ramdisk with a static busybox that I could use to poke
around if anything interesting happened. Just now everything using the
filesystem went into D-state, so I checked dmesg and saw uncorrectable
errors being reported on /dev/sdd. The system froze completely within
a minute. When I rebooted, I got the oops at the end of this message.
I was only able to copy the portion that fit on the screen. A second
reboot was sucessful. My RAID5 arrays are resyncing now, and I expect
that to complete normally because I've had to go through a lot of
resyncs since I set this system up and they were all sucessful. Once
that's done, I guess I'll run badblocks on sdd and see if anything
turns up. It would be a shame if that drive is bad, considering that
my 4 hard drives are brand new ones to replace a failed array I had
lots of problems with.

Process scsi_eh_3 (pid: 25, threadinfo fff81001fbc0000, task ffff81001fbbcf40)
Stack: ffffffff80274291 ffff81001fc0f800 ffff81001fb2a340 ffff81001fe78000
       ffffffff8026d524 ffff81001fe78948 ffff81001fb2a340 ffff81001fe78428
       ffffffff80280006 ffff81001fe78428
Call Trace:<ffffffff80274291>{scsi_device_unbusy+33} <ffffffff8026d524>{scsi_fin
ish_command+36}
       <ffffffff80280006>{ata_scsi_qc_complete+54} <ffffffff8027c32e>{ata_qc_com
plete+366}
       <ffffffff80281764>{pdc_eng_timeout+212} <ffffffff802716f0>{scsi_error_han
dler+0}
       <ffffffff8027fae5>{ata_scsi_error+21} <ffffffff80271790>{scsi_error_handl
er+160}
       <ffffffff80149430>{keventd_create_kthread+0} <ffffffff802716f0>{scsi_erro
r_handler+0}
       <ffffffff80149430>{keventd_create_kthread+0} <ffffffff801496a9>{kthread+2
17}
       <ffffffff80130260>{schedule_tail+64} <ffffffff8010e746>{child_rip+8}
       <ffffffff80149430>{kevent_create_kthread+0} <ffffffff801495d0>{kthread+0}
       <ffffffff8010e73e>{child_rip+0}

Code: 80 3f 00 7e f9 e9 2e fe ff ff f3 90 80 3f 00 7e f9 e9 30 fe
console shuts up ...
 <0>Kernel panic - not syncing: Aiee, killing interrupt handler!

