Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266096AbTIKFdE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 01:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266103AbTIKFdD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 01:33:03 -0400
Received: from outbound01.telus.net ([199.185.220.220]:18866 "EHLO
	priv-edtnes61.telusplanet.net") by vger.kernel.org with ESMTP
	id S266096AbTIKFc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 01:32:59 -0400
Message-ID: <003601c37826$26d8d220$5d74ad8e@hyperwolf>
From: "Eric Bickle" <ebickle@healthspace.ca>
To: <linux-kernel@vger.kernel.org>
Subject: Problem: IDE data corruption with VIA chipsets on 2.4.20-19.8+others
Date: Wed, 10 Sep 2003 22:32:54 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The core issue:
----------------
Random crashes, general operating system instability with a RedHat 8 Linux
install running a moderately heavy-use database server (IBM Lotus Domino 5
or 6). All current indications point to a data
corruption/ide-incompatibility between the linux IDE driver and various VIA
chipsets. The problem only occurs during heavy database server load.

What happened:
----------------
We decided to migrate our Windows 2000 Pro Lotus Domino installations to
RedHat Linux 8. Everything worked fine on the office servers, which were
older 300-400mhz computers based on the good-old "bx" intel chipset.
Everything worked perfectly.

A few months ago we launched a large website for a large US state
department/organization. The website received and extreme amount of positive
press, and as a result the server load became more than we could handle. We
built an interim linux server which we hoped would tide us over until we
could purchase permadent, proper server hardware. After some testing
everything looked good and we launched the server. The server had two IDE
80gig hard-drives in a Software RAID-1 configuration. We chose IDE due to
the extremely high cost of SCSI and the fact we weren't sure if this was
going to be a permanent configuration. The installation used RedHat 8, with
all of the latest patches installed. (redhat network).

About one week later, the machine started behaving badly. Random crashes,
problems, etc. A very unstable server. We suspected it was the IDE. We built
another server using a different brand of motherboard and hard-drives and
launched the server. One or two weeks later - same thing - major problems,
crashes. In fact, we've launched about 4 different hardware configurations,
some raid, some non-raid, different hard-drive brands, different versions of
Lotus Domino. There is only one thing in common - they all crash, they all
run RedHat Linux, and they all use IDE.

We also get various IDE errors in the /var/log files, such as: (also another
weird IRQ error - except we're running a stock config! (ie/ no PCI devices
other than one NIC... No idea if they're related to the IDE thing <sigh>.
The IRQ thing appears to be USB related)
== during server runtime ==
kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=150637065,
sector=150636992
kernel: end_request: I/O error, dev 16:01 (hdc), sector 150636992
kernel: hdc: dma_intr: status=0x53 { DriveReady SeekComplete Index Error }
kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=150630007,
sector=150629920
kernel: end_request: I/O error, dev 16:01 (hdc), sector 150629920
== during server boot ==
kernel: usb.c: new USB bus registered, assigned bus number 3
kernel: hub.c: USB hub found
kernel: hub.c: 2 ports detected
kernel: PCI: Found IRQ 3 for device 00:10.2
kernel: IRQ routing conflict for 00:10.0, have irq 9, want irq 3
kernel: IRQ routing conflict for 00:10.1, have irq 9, want irq 3
kernel: IRQ routing conflict for 00:10.2, have irq 9, want irq 3
kernel: IRQ routing conflict for 00:10.3, have irq 9, want irq 3
kernel: usb-uhci.c: USB UHCI at I/O 0x9400, IRQ 9

Usually after that happens (the IDE errors) it will crash fairly soon. Other
times no errors are logged but the server is *extremely* slow - likely due
to disk performance. My guess is that there is some sort of internal IDE
error (A "CorrectableError"?) that the kernel is recovering from and not
writing a message to the log.

Once and awhile after a major kernel panic or reboot, the system refused to
reboot at all, going into an endless cycle of disk checking. We tried
various brand-name ram suppliers in case it was a ram corruption - no luck.
Everything points to IDE.

We tried various motherboards, including the following chipsets:
VIA KT333
VIA KT400
SiS 745

The problem definately occurs on 2.4.20-19.8, but also some earlier kernel
versions as well (which I can't remember). It only happens during extremely
high disk usage (I've seen it fail with about 8% CPU and Memory Usage...)
It's not our database server - it runs fine on our older "BX-Boards" (the
older 300mhz intels) and on various Windows NT/2000 boxes. The configuration
of the database server is exactially the same as on the other servers (I
double checked at least 5 times...)

After about 4 months of random server crashes and corruption, various trials
and testing, I'm fairly certain it must be a hardware interaction between
the IDE hard-drives and the Linux kernel. We've gone through 20 IDE
hard-drives that work fine and look fine after the crashes - definately not
a physical hard-drive problem. Definately not a motherboard problem because
we've been through 4 different motherboards, different manufacturers and 3
different chipsets.

Ideas..? Help..? :( The clients are going to be banging down the doors any
day if we don't get operational servers, and so far the only solution that I
believe works 100% is to install Windows (doh). As a last resort I'm asking
to see if any of you Kernel-gurus have ideas :-)

Thanks,
-Eric Bickle

