Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750983AbWH0C2U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750983AbWH0C2U (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 22:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750977AbWH0C2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 22:28:20 -0400
Received: from out-mta2.ai270.net ([83.244.130.25]:34252 "EHLO
	out-mta1.ai270.net") by vger.kernel.org with ESMTP id S1750930AbWH0C2T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 22:28:19 -0400
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Transfer-Encoding: 7bit
Message-Id: <18AC2580-555A-460F-B9D7-3E4CBBA73941@lougher.org.uk>
Content-Type: text/plain; charset=US-ASCII; format=flowed
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
From: Phillip Lougher <phillip@lougher.org.uk>
Subject: [ANN] Squashfs 3.1 released
Date: Sun, 27 Aug 2006 03:28:16 +0100
X-Mailer: Apple Mail (2.752.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm pleased to announce Squashfs version 3.1.  Squashfs 3.1 has some
major improvements to the squashfs-tools, a couple of major bug fixes,
lots of small improvements/bug fixes, and new kernel patches.

Squashfs can be dowloaded from http://squashfs.sourceforge.net.
The list of changes  are:

1. Mksquashfs has been rewritten to be multi-threaded.  It has the
following improvements

1.1. Parallel compression.  By default as many compression and
      fragment compression threads are created as there are available
      processors.  This significantly speeds up performance on SMP
      systems.

1.2. File input and filesystem output is peformed in parallel on
      separate threads to maximise I/O performance.  Even on single
      processor systems this speeds up performance by at least 10%.

1.3. Appending has been significantly improved, and files within the
      filesystem being appended to are no longer scanned and
      checksummed.  This significantly improves append time for large
      filesystems.

1.4. File duplicate checking has been optimised, and split into two
      separate phases.  Only files which are considered possible
      duplicates after the first phase are checksummed and cached in
      memory.

1.5  The use of swap memory was found to significantly impact
      performance. The amount of memory used to cache files is now a
      command line option, by default this is 512 Mbytes.

2. Unsquashfs has the following improvements

2.1  Unsquashfs now allows you to specify the filename or the
      directory within the Squashfs filesystem that is to be
      extracted, rather than always extracting the entire filesystem.

2.2  A new -force option has been added which forces Unsquashfs to
      output to the destination directory even if files and directories
      already exist in the destination directory.  This allows you to
      update an already existing directory tree, or to Unsquashfs to
      a partially filled directory tree.  Without the -force option
      Unsquashfs will refuse to output.

3.  The following major bug fixes have been made

3.1   A fragment table rounding bug has been fixed in Mksquashfs.
       Previously if the number of fragments in the filesystem
       were a multiple of 512, Mksquashfs would generate an
       incorrect filesystem.

3.2   A rare SMP bug which occurred when simultaneously acccessing
       multiply mounted Squashfs filesystems has been fixed.

4. Miscellaneous improvements/bug fixes

4.1   Kernel code stack usage has been reduced.  This is to ensure
       Squashfs works with 4K stacks.

4.2   Readdir (Squashfs kernel code) has been fixed to always
       return 0, rather than the number of directories read.  Squashfs
       should now interact better with NFS.

4.3   Lseek bug in Mksquashfs when appending to larger than 4GB
       filesystems fixed.

4.4   Squashfs 2.x initrds can now been mounted.

4.5   Unsquashfs exit status fixed.

4.6   New patches for linux-2.6.18 and linux-2.4.33.

Comments, especially any performance results of the new parallelised
Mksquashfs are welcome.

Phillip

