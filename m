Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267543AbRGMVHJ>; Fri, 13 Jul 2001 17:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267542AbRGMVHB>; Fri, 13 Jul 2001 17:07:01 -0400
Received: from warden.digitalinsight.com ([208.29.163.2]:18053 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S267539AbRGMVGz>; Fri, 13 Jul 2001 17:06:55 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Mike Kravetz <mkravetz@sequent.com>
Cc: Larry McVoy <lm@bitmover.com>, Davide Libenzi <davidel@xmailserver.org>,
        lse-tech@lists.sourceforge.net, Andi Kleen <ak@suse.de>,
        linux-kernel@vger.kernel.org
Date: Fri, 13 Jul 2001 12:51:53 -0700 (PDT)
Subject: Re: CPU affinity & IPI latency
In-Reply-To: <20010713100521.D1137@w-mikek2.des.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.33.0107131249200.4540-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A real-world example of this issue.

I was gzipping a large (~800MB) file on a dual athlon box. the gzip prcess
was bouncing back and forth between the two CPUs. I actually was able to
gzip faster by starting up setiathome to keep one CPU busy and force the
scheduler to keep the gzip on a single CPU (I ran things several times to
verify it was actually faster)

David Lang


 On Fri, 13 Jul 2001, Mike Kravetz wrote:

> Date: Fri, 13 Jul 2001 10:05:21 -0700
> From: Mike Kravetz <mkravetz@sequent.com>
> To: Larry McVoy <lm@bitmover.com>
> Cc: Davide Libenzi <davidel@xmailserver.org>, lse-tech@lists.sourceforge.net,
>      Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
> Subject: Re: CPU affinity & IPI latency
>
> On Thu, Jul 12, 2001 at 05:36:41PM -0700, Larry McVoy wrote:
> > Be careful tuning for LMbench (says the author :-)
> >
> > Especially this benchmark.  It's certainly possible to get dramatically better
> > SMP numbers by pinning all the lat_ctx processes to a single CPU, because
> > the benchmark is single threaded.  In other words, if we have 5 processes,
> > call them A, B, C, D, and E, then the benchmark is passing a token from
> > A to B to C to D to E and around again.
> >
> > If the amount of data/instructions needed by all 5 processes fits in the
> > cache and you pin all the processes to the same CPU you'll get much
> > better performance than simply letting them float.
> >
> > But making the system do that naively is a bad idea.
>
> I agree, and can't imagine the system ever attempting to take this
> into account and leave these 5 tasks on the same CPU.
>
> At the other extreme is my observation that 2 tasks on an 8 CPU
> system are 'round robined' among all 8 CPUs.  I think having the
> 2 tasks stay on 2 of the 8 CPUs would be an improvement with respect
> to CPU affinity.  Actually, the scheduler does 'try' to do this.
>
> It is clear that the behavior of lat_ctx bypasses almost all of
> the scheduler's attempts at CPU affinity.  The real question is,
> "How often in running 'real workloads' are the schduler's attempts
> at CPU affinity bypassed?".
>
> --
> Mike Kravetz                                 mkravetz@sequent.com
> IBM Linux Technology Center
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
