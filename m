Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263107AbUGHXYx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263107AbUGHXYx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 19:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263714AbUGHXYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 19:24:53 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49835 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262065AbUGHXYR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 19:24:17 -0400
Message-ID: <40EDD78C.9070408@pobox.com>
Date: Thu, 08 Jul 2004 19:23:56 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-ide@vger.kernel.org
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Linux Serial ATA (SATA) status report
Content-Type: multipart/mixed;
 boundary="------------000108060501080202090500"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000108060501080202090500
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

attached.

--------------000108060501080202090500
Content-Type: text/plain;
 name="sata-status.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sata-status.txt"


Serial ATA (SATA) for Linux
status report
July 8, 2004



This status report applies to the latest SATA driver release, found in
(not yet release) kernels 2.4.28 and 2.6.7.



Recent updates
==============
Recent libata changes have focused on updating the libata core to be
more flexible, and support newer SATA-II host controllers.  These
changes aren't very visible, but they lay the groundwork for a more
ATA hardware interface that supports queueing.

Various bits of the core have been tweaked in association with the
following buzzwords:  ATAPI, DMADIR, legacy TCQ, NCQ, hotplug, port
multiplier, jelly beans.  Ok, that last one isn't part of any official
specification.  But the others should be fun.


Hardware support
================


Intel ICH5, ICH5-R, ICH6
------------------------
Summary: No TCQ. Looks like a PATA controller, but with a few added,
non-standard SATA port controls. Hardware does not support hotplug.
"Coldplug" support is potentially feasible.

libata driver status: Production, but see issue #2, #3.
Recently work on issue #2 has improved the state of that issue.

drivers/ide driver status: Production, but see issue #1, #2.


Issue #1: Depending on BIOS settings, IDE driver may lock up computer
when probing drives.

Issue #2: Excessive interrupts are seen in some configurations.

Issue #3: "Enhanced mode" or "SATA-only mode" may need to be set in BIOS.



AHCI (Intel ICH6-R/ICH6-M currently)
------------------------------------
Summary: Per-device queues, full SATA control including hotplug
and PM.

libata driver status: "looks like ICH5" support available in ata_piix.
Preliminary driver with full AHCI support now exists, and is being
integrated into libata mainline.

Note1:  AHCI specification is completely open.

Note2:  To ease integration, AHCI on ICH6 will be deployed inside the
ata_piix driver.

Note3:  SiS has AHCI on its roadmap.  Hopefully others will follow.


Promise TX2/TX4/SX4
-------------------
Summary: Per-host queues on all controllers. Full SATA control
including hotplug and PM on all but one controller (SX4).

libata TX2/TX4 driver status: Production, but see issue #5.

libata SX4 driver status: Production, but see issue #6.


Issue #5: Some boards appear to have PATA as well as SATA ports. PATA
is not currently supported, and no plans have yet been made to rectify
this. Ideally drivers/ide would drive PATA, but if they are the same
PCI device, that would not be feasible.

Issue #6: The SX4 hardware is not fully utilized by the Linux kernel
driver.  The SX4 hardware includes an on-board DIMM and hardware XOR
offload.  Using the on-board DIMM as cache, and issuing each RAID
transaction once (instead of once for each disk), will result in
increased performance, but the driver doesn't do that yet.  SX4 hardware
is very "RAID friendly", particularly RAID1/5.  Users may wish to use
the Promise driver to fully utilize the hardware.


Silicon Image 3112/3114
-----------------------
Summary: No TCQ. Looks like a PATA controller, but with full SATA
control including hotplug and PM.

libata driver status: Beta.

drivers/ide driver status: Beta?


Silicon Image 3124
------------------
Soon, hopefully.  Silicon Image has made documentation and sample
hardware available to me (jgarzik) for development.  Some code exists
internally.


Broadcom/ServerWorks/Apple
--------------------------
Summary: Huge per-device queues, full SATA control including hotplug
and PM for the "Frodo4" and "Frodo8" boards.  Apple K2 SATA, which also
uses this chipset, has all the feature of Frodo4/8 save the host DMA
queueing feature ("QDMA").  QDMA supports legacy TCQ, but not NCQ.

libata driver status: Beta, but no QDMA support yet.


VIA
---
Summary: No TCQ. Looks like a PATA controller, but with full SATA
control including hotplug and PM.

libata driver status: Beta.


