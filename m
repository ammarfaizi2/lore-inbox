Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263357AbUJ2PnR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263357AbUJ2PnR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 11:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263401AbUJ2Pkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 11:40:45 -0400
Received: from dsl254-100-205.nyc1.dsl.speakeasy.net ([216.254.100.205]:29680
	"EHLO memeplex.com") by vger.kernel.org with ESMTP id S263359AbUJ2PYD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 11:24:03 -0400
From: "Andrew A." <aathan-linux-kernel-1542@cloakmail.com>
To: <linux-kernel@vger.kernel.org>
Subject: RESEND: Consistent lock up 2.6.8-1.521 (and 2.6.8.1 w/ high-res-timers/skas/sysemu)
Date: Fri, 29 Oct 2004 11:23:50 -0400
Message-ID: <NFBBICMEBHKIKEFBPLMCAEEEJGAA.aathan-linux-kernel-1542@cloakmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <200410051317.48071.jstubbs@work-at.co.jp>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Try #3.  This message is being resent because it was never forwarded by majordomo, it is superceded by "RE: Consistent lock up
2.6.10-rc1-bk7 (mutex/SCHED_RR bug)" sent minutes ago, which *was* forwarded by majordomo.  I have shortened the message
considerably by including links for, rather than quoting the sysrq-t output (didn't realize the original was 552k!), and have also
mangled links suspecting majordomo spam filtering.

-----
Caveat:  This may be an infinite loop in a SCHED_RR process.  See very bottom of email for sysrq-t sysrq-p output.



I have in the past posted emails with the subject "Consistent kernel hang during heavy TCP connection handling load"  I then
recently saw a linux-kernel thread "PROBLEM: Consistent lock up on >=2.6.8" that seemed to be related to the problem I am
experiencing, but I am not sure of it (thus the cc:).

I have, however, now managed to formulate a series of steps which reproduce my particular lock up consistently.  When I trigger the
hang, all virtual consoles become unresponsive, and the application cannot be signaled from the keyboard.  Sysrq seems to work.

The application in question is called "tt1".  It runs several threads in SCHED_RR and uses select(), sleep() and/or nanosleep()
extensively.  I suspect there's a good chance the application calls select() with nfds=0 at some point.

Due to the SCHED_RR usage in tt1, before executing the tt1 hang, I have tried to log into a virtual console on the host and run
"nice -20 bash" as root.  THe nice'd shell is hung just like everything else.

Did I do it right?  I was trying to make sure this hang is not simply an infinite loop in a SCHED_RR high priority process (tt1).

I initially had a lot of trouble trying to capture sysrq output, but then I checked my netlog host and found (lo and behold) that it
had captured it!  Of course, that was before I went through the trouble of taking pictures of my monitor! I've included the netlog
sysrq output from two runs below.  They are at the very bottom of this email, separated by lines of '*'s  These runs are probably
DIFFERENT than the runs from which I produced the below screenshots.

So, here are those screenshots, I still welcome any comments you might have about easier ways to capture sysrq output than using
netdump!

I modified /etc/syslog.conf to say kern.* /var/log/kernel, however, output of sysrq-t and sysrq-p while in the locked up state never
ends up in the file (though, it does, when not locked up).

Due to apparent majordomo spam filtering, these URLs are mangled.


All of these files are at       h t t p : / / w w w . m e m e p l e x . c o m /

sysrq-t --> lock1.gif, lock2.gif

sysrq-p --> lock3.gif

Kernel symbols for above are at  System.map-2.6.8.1.gz

sysrq-t --> lock4.gif

sysrq-p --> lock5.gif

Kernel symbols for above are at System.map-2.6.8-1.521.gz and

A.

***********************************************************

same url prefix...

sysrq1.txt.gz

sysrq2.txt.gz


