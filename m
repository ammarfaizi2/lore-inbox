Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278332AbRJSHjI>; Fri, 19 Oct 2001 03:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278330AbRJSHi5>; Fri, 19 Oct 2001 03:38:57 -0400
Received: from eamail1-out.unisys.com ([192.61.61.99]:57034 "EHLO
	eamail1-out.unisys.com") by vger.kernel.org with ESMTP
	id <S278329AbRJSHin>; Fri, 19 Oct 2001 03:38:43 -0400
Message-ID: <DD0DC14935B1D211981A00105A1B28DB05298FB8@NL-ASD-EXCH-1>
From: "Leeuw van der, Tim" <tim.leeuwvander@nl.unisys.com>
To: linux-kernel@vger.kernel.org
Subject: Case where VM of 2.4.13pre2aa falls apart
Date: Fri, 19 Oct 2001 02:39:00 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've observed a case where the VM of 2.4.13pre2aa totally falls apart. I
know it's not the latest of Andrea's VM tweaks, but I didn't yet get a
chance to compile&reboot into a later version. I've noticed a similar
breakdown in one of the first pre-release kernels with the Andrea VM, btw.

Unfortunately I don't have any numbers, so it's just a story. I guess it
would be useful to run vmstat in the background, at least from time to time?
Anything else that could give useful information?

Anyways.

In the evening I was browsing the web with Mozilla, and I was trying to
compile a newer kernel. This went quite smooth. In the morning before going
to the office, I did apt-get dist-upgrade of the system with Mozilla still
running on another desktop.
In the evening I came back, checked the result of this system upgrade; the X
server and terminal windows on that desktop were totally responsive. Mozilla
had an RSS of around 2.5Mb, and about 18Mb in swap according to top. Not
unusual after such activity.

Then I switched to the desktop with Mozilla and everything fell apart.
Mozilla, which hadn't been used for nearly 24 hours, had big trouble to get
going again. Once it displayed it's interface again (instead of a black
window) it took forever get it to respond to mouseclicks. At this time the X
server and windowmaker started stuttering too. I switched back to the
desktop with terminal windows, they were responsive except for the
stuttering X server. I noticed in top that Mozilla's RSS was about half of
what it normally was, and going down again.
Switching back to the Mozilla desktop again it had a black window, as if it
was mostly swapped out again. For several minutes it was really hard to do
anything with Mozilla, the system was constantly busy with it's disks and (I
guess) constantly paging things in and out. After it became useable, it was
still not smooth.
The rest of the evening I didn't have a chance to touch the computer again;
in the weekend I'll try to gather more useful data.

It seems that Mozilla was severely punished for not being used for such a
long time, and had to fight very very hard to earn a place back in memory. I
was not doing anything else with the computer in the evening, I wasn't
compiling. The evening before everything was smooth while compiling, now it
was pathological while not doing anything.

I noticed that the cache was very small, but I can't remember of it was
around 4.5Mb or 8Mb, sorry! In any case, much lower than in older version of
2.4kernels where it was usually around 16Mb, 20Mb or even more. I don't know
what is counted towards the cache in top? Just datafiles, or also
executables and shared libraries which are loaded?


In an earlier version of the Andrea VM I had a similar case: At night I
logged in to Gnome, with nautilus running in background, and did some
browsing with Galeon. In the morning I wanted to do something at the
computer, after it had been idle all night and running it's cron jobs. I
opened a nautilus window, and wanted to browse the web a bit.  I was unable
to do either of them; it was a disaster. Of course, this is with two
memory-hogs running at the same time. But I've gotten faster response from
the computer under worse memory stress.


In conclusion, it really seems to me that the VM of Andrea performs
wonderful when you boot and start working, but when you give the system a
chance to swap out your programs (running apt-get upgrade, cron jobs with a
lot of find and updatedb, etc) the VM falls apart completely when you want
to return to those programs. What was before a beautifully smooth workingset
is now unable to get back into memory and become smooth again until after
you try for 10, 15, 20 minutes.
I don't recall it ever being that bad.

I will try Rik's VM whenever I get a chance for behaviour under similar
circumstances. Meanwhile, I'm open to any hints that ppl can give me on how
to collect the most useful statistics without overkill (24 hours worth of
continuous vmstat-output is probably worthless because it's too much).

with regards,

--Tim


