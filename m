Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbTFHIlN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 04:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbTFHIlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 04:41:13 -0400
Received: from 205-158-62-158.outblaze.com ([205.158.62.158]:51675 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP id S261169AbTFHIlM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 04:41:12 -0400
Message-ID: <20030608085448.31378.qmail@email.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Clayton Weaver" <cgweav@email.com>
To: linux-kernel@vger.kernel.org
Date: Sun, 08 Jun 2003 03:54:48 -0500
Subject: Re: Linux 2.4.21-rc7
X-Originating-Ip: 172.137.84.167
X-Originating-Server: ws3-4.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Now I really hope its the last one, all this
> rc's are making me mad.

We still have ide problems, and I don't see any
potential fixes for that in the changelog between -rc6 and -rc7.

I tried -rc6 on a whim and had hda report
a timeout (dma, I think, but the message went by kind of quick), then the big freeze with the
disk light stuck on,  Never happened
in 6 months on the same hardware running
2.4.19-rc2 (with glibc-2.2.5, gcc-2.95.3,
binutils-2.12.90.0.9, all ext2 filesystems).

I recompiled with all kernel debugging options
enabled and disabled partition statistics, since that was the one thing that was obviously new about the enabled ide options (I didn't select
any other new options, but of course the kernel code underneath is probably different, so one could not conclude anything from suck meager
testing). It ran for about 8 hours without freezing, with that drive doing a lot more
work than it was doing when it livelocked.

e2fsck reported errors on the next reboot, though,
and it's been rebooted into 2.4.19-rc2 to get some
other work done with it since then (caching the source for an upgrade of a 2.2.x box, different libc, yada yada, needs to be reliable until
that is finished).

SiS530/5513, k6-II/450, udma33 Maxtor drive that 2.4.19-rc2 has no problems with.

You can release a 2.4.21 anyway, of course, but without finding out where the ide livelock (and other big freezes, thinking of the report on the all-scsi system already posted) originates, calling it "stable" would be a bit fanciful.

(2.4.19-rc2 has its own quirks, of course, but
not "single-threaded ide livelock with this
chipset and ide drive". I can reliably kill it with 32 threads depth-first scanning different directory trees on that same disk in parallel, unfortunately without an oops to show for it.
It is not running out of memory (no ENOMEM reports), merely some mundane race condition or missing lock or whatever. Change it to 32 forks running in parallel, and they finish normally, though of course not all that quickly while seek-thrashing one and the same disk between them.)

Not what you wanted to hear, right? Oh well.

(Better to find out sooner than release
2.4.21-stable and watch 52 different bug reports on it arrive at the list the next day.)

Regards,

Clayton Weaver
<mailto: cgweav@email.com>

-- 
_______________________________________________
Sign-up for your own FREE Personalized E-mail at Mail.com
http://www.mail.com/?sr=signup

