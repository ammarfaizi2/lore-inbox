Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261916AbSJIR1Z>; Wed, 9 Oct 2002 13:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261914AbSJIR1Y>; Wed, 9 Oct 2002 13:27:24 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:59012 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261916AbSJIR1Y>;
	Wed, 9 Oct 2002 13:27:24 -0400
Date: Wed, 9 Oct 2002 13:33:00 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [bk/patch] driver model update: device_unregister()
In-Reply-To: <Pine.LNX.4.44.0210091010360.7355-100000@home.transmeta.com>
Message-ID: <Pine.GSO.4.21.0210091323480.8980-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 9 Oct 2002, Linus Torvalds wrote:

> I think that is a valid argument as long as it's called "driverfs" or
> something, but since the thing is clearly evolving into a "kernelfs"  and
> has drivers and devices as only a part of its structure knowledge, and is
> used to expose various kernel hierarchies and relationships, I actually
> think that it makes sense to expose the relationship of partitions to
> devices.

It makes sense, but that should be done for gendisk.  I.e. we should have
(name, base, range) - not a node for each partition.

At least one obvious reason for oops is that thing sets ->disk_dev, which is
under complete control of partitions/check.c.  If anything, setting
->driverfs_dev would be legitimate - use of ->disk_dev is a bug.

Al, waiting for already merged stuff to show up in snapshots...

