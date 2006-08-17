Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964795AbWHQK4E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964795AbWHQK4E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 06:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932476AbWHQK4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 06:56:04 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:23644 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S932474AbWHQK4B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 06:56:01 -0400
Message-ID: <44E44B3E.10708@tls.msk.ru>
Date: Thu, 17 Aug 2006 14:55:58 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Mail/News 1.5 (X11/20060318)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: linux-scsi@vger.kernel.org
Subject: Random scsi disk disappearing
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

An old problem, very annoying.

>From time to time, an scsi disk just disappears from
the bus, without any [error] messages whatsoever.
The only relevant stuff in dmesg is logging from md
(softraid) layer, about "error updating superblock"
and later "giving up and removing the disk from the
array" - not even error number.

When I try to access such a disk (/dev/sdX device),
I got "No such device or address" error back.

It's still listed in /sys/block and /proc/scsi/scsi,
but any access to the device gives this error.

But the disk is here, I know it is.  Deleting it from
kernel:

  echo y > /sys/block/sdX/device/delete

and adding it back:

  echo scsi add-single-device x y z > /proc/scsi/scsi

works just fine, linux finds "new" scsi device and it
happily works again.

This happens on alot of different machines, with different
disk drives (ok, most of them are from Seagate, but not
all).  I can't say for sure that it happens on different
scsi controllers - at least majority of them are adaptecs,
using aic7xxx or aix79xx driver.

I suspected the disks are too hot - nope, according to
smartctrl, the themp is far from bad (typically about
25..35 Celsius, and the themperature is not changing much).
Bad cables, bad power supply, bad anything else?  Not sure
either, at least I can't guess more: the machines are
really different, some has good, under-loaded power supplies
(and server chassis/motherboards/allthestuff) some has less
good ones - makes no difference.  And the thing is - having
in mind really sporadic disappearing, not depending on current
load, time of day (eg, during nights, there's no one on site
so no one to touch cables etc), ...  Well, I just can't think
of any reason, at all.

But one thing bothers me most: there's NO LOGGING from scsi
layer.  None, zero, not at all.

Has anyone else seen something similar?  Any pointers on how
to debug the issue?

Thanks.

/mjt
