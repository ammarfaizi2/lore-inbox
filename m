Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262616AbREOELZ>; Tue, 15 May 2001 00:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262617AbREOELP>; Tue, 15 May 2001 00:11:15 -0400
Received: from axon.amtp.cam.ac.uk ([131.111.16.133]:31399 "EHLO
	axon.amtp.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S262616AbREOELA>; Tue, 15 May 2001 00:11:00 -0400
Message-Id: <200105150410.FAA08227.redmires.amtp.cam.ac.uk@damtp.cam.ac.uk>
From: Jon Peatfield <J.S.Peatfield@damtp.cam.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: device ordered files (for backups etc)
CC: J.S.Peatfield@damtp.cam.ac.uk
Date: Tue, 15 May 2001 05:10:58 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While reading the "getting fs access events" thread I remembered
something which I've been meaning to look at for ages.

[some history]
I don't trust programs which dump file systems by reading the data
directly from the block device (I'm never sure that they get things
right).  I prefer to do backups through the standard fs interfaces (so
logically we do 2 steps, make a list of files and then archive them).

However, this does mean that the order of real block reads may not be
very good (since files may accessed in an order which doesn't minimise
seeks).  Ignoring the problem of files with blocks spread far apart,
it seems clear that mapping the file to a rough index into the device
and ordering the reading of the files by this index ought to reduce
the seeks.

Now most systems provide no interface for this (pity), though Linux
does through the FIBMAP ioctl() (for fs which support bmap at least).
However to use this we need to open() all the files get the block
index, sort them and then reopen the files in the right order.

There is also the problem that we are (indirectly) reading the
directories to do the readdir()/lstat() etc in some arbitrary order,
so causing more seeks.

Is there some trick I'm missing or is there really no way to avoid
these seek penalty and go through the standard fs interfaces?

 -- Jon
