Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281170AbRKEOtZ>; Mon, 5 Nov 2001 09:49:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281169AbRKEOtP>; Mon, 5 Nov 2001 09:49:15 -0500
Received: from [62.58.73.254] ([62.58.73.254]:44020 "EHLO
	ats-core-0.atos-group.nl") by vger.kernel.org with ESMTP
	id <S281168AbRKEOtH>; Mon, 5 Nov 2001 09:49:07 -0500
Date: Mon, 5 Nov 2001 15:50:55 +0100 (CET)
From: Ryan Sweet <rsweet@atos-group.nl>
To: Keith Owens <kaos@ocs.com.au>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: random reboots of diskless nodes - 2.4.7 (fwd) 
In-Reply-To: <20123.1003208317@kao2.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.33.0111051509550.5887-100000@rsweet2.atos-group.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Keith,
Regarding the message below - I've now reproduced the problem with both
2.4.7 and 2.4.13 each with the appropriate kdb patch applied.  The trouble
is that I don't ever get a chance to break-in or do anything else with the
debugger - the system just restarts without complaining.  Would this be
the triple fault scenario described below?

As for IKD, I am trying again with 2.4.7 and IKD now.  I am wondering
though, will it do me any good if I don't catch the problem with my
eyeballs as it happens; I have oodles of nodes and the problem happens
on one of them at random.  If I run on one node or two nodes it sometimes
runs for a week, and thus to increase my statistical sample (and to be
closer to the real usage), I have to test across a large subset of the
cluster, meaning that I can't watch 8-16 serial consoles at once.

thanks,
-Ryan Sweet

BTW - I tried using kdb for poking around at kernel internals on a
different system just for educational purposes and I wanted to say thanks
for such a great tool.  It really helps to bridge the gap between the
source, gcc, as, and my generally useless lump of grey matter.

On Tue, 16 Oct 2001, Keith Owens wrote:

> On Tue, 16 Oct 2001 02:28:46 +0200 (CEST),
> Ryan Sweet <rsweet@atos-group.nl> wrote:
> >Questions:
> >- what the heck can I do to isolate the problem?
>
> Debugger over a serial console.
>
> >- why would the system re-boot instead of hanging on whatever caused it to
> >crash (ie, why don't I see an oops message?)
>
> Probably triple fault on ix86, which forces a reboot.  That is, a fault
> was detected, trying to report the fault caused an error which caused a
> third error.  Say goodnight, Dick.  The other main possibility is a
> hardware or software watchdog that thinks the system has hung and is
> forcing a reboot, do you have one of those?
>
> >- how can I tell the system not to re-boot when it crashes (or is it
> >crashing at all???)
>
> If it is a triple fault, you have to catch the error before the third
> fault.  Tricky.
>
> >- is it worth trying all the newer kernel versions (this does not sound
> >very appealing, especially given the troubles reported with 2.4.10 and
> >also the split over which vm to use, etc..., also the changelogs don't
> >really point to anything that appears to precisely describe my problem)?
>
> Maybe.  OTOH if you wait until you capture some diagnostics it will
> give you a better indication if the later kernels actually fix the
> problem.
>
> >- if I patch with kgdb and use a null modem connection from the gateway to
> >run gdb can I expect to gain any useful info from a backtrace?
>
> It is definitely worth trying kgdb or kdb[1] over a serial console.  I
> am biased towards kdb (I maintain it) but either are worth a go.
>
> Unfortunately the most common triple fault is a kernel stack overflow
> and the ix86 kernel design has no way to recover from that error, the
> error handler needs stack space to report anything, both kgdb and kdb
> need stack space as well.  If you suspect stack overflow, look at the
> IKD patch[2], it has code to warn about potential stack overflows
> before they are completely out of hand.
>
> [1] ftp://oss.sgi.com/projects/kdb/download/ix86, old for 2.4.7.
> [2] ftp://ftp.kernel.org/pub/linux/kernel/people/andrea/ikd/
>

-- 
Ryan Sweet <ryan.sweet@atosorigin.com>
Atos Origin Engineering Services
http://www.aoes.nl


