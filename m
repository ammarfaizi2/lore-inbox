Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278336AbRJMSGF>; Sat, 13 Oct 2001 14:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278338AbRJMSF4>; Sat, 13 Oct 2001 14:05:56 -0400
Received: from mail3.aracnet.com ([216.99.193.38]:29196 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S278336AbRJMSFo>; Sat, 13 Oct 2001 14:05:44 -0400
From: "M. Edward Borasky" <znmeb@aracnet.com>
To: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: RE: Which is better at vm, and why? 2.2 or 2.4
Date: Sat, 13 Oct 2001 11:06:16 -0700
Message-ID: <HBEHIIBBKKNOBLMPKCBBKEOIDOAA.znmeb@aracnet.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <E15sSOG-0003Fb-00@the-village.bc.nu>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Alan Cox
> Sent: Saturday, October 13, 2001 10:16 AM
> To: Patrick McFarland
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: Which is better at vm, and why? 2.2 or 2.4
> > Now, the great kernel hacker, ac, said that 2.2 is better at vm
> in low memo=
> > ry situations than 2.4 is. Why is this? Why hasnt someone fixed
> the 2.4 cod=
> > e?
> Actually they have on thw whole. However VM tuning is a hard problem

Ah! Finally the t-word!! Yes, VM "tuning" is a hard problem. Because any
full-strength operating system, whether Windows NT, Linux, some other flavor
of UNIX or even MVS, can be used to support a variety of computational
endeavors, it is almost impossible to come up with a fixed "algorithm" that
will effectively support all legitimate usage patterns while protecting
users as much as possible from pathological usage patterns. Therefore ...

Most operating systems allow one to *measure* performance variables and give
system managers *control knobs* they can use to tune policy to a given
usage. For example, I once worked on a system where there were three modes.
During the day, the system was tuned for interactive users, on the swing
shift it was tuned to a mix of batch jobs and system administration
functions like backups, and on the graveyard shift it ran nothing but huge
batch jobs.

Linux certainly has the measurement capabilities; I've been able to find
everything I need in /proc for the monitoring and analysis I need to do. On
the control knobs, I think Linux falls short relative to, say, Solaris,
Tru64, VMS and Windows 2000. Nearly all decisions seem to be "hard-wired" in
Linux, for example, the goodness boosts given to processes to promote soft
affinity, the time slice, and the fractions of memory allocated to the
various functions: buffers, cached, etc. They are set as #defines in header
files. Even having them as variables would be an improvement; then they
could be examined and modified with a debugger.

I would like to be able to set up a test system in my laboratory, fire up a
benchmark that emulates a real-world workload and tweak these parameters
somewhere in /proc in real time, while watching the response times of my
benchmark transactions. I can do this in Tru64, I can do this in a number of
other operating systems. Right now, for all practical purposes, when I want
to perform an experiment like this, I need to recompile, quite often, the
*entire* kernel, reboot and re-run my benchmark. In other words, if the
parameters were tunable, what now takes *days* to do could be accomplished
in hours, even minutes, with just a little up-front work.
--
M. Edward (Ed) Borasky, Chief Scientist, Borasky Research
http://www.borasky-research.net
mailto:znmeb@borasky-research.net
http://groups.yahoo.com/group/BoraskyResearchJournal

Q: How do you tell when a pineapple is ready to eat?
A: It picks up its knife and fork.

