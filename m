Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261571AbVASEiB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261571AbVASEiB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 23:38:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbVASEhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 23:37:36 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:62675 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261569AbVASEhJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 23:37:09 -0500
Message-ID: <41EDE3F8.3080605@comcast.net>
Date: Tue, 18 Jan 2005 23:37:12 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Passive-aggressive scheduling to enhance responsiveness?
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I was looking at what happens to responsiveness when CPU  usagee goes up
and I had an idea about CPU and IO scheduling.

Tasks can be grouped by user and nice (and by scheduler type but let's
leave SCHED_RR and friends out of this).  Let's say that user X
shouldn't choke user Y, and that nice 19 shouldn't choke nice 18.  So
obviously we make sure to balance CPU between X and Y, and make sure 18
gets CPU when it needs it even if 19 needs it; but 19 STILL gets at
least SOME CPU to avoid choking.

Next we have prioritizing.  I dunno how it works, so I'll  ignore it for
this discussion.

I'm not sure how scheduling works, but I'm thinking that because high
CPU tasks are causing jerkiness here, maybe it's not balanced?  I dunno,
you tell me.  The below is probably me being dumb, but at least I'm
putting the idea out there.

First, balance out CPU between users.  If X and Y are using 100% of the
CPU collectively, nobody else using any, user X gets 50% of the CPU;
user Y gets 50% of the CPU.  If X is using 20% and Y wants 70% (leaving
10%), that's fine; the CPU is balanced fairly.

Now do CPU balancing between nice levels.  a lower nice can have more
CPU than a higher one when 100% CPU is in use, but not to the point that
it chokes out all CPU.

Inside a single nice level, there's multiple tasks.  Here's where it
gets hairy.  If a task seems to have things to do, and it's not used as
much CPU as another task in this nice level for a specific interval
(500mS?), it gets automatic priority and gets CPU first for a timeslice.
 This way CPU is balanced inside the same nice level, by always making
sure that low-CPU tasks are given the most priority in their own nice
level.  High CPU tasks get their work done when what's probably
interactive has finished what it wants to do.

I dunno.  I don't know how it works, I just know I see jerks and fizzles
sometimes.
- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB7eP4hDd4aOud5P8RAp+hAJwOPvUwfcFUFQZyXYECmu2UsYI5HQCfT0ud
Eh9LsBVwycvIxZhq26E5ZVQ=
=LV4d
-----END PGP SIGNATURE-----
