Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129314AbQLGUYE>; Thu, 7 Dec 2000 15:24:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129345AbQLGUXy>; Thu, 7 Dec 2000 15:23:54 -0500
Received: from pobox.sibyte.com ([208.12.96.20]:49674 "HELO pobox.sibyte.com")
	by vger.kernel.org with SMTP id <S129314AbQLGUXj>;
	Thu, 7 Dec 2000 15:23:39 -0500
From: Justin Carlson <carlson@sibyte.com>
Reply-To: carlson@sibyte.com
Organization: Sibyte
To: linux-kernel@vger.kernel.org
Subject: Ramdisk root filesystem strangeness
Date: Thu, 7 Dec 2000 11:51:33 -0800
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Message-Id: <0012071153066S.11653@baton.sibyte.com>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am in the midst of bringing up the kernel on a new MIPS variant, and I'm tryingthe mount a statically linked ramdisk as the root filesystem.

Note, this is NOT using initrd support, I really want to use a ramdisk as my
final filesystem, not as an intermediate step in booting the system.

In blkdev_get(), called from mount_root(), there's some code that grabs
an empty inode, sets up i_rdev, and calls open() for the root device
with the caveat that open() must not examine anything except i_rdev.

in rd_open, though, there's this code snippet:

 /*
  * Immunize device against invalidate_buffers() and prune_icache().
  */
 if (rd_inode[DEVICE_NR(inode->i_rdev)] == NULL) {
         if (!inode->i_bdev) 
                 return -ENXIO;

I'm hitting the -ENXIO return, which is based on an uninitialized field of the
inode structure.    

Being relatively new to the code base, I'm not sure what this code is trying to
do, nor how to fix it.  Any suggestions?

The code involved is from the MIPS CVS repository at oss.sgi.com, which was
synced in the past couple days from 2.4.0test11

-Justin

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
