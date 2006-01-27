Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932248AbWA0FH5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248AbWA0FH5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 00:07:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932407AbWA0FH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 00:07:57 -0500
Received: from main.gmane.org ([80.91.229.2]:36808 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932248AbWA0FH4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 00:07:56 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: libata errors in 2.6.15.1 ICH6 AHCI (SATA drive WD740GD)
Date: Fri, 27 Jan 2006 14:07:41 +0900
Message-ID: <drc9qt$mk4$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: s175249.ppp.asahi-net.or.jp
User-Agent: Mail/News 1.5 (X11/20060115)
X-Enigmail-Version: 0.94.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there.

I am reiterating this, while trying to diagnose the problem.
It is a DIY box with Asus P5GDC-V Deluxe motherboard with Marvel 88E8053 GB
ethernet (for info see [1]) and WD740GD (10k RPM) harddisk.

The NIC was not found by the in kernel driver, so I used a patch to sk98lin
binary driver, later tried sky2; both with intermittent succes. Now I have a
r8169 NIC and have disabled on board one in BIOS and put a new vanilla
linux-2.6.5.1

After some time (30 minutes to 3 days) the machine dies, first the disk,
some partitions mounted RO by the kernel, finally everything is dead (no
response to ping and KBD).

What I get in the dmesg is this:
...
[   23.464209] hub 5-0:1.0: USB hub found
[   23.464221] hub 5-0:1.0: 8 ports detected
[   25.819331] r8169: eth0: link up
[13091.397797] ata1: handling error/timeout
[13091.397805] ata1: port reset, p_is 0 is 0 pis 0 cmd 4017 tf d0 ss 113 se 0
[13091.397823] ata1: status=0x50 { DriveReady SeekComplete }
[13091.397828] sda: Current: sense key=0x0
[13091.397831]     ASC=0x0 ASCQ=0x0
[13091.481534] ata1: port reset, p_is 40000001 is 1 pis 0 cmd 4017 tf 471 ss
113 se 0
[13091.481542] ata1: translated ATA stat/err 0x71/04 to SCSI SK/ASC/ASCQ
0xb/00/00
[13091.481544] ata1: status=0x71 { DriveReady DeviceFault SeekComplete Error }
[13091.481549] ata1: error=0x04 { DriveStatusError }
...

The full dmesg can be found under [1] as 2.6.15.1-K01_P4_server.3.dmesg

I checked the drive (on the same machine) both with smartctl and with the
boot floppy I downloaded from WD support site (Data lifeguard tools).
Neither reported anything bad (yes I looked the status after the test).

The filesystem (reiserfs) does fscheck on every bood, but so far corruption
has not occured as far as I can see.

As always, the usual question is:

What is the cause of this? Bug?

What can I do to better diagnose it?

Is any additional info helpful (see [1])?

Dmesg and other hardware info can be found here:
[1]:	http://linux.tar.bz/reports/oopses/char/

Kalin.
-- 
|[ ~~~~~~~~~~~~~~~~~~~~~~ ]|
+-> http://ThinRope.net/ <-+
|[ ______________________ ]|

