Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263441AbTEVXv2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 19:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263444AbTEVXv2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 19:51:28 -0400
Received: from 66-122-194-202.ded.pacbell.net ([66.122.194.202]:7608 "HELO
	mail.keyresearch.com") by vger.kernel.org with SMTP id S263441AbTEVXv1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 19:51:27 -0400
Subject: [CFT] Move ipconfig and nfsroot support from kernel to userspace
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1053648269.1237.96.camel@serpentine.internal.keyresearch.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 22 May 2003 17:04:29 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've put together a new klibc snapshot, along with a set of kernel
patches, to move ipconfig and nfsroot support into userspace.  These can
all be found at http://www.speakeasy.org/~bos

The klibc snapshot includes kinit, a statically linked binary that
replaces the 2.5 kernel's support for IP autoconfiguration
(CONFIG_IP_PNP, aka "ipconfig") and use of NFS as the root filesystem
(CONFIG_ROOT_NFS, aka "nfsroot"). 

The patches remove support for ipconfig and nfsroot, and get the kernel
into an intermediate state where it can at least boot into a kinit built
in a klibc tree. 

      * ipconfig-2.5.69 removes support for ipconfig, and disables the
        building of nfsroot. 
      * nfsroot-2.5.69 removes support for nfsroot. 
      * initramfs-2.5.69 stops the kernel from doing the usual mount
        procedure if it sees "root=initramfs" or "root=/dev/nfs" on the
        kernel command line. Instead, it hands control over to whatever
        it finds in initramfs. 

To test, you'll need to build klibc, copy kinit into the kernel's usr
directory, blow away the .cpio file in there, and rebuild your kernel.
You can then reboot with a kernel command line such as "ip=eth0
root=/dev/nfs", and your kernel should use DHCP to configure eth0 and
mount its root filesystem from whatever NFS server the DHCP server told
it. 

If you're feeling impatient and don't want to build klibc, there's a
kinit binary precompiled that you can use for testing. 

Note: the kinit binary currently only supports nfsroot and ipconfig used
together. It doesn't make any sense to use them separately right now,
anyway. 

	<b

