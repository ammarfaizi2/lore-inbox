Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262807AbSKUBhw>; Wed, 20 Nov 2002 20:37:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262803AbSKUBhw>; Wed, 20 Nov 2002 20:37:52 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:20284 "EHLO
	flossy.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S262800AbSKUBhu>; Wed, 20 Nov 2002 20:37:50 -0500
Date: Wed, 20 Nov 2002 20:46:25 -0500
From: Doug Ledford <dledford@redhat.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Joel Becker <Joel.Becker@oracle.com>, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org
Subject: Re: RFC - new raid superblock layout for md driver
Message-ID: <20021121014625.GA14063@redhat.com>
Mail-Followup-To: Neil Brown <neilb@cse.unsw.edu.au>,
	Joel Becker <Joel.Becker@oracle.com>, linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org
References: <15835.2798.613940.614361@notabene.cse.unsw.edu.au> <20021120160259.GW806@nic1-pc.us.oracle.com> <15836.7011.785444.979392@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15836.7011.785444.979392@notabene.cse.unsw.edu.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2002 at 10:31:47AM +1100, Neil Brown wrote:
> I see MD and DM as quite different, though I haven't looked much as DM
> so I could be wrong.

I haven't yet played with the new dm code, but if it's like I expect it to 
be, then I predict that in a few years, or maybe much less, md and dm will 
be two parts of the same whole.  The purpose of md is to map from a single 
logical device to all the underlying physical devices.  The purpose of :VM 
code in general is to handle the creation, orginization, and mapping of 
multiple physical devices into a single logical device.  LVM code is 
usually shy on advanced mapping routines like RAID5, relying instead on 
underlying hardware to handle things like that while the LVM code itself 
just concentrates on physical volumes in the logical volume similar to how 
linear would do things.  But, the things LVM does do that are very handy, 
are things like adding a new disk to a volume group and having the volume 
group automatically expand to fill the additional space, making it 
possible to increase the size of a logical volume on the fly.

When you get right down to it, MD is 95% advanced mapping of physical
disks with different possibilities for redundancy and performance.  DM is
95% advanced handling of logical volumes including snapshot support,
shrink/grow on the fly support, labelling, sharing, etc.  The best of both
worlds would be to make all of the MD modules be plug-ins in the DM code
so that anyone creating a logical volume from a group of physical disks
could pick which mapping they want used; linear, raid0, raid1, raid5, etc.  
You would also want all the md modules inside the DM/LVM core to support
the advanced features of LVM, with the online resizing being the primary
one that the md modules would need to implement and export an interface
for.  I would think that the snapshot support would be done at the LVM/DM
level instead of in the individual md modules.

Anyway, that's my take on how the two *should* go over the next year or 
so, who knows if that's what will actually happen.


-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  
