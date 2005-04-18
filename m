Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262011AbVDRJPL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262011AbVDRJPL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 05:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262012AbVDRJOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 05:14:24 -0400
Received: from rev.193.226.232.28.euroweb.hu ([193.226.232.28]:44419 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262014AbVDRJNd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 05:13:33 -0400
To: fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [announce] mountlo 0.1 - loopback mounting in userspace
Message-Id: <E1DNSJV-0006og-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 18 Apr 2005 11:13:05 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This program works similarly to "mount -o loop", but the filesystem
runs in userspace, making it possible for non-root users to safely
loopback mount filesystem images.

It works by starting a UML (User Mode Linux) instance, mounting the
image in there, and exporting the resulting data through FUSE. 

This is a first release and is really stupid: you can't even specify
the filesystem type or any mount options.  But for filesystems that
mount can recognize it works fine.

A binary compiled for i386 is available (2.1M) [1]. Requirements for
running the binary are:

  o FUSE-2.2 or greater, or kernel module from recent -mm kernel
  o Any Linux version supported by the above (>= 2.4.21 basically)

To compile from source, the following components are needed:

  o Linux 2.6.11 kernel source  (35M)  [2]
  o FUSE 2.3-pre4 source        (350k) [3]
  o mountlo 0.1 source          (15k)  [4]

Mount time is about 0.5 sec, which is ghastly compared to native
kernel mount, but not so bad considering, that a complete kernel boot
with initramfs unpacking, etc. is in there.  Other than this I haven't
done any performance measurements.

Comments, patches, offers to take over maintenance are welcome ;)

Miklos

[1] http://prdownloads.sourceforge.net/fuse/mountlo-i386-0.1.tar.gz
[2] http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.11.tar.bz2
[3] http://prdownloads.sourceforge.net/fuse/fuse-2.3-pre4.tar.gz
[4] http://prdownloads.sourceforge.net/fuse/mountlo-0.1.tar.gz
