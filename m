Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285203AbRLRVjF>; Tue, 18 Dec 2001 16:39:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285180AbRLRVht>; Tue, 18 Dec 2001 16:37:49 -0500
Received: from smtp-ham-2.netsurf.de ([194.195.64.98]:17881 "EHLO
	smtp-ham-2.netsurf.de") by vger.kernel.org with ESMTP
	id <S285203AbRLRVgc>; Tue, 18 Dec 2001 16:36:32 -0500
Date: Tue, 18 Dec 2001 22:35:42 +0100
From: Andreas Bombe <bombe@informatik.tu-muenchen.de>
To: linux-kernel@vger.kernel.org
Subject: 2.5.1 API change summary rev. 2
Message-ID: <20011218213542.GA3217@storm.local>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20011218031427.GA5990@storm.local> <20011218100609.C5273@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011218100609.C5273@kroah.com>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to Greg KH and David Brownell for helping me with the USB
changes.  Here is an updated version:

=======================================================================

	GENERAL CHANGES:

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


	include/linux/mempool.h (new):

Memory buffer pools introduced.  "Such pools are mostly used for
guaranteed, deadlock-free memory allocations during extreme VM load."


	include/linux/device.h (new):
	include/linux/driverfs_fs.h (new):

Centralized driver model introduced.  This allows all devices
independent of bus to be registered in a common tree and to improve
power management.  See Documentation/driver-model.txt.


	BLOCK DEVICES:

	include/linux/types.h:

Typedef sector_t for block device sector numbers introduced to allow
making its size an option.


	include/linux/genhd.h:

get_start_sect() and get_nr_sects() on kdev_t introduced.


	include/linux/bio.h (new):
	include/linux/blkdev.h:
	include/linux/fs.h:
	include/linux/highmem.h:

New block IO layer introduced.


	SCSI:

	drivers/scsi/hosts.h:

Scsi_Host_Template and Scsi_Host include new flag highmem_io, the flag
use_new_eh_code is removed along with the old error handling interface.


	drivers/scsi/scsi.h:

- New sg list allocation functions scsi_alloc_sgtable() and
  scsi_free_sgtable().

- Function initialize_merge_fn() renamed to scsi_initialize_merge_fn().
  Function recount_segments() removed, scsi_init_io() added.


	USB:

	include/linux/usb.h:

- Lots of documentation added.  Not really an API change but you might
  want to know.

- HID specific defines and functions moved into include/linux/usb.h.

- FILL_BULK_URB_TO and FILL_INT_URB_TO macros removed as they were
  not being used.

- New inline functions usb_fill_control_urb(), usb_fill_bulk_urb() and
  usb_fill_int_urb() replace the FILL_*_URB macros.


	drivers/usb/hid.h:

HID class defines and functions moved here.

=======================================================================

-- 
Andreas Bombe <bombe@informatik.tu-muenchen.de>    DSA key 0x04880A44
