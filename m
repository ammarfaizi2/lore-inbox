Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288836AbSAEPQ5>; Sat, 5 Jan 2002 10:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288838AbSAEPQi>; Sat, 5 Jan 2002 10:16:38 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:45706 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S288836AbSAEPQS>;
	Sat, 5 Jan 2002 10:16:18 -0500
Date: Sat, 5 Jan 2002 16:16:02 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200201051516.QAA20961@harpo.it.uu.se>
To: mjh@vr-web.de
Subject: Re: 2.5.2-pre performance degradation on an old 486 (it's the scheduler)
Cc: axboe@suse.de, davidel@xmailserver.org, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Jan 2002 09:25:48 +0100 (CET), Matthias Hanisch wrote:
>On Sat, 5 Jan 2002, Mikael Pettersson wrote:
>
>> When running 2.5.2-pre7 on my old for-testing-only 486(*),
>> file-system accesses seem to come in distinct bursts preceded
>> by lengthy pauses. Overall performance is down quite significantly
>> compared to 2.4.18pre1 and 2.2.20pre2. To measure it I ran two
>> simple tests:
>> 
>> Test 1: time to boot the kernel, from hitting enter at the LILO
>> prompt to getting a login prompt
>> Test 2: time to "rm -rf" a clean linux-2.4.17 source tree, using
>> the newly booted kernel (no other access to the tree before that,
>> so it wasn't cached in any way, and the machine was otherwise idle)
>> 
>> 		Test 1		Test 2
>> 2.2.21pre2:	71 sec		 75 sec
>> 2.4.18pre1:	64 sec		 72 sec
>> 2.5.2-pre7:	97 sec		251 sec
>> 
>> I haven't noticed any slowdowns on my other boxes, so I didn't
>> do any measurements on them. On the 486 it's very very obvious.
>
>This is exactly, what I see with my old 486 box. It started with
>2.5.2-pre3, which contained two major items:
>
>- bio changes from Jens
>- scheduler changes from Davide
>
>Surprisingly, backing out the bio changes didn't help. Backing out the
>scheduler changes from Davide did!!

BINGO! Running 2.5.2-pre8 with the scheduler changes backed out made
all the difference! Interactive responsiveness is much improved and
performance in the above two tests I ran is back to 2.4.18pre1 levels.

With 2.5.2-pre8 vanilla the 486 is getting large variation in Test 2
above (157s, 237s, 292s), but is never even close to 2.2/2.4 levels.

>> (*) 100MHz 486DX4, 28MB ram, no L2 cache, two old and slow IDE disks,
>> small custom no-nonsense RedHat 7.2, kernels compiled with gcc 2.95.3.

/Mikael
