Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286147AbSAEAmz>; Fri, 4 Jan 2002 19:42:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286148AbSAEAmq>; Fri, 4 Jan 2002 19:42:46 -0500
Received: from white.pocketinet.com ([12.17.167.5]:5142 "EHLO
	white.pocketinet.com") by vger.kernel.org with ESMTP
	id <S286147AbSAEAmk>; Fri, 4 Jan 2002 19:42:40 -0500
Content-Type: text/plain; charset=US-ASCII
From: Nicholas Knight <nknight@pocketinet.com>
Reply-To: nknight@pocketinet.com
To: Stephan von Krawczynski <skraw@ithnet.com>,
        "Phil Oester" <kernel@theoesters.com>
Subject: Re: 1gb RAM + 1gb SWAP + make -j bzImage = OOM
Date: Fri, 4 Jan 2002 16:42:43 -0800
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <004b01c1955e$ecbc9190$6400a8c0@philxp> <20020104220240.233ae66a.skraw@ithnet.com>
In-Reply-To: <20020104220240.233ae66a.skraw@ithnet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <WHITExcPbVzv2N2Ku2000000c76@white.pocketinet.com>
X-OriginalArrivalTime: 05 Jan 2002 00:41:08.0199 (UTC) FILETIME=[AA34C770:01C19581]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 January 2002 01:02 pm, Stephan von Krawczynski wrote:
> On Fri, 4 Jan 2002 12:32:27 -0800
>
> "Phil Oester" <kernel@theoesters.com> wrote:
> > On 2.4.17, I can't make -j bzImage without OOM kicking in. 
> > Relatively light .config here - bzImage compiles to less than 1mb.
> >
> > Seems with 1 gb of RAM and swap, the box should be able to handle
> > this (box is dual P3 600 btw).
> >
> > Is this unreasonable?  How much RAM should it take to accomplish
> > this???
>
> You should give a bit more info on that, especially vmstat and the
> like. I cannot reproduce this. Neither on 1GB/256MB nor on 2GB/256MB
> RAM/SWAP. (P3-1GHz, dual SMP, 2.4.17)
>


I have absilutely no trouble reproducing on an 800MHz Athlon with 256MB 
RAM/256MB swap on 2.4.17

The one catch is that -j is specified without a number.

from man make:
       -j jobs
            Specifies  the  number  of  jobs  (commands) to run 
simultaneously.  If there is more than one -j
            option, the last one is effective.
**If the -j option is given without an argument, make will not limit 
the number of jobs that can run simultaneously.**

(emphasis mine)

Hence, unlimited number of jobs, theoreticaly unlimited amount of 
memory usage.
The last number of processes I saw in top before the system was 
basically dead and I just hit A-SYSRQ-S and A-SYSRQ-B was 416, and all 
the top processes were make or cc

Somehow I doubt this is a kernel issue and is instead a make and user 
issue. A make issue because it's probably poor design to have an option 
that's specified with a number be normaly harmless and useful, be 
potentialy lethal when the number is left off, so if you forget the 
number, your system is dead. A user issue because it seems the user is 
using the option without fully comprehending the consequences.

> Regards,
> Stephan
>
