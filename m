Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287404AbRL3NQV>; Sun, 30 Dec 2001 08:16:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287402AbRL3NQL>; Sun, 30 Dec 2001 08:16:11 -0500
Received: from oker.escape.de ([194.120.234.254]:22360 "EHLO oker.escape.de")
	by vger.kernel.org with ESMTP id <S287399AbRL3NPx>;
	Sun, 30 Dec 2001 08:15:53 -0500
Date: Sun, 30 Dec 2001 14:13:42 +0100 (CET)
From: Matthias Kilian <kili@outback.escape.de>
To: <linux-kernel@vger.kernel.org>
cc: Matthias Kilian <kili@outback.escape.de>
Subject: [PATCH] tmpfs+inittar, replacement for initrd
Message-ID: <Pine.LNX.4.30.0110272244390.28573-100000@outback.escape.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch (for linux-2.4.17) enables the kernel to use tmpfs and
an optionally compressed tar file instead of an initrd.

Instead of the /linuxrc-method, inittar completely relies on the "new"
method (pivot_root/chroot).

Since the patch is rather large, you can find it here:

http://www.escape.de/users/outback/linux/patch-2.4.17-inittar.gz

Note that it has only be compiled and tested on i386. I'd like to hear of
experiences on other platforms.


Contents of the patch:
- splitup of drivers/block/rd.c into rd.c (the ramdisk), rdload.c (ramdisk
  loader), crdload.c (loader for compressed ramdisks/tar files), irdload.c
  (initrd/inittar specific stuff).
- a small tar extractor (drivers/block/tar.c).
- create and mount a tmpfs as root fs (fs/super.c, mount_tmpfs_root()).
- configuration stuff for the above.


Goals:

- First, just use the benefits of tmpfs and the simplicity of a tar file
  instead of an old ramdisk and a *real* file system image. Since inittar
  can be enabled/disabled in .config, it may even be an option for 2.4
  kernels.

- For futures kernel versions (2.5 or 2.6), inittar could completely
  replace the old initrd and the whole rd stuff. I don't see who needs a
  ramdisk when there's a tmpfs.

- Still another option would make booting via tmpfs/inittar mandatory
  (IIRC, linus suggested this some time ago). This would allow for large
  cleanups in mount_root() (super.c), including root_dev and
  real_root_dev.


Credits:

- David L. Parsley, for lots of design suggestions (such as splitup of
  rd.c)
- Jason A. Pattie for testing and submitting bug reports


Some additional thoughts and instructions:

http://www.escape.de/users/outback/linux/index_en.html#inittar

or (german)

http://www.escape.de/users/outback/linux/index.html#inittar


Ciao,
	Kili

ps: please cc: answers to my address

