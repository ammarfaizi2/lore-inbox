Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286468AbSANPjp>; Mon, 14 Jan 2002 10:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286959AbSANPjf>; Mon, 14 Jan 2002 10:39:35 -0500
Received: from colorfullife.com ([216.156.138.34]:29196 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S286468AbSANPjY>;
	Mon, 14 Jan 2002 10:39:24 -0500
Message-ID: <3C42FBA7.B1084B4D@colorfullife.com>
Date: Mon, 14 Jan 2002 16:39:19 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.2-pre11 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
CC: Rusty Russell <rusty@rustcorp.com.au>, mingo@elte.hu,
        linux-kernel@vger.kernel.org
Subject: Re: cross-cpu balancing with the new scheduler
In-Reply-To: <Pine.LNX.4.40.0201131842570.937-100000@blue1.dev.mcafeelabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> 
> I've a very simple phrase when QA is bugging me with these corner cases :
> 
> "As Designed"
> 
> It's much much better than adding code and "Return To QA" :-)
> I tried priority balancing in BMQS but i still prefer "As Designed" ...
>
Another test, now with 4 process (dual cpu):
#nice -n 19 ./eatcpu&
#nice -n 19 ./eatcpu&
#./eatcpu&
#nice -n -19 ./eatcpu&

And the top output:
<<<<<<
73 processes: 68 sleeping, 5 running, 0 zombie, 0 stopped
CPU0 states: 100.0% user,  0.0% system, 100.0% nice,  0.0% idle
CPU1 states: 98.0% user,  2.0% system, 33.0% nice,  0.0% idle
[snip]
PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
 1163 root      39  19   396  396   324 R N  99.5  0.1   0:28 eatcpu
 1164 root      39  19   396  396   324 R N  33.1  0.1   0:11 eatcpu
 1165 root      39   0   396  396   324 R    33.1  0.1   0:07 eatcpu
 1166 root      39 -19   396  396   324 R <  31.3  0.1   0:06 eatcpu
 1168 manfred    1   0   980  976   768 R     2.7  0.2   0:00 top
[snip]

The niced process still has it's own cpu, and the "nice -19" process has
33% of the second cpu.

IMHO that's buggy. 4 running process, 1 on cpu0, 3 on cpu1.

--
	Manfred
