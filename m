Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261968AbTIMAsM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 20:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261969AbTIMAsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 20:48:12 -0400
Received: from email-out2.iomega.com ([147.178.1.83]:17634 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S261968AbTIMAsH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 20:48:07 -0400
Subject: Re: console lost to Ctrl+Alt+F$n in 2.6.0-test5
From: Pat LaVarre <p.lavarre@ieee.org>
To: mpm@selenic.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030912230637.GB4489@waste.org>
References: <1063378664.5059.19.camel@patehci2>
	 <1063390768.2898.15.camel@patehci2>  <20030912230637.GB4489@waste.org>
Content-Type: text/plain
Organization: 
Message-Id: <1063414148.2892.26.camel@patehci2>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 12 Sep 2003 18:49:08 -0600
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Sep 2003 00:48:06.0945 (UTC) FILETIME=[B2425910:01C37990]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I'm working on this, it's rather messy. Your lockup might be caused by
> printk spew during console switch, see if it still locks up with the
> sleep debugging turned off.

Yes, thank you, Ctrl+Alt+F$n now works if only I
CONFIG_DEBUG_SPINLOCK_SLEEP=n.

Also `sudo cat /proc/kmsg | tee ...` also suddenly starts working.

I wonder if somehow /proc/kmsg now working is a clue?  Back with =y, my
`dmesg` was clean but via /proc/kmsg I was seeing garbage like

mmae t itbl

or:

mmae t itle

for what now again is such reassuring chatter as:

<6>scsi2 : SCSI emulation for USB Mass Storage devices
<5>  Vendor: Iomega    Model: RRD               Rev: 23.D
<5>  Type:   CD-ROM                             ANSI SCSI revision: 02
<7>WARNING: USB Mass Storage data integrity not assured
<7>USB Mass Storage device found at 3
<4>sr1: scsi3-mmc drive: 125x/125x caddy
<4>sr1: scsi3-mmc maybe not writeable
<4>sr1: scsi3-mmc writable profile: 0x0002
<7>Attached scsi CD-ROM sr1 at scsi2, channel 0, id 0, lun 0

Pat LaVarre

P.S. I could easily check to see if =y kills an ssh session or just the
display, if that helps.

P.P.S.

Tentatively I conclude "sleep debugging ... off" meant this .config
change because I see:

$ make defconfig
...
$ grep -i sleep .config
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
CONFIG_DEBUG_SPINLOCK_SLEEP=y
$ vi +/DEBUG_SPINLOCK_SLEEP .config
...
Kernel hacking ...

Sleep-inside-spinlock checking (DEBUG_SPINLOCK_SLEEP)

If you say Y here, various routines which may sleep will become very
noisy if they are called with a spinlock held.
...

Google isn't quickly confirming/ denying this tentative conclusion of
mine.