NVIDIA
------
Summary: No TCQ. Looks like a PATA controller, but with full SATA
control including hotplug and PM.

libata driver status: Beta.


SiS 180
-------
Summary: No TCQ. Looks like a PATA controller, but with full SATA
control including hotplug and PM.

libata driver status: Beta


Vitesse 7174 / Intel 31244
--------------------------
Summary: NCQ and 64-bit DAC support possible, but not implemented.
Looks like a PATA controller, but with full SATA control including
hotplug and PM.

libata driver status: Beta


Marvell 88SX50[48]x
-------------------
Summary:  Similar to ServerWorks "frodo":  per-device queues, supports
legacy TCQ but not NCQ (I think??), full SATA control including hotplug
and PM.

libata driver status: in progress


HighPoint (HPT)
---------------
I've had no contact with the company.  Someone poke them, and get
them to get me a card and docs :)

libata driver status:  no driver planned at this point.


ADMA (including Pacific Digital Talon SATA)
-------------------------------------------
Summary:  No control over SATA phy at all (no hotplug/PM).  Has
per-device hardware queues, and supports legacy TCQ.

Docs are public (yay!)

libata driver status:  none, but hopefully soon


3ware SATA RAID
---------------
Not suited for libata architecture.  Separate SCSI driver exists.



Software support
================


Basic Serial ATA support
------------------------
The "ATA host state machine", the core of the entire driver, is
considered production-stable.

The error handling is _very_ simple, but at this stage that is an
advantage. Error handling code anywhere is inevitably both complex and
sorely under-tested. libata error handling is intentionally simple.
Positives: Easy to review and verify correctness. Never data
corruption. Negatives: if an error occurs, libata will simply send
the error back the block layer. There are limited retries by the block
layer, depending on the type of error, but there is never a bus reset.

Or in other words: "it's better to stop talking to the disk than
compound existing problems with further problems."

As Serial ATA matures, and host- and device-side errata become apparent,
the error handling will be slowly refined. I am planning to work with a
few (kind!) disk vendors, to obtain special drives/firmwares that allow
me to inject faults, and otherwise exercise error handling code.



Queueing support
----------------
Even though some SATA host controllers on the market already support
command queueing (a.k.a. "TCQ"), libata does not yet support it.

However, libata was designed from the ground-up to support queueing, so
I need only change a few lines of code, and write two functions, to
enable this behavior.

Queueing will be enabled in libata soon, but to do so requires a long
stretch of testing on a large variety of controllers and drives. This
is very time-intensive, and is the largest part of this task.


Tangent: Host-based queueing and Native Command Queueing

Queueing is the process of sending multiple commands to a single device,
without waiting for prior commands to finish. This increases
performance and reduces latency. There are three types of queueing in
the ATA world:

1) "legacy TCQ" -- some PATA devices support this. Just ignore it,
it's going away.

2) "host-based TCQ" -- the host controller supports a queue of drive
commands, whether or not the drive supports it.

3) "Native Command Queueing" -- both host and drive cooperate in the
queueing and execution of drive commands. This should provide the
highest performance and lowest latency of all three options.


#1 will be supported only where hardware handles all the details.
#2 will soon be supported by libata.
#3 will be supported by libata when hardware is available from drive
manufacturers.


Hotplug support
---------------
All SATA is hotplug.

libata does not support hotplug... yet.

The following SATA controllers will never support hotplug:
Intel ICH5, Intel ICH5-R, Intel ICH6 (non-AHCI), Pacific Digital Talon,
Promise SATA SX4.

These controllers do not export enough information about the SATA phy to
make it possible to support hotplug.  In some cases, such as Intel
ICH5/ICH6, it is possible to support "coldplug" operation:  the user
informs the OS driver he wishes to disconnect his SATA device, rather
than simply disconnecting it.


Power Management support
------------------------
Over and above the power management specified in the ATA/ATAPI
specification, one can aggressively control the power consumption of
SATA hosts, the SATA bus, and the SATA device.

Note:  as discussed on some mailing lists, the aggressive power
management can be too aggressive, and park the heads too often
(resulting in shortened disk drive life).  Careful attention must be
paid to balance.


SMART support
-------------
Soon. Requires the capability to directly submit ATA commands from
userspace to the low-level device, which must be added with care. The
smartmontools developers have committed to adding a new device type '-d
sata' to utilize this passthrough, once it is ready.



--------------000108060501080202090500--
