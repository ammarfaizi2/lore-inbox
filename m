Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314512AbSE0IoM>; Mon, 27 May 2002 04:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314529AbSE0IoM>; Mon, 27 May 2002 04:44:12 -0400
Received: from inje.iskon.hr ([213.191.128.16]:3539 "EHLO inje.iskon.hr")
	by vger.kernel.org with ESMTP id <S314512AbSE0IoL>;
	Mon, 27 May 2002 04:44:11 -0400
To: Andrew Morton <akpm@zip.com.au>
Cc: Christoph Rohland <cr@sap.com>, linux-kernel@vger.kernel.org,
        Hugh Dickins <hugh@veritas.com>
Subject: Re: 2.5.18 / ext3 / oracle trouble
In-Reply-To: <877klr2ank.fsf@atlas.iskon.hr> <d6vi836v.fsf@sap.com>
	<3CF1E5CF.2B11258F@zip.com.au>
Reply-To: zlatko.calusic@iskon.hr
X-Face: s71Vs\G4I3mB$X2=P4h[aszUL\%"`1!YRYl[JGlC57kU-`kxADX}T/Bq)Q9.$fGh7lFNb.s
 i&L3xVb:q_Pr}>Eo(@kU,c:3:64cR]m@27>1tGl1):#(bs*Ip0c}N{:JGcgOXd9H'Nwm:}jLr\FZtZ
 pri/C@\,4lW<|jrq^<):Nk%Hp@G&F"r+n1@BoH
From: Zlatko Calusic <zlatko.calusic@iskon.hr>
Date: Mon, 27 May 2002 10:43:57 +0200
Message-ID: <dnvg9am14i.fsf@magla.zg.iskon.hr>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@zip.com.au> writes:

> Christoph Rohland wrote:
>> 
>> Hi Zlatko,
>> 
>> On Sun, 26 May 2002, Zlatko Calusic wrote:
>> > Hi!
>> >
>> > After lots of testing, I can say that 2.5.18 works great in all
>> > three modes of ext3 for all but one purpose. Oracle database still
>> > gets corrupted during insert load. More precisely, online redo log
>> > gets corrupted, database panics and restore is in order.
>> >
>> > This leads me to thinking that there's something wrong with sysv
>> > shared memory in 2.5.x. Although the problem could also be in
>> > fsync() or swap_out() & co. paths, it's yet to be discovered.
>> >
>> > It could also be that journaled mode helps the trouble, and it could
>> > be that some swapping makes it more certain, but none of these two
>> > facts are proved for sure. Take it as an observation.
>> >
>> > Christoph, I don't know if you're still taking care of shmem in
>> > 2.5.x, so take my apologies if you didn't want to see this email.
>> >
>> > Regards,
>> > --
>> > Zlatko
>> 
>> Unfortunately I do not have the time to work on shmem right now. Hugh
>> Dickins is the right guy to contact nowadays.
>> 
>
> Most likely suspect here is the heavy fsync() load is triggering
> some timing problem in ext3 - it'll be pushing the commits though
> at high rate.
>
> I'll teach fsx-linux (great test app, btw) about fsync() and see
> how it stands up.  And if Zlatko can retest on ext2 that would be a
> big help.
>

This is just a short notice so that you know I'm working on it.

I did some testing last evening, but I need to do some more
comprehensive ones before any meaningful conclusion.

1 test: compiled ext2 in, mounted partitions as ext2, tests passed
        (no corruption)
2 test: rebooted, mounted as ext3(journal/writeback). This time even
        ext3 passed tests, so I got confused :)
3 test: pushed things harder on ext3, machine started swapping,
        restarted tests and finally it choked (some kind of smon
        non-fatal error 1/100, problem with writing scn, and instance
        shutdown)

Obviously I need to perform tests on ext2 with swap load, and repeat
them few times. Will do this evening (it takes some time to recover a
database after a corruption, so it's slightly time consuming).

Later,
-- 
Zlatko
