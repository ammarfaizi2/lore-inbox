Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263527AbTDIPhZ (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 11:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263528AbTDIPhY (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 11:37:24 -0400
Received: from inet-mail4.oracle.com ([148.87.2.204]:9143 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id S263527AbTDIPhU (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 11:37:20 -0400
Date: Wed, 9 Apr 2003 08:48:36 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Rob van Nieuwkerk <robn@verdi.et.tudelft.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: O_DIRECT alignment requirements ?
Message-ID: <20030409154836.GA31739@ca-server1.us.oracle.com>
References: <20030409141608.A12136@verdi.et.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030409141608.A12136@verdi.et.tudelft.nl>
X-Burt-Line: Trees are cool.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 09, 2003 at 02:16:08PM +0200, Rob van Nieuwkerk wrote:
> I plan to use O_DIRECT in my application (on a partition, no fs).
> It is hard to find info on the exact requirements on the mandatory
> alignments of buffer, offset, transfer size: it's easy to find many
> contradicting documents.  And checking the kernel source itself isn't
> trivial.

	In 2.4, your buffer, offset, and transfer size must be soft
blocksize aligned.  That's the output of BLKBSZGET against the block
device.  For unmounted partitions that is 512b, for most people's ext3
filesystems that is 4K.  It is, FYI, the number set by set_blocksize().
	In 2.5, the alignment restrictions have been relaxed.  Your
offset, buffer, and transfer size must all be aligned on the hardware
sector size.  That is the output of BLKSSZGET against the block device,
and is also what get_hardsect_size() returns in the kernel.  For almost
all disks this number is 512b, so you can do O_DIRECT on 512b alignment
for a raw disk or for an ext3 filesystem.  About the only thing that
may not have a 512b hardware sector size is a CD-ROM.

Joel

-- 

"Hey mister if you're gonna walk on water,
 Could you drop a line my way?"

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
