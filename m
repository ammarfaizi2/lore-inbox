Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129054AbQJaUi4>; Tue, 31 Oct 2000 15:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129436AbQJaUiq>; Tue, 31 Oct 2000 15:38:46 -0500
Received: from www.collectingnation.com ([206.183.160.80]:43019 "EHLO
	collectingnation") by vger.kernel.org with ESMTP id <S129054AbQJaUij>;
	Tue, 31 Oct 2000 15:38:39 -0500
Date: Tue, 31 Oct 2000 15:41:59 -0500 (EST)
From: John Babina III <babina@pex.net>
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Update: 2.2.15 SMP problem...
Message-ID: <Pine.LNX.4.20.0010311531060.17340-100000@pioneer.local.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After talking with two members of the list, here is the latest situation.

I was having major problems upgrading to .17, having it crash immediately
on boot.  Yesterday due to frustration I wound up setting MEM=900 (as per
Alan Cox's suggestion) and keeping .15 running.. this seemed to be working
fine (as it had in the past), but it only ran for 18 hours so testing for
locking of the system was not fully possible (sometimes takes 2 days).

I had 1 gig of memory, same type but different brand overnighted to me to
replace, went to the machine and the following is what happened:

* At this time, .15 was running with 1 gig of memory and MEM=900 set in
lilo.  System had been up 18 hours.

* I dropped .15 down to single user mode and attempted to fsck all drives
(the drives were not properly modified due to the last crash and I
couldn't fix them remotely).  This was working fine but as soon as it hit
the second phase and tried to repair something I got a kernel crash with
an error on the screen similar to what was happening under .17... this
leads me to believe the problem was not the MEM= line, but maybe memory
issues (or something else?)

* I powered the machine down and: A) Replaced the 1 gig of memory with the
new memory.  B) Replaced the ATI Rage graphics card with a standard simple
low end card (this was done for the heck of it, due to some posts i found
on the net stating that some video cards use some system ram...)

* Then I rebooted and checked the BIOS memory options.  The memory I am
using is "registered" 256k dram ECC.  I found an option labled "Dram
Type:" with the options "none", "EC", "ECC Hardware".  I chose ECC
Hardware (why does it state "hardware"?  Is there a software ECC? -- I am
going to call the vendor in regards to this question).

* Now tried to boot .17 and it worked perfectly... I was able to fsck all
drives, no crashes, etc.  Brought up the web servers and the machine ran
for a full 15 mins with no crashes under .17 which is very good
(considering yesterday I couldn't get the thing to stay up 1 min without a
crash).

Since .15 still crashed with MEM=900 set, I am assuming the problem was
most likely bad memory or the Dram type setting... anyone have any
thoughts on this?  I unfortunately cannot afford at this time to keep the
system down for long periods of time to trace the problem down exactly.

As for the 24-48 hour lockups, I will have to wait and see if they still
occur under .17.  As per previous posts I am running a high TCP/IP load
which Alan suggested may be fixed under .17.

One other question, since there is a bug not allowing the bios to detect
how much memory you have, is there any patch I can put into a 2.2.x kernel
or a program to run after bootup to find out the max MEM= setting which is
appropriate, without having to do blind tests changing the amount until it
crashes?

I want to thank everyone for their help so far.
-John

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
