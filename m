Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264745AbTA1DeN>; Mon, 27 Jan 2003 22:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264838AbTA1DeN>; Mon, 27 Jan 2003 22:34:13 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:38665 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S264745AbTA1DeL>; Mon, 27 Jan 2003 22:34:11 -0500
Date: Mon, 27 Jan 2003 22:40:34 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: jordan.breeding@attbi.com
cc: Arador <diegocg@teleline.es>, akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: Re: 2.5.59-mm5: cpu1 not working
In-Reply-To: <20030127222749.5591313CF0@blue.rahul.net>
Message-ID: <Pine.LNX.3.96.1030127222932.29138A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jan 2003 jordan.breeding@attbi.com wrote:

> > On Mon, 27 Jan 2003 16:34:22 -0500 (EST)
> > Bill Davidsen <davidsen@tmr.com> wrote:
> > 
> > > That's the thing I would expect to see if you used 'noapic' and watchdog. 
> > > I posted over the weekend that I have been seeing some inobvious results
> > > to IPC benchmarking with scombinations of noapic and watchdog, but I
> > > didn't snap the interrupts. I'll be happy to add that to my list of stuff
> > > to try next weekend, but the box is not a toy during the week, and I would
> > > have a five hour round trip drive if a reboot failed, so I'll pass on
> > > trying it until I'll in the same room. 
> > 
> > no "noapic" here:
> > 
> > kernel /boot/linux-2.5.59-mm5 root=/dev/hda5 ro vga=0x30a profile=2 
> > nmi_watchdog=1

> There was a seperate thread about this a couple of days ago.  It boils
> down to this:  if there isn't sufficient load on your CPUs then it is
> both easier and faster to have one CPU handle all of the interrupts, if
> there is sufficient load on your CPUs then the kirq patch distributes
> the interrupts accordingly.  I can verify that this behavior is
> consisent with what I see on my dual Xeon box (shows up as 4 ht capable
> CPUs).  As long as your second CPU is showing up in /proc/cpuinfo and in
> top then the CPU is working it just isn't having to handle any
> interrupts yet. 

The reason I mentioned noapic is that when running with the apic I see a
very good balance on a system with minimal load other than CPU. Since
there was a count on NMI the watchdog was clearly on. But on my test
system, I just check the count and the balance is very good:

Script started on Mon Jan 27 22:38:37 2003
bash-2.05a$ uname -a
Linux bilbo.tmr.com 2.5.59 #6 SMP Sat Jan 25 19:46:18 EST 2003 i686 unknown
bash-2.05a$ cat /proc/interrupts 
           CPU0       CPU1       
  0:   88705542   91864773    IO-APIC-edge  timer
  1:        853        850    IO-APIC-edge  i8042
  2:          0          0          XT-PIC  cascade
  3:       7752       7269    IO-APIC-edge  NE2000
  8:          1          1    IO-APIC-edge  rtc
  9:          0          0   IO-APIC-level  uhci-hcd
 11:      24218      28443   IO-APIC-level  ide2
 12:         26         26    IO-APIC-edge  i8042
 14:     664226     665346    IO-APIC-edge  ide0
 15:          1          1    IO-APIC-edge  ide1
NMI:          0          0 
LOC:  180596403  180596410 
ERR:         25
MIS:          0
bash-2.05a$ exit

Script done on Mon Jan 27 22:39:00 2003

The system is up >24hr, so the irq counts reflect very little io. Running
noapic obviously puts all the ints on CPU0.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

