Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262906AbSJGHcu>; Mon, 7 Oct 2002 03:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262908AbSJGHct>; Mon, 7 Oct 2002 03:32:49 -0400
Received: from d12lmsgate-5.de.ibm.com ([194.196.100.238]:4801 "EHLO
	d12lmsgate-5.de.ibm.com") by vger.kernel.org with ESMTP
	id <S262906AbSJGHcs> convert rfc822-to-8bit; Mon, 7 Oct 2002 03:32:48 -0400
Importance: Normal
Sensitivity: 
Subject: Re: [PATCH] 2.5.40 s390.
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OFEE3CA8C8.88B80B69-ONC1256C4B.00290591@de.ibm.com>
From: "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Date: Mon, 7 Oct 2002 09:35:24 +0200
X-MIMETrack: Serialize by Router on D12ML016/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 07/10/2002 09:37:16
MIME-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Al,

> * please switch to use of alloc_disk()/put_disk()
> * don't bother with disk->part allocation - it's done by add_disk()
> * ditto for freeing it (del_gendisk())
> * dasd_partition_to_kdev_t() - please use ->gdp->{major,first_minor}
> * s/bdevname(d_device->bdev)/d_device->gdp->disk_name/
> * lose ->bdev
 I'll do that.

> Note that we are getting bdev->bd_disk and disk->private pretty soon, so
> we'll have very easy way to do your devmap by bdev stuff.
Thats good to hear. One of the reasons for me to split of dasd_devmap.c
was to have the code concerned about minors and friends in on place.
That makes it easy to get rid of it.

> Anther thing: tapeblock.c and friends.
> <rant>
 > In ~ 2.5.16 blksize_size[] had been removed.  Tape-related code
> in s390 was using it, but that was fairly easy to get rid of.  Now, in
> 2.5.21 somebody (presumably architecture maintainers) had submitted a
> patch that
 > * reverted all compile fixes, etc. that had happened in 2.5
 > * reintroduced use of (long-dead) blksize_size[]
> ^#$^%@!
> Folks, if you do something like that, at least check the bloody changelog...
> </rant>

Oh, that must have been me then. Sorry about that. But there is a reason
for my obvious desinterest in the tape device driver. I'm just rewriting
it completely. So don't bother with the old one.

blue skies,
   Martin

Linux/390 Design & Development, IBM Deutschland Entwicklung GmbH
Schönaicherstr. 220, D-71032 Böblingen, Telefon: 49 - (0)7031 - 16-2247
E-Mail: schwidefsky@de.ibm.com


