Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265695AbTF2QCE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 12:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265694AbTF2QCE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 12:02:04 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:12930 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S265695AbTF2QCC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 12:02:02 -0400
Date: Sun, 29 Jun 2003 17:24:47 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200306291624.h5TGOl4A001008@81-2-122-30.bradfords.org.uk>
To: linux-kernel@vger.kernel.org, thervoy@post.pl
Subject: Re: File System conversion -- ideas
Cc: jamie@shareable.org, john@grabjohn.com, mlmoser@comcast.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I think
> > 
> >>the performance of an on-the-fly filesystem conversion utility is
> >>going to be so much worse than just creating a new partition and
> >>copying the data across,
> > 
> > 
> > which is awfully difficult if you have, say, a 60GB filesystem, a 60GB
> > disk, and nothing else.
> >
>
> I think that filesystem conversion on-the-fly is useless. Why? If you're
> making conversion of filesystem, you have to make good backup of data
> from that filesystem.

I agree.

Imagine a webserver with all it's webpages on a 40 GB EXT-2 partition
on /dev/sda1.

If I wanted to move the data on to a ReiserFS partition, I would just:

* Create the new partition on another device, E.G. /dev/sdb1
* Mount /dev/sda1 read-only
* Copy the data across to /dev/sdb1 as a nice process
* Stop the webserver processes
* Unmount /dev/sda1
* Mount /dev/sdb1 read-only
* Restart the webserver processes
* Test it
* Mount /dev/sdb1 read-write
* Keep /dev/sda1 around as a quick-to-access backup until I was sure
  it was all working correctly.
* Re-use /dev/sda1

The webserver would be off-line for only a few seconds, and
performance would not be significantly degraded at any time.

John.
