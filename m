Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261304AbULEODc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbULEODc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 09:03:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261306AbULEODc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 09:03:32 -0500
Received: from hera.cwi.nl ([192.16.191.8]:58097 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S261304AbULEOD3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 09:03:29 -0500
Date: Sun, 5 Dec 2004 15:03:14 +0100 (MET)
From: <Andries.Brouwer@cwi.nl>
Message-Id: <200412051403.iB5E3EJ01749@apps.cwi.nl>
To: mbp@sourcefrog.net
Subject: rescan partitions returns EIO since 2.6.8
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Pool changed the behaviour of the BLKRRPART ioctl in 2.6.8.
The effect is that one now gets an I/O error when first
partitioning an empty disk:

# sfdisk /dev/sda
Checking that no-one is using this disk right now ...
BLKRRPART: Input/output error

Ugly. I am tempted to go back to the state before his patch.

Why was this patch made? Just something random that seemed like
a good idea? Is there software that needs it?

Andries


The guilty patch (called "lost error code"):

	if (!get_capacity(disk) || !(state = check_partition(disk, bdev)))
-          return 0;
+          return -EIO;
