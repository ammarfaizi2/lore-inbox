Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261888AbUDCTPt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 14:15:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261897AbUDCTPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 14:15:49 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:12694 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261888AbUDCTPq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 14:15:46 -0500
From: "R. J. Wysocki" <rjwysocki@sisk.pl>
Organization: SiSK
To: linux-kernel@vger.kernel.org
Subject: 2.6.[45]-.*: weird behavior
Date: Sat, 3 Apr 2004 21:22:54 +0200
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200404032122.54823.rjwysocki@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

For quite some time I've been observing strange keyboard problems with the 
kernels 2.6.4 and above.  Namely, in a GUI, the keyboard (which is a PS/2) 
sometimes seems to get "locked" for some time (usually for a couple of 
seconds) even if there's no any process running in the background (of course 
there are some processes in the background but they are all sleeping).  By 
saying "locked" I mean that the kernel does not seem to accept any keyboard 
input whatsoever at that time, but after the kayboard gets "unclocked" it 
properly passes all of the characters typed in the meantime to applications.

Moreover, it often takes more time to "unlock" the keyboard (up to 30 sec. or 
so), in which case I can speed up the proccess by switchig windows with a 
mouse (usually it is sufficient to switch once to another window, but 
sometimes more window switching is necessary).

Some days ago I noticed that similar problem occured for example when I tried 
to unpack the kernel source: the tar process had apparently been suspended 
for several times for up to 10 sec., so it took more than approx. 3 min. to 
unpack the source (usually it takes no more than 30 sec.).  There were not 
any processes running in the background, though.

I noticed that this happened after updatedb had finished so I tried to 
recreate this by running updatedb once again and than unpacking the kernel 
once again and the problem reappeared.  I'd run top before and I found that 
the CPUs were spending 90+ percent of the time on IO-wait (the system is a 
dual AMD64 w/ NUMA w/o kernel preemption).  Strange.

I thought it was accidental (the kernel was 2.6.5-rc3-mm2), but yesterday I 
noticed that the keyboard "locking" occured even more often after I had 
installed the 2.6.5-rc3-mm4 kernel (it happened after the machine had been - 
seemingly - idle for some time).  I ran top and that's what it showed me:

top - 23:14:39 up  3:21,  1 user,  load average: 1.24, 1.12, 1.05
Tasks: 111 total,   1 running, 110 sleeping,   0 stopped,   0 zombie
Cpu(s):   0.5% user,   0.0% system,   0.0% nice,  50.0% idle,  49.5% IO-wait
Mem:   1030060k total,  1000820k used,    29240k free,    18724k buffers
Swap:  1050608k total,     3520k used,  1047088k free,    50168k cached

and it had been showing similar things for a minute or so, which is a kind of 
weird, IMHO.  I mean, the only running process was the top itself, so I don't 
get the 49.5% IO-wait.

Then I thought it was a NUMA-related issue but today I had the "keyboard 
locking problem" on a Celeron (Coppermine)-based laptop running the 2.6.5-rc3 
with exactly the same symptoms (apparantly, the kernel stopped accepting the 
keyboard input or at least passing it to applications - I couldn't even 
switch from X to a console - and then, when I closed some windows with a 
mouse preparing the system for reboot, the keyboard got "unlocked" and it 
started to work as usual).  So, there are two different (though a bit 
similar) architectures affected, it seems.

Now, can you please tell me what may cause such a behavior?  I really would 
like to narrow it, so please tell me what I can do for this purpose (I've no 
idea whatsoever).

Yours,
Rafael

-- 
Rafael J. Wysocki,
SiSK
[tel. (+48) 605 053 693]
----------------------------
For a successful technology, reality must take precedence over public 
relations, for nature cannot be fooled.
					-- Richard P. Feynman


