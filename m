Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261397AbULEVH4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261397AbULEVH4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 16:07:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261396AbULEVHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 16:07:48 -0500
Received: from hermine.aitel.hist.no ([158.38.50.15]:41234 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S261394AbULEVHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 16:07:35 -0500
Date: Sun, 5 Dec 2004 22:14:43 +0100
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Helge Hafting <helge.hafting@hist.no>, Andrew Morton <akpm@osdl.org>,
       andrea@suse.de, marcelo.tosatti@cyclades.com,
       LKML <linux-kernel@vger.kernel.org>, nickpiggin@yahoo.com.au
Subject: Re: [PATCH] oom killer (Core)
Message-ID: <20041205211443.GA31731@hh.idb.hist.no>
References: <20041202164725.GB32635@dualathlon.random> <20041202085518.58e0e8eb.akpm@osdl.org> <20041202180823.GD32635@dualathlon.random> <1102013716.13353.226.camel@tglx.tec.linutronix.de> <20041202110729.57deaf02.akpm@osdl.org> <1102014493.13353.239.camel@tglx.tec.linutronix.de> <20041202112208.34150647.akpm@osdl.org> <1102015450.13353.245.camel@tglx.tec.linutronix.de> <41B07B1E.8050503@hist.no> <1102108823.13353.267.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1102108823.13353.267.camel@tglx.tec.linutronix.de>
User-Agent: Mutt/1.5.6+20040722i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2004 at 10:20:22PM +0100, Thomas Gleixner wrote:
> On Fri, 2004-12-03 at 15:41 +0100, Helge Hafting wrote:
> > The case of OOM killed sshd is fixable without touching the kernel:
> > Make sure sshd is started from init, init will then restart sshd whenever
> > it quits for some reason.  This will get you your essential sshd back
> > assuming the machine is still running and the OOM killer managed
> > to free up some memory by killing some other processes.
> > 
> > One might still wish for better OOM behaviour, but it is a case
> > where something has to give.
> > 
> 
> Hey, are you kidding ?
> 
Please don't misunderstand.  I'm not saing that 2.6 is fine,
only that there is a way to automatically restart a sshd accidentally 
killed by the OOM killer.  This could probably save you some of those
trips, if you keep experimenting with 2.6.

> 2.4 lets me not in, because the fork of sshd fails. How do you fix this
> with changing the userspace ?
> 
Fork failing is another issue than a killed sshd.  It is usually fixed
by using ulimit so a buggy process simply cant fork off way too
many children. (Or use up too much memory.)

> 2.6 oom is plain buggy
> 
Quite possible, but be aware that these things can happen with 2.4 too.
It is possible to get 2.4 into a shortage where fork fails,
you should use ulimit anyway to avoid that.  Also, having
a sshd that is restarted by "init" is a good idea anyway
on such a remote machine.  2.4 might not kill sshd by kernel bug, but
who knows what some future exploit or future bug could do. 

> I have no problem to help myself, but I want to get this fixed in a
> reliable way which meets the comment in oom_kill.c: "least surprise"

I too want a well-behaved OOM killer.  Workarounds are available though,
until this happens.

Helge Hafting
