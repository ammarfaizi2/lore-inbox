Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262092AbSJHLWh>; Tue, 8 Oct 2002 07:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262132AbSJHLWh>; Tue, 8 Oct 2002 07:22:37 -0400
Received: from inje.iskon.hr ([213.191.128.16]:31110 "EHLO inje.iskon.hr")
	by vger.kernel.org with ESMTP id <S262092AbSJHLWb>;
	Tue, 8 Oct 2002 07:22:31 -0400
To: Alessandro Suardi <alessandro.suardi@oracle.com>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: Shared memory shmat/dt not working well in 2.5.x
References: <Pine.LNX.4.44.0210011401360.991-100000@localhost.localdomain>
	<3D99A2F2.70102@oracle.com> <dnelbaclvo.fsf@magla.zg.iskon.hr>
	<3D99B672.2090805@oracle.com> <874rc4fzml.fsf@atlas.iskon.hr>
Reply-To: zlatko.calusic@iskon.hr
X-Face: s71Vs\G4I3mB$X2=P4h[aszUL\%"`1!YRYl[JGlC57kU-`kxADX}T/Bq)Q9.$fGh7lFNb.s
 i&L3xVb:q_Pr}>Eo(@kU,c:3:64cR]m@27>1tGl1):#(bs*Ip0c}N{:JGcgOXd9H'Nwm:}jLr\FZtZ
 pri/C@\,4lW<|jrq^<):Nk%Hp@G&F"r+n1@BoH
From: Zlatko Calusic <zlatko.calusic@iskon.hr>
Date: Tue, 08 Oct 2002 13:22:47 +0200
In-Reply-To: <874rc4fzml.fsf@atlas.iskon.hr> (Zlatko Calusic's message of
 "Wed, 02 Oct 2002 20:45:54 +0200")
Message-ID: <87ptulcgzc.fsf@atlas.iskon.hr>
User-Agent: Gnus/5.090007 (Oort Gnus v0.07) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zlatko Calusic <zlatko.calusic@iskon.hr> writes:

> Alessandro Suardi <alessandro.suardi@oracle.com> writes:
>> The more complicated bug you're talking about is the exec_mmap
>>   change introduced in 2.5.19 and fixed a handful of versions
>>   later, possibly .28, where PMON wouldn't start after 120"...
>>   I guess :)
>
> Oh, well, if that one is really fixed, then I have another one. ;)
>

Hm, not anymore!

Thanks to you guys, 2.5.41 is flawless. It works under all the tests
that were failing before. Great work!

I did some benchmarks and it looks like 2.5 is a little bit slower.  I
have two small perl+plsql applications for testing purposes,
"cucibench" benches how long it takes to parse cucitail POP daemon log
and put it into database (insert load). "mailproc" processes sendmail
log and does the same. mailproc is a little bit more complicated (it
also does updates). The results are as follows (numbers are
minutes:seconds it took to finish the task on Oracle 9.2.0.1):

| app       | 2.4.19 | 2.5.41 |
|-----------------------------|
| cucibench |  03:17 |  03:38 |
| mailproc  |  02:12 |  02:30 |
|-----------------------------|

I also observed that other application I use occasionally - LXR (Linux
source cross referencing tool) - takes much longer to generate xref
database (which is in Berkeley DB files). It works in three passes,
where the last one, when it dumps symbols into DB, is interesting. In
2.4 it finishes quickly (it uses 100% CPU, then occasionally syncs the
databases - heavy write traffic for a second - then continues), but
2.5 has problems with it (it stucks writing to disk all the time, CPU
usage is minimal and process progresses very slowly). Andrew, if
you're interested I can send you some numbers to describe the case
better.

Keep up the good work!
-- 
Zlatko
