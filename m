Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317448AbSG2PAJ>; Mon, 29 Jul 2002 11:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317466AbSG2PAJ>; Mon, 29 Jul 2002 11:00:09 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:17415 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317448AbSG2PAI>; Mon, 29 Jul 2002 11:00:08 -0400
Date: Mon, 29 Jul 2002 16:03:28 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.29 serial update
Message-ID: <20020729160328.D25451@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Serial update; see changesets below for details (as just sent to Linus).
The patch is available from:

      http://ftp.linux.org.uk/pub/linux/rmk/serial-2.5.29.diff

If people want a repository to pull from, its publically available, but
I'd rather not have lots of people pulling from it, so its available on
request.

Notable things are:
 - include cleanup
 - HP Diva support (from Matthew Wilcox)
 - cleanup locking surrounding stop_rx and enable_ms (note - anyone
   working on drivers using core.c)

This will update the following files:

 Documentation/serial/driver |    9 ++--
 drivers/serial/21285.c      |   22 +---------
 drivers/serial/8250.c       |   35 ++++------------
 drivers/serial/8250_pci.c   |   92 +++++++++++++++++++++++++++++++++++++-------
 drivers/serial/amba.c       |   27 +-----------
 drivers/serial/anakin.c     |   23 -----------
 drivers/serial/clps711x.c   |   21 +---------
 drivers/serial/core.c       |   24 ++---------
 drivers/serial/sa1100.c     |   29 +++----------
 drivers/serial/uart00.c     |   19 ---------
 include/linux/pci_ids.h     |   13 ++++--
 11 files changed, 128 insertions, 186 deletions

through these ChangeSets:

<rmk@flint.arm.linux.org.uk> (02/07/29 1.454)
	[SERIAL] Cleanup includes.
	Al Viro pointed out there was a fair bit of redundancy here.  We
	remove many include files from the serial layer, leaving those
	which are necessary for it to build.  This has been posted to lkml,
	no one complained.
	
	This cset also combines a missing include of asm/io.h in 8250_pci.c
	(unfortunately I've lost the name of the reporter, sorry.)

<rmk@flint.arm.linux.org.uk> (02/07/29 1.453)
	[SERIAL] Add HP Diva PCI serial port support.

<rmk@flint.arm.linux.org.uk> (02/07/28 1.452)
	[SERIAL] Add pci_disable_device() to initialisation failure paths.

<rmk@flint.arm.linux.org.uk> (02/07/28 1.451)
	[SERIAL] Remove some old compatibility cruft from 8250_pci.c
	8250_pci.c contains some old compatibility cruft for when __devexit
	wasn't defined by the generic kernel.  It is now, so it's gone.

<rmk@flint.arm.linux.org.uk> (02/07/27 1.450)
	[SERIAL] Locking fixup (part 2)
	After the last few days of debugging, we've ended up with the caller
	of the start_tx and stop_tx methods taking the per-port lock.  This
	cset and the accompanying csets make the same change to some of the
	other methods for consistency reasons.  Since these methods don't
	contain a lot of code, it is better that they have consistent locking
	rules.
	
	This cset fixes up the enable_ms method.

<rmk@flint.arm.linux.org.uk> (02/07/27 1.449)
	[SERIAL] Locking fixup (part 1)
	After the last few days of debugging, we've ended up with the caller
	of the start_tx and stop_tx methods taking the per-port lock.  This
	cset and the accompanying csets make the same change to some of the
	other methods for consistency reasons.  Since these methods don't
	contain a lot of code, it is better that they have consistent locking
	rules.
	
	This cset fixes up the stop_rx method.


-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

