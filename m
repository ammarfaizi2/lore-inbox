Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964889AbWAWSwO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964889AbWAWSwO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 13:52:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964890AbWAWSwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 13:52:14 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:39842 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S964889AbWAWSwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 13:52:13 -0500
Message-ID: <43D525D8.8080501@comcast.net>
Date: Mon, 23 Jan 2006 13:52:08 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Loftis <mloftis@wgops.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: soft update vs journaling?
References: <43D3295E.8040702@comcast.net> <B78EFD916FFE8034EC546F38@dhcp-2-206.wgops.com>
In-Reply-To: <B78EFD916FFE8034EC546F38@dhcp-2-206.wgops.com>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Michael Loftis wrote:
> 
> 
> --On January 22, 2006 1:42:38 AM -0500 John Richard Moser
> <nigelenki@comcast.net> wrote:
> 
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> So I've been researching, because I thought this "Soft Update" thing
>> that BSD uses was some weird freak-ass way to totally corrupt a file
>> system if the power drops.  Seems I was wrong; it's actually just the
>> opposite, an alternate solution to journaling.  So let's compare notes.
> 
> 
> I hate to say it...but in my experience, this has been exactly the case
> with soft updates and FreeBSD 4 up to 4.11 pre releases.
> 
> Whenever something untoward would happen, the filesystem almost always
> lost files and/or data, usually just files though.  In practice it's
> never really worked too well for me.  It also still requires a full fsck
> on boot, which means long boot times for recovery on large filesystems.

You lost files in use, or random files?

Soft Update was designed to assure file system consistency.  In typical
usage, when you drop power on something like FAT, you create a 'hole' in
the filesystem.  This hole could be something like files pointing to
allocated blocks belonging to other files; or crossed dentries; etc.  As
you use the file system, it simply accepts the information it gets,
because it doesn't look bad until you look at EVERYTHING.  The effect is
akin to repeatedly sodomizing the file system in this newly created
hole; you just cause more and more damage until the system gives out.
The system makes allocations and decisions based on faulty data and
really, really screws things up.

The idea of Soft Update was to make sure that while you may lose
something, when you come back up the FS is in a safely usable state.
The fsck only colors in a view of the FS and frees up blocks that don't
seem to be allocated by any particular file, an annoying but mostly
harmless side effect of losing power in this scheme.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
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

iD8DBQFD1SXXhDd4aOud5P8RAj9PAJ9G5CF6gfPx470/Ak+OlaKogZhMSwCeKORg
Q7AZegZunZ3S2hTSNVnXFlc=
=7Rme
-----END PGP SIGNATURE-----
