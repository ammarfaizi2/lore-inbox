Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264501AbUFSXSn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264501AbUFSXSn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 19:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264775AbUFSXSm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 19:18:42 -0400
Received: from mail014.syd.optusnet.com.au ([211.29.132.160]:11656 "EHLO
	mail014.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S264501AbUFSXSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 19:18:17 -0400
Message-ID: <40D4C9AA.5030307@kolivas.org>
Date: Sun, 20 Jun 2004 09:18:02 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7 (X11/20040615)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>, axboe@suse.de
Subject: Re: 2.6.7-ck1, cfq ionice?
References: <200406162122.51430.kernel@kolivas.org> <40D4A962.7030508@gmx.de>
In-Reply-To: <40D4A962.7030508@gmx.de>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Prakash K. Cheemplavam wrote:
| So,
|
| I have been using 2.6.7-ck1 for a few days now and must say it is simply
| *great*. Everything is working as it should, but only better. :-) Even
| ut2004 seems to be much smoother using staircase, some people reported
| 15% more fps (I haven't measured), but it runs as smooth as ut2003 did
| previously with Nick's scheduler (before the O(1) scheduler was updated
| to its current state in mm).
|
| The only thing left, which is a major pain for me, is disk i/o. Once it
| starts performance goes down, I think even more with staircase than with
| Nick's but this could be due to faster feel of staircase in general...
|
| Example: When I do a emerge rsync in gentoo a tree consisting of nearly
| 9000 files gets synced and a cache is built which causes a lot of random
| access on hd. So when I try to use thunderbird mailer at the same time,
| it act like a snail now due to concurrent disk access.
|
| As I understood the cfq ionice part would solve this issue. I never
| tried it, as I think I never had a kernel containing it (and never had
| such a desperate need for it :-). Reading your changelog, it is not
| included anymore in ck1. So should I beg Jens Axboe for a rediff or new
| patch or how to get this piece inside? I think it is the only thing left
| for the next to perfect desktop experience I ever had.

Hi.

By default -ck1 uses the default I/O scheduler which is anticipatory.
You can set the cfq scheduler (as I recommend and write in my faq) by
adding the boot command:

elevator=cfq

This does not include ionice, though, as the version of ionice that Jens
published was getting quite old and only worked with a much slower
version of the cfq scheduler. I had to drop that version in favour of
the higher throughput cfq scheduler in mainline. See how you go with jus
the normal cfq elevator first.

Hopefully Jens will resync his ionice work with the current cfq
scheduler. As soon as he does I'll include it in -ck ;-)

Cheers,
Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFA1MmqZUg7+tp6mRURAi4ZAJ47GL+H1NpgKkbzW/9aA8L85S1xpQCcCljF
ysonA/FE6GXn9BuVHqIEXCQ=
=BDBF
-----END PGP SIGNATURE-----
