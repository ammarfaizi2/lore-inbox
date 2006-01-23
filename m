Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932412AbWAWAH2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932412AbWAWAH2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 19:07:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932417AbWAWAH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 19:07:28 -0500
Received: from rwcrmhc11.comcast.net ([216.148.227.151]:1693 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S932412AbWAWAH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 19:07:27 -0500
Message-ID: <43D41DFC.5020608@comcast.net>
Date: Sun, 22 Jan 2006 19:06:20 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Courtier-Dutton <James@superbug.co.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: soft update vs journaling?
References: <43D3295E.8040702@comcast.net> <43D3DC75.30703@superbug.co.uk>
In-Reply-To: <43D3DC75.30703@superbug.co.uk>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



James Courtier-Dutton wrote:
> John Richard Moser wrote:
> 
>>
>> Unfortunately, journaling uses a chunk of space.  Imagine a journal on a
>> USB flash stick of 128M; a typical ReiserFS journal is 32 megabytes!
>> Sure it could be done in 8 or 4 or so; or (in one of my file system
>> designs) a static 16KiB block could reference dynamicly allocated
>> journal space, allowing the system to sacrifice performance and shrink
>> the journal when more space is needed.  Either way, slow media like
>> floppies will suffer, HARD; and flash devices will see a lot of
>> write/erase all over the journal area, causing wear on that spot.
>>
> 
> My understanding is that if one designed a power supply with enough
> headroom, one could remove the power and still have time to write dirty
> sectors to the USB flash stick. Would this not remove the need for a
> journaling fs on a flash stick.

Depends on how much meta-data you have to write out.  What if you just
altered 6000 files?  Now you have a ton of dentries to destroy and
inodes to invalidate, some FAT entries to free up, etc.  What if the
user just pulled the drive out of the USB port?  Or the USB port is
faulty and lost connection (I've seen it!).

> This would remove the "wear on that
> spot" problem.

Wha?  You mean remove the trigger, not the underlying problem.

> Actually USB flash sticks are a bit clever, in that they
> add an extra layer of translation to the write. I.e. If you write to the
> same sector again and again, the USB flash stick will actually write it
> to a different area of the memory each time. This is specifically done
> to save the "wear on that spot" problem.

Yeah, built-in write balancing is nice.

> 
> This "flush on power fail" approach is not so easy with a HD because it
> uses more power and takes longer to flush.

The "flush on power fail" is retarded because it takes extra hardware
and doesn't work if the USB port itself loses connection or if the user
is just dumb enough to pull/knock the drive out.  It won't work with
mini hard disks either, as you say.

"Flush on power fail" is pretty much getting a 10 minute UPS and issuing
'shutdown -h now' when the UPS signals init, which there's already
contingencies for (can also suspend to disk).  It won't help if the PSU
burns out, if the system crashes, if the power cord is pulled, or if the
dog walks around your chair and you turn and bump your foot into the
"power" button on the UPS itself.

> 
> James
> 
> 

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

iD8DBQFD1B37hDd4aOud5P8RAsCtAJ0TZM4I9T9gE6PMbfUhMux8zrxE9wCff67G
kdlY0fvfJQXmDljz6KekSxc=
=BV+l
-----END PGP SIGNATURE-----
