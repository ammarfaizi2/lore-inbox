Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261825AbVFGKpp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbVFGKpp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 06:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261826AbVFGKpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 06:45:45 -0400
Received: from postfix4-2.free.fr ([213.228.0.176]:8122 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S261825AbVFGKpj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 06:45:39 -0400
Date: Tue, 7 Jun 2005 12:45:45 +0200
From: Christophe Varoqui <christophe.varoqui@free.fr>
To: linux-kernel@vger.kernel.org
Subject: bdev resize
Message-ID: <20050607104545.GA5286@averon.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

it is now a common feature for modern storage controlers to allow online volume resizing.
The Linux kernel SCSI subsystem seems to handle this pretty well through /sys/block/*/device/rescan :

# cat /sys/block/sda/size
41943040

<reconfigure the volume>

# echo 1>/sys/block/sda/device/rescan
# cat /sys/block/sda/size
52428800
# dmseg|tail -2
SCSI device sda: 52428800 512-byte hdwr sectors (26844 MB)
SCSI device sda: drive cache: write through

Still there's something going wrong : in the previous sample, sda had a mounted filesystem on it and BLKGETSIZE still reports the previous size.

If I umount the fs, this ioctl gives the new size, but mount -o remount does not work the same.
Hence, fully online resize is not possible.

Does someone is aware of this, and is it being worked on ?

Best regards,
cvaroqui
