Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129097AbQKMWYe>; Mon, 13 Nov 2000 17:24:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129388AbQKMWYZ>; Mon, 13 Nov 2000 17:24:25 -0500
Received: from sgi.SGI.COM ([192.48.153.1]:32581 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S129097AbQKMWYI>;
	Mon, 13 Nov 2000 17:24:08 -0500
From: "LA Walsh" <law@sgi.com>
To: "lkml" <linux-kernel@vger.kernel.org>
Subject: writing out disk cache
Date: Mon, 13 Nov 2000 13:52:39 -0800
Message-ID: <NBBBJGOOMDFADJDGDCPHKEJDCJAA.law@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another question that's been bugging me -- this is behavior that seems
identical in 2216/2217 and not related to my ealier performance degredation
post.

I run VMware.  It runs w/144Mg and writes out a 153M suspend file when I
suspend it to disk.  My system has a total of 512M, so the entire
suspend file gets written to the disk buffers pronto (often under 1 second).

But a 'sync' done afterwards can take anywhere from 20-40 seconds.
vmstat shows a maximum b/o rate of 700, with 200-500 being typical.

So, I know that the maximum write rate through the disk cache is
close to 10,000 blocks/second.  So why when the disk cache of a
large file is 'sync'ed out, do I get such low b/o rates?

Two sample 'vmstat 5' outputs during a sync were:
 1  0  0   6292  13500 254572 165712   0   0     1     0  119   282   1   1
98
 2  0  0   6292  13444 254572 165716   0   0     0   702  279   534   0   2
98
 1  1  0   6292  13444 254572 165716   0   0     0   501  352   669   0   1
99
 0  1  0   6292  13444 254572 165716   0   0     0   520  372   697   0   2
97
 1  0  0   6292  13444 254572 165716   0   0     0   510  367   694   0   2
98
 0  1  0   6292  13444 254572 165716   0   0     0   694  379   715   0   2
98
 1  0  1   6292  13444 254572 165716   0   0     0   618  391   964   0   2
98
 0  1  1   6292  13444 254572 165716   0   0     0   441  302   765   0   1
98
 0  0  0   6292  13496 254572 165716   0   0     0    63  180   355   1   1
99
 0  0  0   6292  13496 254572 165716   0   0     0     0  103   195   0   1
99
----and
 0  0  0   6228  18836 246036 167824   0   0     0     0  232   563   6  13
82
 0  1  0   6228  18784 246036 167824   0   0     0   506  175   489   2   1
97
 1  0  0   6228  18780 246036 167824   0   0     0   292  305   647   0   1
99
 0  1  0   6228  18780 246036 167824   0   0     0   253  285   602   0   1
99
 0  1  0   6228  18780 246036 167824   0   0     0   226  289   612   0   1
99
 1  0  0   6228  18832 246036 167824   0   0     0   157  199   406   0   1
99
 0  0  0   6228  18832 246036 167824   0   0     0     0  101   240   1   1
99
---
	Another oddity -- If you add up the rates in the 2nd example, and multiply
the average rate by 5, you get around 5200 blocks written out (for a 152M
file).
Note that a du on it shows it to use 155352, so it isn't that it is sparse.

	Is vmstat an unreliable measure?  The above tests were on a 2216 system.

-l

--
L A Walsh                        | Trust Technology, Core Linux, SGI
law@sgi.com                      | Voice/Vmail: (650) 933-5338

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
