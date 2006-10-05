Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751634AbWJEKkX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751634AbWJEKkX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 06:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751625AbWJEKkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 06:40:23 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:24563 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1751630AbWJEKkV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 06:40:21 -0400
Date: Thu, 5 Oct 2006 12:40:19 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Suzuki Kp <suzuki@in.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, andmike@us.ibm.com
Subject: Re: [RFC] PATCH to fix rescan_partitions to return errors properly
Message-ID: <20061005104018.GC7343@harddisk-recovery.nl>
References: <452307B4.3050006@in.ibm.com> <20061004130932.GC18800@harddisk-recovery.com> <4523E66B.5090604@in.ibm.com> <20061004170827.GE18800@harddisk-recovery.nl> <4523F16D.5060808@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4523F16D.5060808@in.ibm.com>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2006 at 10:37:49AM -0700, Suzuki Kp wrote:
> Erik Mouw wrote:
> >I disagree. It's perfectly valid for a disk not to have a partition
> >table (for example: components of a RAID5 MD device) and we shouldn't
> >scare users about that. Also an unrecognised partition table format
> >(DEC VMS, Novell Netware, etc.) is not a reason to throw an error, it's
> >just unrecognised and as far as the kernel knows it's unpartioned.
> 
> Thank you very much for the clarification.
> 
> But don't you think that, we should let know the user that he/she is 
> trying to re-read a partition table from a device, which doesn't have it 
> or is not useful for the kernel or to him, rather than making him happy 
> with a success ?

But we already do that. This is a part of the log from a 2.6.18 kernel:

SCSI device sda: 390721968 512-byte hdwr sectors (200050 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: unknown partition table

(SATA disk without partition table. It's one out of four components for
a RAID5 MD array).

Reading the partition table from an unpartitioned device *is* a
success. If that's what the user wanted, then yes, that will make him
happy.

If we let the kernel return an error like you propose, we will get a
lot of bug reports from users plugging in their new and shiny disk:
Kernel finds no partition table and throws an error. User thinks his
shiny disk is faulty, lkml tells him it's not, user then asks why the
kernel throws an error...


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
