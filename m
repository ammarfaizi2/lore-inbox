Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129115AbRBWRZt>; Fri, 23 Feb 2001 12:25:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129156AbRBWRZa>; Fri, 23 Feb 2001 12:25:30 -0500
Received: from cthulhu.lls.se ([193.15.114.2]:28596 "HELO cthulhu.lls.se")
	by vger.kernel.org with SMTP id <S129115AbRBWRZH>;
	Fri, 23 Feb 2001 12:25:07 -0500
From: "Magnus Walldal" <magnus.walldal@b-linc.com>
To: "Rik van Riel" <riel@conectiva.com.br>
Cc: <kuznet@ms2.inr.ac.ru>, <linux-kernel@vger.kernel.org>
Subject: RE: 2.4.1 under heavy network load - more info
Date: Fri, 23 Feb 2001 18:26:06 +0100
Message-ID: <HFEDLHHPHHEOBHLNPJOKGEIECAAA.magnus.walldal@b-linc.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <Pine.LNX.4.31.0102212031240.21127-100000@localhost.localdomain>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> In that case, could I see some vmstat (and/or top) output of
> when the kernel is no longer able to keep up, or maybe even
> a way I could reproduce these things at the office ?

Interactive response is actually pretty OK, the only thing I'm seeing is
short (about 1 sec) pauses, they could be due to network problems or VM
stuff...
hard to say because I work with the machine over the net and not from
console.
What I do see during these short pauses is that sendq is building up on the
remote end, nothing happens for a short while and then things continue as
nothing bad happened ;)

It feels like a subtle problem, nothing terribly wrong, but the system does
not feel
100% OK either. Be it a networking or a VM-problem.

Some data from vmstat
root@mcquack:/root# vmstat 3
   procs                      memory    swap          io     system
cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy
id
 1  0  0  76572   2400    324  48160   4   2     1     1   22    14  47  39
14
 1  0  0  76572   2400    324  48160   0   0     0     1 3889     5  49  51
0
 1  0  0  76572   2400    324  48160   0   0     0     1 3698     7  48  52
0
 1  0  0  76572   2400    324  48160   0   0     0     0 3759     6  46  54
0
 1  0  0  76572   2400    324  48160   0   0     0     0 2987     6  48  52
1
 1  0  0  76572   2400    324  48160   0   0     0     0 3015     5  46  54
0
 1  0  0  76572   2400    324  48160   0   0     0     0 4024     4  45  55
0
 2  0  0  76572   2396    324  48160   0   0     0     0 4066    21  44  42
14
 1  0  0  76572   2400    324  48160   0   0     0     0 3995    75  29  26
44
 1  0  0  76572   2400    324  48160   0   0     0     0 3747    30  43  40
16
 1  0  0  76572   2400    324  48160   0   0     0     0 3568     5  44  56
0
 1  0  0  76572   2400    324  48160   0   0     0     0 3942     4  43  57
0
 1  0  0  76572   2400    324  48160   0   0     0     0 3702     5  44  56
0
 1  0  0  76572   2376    320  48176   0   0     0     0 3994    50  33  32
34
 1  0  0  76572   2376    320  48176   0   0     0     0 3637    31  25  24
51
 1  0  0  76572   2376    320  48176   0   0     0     0 3445     5  48  52
0
 1  0  0  76572   2376    320  48176   0   0     0     0 3709     5  52  48
0

This goes on and on, long periods of zero idle time and then a short period
with some idle time and some more cs, the "short pauses" are (when they
happen to occur) just before or slightly after the period with more context
switches.

Top says:
 4:53pm  up 5 days, 13:42,  1 user,  load average: 0.62, 0.69, 0.64
22 processes: 19 sleeping, 3 running, 0 zombie, 0 stopped
CPU states: 47.1% user, 52.8% system,  0.0% nice,  0.0% idle
Mem:   127264K av,  125052K used,    2212K free,       0K shrd,     452K
buff
Swap:  499960K av,   76680K used,  423280K free                   48480K
cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT  LIB %CPU %MEM   TIME COMMAND
 1152 adm       20   0  110M  78M 42792 R       0 99.3 63.1  6772m ircd


Btw..the box is a PII-450 so it's not terribly slow ;)


> I'm really interested in things which make Linux 2.4 break
> performance-wise since I'd like to have them fixed before the
> distributions start shipping 2.4 as default.


As always, I'm happy to provide you with more information if I can!

Regards,
Magnus

