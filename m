Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751313AbWAVSl0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313AbWAVSl0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 13:41:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbWAVSl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 13:41:26 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:46742 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1751313AbWAVSlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 13:41:25 -0500
Message-ID: <43D3D190.8010104@comcast.net>
Date: Sun, 22 Jan 2006 13:40:16 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: soft update vs journaling?
References: <43D3295E.8040702@comcast.net> <Pine.LNX.4.61.0601220945160.5126@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0601220945160.5126@yvahk01.tjqt.qr>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Jan Engelhardt wrote:
>>Unfortunately, journaling uses a chunk of space.  Imagine a journal on a
>>USB flash stick of 128M; a typical ReiserFS journal is 32 megabytes!
>>Sure it could be done in 8 or 4 or so; or (in one of my file system
>>designs) a static 16KiB block could reference dynamicly allocated
>>journal space, allowing the system to sacrifice performance and shrink
>>the journal when more space is needed.  Either way, slow media like
>>floppies will suffer, HARD; and flash devices will see a lot of
>>write/erase all over the journal area, causing wear on that spot.
> 
> 
>  - Smallest reiserfs3 journal size is 513 blocks - some 2 megabytes,
>    which would be ok with me for a 128meg drive.
>    Most of the time you need vfat anyway for your flashstick to make
>    useful use of it on Windows.
> 
>  - reiser4's journal is even smaller than reiser3's with a new fresh
>    filesystem - same goes for jfs and xfs (below 1 megabyte IIRC)
> 

Nice, but does not solve. . .

>  - I would not use a journalling filesystem at all on media that degrades
>    faster as harddisks (flash drives, CD-RWs/DVD-RWs/RAMs).
>    There are specially-crafted filesystems for that, mostly jffs and udf.
> 

Yes.  They'll degrade very, very fast.  This is where Soft Update would
have an advantage.  Another issue here is we can't just slap a journal
onto vfat, for all those flash devices that we want to share with Windows.

>  - You really need a hell of a power fluctuation to get a disk crippled.
>    Just powering off (and potentially on after a few milliseconds) did
>    (in my cases) just stop a disk write whereever it happened to be,
>    and that seemed easily correctable.

Yeah, I never said you could cripple a disk with power problems.  You
COULD destroy a NAND in a flash device by nuking the thing with
10000000000000 writes to the same area.

> 
> 
> Jan Engelhardt

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFD09GOhDd4aOud5P8RAr1lAJ9fGMSJOd4QALc4nCbx+jDLgTlijwCbBM94
r60oZO/x2Q0xEWeF9sp9Vz8=
=63vo
-----END PGP SIGNATURE-----
