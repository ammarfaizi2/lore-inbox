Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261554AbVC3Fbo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261554AbVC3Fbo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 00:31:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261557AbVC3Fbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 00:31:44 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:18322 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261554AbVC3Far (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 00:30:47 -0500
Message-ID: <424A3990.9070002@comcast.net>
Date: Wed, 30 Mar 2005 00:30:56 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050111)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert Hancock <hancockr@shaw.ca>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Aligning file system data
References: <3ND9P-2LV-1@gated-at.bofh.it> <424A3002.0@shaw.ca>
In-Reply-To: <424A3002.0@shaw.ca>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Well then, the verdict is reached.

My original design is based around storing related data in the same
block so that the track cache allows me to evade doing reads while I
poke around.

The design will stay the same; but the dependency on the track cache
will dissappear.  I'll simply consider 32KiB or 64KiB to be a nice block
size, 64KiB being the biggest, and leverage the design on the kernel
reading whole blocks into main memory to play with at a time.

Back to designing my file system. . . .


The only lasting regrets I have is that I don't have a good, fast way to
do on-disk locking for a cluster file system.  This would make my FS a
complete solution. . . .

It doesn't matter, finishing the design is a while off anyway.  I still
have to define several extended journal transaction types to support
fault tolerant dynamic resizing (grow, shrink) while running.  I don't
see how to grow left; shrinking from the left is easy enough.  Wait,
suddenly I see how to grow left:  Superblock at the end, and a bit of
magic. . . .


Robert Hancock wrote:
> John Richard Moser wrote:
> 
>> How likely is it that I can actually align stuff to 31.5KiB on the
>> physical disk, i.e. have each block be a track?
> 
> 
> I don't think this is very likely. Even being able to find out what the
> physical disk arrangement is, or whether it is consistent in terms of
> track size, etc. seems unlikely.
> 
>>
>> Rather than leveraging the track cache, would it be less expensive for
>> me to simply read in blocks totaling about 16 or 32KiB all at once?
> 
> 
> For block sizes that small I think that the kernel should be smart
> enough to do this itself, there is no need to concern with such low
> level details in the application.
> 
>> How much more latency is involved in (B) than in (C)?  Does crossing a
>> track boundary incur anything expensive?
> 
> 
> Given that both the disk and the kernel will likely read far more than
> 32KB ahead I can't see much difference other than the overhead inside
> your application..
> 

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD4DBQFCSjmPhDd4aOud5P8RAgB7AJiWq4Qiyfk1G0SJa+5ZCtJ//WH8AJ9ysogo
3z6+FLvkNgyU/k0o9HBf1w==
=OPXo
-----END PGP SIGNATURE-----
