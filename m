Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132689AbRDOPhO>; Sun, 15 Apr 2001 11:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132690AbRDOPhE>; Sun, 15 Apr 2001 11:37:04 -0400
Received: from mail.gator.com ([63.197.87.182]:38149 "EHLO mail.gator.com")
	by vger.kernel.org with ESMTP id <S132689AbRDOPg5>;
	Sun, 15 Apr 2001 11:36:57 -0400
From: "George Bonser" <george@gator.com>
To: "Rik van Riel" <riel@conectiva.com.br>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: 2.4 stable when?
Date: Sun, 15 Apr 2001 08:38:47 -0700
Message-ID: <CHEKKPICCNOGICGMDODJCEODCLAA.george@gator.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <Pine.LNX.4.21.0104151151280.14442-100000@imladris.rielhome.conectiva>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> > Is there any information that would be helpful to the kernel
> > developers that I might be able to provide or is this a known issue
> > that is currently being worked out?
>
> I never heard about this problem.  What would be helpful is to
> send a few minutes' (a full 'load cycle'?) worth of output from
> 'vmstat 5' and some information about the configuration of the
> machine.
>
> It's possible I'll want more information later, but just the
> vmstat output would be a good start.
>
> If the data isn't too big, I'd appreciate it if you could also
> CC linux-mm@kvack.org.
>
> regards,

Sounds good. I think I can do this.  Also, it appears that the problem is
related to how busy the farm is.  The machines are load balanced in a "least
connections" mode. There are 5 servers in the farm. Suppose I have 300
connections to each machine and reboot one to load the new kernel.

When that server comes back up it is handed 300 connections all at once. It
seems (and this is subjective ... does it handle things differently with
more than 256 processes?) that when I give the machine much more than 200
connections, it is very slow to clear them.  It seems to have trouble at
that point clearing connections as fast as it is getting them. If I have
less than 200 connections initially, it seems to handle things OK.

I tried to collect some data last night but it appeared to work ok. I will
wait for the load to come up later today and try it during its peak time.
While I could put the balancer into a "slow start" mode, 2.2 always seemed
to handle the burst of new connections just fine so I didn't bother.

The machine is a UP Pentium-III 800MHz with 512MB of RAM running Debian
Woody. It is a SuperMicro 6010L 1U unit with the SuperMicro 370DLR
motherboard. This uses the ServerWorks ServerSet III LE chipset and Adaptec
AIC-7892 Ultra160 disk controller and on-board dual Intel NIC (only using
eth0).

I have cut the configuration pretty much to the bone, no NetFilter support,
no QoS, no Audio/Video. Tried to get it as plain vanilla as possible (my
first step when having problems).

I was able to run 2.4.0-test12 in this application and did for quite some
time. I don't recall trying 2.4.1 but I know I had severe problems with
2.4.2 and 2.4.3. Now that I think about it, I am not sure the farm was as
busy back when I put 2.4.0 on it or that I ever rebooted during my peak
period. This might have been a problem all along but I just never saw it. It
seems to have to do with handing the machine a large number of connections
at once and then a stream of them at a pretty good clip. It is getting about
40 connections/second right this minute but that should come up a bit in the
next couple of hours.

To be quite honest, I could run this on 2.2 forever, it is just a webserver.
My only reason for using 2.4 would be to see if I can go SMP on these things
when my load gets higher and I get some benefit of the finer granularity of
2.4 in SMP to serve a higher load with fewer machines than would be possible
with 2.2. That, and just to beat on a 2.4 kernel and report any problems to
you guys.


