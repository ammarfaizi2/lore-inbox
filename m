Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268217AbRIBUG1>; Sun, 2 Sep 2001 16:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268813AbRIBUGR>; Sun, 2 Sep 2001 16:06:17 -0400
Received: from hera.cwi.nl ([192.16.191.8]:50849 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S268217AbRIBUGE>;
	Sun, 2 Sep 2001 16:06:04 -0400
From: Andries.Brouwer@cwi.nl
Date: Sun, 2 Sep 2001 20:05:45 GMT
Message-Id: <200109022005.UAA20596@vlet.cwi.nl>
To: Andries.Brouwer@cwi.nl, viro@math.psu.edu
Subject: Re: [RFC] lazy allocation of struct block_device
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> How many bits should a dev_t have? Well, enough.

> Enough for what? To cover all currently supported devices?

Enough to avoid the hassles that one has when dev_t is too small.

dev_t is a communication channel - you come with a cookie
and get a device in return.

Now NFS uses a 64-bit dev_t. If you choose a smaller one
then you have to invent some mapping between your 16 or 32 bits
and the 64 of NFS. I have not myself used systems that use a
64-bit dev_t (except for my own Linux machine :-) but have seen
systems with 32 bits divided 8+24 or 12+20 or 14+18 or 16+16,
so your mapping may have to depend on what is on the other side.
Not difficult, but annoying. A hassle for the sysadm.
There is no hassle with 64-bit dev_t.

In reality nobody wants a dev_t. We want a string.
A device path that gives the bus and SCSI ID or USB address
or internet URL plus protocol where to find this device.
But such a device path is large and of unknown shape.
Current user space software cannot easily handle such new objects.
Life becomes simpler if a disk on my local ethernet that
requires a password before use can be accessed as /dev/eda
not different from /dev/hda. Some as yet unspecified attach()
system call can turn device paths into numbers (dev_t),
and a following mknod() can attach a Unix filename to the number.
You see that in such a setup the dev_t is a handle, maybe a
pointer, not unlike the filehandles that NFS uses.
If your machine has more than 1 GB of memory, maybe you want
to use more than 32 bits for your handle.

The above is just fiction - I don't know how devices will be handled
in the future. But I find it very easy to conjure up scenarios
where having 64-bit dev_t would be very useful in order to make
sure that our current body of programs keeps working also in new
circumstances.

Andries
