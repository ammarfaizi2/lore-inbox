Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261994AbSJIRzq>; Wed, 9 Oct 2002 13:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261914AbSJIRzq>; Wed, 9 Oct 2002 13:55:46 -0400
Received: from air-2.osdl.org ([65.172.181.6]:12719 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S261994AbSJIRyo>;
	Wed, 9 Oct 2002 13:54:44 -0400
Date: Wed, 9 Oct 2002 11:02:18 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alexander Viro <viro@math.psu.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: [bk/patch] driver model update: device_unregister()
In-Reply-To: <Pine.LNX.4.44.0210091050330.7355-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0210091058230.16276-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 9 Oct 2002, Linus Torvalds wrote:

> 
> On Wed, 9 Oct 2002, Alexander Viro wrote:
> > 
> > Sorry, no.  Which partition is the backing store for this filesystem is
> > question to some filesystem drivers.  Not even every fs driver that
> > happens to use block devices - some of them use more than one (e.g
> > for journal).
> > 
> > IOW, it's not a partition property.
> 
> I didn't say it was a partition. I said it was a _filesystem_ property.  
> And yes, it can be a list of multiple partitions - the same way LVM is a
> list of _multiple_ partitions.
> 
> The point being that a partition is a real entity, and should have a node 
> of its own - so that you can point to it (and "node" may of course be 
> "subdirectory" if you want to have multiple things associated with it). 

It doesn't have to be a struct device, either. 

What describes partitions, struct hd_struct? By adding a struct 
driver_dir_entry (yes, crappy name; will change) and a bit of glue logic, 
we can create driverfs directories for them, and start adding attributes 
to the partitions themselves. 

Volume managers can have their own top-level directories, and one 
directory for each volume, with symlinks to the partition directories 
under the disk node directories that make up the volume. 

The code shouldn't be that bad, and I can whip something this afternoon, 
if interested..

	-pat

