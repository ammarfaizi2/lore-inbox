Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281923AbRLAWn1>; Sat, 1 Dec 2001 17:43:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281925AbRLAWnS>; Sat, 1 Dec 2001 17:43:18 -0500
Received: from hera.cwi.nl ([192.16.191.8]:26282 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S281923AbRLAWnH>;
	Sat, 1 Dec 2001 17:43:07 -0500
From: Andries.Brouwer@cwi.nl
Date: Sat, 1 Dec 2001 22:43:02 GMT
Message-Id: <UTC200112012243.WAA115170.aeb@cwi.nl>
To: Andries.Brouwer@cwi.nl, aia21@cam.ac.uk
Subject: Re: [PATCH] Enhancement of /proc/partitions output (2.5.1-pre5)
Cc: adilger@turbolabs.com, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Anton Altaparmakov <aia21@cam.ac.uk>

    > It will still break things.

    Sure. I anticipated it would break things but then again it is
    2.5.1-pre5 and not 2.4.x.

True. But this is the reporting side of the block device stuff.
And all is going to be changed. It is better to wait until the
new situation has been established.

    >Adding such stuff to the kernel would be especially unfortunate if,
    >as I did in my version of the block layer, the unit becomes byte
    >instead of sector. We would have to change again.

    So you are going to change it anyway at some point?

Who am I? I have plans, but other people may have other plans,
and it is not me who decides.

    We could just make the changes at the same time in that case?
    If it is in bytes even better. Just give start byte and length, 

But why not do it in user space?

# ./blockdev --report /dev/hda?
RO    RA   SSZ   BSZ   StartSec     Size    Device
rw     8   512  1024   16450560          2  /dev/hda1
rw     8   512  1024          0          0  /dev/hda2
rw     8   512  1024          0          0  /dev/hda3
rw     8   512  1024         63   16450497  /dev/hda4
rw     8   512  4096   16450623    4096512  /dev/hda5
rw     8   512  4096   20547198   13108977  /dev/hda6
rw     8   512  1024   33656238      80262  /dev/hda7
rw     8   512  1024     481950    4209030  /dev/hda8
rw     8   512  1024      64260     417690  /dev/hda9

(util-linux-2.11n)

    And I agree with Andreas the partition type would be useful
    in the display, too.

I don't.

This type is irrelevant. It would be very bad to make it available.
People might start using it, and that can only cause problems.
Moreover, usually there is no type, and in the future that I plan
there will never be a type. If there is a type, *fdisk will tell you.

[We all have plans, and some of these will actually be implemented.
In util-linux I already distribute for quite some time code that will
do partition setup. That means that no partition code is required
in the kernel. If 2.5 adds an initrd or so to the kernel, so that
Linux boots in its own ramdisk, then all partition reading code
can be thrown out of the kernel. That is one of my goals.
User space comes and tells the kernel: on device /dev/hda,
let hda7 be the interval of length 80262 sectors, starting at
sector 33656238. It is possible today, but not many people
use it. The plan is to make that the only way to get partitions.]

    If it really is only a list of available devices why show the size in 
    blocks at all?

History. It happened to be implemented like that.
There were some reasons, but not very strong ones.

Andries
