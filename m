Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282859AbRLRDPk>; Mon, 17 Dec 2001 22:15:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282918AbRLRDPb>; Mon, 17 Dec 2001 22:15:31 -0500
Received: from smtp-ham-2.netsurf.de ([194.195.64.98]:46073 "EHLO
	smtp-ham-2.netsurf.de") by vger.kernel.org with ESMTP
	id <S282859AbRLRDPR>; Mon, 17 Dec 2001 22:15:17 -0500
Date: Tue, 18 Dec 2001 04:14:27 +0100
From: Andreas Bombe <bombe@informatik.tu-muenchen.de>
To: linux-kernel@vger.kernel.org
Subject: 2.5.1 API change summary
Message-ID: <20011218031427.GA5990@storm.local>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One problem with following kernel development is that new APIs are
nowhere really summarized outside of the list thread where they are
developed (if there is a thread at all).  So maybe there's this great
new function that simplifies something in your driver, but you don't
know about it and only stumble across it much later (like 50 dev kernel
revisions) and wish you'd known earlier.

So someone should just collect the changes and post a summary to
linux-kernel, now wouldn't that be useful ...

[Silence, far away keyboards can be heard having "So I take it you
volun..." typed on them.]

... and I will try to do that for the kernel 2.5 revisions.

I have collected the API changes in 2.5.1 and summarized below.  I just
read the patch for all the *.h files, so I may have confused something
(like not realizing something just moved instead of being new).  I also
don't know much about most of the areas I'm summarizing, any corrections
are welcome.

These summaries won't serve as documentation except when it's short and
simple.  If there are big changes, I won't list every detail (I just
remind you that there is something, you can read the source yourself).
I will list changes which are global or at least apply to a whole
subsystem.

You'll also find stuff that's pretty much the talk of the week on
linux-kernel and therefore well known, but these summaries should also
serve as a overview ("when was what introduced") in combination with the
kernel changelogs for those who get into 2.5 later (yes, I will archive
these summaries on the web when I get a few together).

So, here it goes:

=======================================================================

	include/linux/types.h:

Typedef sector_t for block device sector numbers introduced to allow
making its size an option.


	include/linux/cache.h:

New macro __cacheline_aligned_in_smp that expands to __cacheline_aligned
on SMP and to nothing on UP.


	include/linux/kernel.h:

New macro BUG_ON(condition) which is equivalent to 
	if (condition) BUG();

The condition is also hinted "unlikely" to the compiler, which gives
better optimization on recent gcc versions even while decreasing typing
work.  (And if you update your code today, we'll throw in this set of
kitchen knives which will stay sharp as a razor forever...)


	include/linux/genhd.h:

get_start_sect() and get_nr_sects() on kdev_t introduced.


	include/linux/mempool.h (new):

Memory buffer pools introduced.  "Such pools are mostly used for
guaranteed, deadlock-free memory allocations during extreme VM load."


	include/linux/bio.h (new):
	include/linux/blkdev.h:
	include/linux/fs.h:
	include/linux/highmem.h:

New block IO layer introduced.


	include/linux/device.h (new):
	include/linux/driverfs_fs.h (new):

Centralized driver model introduced.


	drivers/scsi/hosts.h:

Scsi_Host_Template and Scsi_Host include new flag highmem_io, the flag
use_new_eh_code is removed along with the old error handling interface.


	drivers/scsi/scsi.h:

New sg list allocation functions scsi_alloc_sgtable() and
scsi_free_sgtable().  Function initialize_merge_fn() renamed to
scsi_initialize_merge_fn().  Function recount_segments() removed,
scsi_init_io() added.


	drivers/usb/hid.h:

HID class defines and functions added.


	include/linux/usb.h:

Yes, there are lots of changes.  I haven't sorted them out yet.

=======================================================================

-- 
Andreas Bombe <bombe@informatik.tu-muenchen.de>    DSA key 0x04880A44
