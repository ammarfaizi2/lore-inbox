Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265993AbSKTJSu>; Wed, 20 Nov 2002 04:18:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266020AbSKTJSu>; Wed, 20 Nov 2002 04:18:50 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:51426 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265993AbSKTJSu>;
	Wed, 20 Nov 2002 04:18:50 -0500
Message-Id: <200211200925.gAK9Pl002345@owlet.beaverton.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [BUG] 2.5.47: sysfs hierarchy can begin to disintegrate
Date: Wed, 20 Nov 2002 01:25:47 -0800
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.47 (top of bk tree on 11/14, to be precise)

/sys has a sysfs file system on it.  I'd expect /sys/block to contain
hd[abc], an assortment of ram disks, and perhaps some SCSI disks.
However, these all appear under /sys instead of /sys/block.  /sys/block
exists but is empty.

Interesting observation: the megaraid controller has some problem right
now (suspected to be hardware) wherein its scsi disks appear at boot
time but then cannot be accessed later and are subsequently detached.
Since this could well be a little-used and little-tested path, my
suspicion is that either the megaraid, scsi, or sysfs code has a bug when
disks are detached.  So far, I've not been able to find one, however, so
I thought I'd report this in case others might know just where to peek.
Could it be that removing entries from sysfs is done incorrectly in
some cases?

This was reproduced consistently on a machine at OSDL with the assistance
of Cliff White ... however I was not able to reproduce on my own 4-way
machine which has IDE disks and RAM disks but no megaraid.

I'm continuing to investigate this but there are more of you than of me
so ... :)

Rick
