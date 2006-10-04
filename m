Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932282AbWJDNJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbWJDNJg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 09:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932409AbWJDNJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 09:09:36 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:34297 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S932282AbWJDNJf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 09:09:35 -0400
Date: Wed, 4 Oct 2006 15:09:32 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Suzuki Kp <suzuki@in.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] PATCH to fix rescan_partitions to return errors properly
Message-ID: <20061004130932.GC18800@harddisk-recovery.com>
References: <452307B4.3050006@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <452307B4.3050006@in.ibm.com>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2006 at 06:00:36PM -0700, Suzuki Kp wrote:
> Currently the rescan_partition returns 0 (success), even if it is unable
> to rescan the partition information ( may be due to disks offline, I/O
> error reading the table or unknown partition ). This would make ioctl()
> calls succeed for BLKRRPART requests even if partitions were not scanned
> properly, which is not a good thing to do.
> 
> Attached here is patch to fix the issue. The patch makes
> rescan_partition to return -EINVAL for unknown partitions and -EIO for
> disk I/O errors ( or when disks are offline ).

I don't think it's a good idea to return an error when there's an
unknown partition table. How do you differentiate between a device that
isn't partitioned at all and a device with an unknown partition table?
Better return 0 on an unknown partition table.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
