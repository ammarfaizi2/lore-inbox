Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282702AbRLBD3J>; Sat, 1 Dec 2001 22:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282706AbRLBD3A>; Sat, 1 Dec 2001 22:29:00 -0500
Received: from hera.cwi.nl ([192.16.191.8]:57276 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S282703AbRLBD26>;
	Sat, 1 Dec 2001 22:28:58 -0500
From: Andries.Brouwer@cwi.nl
Date: Sun, 2 Dec 2001 03:28:53 GMT
Message-Id: <UTC200112020328.DAA132404.aeb@cwi.nl>
To: Andries.Brouwer@cwi.nl, aia21@cam.ac.uk
Subject: Re: [PATCH] Enhancement of /proc/partitions output (2.5.1-pre5)
Cc: adilger@turbolabs.com, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Anton Altaparmakov <aia21@cam.ac.uk>

    btw. You sent a patch to fsdevel some time ago converting parts of the 
    kernel to use bytes instead of 1024 byte blocks. Have you got an 
    updated/more complete version of that?

Yes. This summer I constructed the first dozen patches or so of
a path that would step by step change the present situation into one
without the `arrays', and with proper partition handling (namely not
buried down in the drivers), and with sizes as 64-bit byte amounts etc.
You can still find them on ftp.kernel.org.
Part of this was applied to 2.4.

Now that 2.5 has opened, I started (an hour ago) moving this stuff to 2.5.
(But will be abroad next week.)


    >    And I agree with Andreas the partition type would be useful
    >     in the display, too.
    >
    >I don't.
    >
    >This type is irrelevant. It would be very bad to make it available.
    >People might start using it, and that can only cause problems.
    >Moreover, usually there is no type, and in the future that I plan
    >there will never be a type. If there is a type, *fdisk will tell you.

    I am afraid I disagree. - Type is important when a partitioned device is 
    being worked on. LDM for example needs to know the types in order to make 
    sure not to take over a non-dynamic disk by mistake / to know that it is a 
    dynamic disk.

You illustrate what I say. It is vary bad to make types available,
since they do not exist. And ignorant people might start using them.

There are lots of partitioning systems in common use. And there is
no reason why LDM or MD RAID can sit on top of a DOS partition only.
Consequently, any dependence on types here is a bug.
Moreover, DOS type partitioning is dying. It cannot describe partitions
larger than 1 or 2 TB.

    .. I.e. where several different partitions have to be combined
    in various ways to give new devices? What are your thoughts
    on this? And do you have or are you aware of any code for
    these more advanced uses of partitioned devices?

No - but things will improve fully automatically. The MD code is
terrible (seen from a kdev_t point of view) and requires a lot of
restructuring.

Andries
