Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288795AbSAEMa5>; Sat, 5 Jan 2002 07:30:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286207AbSAEMas>; Sat, 5 Jan 2002 07:30:48 -0500
Received: from Expansa.sns.it ([192.167.206.189]:20750 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S288795AbSAEMan>;
	Sat, 5 Jan 2002 07:30:43 -0500
Date: Sat, 5 Jan 2002 13:30:30 +0100 (CET)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Nicholas Knight <nknight@pocketinet.com>
cc: Stephan von Krawczynski <skraw@ithnet.com>,
        Phil Oester <kernel@theoesters.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 1gb RAM + 1gb SWAP + make -j bzImage = OOM
In-Reply-To: <WHITExcPbVzv2N2Ku2000000c76@white.pocketinet.com>
Message-ID: <Pine.LNX.4.33.0201051324430.6147-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No troubles to reproduce this here, on sparc64 !GM ran/1GB swap,
and on dualathlon 768MB RAM 1.5GB swap, and on athlon 1GBRAM/1GBSWAP

But this is not a kernel issue, it is simply that
too many gcc processes are runned at the same time because the source
files are too many.

On Fri, 4 Jan 2002, Nicholas Knight wrote:

> On Friday 04 January 2002 01:02 pm, Stephan von Krawczynski wrote:
> > On Fri, 4 Jan 2002 12:32:27 -0800
> >
> > "Phil Oester" <kernel@theoesters.com> wrote:
> > > On 2.4.17, I can't make -j bzImage without OOM kicking in.
> > > Relatively light .config here - bzImage compiles to less than 1mb.
> > >
> > > Seems with 1 gb of RAM and swap, the box should be able to handle
> > > this (box is dual P3 600 btw).
> > >
> > > Is this unreasonable?  How much RAM should it take to accomplish
> > > this???
> >
> > You should give a bit more info on that, especially vmstat and the
> > like. I cannot reproduce this. Neither on 1GB/256MB nor on 2GB/256MB
> > RAM/SWAP. (P3-1GHz, dual SMP, 2.4.17)
> >
>
>
> I have absilutely no trouble reproducing on an 800MHz Athlon with 256MB
> RAM/256MB swap on 2.4.17
>
> The one catch is that -j is specified without a number.
>
> from man make:
>        -j jobs
>             Specifies  the  number  of  jobs  (commands) to run
> simultaneously.  If there is more than one -j
>             option, the last one is effective.
> **If the -j option is given without an argument, make will not limit
> the number of jobs that can run simultaneously.**
>
> (emphasis mine)
>
> Hence, unlimited number of jobs, theoreticaly unlimited amount of
> memory usage.
> The last number of processes I saw in top before the system was
> basically dead and I just hit A-SYSRQ-S and A-SYSRQ-B was 416, and all
> the top processes were make or cc
>
> Somehow I doubt this is a kernel issue and is instead a make and user
> issue. A make issue because it's probably poor design to have an option
> that's specified with a number be normaly harmless and useful, be
> potentialy lethal when the number is left off, so if you forget the
> number, your system is dead. A user issue because it seems the user is
> using the option without fully comprehending the consequences.
>
> > Regards,
> > Stephan
> >
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

