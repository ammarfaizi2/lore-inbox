Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131460AbRC0RId>; Tue, 27 Mar 2001 12:08:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131459AbRC0RIX>; Tue, 27 Mar 2001 12:08:23 -0500
Received: from zooty.lancs.ac.uk ([148.88.16.231]:64748 "EHLO
	zooty.lancs.ac.uk") by vger.kernel.org with ESMTP
	id <S131457AbRC0RIL>; Tue, 27 Mar 2001 12:08:11 -0500
Message-Id: <l0313033ab6e6722b2f33@[192.168.239.101]>
In-Reply-To: <NEBBLEJBILPLHPBNEEHIKECICBAA.michel@procyon14.yi.org>
In-Reply-To: <l03130337b6e65e809070@[192.168.239.101]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 27 Mar 2001 18:07:14 +0100
To: "Michel Wilson" <michel@procyon14.yi.org>, <linux-kernel@vger.kernel.org>
From: Jonathan Morton <chromi@cyberspace.org>
Subject: RE: [PATCH] OOM handling
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> relative ages.  The major flaw in my code is that a sufficiently
>> long-lived
>> process becomes virtually immortal, even if it happens to spring a serious
>> leak after this time - the flaw in yours is that system processes
>
>I think this could easily be fixed if you'd 'chop off' the runtime at a
>certain point:
>
>if(runtime > something_big)
>	runtime = something_big;
>
>This would of course need some tuning. The only thing i don't like about
>this is that it's a kind of 'magical value', but i suppose it's not a very
>good idea to make this configurable, right?

Configurable is good, but right now I'm considering alternative (but
reasonably similar) algorithms.  If I can come up with something that works
reasonably well under all the scenarios I can think up - which is quite a
range - then configurable options may not be necessary.  In any case, other
work I'm doing should make OOM a thing of the past on most systems, since
malloc() and other memory-reservation calls will normally fail before OOM
happens.

It might just happen that totally different algorithms apply best to
different usage patterns, and I can put in some logic to try and detect
these patterns as needed, selecting the most appropriate algorithm.  An
embedded system is very different from a large batch-computation system,
and likewise for an Internet server, multiuser host, or single-user
workstation.  Internet servers come in different sizes, too - the 486 NAT
and web proxy differs considerably from the dedicated mail/web/database
server.

What would really help me is if a number of people with boxen under each of
the above loads could send me a "snapshot" of their system, under normal
load, containing the following info:

- General usage pattern description, in plain English
- Physical and swap memory: total sizes and current utilisation, in MB
- System uptime in days
- Summary of processes running at that instant, including for each process:
	- Approximate UID range
	- SIZE (not RSS, I want total size)
	- CPU time (with separate user and system totals if possible)
	- run time
Generalisations would probably be helpful - I don't expect to receive a
list of 500 emacs and bash processes, but indications of the distribution
of the above values for sensible groupings of processes would be valuable.
Of course, if you group processes, include information on how many process
you're grouping.  :)

For your security and protection, it would probably not be wise to indicate
the hostname or IP address(es) of the systems you profile in this manner.
You may, however, wish to invent codenames for the machines in case it
becomes necessary to refer to specific cases.  Profiles can be sent to me
at <chromi@cyberspace.org>, please include the string [SNAPSHOT] in the
subject for easy identification.

--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)
big-mail: chromatix@penguinpowered.com
uni-mail: j.d.morton@lancaster.ac.uk

The key to knowledge is not to rely on people to teach you it.

Get VNC Server for Macintosh from http://www.chromatix.uklinux.net/vnc/

-----BEGIN GEEK CODE BLOCK-----
Version 3.12
GCS$/E/S dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$ V? PS
PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r++ y+(*)
-----END GEEK CODE BLOCK-----


