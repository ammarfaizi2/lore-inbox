Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285229AbSACJoE>; Thu, 3 Jan 2002 04:44:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285216AbSACJnz>; Thu, 3 Jan 2002 04:43:55 -0500
Received: from news.cistron.nl ([195.64.68.38]:13829 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id <S285210AbSACJnm>;
	Thu, 3 Jan 2002 04:43:42 -0500
From: Miquel van Smoorenburg <miquels@cistron.nl>
Subject: Re: system.map
Date: Thu, 3 Jan 2002 09:43:41 +0000 (UTC)
Organization: Cistron Internet Services B.V.
Message-ID: <a1194d$5r6$3@ncc1701.cistron.net>
In-Reply-To: <20020102191157.49760.qmail@web21204.mail.yahoo.com> <200201022006.g02K6vSr021827@svr3.applink.net> <3C336B65.2020905@freesurf.fr> <200201022039.g02KdPSr022018@svr3.applink.net>
X-Trace: ncc1701.cistron.net 1010051021 5990 195.64.65.67 (3 Jan 2002 09:43:41 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200201022039.g02KdPSr022018@svr3.applink.net>,
Timothy Covell  <timothy.covell@ashavan.org> wrote:
>On Wednesday 02 January 2002 14:19, Kilobug wrote:
>> > 5. sync;sync;shutdown -r now
>>
>> Is there any particular reason for this double sync ? One isn't enough ?
>> (And is sync even needed with shutdown, all should be synced when
>> filesystems are unmounted or remounted read-only, am I wrong ? )
>
>The double sync is tradition.

The double sync is because traditionally, sync was asyncronous-
it told the kernel 'flush write cache to disk' but it returned
immidiately. That is why people were told to sync 3 times - by
the time you had typed 'sync' for the third time on your 300 baud
lineprinter console the system was done flushing.

sync;sync;sync;reboot is NOT what was used, it was:

# sync
# sync
# sync
# reboot

Anyway, Linux sync is different. It *is* synchronous. However syncing
and then doing a hard reboot is not recommended, you really need to
unmount all filesystems first, and remount root read-only. The
standard shutdown sequence does all of this for you and typing sync
before shutdown -r now is completely useless.

>SysV init scripts should sync things,
>but "sync;sync;reboot" or "sync;sync;halt" are not so nice in how
>they go down; so it's a case of being extra careful.  I don't use
>linux all the time, and some of the other unices are less tolerant.
>(For example, on a sun box, I would prefer a double sync before I
>"<stop>-a".)

If you're going to halt or reboot a system *hard* by using the reset
button or <stop>-a without calling shutdown you better sync before
you do that yes, and then you're still not guaranteed free of fs
corruption - at least kill all processes first to prevent some
process writing to disk in between the sync and the halt/reset.

Mike.

