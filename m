Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261400AbREUMoP>; Mon, 21 May 2001 08:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261425AbREUMoF>; Mon, 21 May 2001 08:44:05 -0400
Received: from hera.cwi.nl ([192.16.191.8]:4858 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S261400AbREUMns>;
	Mon, 21 May 2001 08:43:48 -0400
Date: Mon, 21 May 2001 14:43:06 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200105211243.OAA62469.aeb@vlet.cwi.nl>
To: bcrl@redhat.com, phillips@bonn-fries.net
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code in userspace
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com, viro@math.psu.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


    How about:

      # mkpart /dev/sda /dev/mypartition -o size=1024k,type=swap
      # ls /dev/mypartition
      base    size    device    type

    Generally, we shouldn't care which order the kernel enumerates
    devices in or which device number gets assigned internally.  If we
    did need to care, we'd just do:

      # echo 666 >/dev/mypartition/number

Only a single thing is of interest.
What is the communication between user space and kernel
that transports device identities?

Note that there is user (human) / user space (programs) / kernel.

This user has interesting machinery in his hands,
but his programs have only strings (path names, fake or not)
to give to the kernel in open() and mount() calls.

Now the device path is so complicated that the user is unable to
describe it using a path name. devfs made an attempt listing controller,
lun, etc etc but /dev/ide/host0/bus1/target1/lun0/disc is not very
attractive, and things only get worse.

When I go to a bookshop to buy a book, I can do so without specifying
all of Author, Editors, Title, Publisher, Date, ISBN, nr of pages, ...
A few items suffice. Often the Title alone will do.

We want an interface where the kernel exports what it has to offer
and the user can pick. Yes, that Zip drive - never mind the bus.
But can distinguish - Yes, that USB Zip drive, not the one
on the parallel port.

The five minute hack would number devices 1, 2, 3 in order of detection,
offer the detection message in /devices/<nr>/detectionmessage
and a corresponding device node in /devices/<nr>/devicenode.
The sysadmin figures out what is what, makes a collection of
symlinks with his favorite names, and everybody is happy.

Until the next reboot. Or until device removal and addition.
There must be a way to give permanence to an association
between name and device. Symlinks into a virtual filesystem
like /devices are not good enough. Turning the five minute
hack into a ten minute hack we take the md5sum of the part
of the bootmessage that is expected to be the same the next time
we encounter this device and use that as device number.

I think a system somewhat in this style could be made to work well.

Andries
