Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264611AbSJWKTD>; Wed, 23 Oct 2002 06:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264615AbSJWKTD>; Wed, 23 Oct 2002 06:19:03 -0400
Received: from cmailm2.svr.pol.co.uk ([195.92.193.210]:54031 "EHLO
	cmailm2.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S264611AbSJWKTC>; Wed, 23 Oct 2002 06:19:02 -0400
Date: Wed, 23 Oct 2002 11:25:03 +0100
To: Linux Mailing List <linux-kernel@vger.kernel.org>, linux-lvm@sistina.com,
       Alan Cox <alan@redhat.com>
Subject: [Patch] Latest device-mapper snapshot
Message-ID: <20021023102503.GA25925@fib011235813.fsnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

New patchballs are available here:

http://people.sistina.com/~thornber/patches/2.5-stable/

Including a diff against 2.5.44-ac1.  There are a lot of changes in
here compared to the last release, however most of these are due to
code refactoring rather than bug fixes.  Highlights include:

o) Make the changes recommended by Christoph Hellwig and others:
   http://marc.theaimsgroup.com/?l=linux-kernel&m=103462345119681&w=2

o) Add reference count to struct mapped_device, and struct dm_table.

o) Hide the above two structs in their respective .c file

o) Move all locking of struct mapped_device into dm.c (we can do this now because
   of the reference counting).

o) Remove the name and uuid field from struct mapped device, these are really
   only used by the interface as a way of refering to devices.

o) Nobody needs to lookup from kdev_t -> struct mapped_device, so remove
   that hash table (thanks to Al Viros recent bdev->bd_disk stuff).

o) dm.c has no need of the dm-hash.c file any more, so merge dm-hash.c into
   dm-ioctl.c (the fs interface uses the dcache for lookups).


There are still open issues that prevent things working perfectly:

o) The gendisk hash table is getting confused when removing a device.  eg, if
   I create 3 devices with minors (1, 2, 3).  Then remove minor 2, get_gendisk 
   will remove minor == 3. (Or I've done something really stupid).

o) Splitting pages still doesn't work, this is a generic block layer
   thing rather than dm.  In practise I can only trigger this with
   striped targets.  So stick to linear targets for now.


Filesystem interface to follow before the end of the week.

- Joe
