Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131621AbQJ2Kqk>; Sun, 29 Oct 2000 05:46:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131632AbQJ2Kqb>; Sun, 29 Oct 2000 05:46:31 -0500
Received: from mpoli.fi ([62.236.132.1]:45836 "EHLO mpoli.fi")
	by vger.kernel.org with ESMTP id <S131621AbQJ2KqX>;
	Sun, 29 Oct 2000 05:46:23 -0500
Date: Sun, 29 Oct 2000 12:46:17 +0200
From: Olli Lounela <olli@mpoli.fi>
To: linux-kernel@vger.kernel.org
Subject: 2.2.18pre17 + vm critical fix success
Message-ID: <20001029124617.A12028@mpoli.fi>
Reply-To: olli@mpoli.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just thought others besides Alan would want to know. There's some new data
too (and typo fixes, now that I'm at it :)

-----klippeti-----klippeti-----klippeti-----klap-----

I'd like to report a successful heavy-duty test of 2.2.18pre17 with Andrea's
strict-VM-corruption-fix-1 (denoted 'vmfix' below).

Hardware: Intel P3 @ 600 MHz, 256 MB RAM, Intel srcu21 i2o RAID controller
with 16 MB extra RAM DIMM (20 MB total, methinks), 3x18 GB LVD disk in
raid5 config.

I ran overnight:

   1. seti@home
   2. looping kernel compile with -j 18

and to create some more memory pressure,

   3. looping find /usr /var -type f -ls > /dev/null

Of course this ate all memory. Load was constantly above 20. No problems.

In the morning, I downloaded Apache sources complex as per the makefile
available in <URL: http://gothic.777-team.org/Software/Makefile-Apache > and
ran 'make apache_ssl' with -j 8 in a loop in addition to the above. Load was
constantly above 40, peaking at about 120.

Slightly dismayed that this would produce no appreaciable effect, I decided
on a real torture test. I booted with 'mem=24m', and ran 

   1. seti@home
   2. kernel make with -j 3
   3. the find as above

This led to severe thrashing, with processor idle approximately 80% due to
swapping. Swap was higher than the 'physical', over 26 MB in swap (as
opposed to 24 MB declared for linux).

The last test produced 'vm cannot free page' four times, about 20 min apart,
in the 1.5 hr test run (I had to deliver the machine to client soon after),
and it occurred just once each time. The machine remained useable, though
latencies went high with excessive thrashing. Even so, once the process got
loaded into memory, interactivity was much better than I expected.

Distribution is fully updated RH 6.2.

I'm the main maintainer of a small ISP's linux boxen, about 5 in all. I've
deployed the kernel in our main servers, one is already in production use,
the other waits for further experiences before boot. 

-----palk-----iteppilk-----iteppilk-----iteppilk-----

New data:

The server now deployed with 2.2.18pre17+vmfix has suffered from recurrent
memory shortage, and was downgraded from plain 2.2.18pre3 to 2.2.16 because
of looping in 'vm cannot free page', eventually killing too many service
processes, even though didn't succeed in crashing the machine. In a bit over
24 hrs since installing 2.2.18pre17+vmfix there's been no problems
whatsoever.

This server is our secondary nameserver (we run a domain hotel), primary
SMTP, user shell and ftp server (not for anon ftp), plus several non-
critical things. If it werent expected after the torture test, I'd be really
impressed that it has survived nightly cron jobs without a hitch. Of course,
Monday will show how it stands in the real load. This is heavily updated 
RH 6.1 running in puny Celeron @ 300 MHz, 128 MB RAM, and about 40 GB in two
IDE disks.

I'm not on the list, so all questions directly via e-mail to 
    olli(at)mpoli.fi

(Oh, I do read LKML, but from web archives.)

Yours,

-- 
    Olli               ...and he thought I'm serious! Hahahaha...
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
