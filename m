Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132593AbRDNApL>; Fri, 13 Apr 2001 20:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132601AbRDNApB>; Fri, 13 Apr 2001 20:45:01 -0400
Received: from vger.timpanogas.org ([207.109.151.240]:59144 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S132593AbRDNAoz>; Fri, 13 Apr 2001 20:44:55 -0400
Date: Fri, 13 Apr 2001 18:38:10 -0600
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org, jmerkey@timpanogas.org,
        Linus Torvalds <torvalds@transmeta.com>, Linux390@de.ibm.com
Subject: Re: EXPORT_SYMBOL for chrdev_open 2.4.3
Message-ID: <20010413183810.A14604@vger.timpanogas.org>
In-Reply-To: <20010413173256.A14267@vger.timpanogas.org> <Pine.GSO.4.21.0104132004320.24992-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.GSO.4.21.0104132004320.24992-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Fri, Apr 13, 2001 at 08:13:41PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 13, 2001 at 08:13:41PM -0400, Alexander Viro wrote:
> 
> 
> On Fri, 13 Apr 2001, Jeff V. Merkey wrote:
> 
> > It would be nice if chrdev_open were added to ksyms.c along with
> > blkdev_open since tape devices seem are always registered as character
> > rather than block devices.  
> > 
> > I am finding that kernel modules that need to open and close a tape 
> > drive have to export chrdev_open manually on 2.4.3.  Can this get 
> > exported as well?  Closing is not a problem since the method of 
> > calling (->release) seems to work OK with SCSI tape devices.
> 
> They don't need it. Moreover, blkdev_open shouldn't be exported too -
> the only potentially modular piece of code that refers to it is
> drivers/block/rd.c and it's in initrd loading, so it isn't even
> compiled when we do rd as a module.
> 
> BTW, Linus, could we remove blkdev_open() from the export list?
> I don't see any legitimate reason to export it - certainly not in
> the official tree.
> 
> BTW, fs/partitions/ibm.c also doesn't need blkdev_open() - it should
> use ioctl_by_bdev() and be done with that.


Al,

How are folks supposed to open disk and tape devices from kernel modules
without these?  Not everything should be done in user space Al.  If you 
remove blkdev_open I will not be able to properly increment the use 
count an a disk device I may be reading or writing to.  

Jeff


> 							Al
