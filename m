Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261583AbVCNQow@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261583AbVCNQow (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 11:44:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261620AbVCNQoq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 11:44:46 -0500
Received: from cliff.cse.wustl.edu ([128.252.166.5]:5544 "EHLO
	cliff.cse.wustl.edu") by vger.kernel.org with ESMTP id S261588AbVCNQod
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 11:44:33 -0500
From: Berkley Shands <berkley@cs.wustl.edu>
Date: Mon, 14 Mar 2005 10:44:31 -0600 (CST)
Message-Id: <200503141644.j2EGiVh0000022634@mudpuddle.cs.wustl.edu>
To: linux-kernel@vger.kernel.org
Subject: Devices/Partitions over 2TB
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	With a Broadcom BC4852 and suitable Sata drives, it is easy to create
functional devices with well in excess of 2TB raw space. This presents a severe
problem to partitioning tools, such as fdisk/cfdisk and the like as the
kernel partition structure has a 32 bit integer max for sector counts. Since
the read_int() function combined with cround() overflows, having such a large
device makes life difficult. While mkfs.ext3 doesn't care, there is not
any way to slice that space up other than to use the raw device (/dev/sda).
Ever though about backing up 4TB to tape? :-)
	Even with a severely hacked up fdisk, the 32-bit field is just too
hard coded to make the effort worthwhile. A newer revision of the partitioning 
system needs to be thought of.  The kernel must be told how to deal with large
devices (the filesystems already do this), using at least 64 bits here.
Using a large SAN server, I've seen 200 Peta-byte arrays. While that is excessive
for a local workstation, 4-16 TB is clearly available and being deployed.
I have not found any documentation of efforts to overcome the 2TB partition limit,
though someone should be thinking of this. If there is an effort, could someone
point me to that place? If not, is there any interest in starting such a project?

thanks for the bandwidth.

berkley@cs.wustl.edu
