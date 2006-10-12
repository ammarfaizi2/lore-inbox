Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422716AbWJLPvX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422716AbWJLPvX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 11:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422717AbWJLPvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 11:51:22 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:41853 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1422716AbWJLPvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 11:51:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=qfBa+BL2FAjI9o3FBw6YH/5+cBalWh8XcG7pjz4H0Asf+A89gUTG9WgyoyROrerqZkkPL9Fch3IqqUx4IWVsyDlj/+MOxDRdSTOPUTzslThtxIoCD/IoLR58CkPG7+ZDDHyWDKCHmdXrggPoCg6C2hGT9GxN2v5bYpEGIw3bilI=
Message-ID: <9ecacaab0610120851i64c9e22fqc038c88e3fbe892f@mail.gmail.com>
Date: Thu, 12 Oct 2006 11:51:20 -0400
From: "David Dumas" <daviddumas@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: sx8 on x86-64 instability with kernels >= 2.6.16
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a dual opteron system with an sx8, and have observed repeatable
sx8 failures under x86-64 linux 2.6.16 and later.  The problems are
not observed on x86-64 kernels 2.6.15 and earlier, nor on _any_ i386
kernel.

I first noticed the problem when trying to build a md RAID on the sx8.
 The resync always stops after < 2 seconds (at different points, but
always early).  Stats in /proc/mdstat continue to update, but show no
progress, and mdadm --stop causes a soft lockup.  Note that building a
RAID consisting of disks on the onboard SATA controller works fine.

The problem is not specific to md however.  While a single instance of
bonnie++ typically succeeds, running two simultaneous instances on
different disks connected to the sx8 always results in one of them
freezing in disk wait.  Sometimes a soft lockup occurs.  I have never
observed any error messages in syslog or on the console.

The dependence of the problem on specific kernel versions and the
x86-64 architecture seems to rule out hardware issues (though I tried
replacing cables, reseating card, etc.).

As for kernel configuration, I have tried both debian stock amd64
kernels and a custom kernel configured as close to the working 2.6.15
kernel as possible.  The problem is the same in each case.  I always
keep the sx8 "max_queue" parameter at the safe value of 1, so this is
not related to the instability observed by the driver developer for
larger queues.

This is especially perplexing since the sx8 driver was only subject to
trivial patches in the 2.6.16 release:

[PATCH] md: remove slashes from disk names when creation dev names in sysfs
[PATCH] mutex subsystem, semaphore to completion: SX8

Perhaps a seemingly unrelated patch affects the sx8 driver, but only
on x86-64?  And advice or suggestions would be appreciated.
