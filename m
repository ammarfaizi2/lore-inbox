Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266614AbRGJPoC>; Tue, 10 Jul 2001 11:44:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266616AbRGJPnw>; Tue, 10 Jul 2001 11:43:52 -0400
Received: from ns.suse.de ([213.95.15.193]:21003 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S266614AbRGJPnr>;
	Tue, 10 Jul 2001 11:43:47 -0400
Date: Tue, 10 Jul 2001 17:43:28 +0200 (CEST)
From: Dave Jones <davej@suse.de>
To: John Clemens <john@deater.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: BIOS, Duron4 specifics...
In-Reply-To: <Pine.LNX.4.33.0107101121100.13575-100000@pianoman.cluster.toy>
Message-ID: <Pine.LNX.4.30.0107101734010.11256-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jul 2001, John Clemens wrote:

> I've got a new laptop with an AMD Duron in it, based on the Athlon4 core
> (PowerNow, SSE, hardware prefetch, etc.. Palomino core)..  However, it
> appears none of the useful features are enabled in the bios.  For example,
> Nowhere does it appear to enable SSE or the APIC.

afair, the mobile Durons are not based upon the Athlon 4 core, and
hence won't have the features you mention. You can verify this with
my x86info tool which you can get from
ftp://ftp.suse.com/pub/people/davej/x86info/x86info-1.3.tgz

This will decode the PowerNOW capabilities register (if it exists)
and tell you if its capable of Bus speed division/Voltage ID control.

I'd be interested in getting the output of x86info -a on this
send to me by private mail btw.

Oh, and you'll need a kernel with the MSR/CPUID drivers loaded.

> Also, whats the state of powernow/clock throttling support? I know there
> was talk of a generic power management/clock control interface a while
> back, where is that project/whats it's status/etc?

The kernel side implementation of this lives in Russell King's CVS.
Grab it using..

cvs -d :pserver:cvs@pubcvs.arm.linux.org.uk:/mnt/src/cvsroot login
cvs -d :pserver:cvs@pubcvs.arm.linux.org.uk:/mnt/src/cvsroot checkout cpufreq

cvs commit list: http://www.linux.org.uk/mailman/listinfo/cpufreq-commit

Note, the Athlon 4 implementation of PowerNOW is currently unsupported,
I'm looking into this right now, after having a chance to talk with
some of the AMD guys at the UKUUG developers conference last week.
The PowerNOW implementation in the CVS tree is equivalent to that
available in my Powertweak program (http://www.powertweak.org) and
its derivative 'k6mult'.

As this implementation was largely reverse engineered, its incomplete
and only supports bus scaling, not voltage scaling. This is something
else we hope to get supported sometime.

The userspace support for this is about to commence, in both a standalone
utility, and a Powertweak plugin.

regards,

Dave.

-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

