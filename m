Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281233AbRKEQsA>; Mon, 5 Nov 2001 11:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281226AbRKEQru>; Mon, 5 Nov 2001 11:47:50 -0500
Received: from mustard.heime.net ([194.234.65.222]:56465 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S281227AbRKEQrd>; Mon, 5 Nov 2001 11:47:33 -0500
Date: Mon, 5 Nov 2001 17:47:29 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: Mark Hahn <hahn@physics.mcmaster.ca>
cc: <linux-kernel@vger.kernel.org>, Tux mailing list <tux-list@redhat.com>
Subject: Re: Lots of questions about tux and kernel setup
In-Reply-To: <Pine.LNX.4.10.10111051119360.13543-100000@coffee.psychology.mcmaster.ca>
Message-ID: <Pine.LNX.4.30.0111051734490.19897-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ~220 MB/s.  I'm not sure why you expect this to be a problem.

because of the pci busses, memory etc. it's got to be read and
transmitted. I'll be glad if i don't need to worry

> why?  VM in general is designed to have swap.  why would it hurt?

well... i thought of potential dropouts... i don't know why... forget it

> neither tux nor sendfile have anything to do with the caching,
> which is done by the kernel (VM and FS readahead, if any).
>
> > sendfile read the file into the cache buffer before sending it? I mean - I
> > can't keep the files in memory, so how much would do?
>
> VM works by scavenging not recently or frequently-used pages.

Does this mean the system could run smoothly on very low memory - say -
128MB RAM?

> > Q: If using the bandwidth control in Tux, how much CPU overhead may I
> > expect per stream (sizes as mentioned above)?
>
> trivial, I expect.  after all, each stream has a trivial bandwidth,
> and bandwidth-control just needs to take a few looks at some timer.
> as I recall, tux uses rdtsc in a smart way to avoid gettimeofday
> syscalls.

Good...

> > Q: Do anyone know what SCSI and NIC (1 or 10Gb-Ethernet) that have low or
> > high CPU overhead? I have the impression that there are quite some
> > variations between different drivers. Is this true?
>
> the bsd-ported scsi driver seems to have some religious friction
> with linux, not surprisingly.  afaik, all the usual gigE cards are
> roughly equivalent.

Does this mean I can choose whatever gigE card I want?
How about SCSI drivers?

> > Q: Tux has some way of linking IRQs directly to a specific CPU/thread
> > (don't really remember what this was...). What should/could be used of
> > these, or other tuning factors to speed up the server?
>
> depends on the hardware and IO rates.  why are you expecting difficulty?
> 220 MB/s is pretty modest.

ok

> > Q: Are there ways to strip down the kernel, as to get rid of everything I
> > don't want or don't need? Could I gain speed on this, or is it just a
> > waste?
>
> silly.

Not silly. I'm not a kernel hacker. I ask naiive questions due to the fact
that I find it better to ask and get to know something, than staying
unknowable of some fact. But thanks for telling me it's of no problem.

> > Q: What file system would be best suitable for this? Ext[23]? ReiserFS?
> > Xfs? FAT? :-)
>
> couldn't possibly make any difference.  journalling FS's are only
> valuable because of their crash-robustness in the presence of writes.
> reiserfs is only faster if you have bizzarely skewed file and dir sizes
> (billions of <1K files, billions of dir entries).  FAT would be very cool,
> in a retro kind of way, but you'd probably hit file-length limits.

How about XFS? I've heard it's better pushing large files...

> > Q: If using iptables to block any unwanted traffic - that is - anything
> > that's not TCP/80, how much CPU overhead could this generate? Could use of
>
> how much unwanted traffic?  why would there be any nontrivial amount?

I thought more about security. I don't want anyone exploiting potential
security holes.

>
> > tcpwrappers or similar systems work better? (I need ssh, snmp and a some
>
> security in depth: use iptables, tcpwrappers, *and* app-based controls.
>
> obviously, iptables discarding any snmp packet from !my.workstation
> is a lot faster than receiving the packet, doing the handshake,
> waking up inetd, firing up tcpd, checking the incoming IP, including
> rev DNS lookups, then passing the socket off to snmp...  but it's also
> true that any large amount of bogus packets would be a problem you
> should handle elsehow (ie, DOS attack or serious misconfiguration.)

How about cpu overhead in iptables/kernel when it processes packets that
are allowed? How about connection tracking? Is the rule order in iptables
important when it comes to speed?

I apologize if some of these questions may seem a little stupid. Please do
not flame

Regards

roy

---
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.

