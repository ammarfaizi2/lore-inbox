Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161882AbWJDRIc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161882AbWJDRIc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 13:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161881AbWJDRIc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 13:08:32 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:48759 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1161863AbWJDRIa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 13:08:30 -0400
Date: Wed, 4 Oct 2006 19:08:28 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Suzuki Kp <suzuki@in.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, andmike@us.ibm.com
Subject: Re: [RFC] PATCH to fix rescan_partitions to return errors properly
Message-ID: <20061004170827.GE18800@harddisk-recovery.nl>
References: <452307B4.3050006@in.ibm.com> <20061004130932.GC18800@harddisk-recovery.com> <4523E66B.5090604@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4523E66B.5090604@in.ibm.com>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2006 at 09:50:51AM -0700, Suzuki Kp wrote:
> Erik Mouw wrote:
> >On Tue, Oct 03, 2006 at 06:00:36PM -0700, Suzuki Kp wrote:
> >
> >>Currently the rescan_partition returns 0 (success), even if it is unable
> >>to rescan the partition information ( may be due to disks offline, I/O
> >>error reading the table or unknown partition ). This would make ioctl()
> >>calls succeed for BLKRRPART requests even if partitions were not scanned
> >>properly, which is not a good thing to do.
> >>
> >>Attached here is patch to fix the issue. The patch makes
> >>rescan_partition to return -EINVAL for unknown partitions and -EIO for
> >>disk I/O errors ( or when disks are offline ).
> >
> >I don't think it's a good idea to return an error when there's an
> >unknown partition table. How do you differentiate between a device that
> >isn't partitioned at all and a device with an unknown partition table?
> 
> Returning -EINVAL in both the above cases would inform the user that, 
> the partition table was not read properly due to an invalid arguemnt 
> (the disk) passed, which holds good for both the above cases.
> 
> What do you think ?

I disagree. It's perfectly valid for a disk not to have a partition
table (for example: components of a RAID5 MD device) and we shouldn't
scare users about that. Also an unrecognised partition table format
(DEC VMS, Novell Netware, etc.) is not a reason to throw an error, it's
just unrecognised and as far as the kernel knows it's unpartioned.

It's OK to tell the user that there was some kind of device error when
scanning the partition table but IMHO an unpartitioned disk is not a
device error.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
