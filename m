Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264665AbUISWFR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264665AbUISWFR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 18:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264571AbUISWFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 18:05:16 -0400
Received: from hera.cwi.nl ([192.16.191.8]:24278 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S264665AbUISWFE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 18:05:04 -0400
Date: Mon, 20 Sep 2004 00:05:02 +0200 (MEST)
From: <Andries.Brouwer@cwi.nl>
Message-Id: <UTC200409192205.i8JM52C25370.aeb@smtp.cwi.nl>
To: linux-kernel@vger.kernel.org
Subject: OOM & [OT] util-linux-2.12e
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just released (on ftp.win.tue.nl in /pub/linux-local/utils/util-linux)
util-linux-2.12e.

The reason for this release were complaints that mount and umount
OOM the kernel when the number of mounts is large.
And indeed - I tried with 30000 mounts and the OOM-killer killed
everything in sight, including X's console, making X exit, killing
all remaining processes.

The new versions have been polished a little bit so as not to waste
too much memory, and now survive the 30000 mount/umount test for me.
Further polishing is needed for the case of large numbers of mounts;
when /etc/mtab is not a symlink to /proc/mounts then umount -a has
quadratic behaviour (it updates mtab after each unmount) and that
gets terribly slow.

About OOM: I am still of the opinion that the default state of the
kernel must be one where OOM does not occur and malloc() tells us
that we are out of memory. A system that suddenly decides to kill
all processes is really very poor and unreliable.
Users can enable other behaviours if they don't care about reliability.

About mount: I wondered whether I should rewrite [u]mounts's handling
of /etc/mtab so as to be a bit faster. But it seems a waste of time -
/proc/mounts has many advantages: automatically up-to-date, correct
also when namespaces are used, much faster. On the other hand, /etc/mtab
contains mount options that are sometimes needed later.
If it were possible to store the mount options in the kernel, making
them visible in /proc/mounts, then we could forget /etc/mtab altogether.

People have asked repeatedly for a way to mark lines in /etc/fstab
so as to make clear that such lines are managed by some GUI or other
external program. Labels like "kudzu".
In this release I added a comment convention for /etc/fstab: options
can have a part starting with \; - that part is ignored by mount
but can be used by other programs managing fstab.

If we would put the mount options in /proc/mounts, and introduced
a comment convention (say, the part starting with \: is ignored by
the kernel but can be used by programs reading /proc/mounts),
then /etc/mtab can die. Comments? Better solutions?

About util-linux and stuff: I have maintained various packages
for ten years or so - it may be time to pass things on to someone else.
Write to aeb@cwi.nl if you are interested in taking over or
co-maintaining kbd or man or man-pages or util-linux.

Andries
