Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932307AbWEAW7u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932307AbWEAW7u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 18:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932308AbWEAW7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 18:59:50 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:18175 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S932307AbWEAW7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 18:59:50 -0400
Date: Tue, 2 May 2006 00:59:48 +0200
From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: kernel concepts <nils@kernelconcepts.de>
Subject: i8xx TCO timer: does not reset my machine
Message-ID: <20060501225948.GM1487@cip.informatik.uni-erlangen.de>
Mail-Followup-To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	LKML <linux-kernel@vger.kernel.org>,
	kernel concepts <nils@kernelconcepts.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,
I have an Intel board (D915GEV/D915GRF) with an onboard i8xx TCO timer
watchdog on it. I compiled a kernel and tried to make it reset my
machine, but it simply doesn't. I use Linus Linux tree (GIT HEAD), the
following watchdog related configuration:

        CONFIG_WATCHDOG=y
        CONFIG_WATCHDOG_NOWAYOUT=y
        CONFIG_I6300ESB_WDT=y
        CONFIG_I8XX_TCO=y

I tried to test the watchdog using the following:

        cat > /dev/watchdog

and wait a few minutes, but that doesn't reset my machine.  dmesg shows the
following:

        (webfarm) [~] dmesg | grep TCO
        i8xx TCO timer: heartbeat value must be 2<heartbeat<39, using 30
        i8xx TCO timer: initialized (0x0460). heartbeat=30 sec (nowayout=1)

lspci is this:

        0000:00:00.0 Host bridge: Intel Corp. 915G/P/GV Processor to I/O Controller (rev 04)
        0000:00:01.0 PCI bridge: Intel Corp. 915G/P/GV PCI Express Root Port (rev 04)
        0000:00:02.0 VGA compatible controller: Intel Corp. 82915G Express Chipset Family Graphics Controller (rev 04)
        0000:00:1c.0 PCI bridge: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 1 (rev 03)
        0000:00:1c.1 PCI bridge: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 2 (rev 03)
        0000:00:1c.2 PCI bridge: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 3 (rev 03)
        0000:00:1c.3 PCI bridge: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 4 (rev 03)
        0000:00:1d.0 USB Controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #1 (rev 03)
        0000:00:1d.1 USB Controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #2 (rev 03)
        0000:00:1d.2 USB Controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #3 (rev 03)
        0000:00:1d.3 USB Controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #4 (rev 03)
        0000:00:1d.7 USB Controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB2 EHCI Controller (rev 03)
        0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev d3)
        0000:00:1f.0 ISA bridge: Intel Corp. 82801FB/FR (ICH6/ICH6R) LPC Interface Bridge (rev 03)
        0000:00:1f.1 IDE interface: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) IDE Controller (rev 03)
        0000:00:1f.2 IDE interface: Intel Corp. 82801FB/FW (ICH6/ICH6W) SATA Controller (rev 03)
        0000:00:1f.3 SMBus: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) SMBus Controller (rev 03)
        0000:04:00.0 Ethernet controller: Marvell Technology Group Ltd.: Unknown device 4361 (rev 17)

Has somone any ideas, did I do something wrong? From looking at the
source code it looks like the watchdog is enabled as soon as I open the
device. And if I don't feed anything in, it shouldn't reload the timer.

        Thomas
