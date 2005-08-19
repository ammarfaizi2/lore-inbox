Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932509AbVHSM7y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932509AbVHSM7y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 08:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932616AbVHSM7y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 08:59:54 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:62874 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S932509AbVHSM7x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 08:59:53 -0400
Date: Fri, 19 Aug 2005 08:59:52 -0400
To: "Mukund JB`." <mukundjb@esntechnologies.co.in>
Cc: hirofumi@mail.parknet.co.jp,
       linux-kernel-Mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: The Linux FAT issue on SD Cards.. maintainer support please
Message-ID: <20050819125952.GZ6714@csclub.uwaterloo.ca>
References: <3AEC1E10243A314391FE9C01CD65429B391B@mail.esn.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3AEC1E10243A314391FE9C01CD65429B391B@mail.esn.co.in>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2005 at 05:09:06PM +0530, Mukund JB`. wrote:
> To handle it in a similarly in Linux we need to support this driver with
> partitions. There looks a loop hole in the driver. 
> I will verify and fix it today.

I suggest having a look at how other drivers use the add_disk call,
since it calls the partition checking code already in the kernel
automatically as far as I can tell.  You really shouldn't have to write
any of the partition parsing code at all.  You should just have to setup
a structure describing the disk and which major/minor numbers it uses,
and passing that to add_disk and it should deal with the rest.

> Just out of inquisitive ness.
> 
> What r u the minor numbers of those zip devices.
> ll /dev/zip 
> ll /dev/zip4

They are symlinks:
/dev/zip -> /dev/sda
/dev/zip4 -> /dev/sda4

sda uses major,minor: 8,0
sda1: 8.1
sda2: 8,2
...
sda15: 8,15
sdb: 8,16
sdb1: 8.17
...
sdb15: 8,31

That is how scsi does it.

If your driver supports multiple slots at once, decide how many to
support, or decide to only allow a few partitions, and space them by 8
or 16 (allowing 7 and 15 partitions respectively), and it should be easy
to deal with.  sda of course accesses the whole device, while sda1 and
up are for those partitions.  I am pretty sure there is standard
partition handling code in the kernel you should be accessing.

> Thanks for ur support.
> I will check with partition support in the driver & update it.
> Let me fix it there and come back.

Len Sorensen
