Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267943AbUIJVk3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267943AbUIJVk3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 17:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267926AbUIJVk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 17:40:29 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:4786 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S267920AbUIJVkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 17:40:13 -0400
Subject: Changes to the SCSI sysfs tree
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 10 Sep 2004 17:39:57 -0400
Message-Id: <1094852403.2553.257.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patches effecting the changes listed below are at

bk://linux-scsi.bkbits.net/scsi-target-2.6

Andrew, could you add this to the -mm tree so it gets some wide testing
before I submit it for inclusion in the kernel proper?  Thanks...

What I'm actually doing is:

I'd like to change the layout of the SCSI sysfs tree to add a target
generic device.  This is essential because we need to hang certainl
device class attributes off the target not replicate them throughout the
LUNs of the individual device.

This means that a current SCSI sysfs device like:

lrwxrwxrwx  1 root root 0 Sep 10 09:44 /sys/block/sda/device ->
../../devices/parisc8/parisc8:0/pci0000:00/0000:00:13.0/host0/0:0:5:0/

will instead become:

lrwxrwxrwx  1 root root 0 Sep 10 09:44 /sys/block/sda/device ->
../../devices/parisc8/parisc8:0/pci0000:00/0000:00:13.0/host0/target0:0:5/0:0:5:0/

(note the extra target).

James


