Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273203AbRJCLmF>; Wed, 3 Oct 2001 07:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273213AbRJCLly>; Wed, 3 Oct 2001 07:41:54 -0400
Received: from balabit.bakats.tvnet.hu ([195.38.106.66]:59397 "EHLO
	kuka.balabit") by vger.kernel.org with ESMTP id <S273203AbRJCLlp>;
	Wed, 3 Oct 2001 07:41:45 -0400
Date: Wed, 3 Oct 2001 13:41:43 +0200
From: Balazs Scheidler <bazsi@balabit.hu>
To: pierre.lombard@imag.fr
Cc: linux-kernel@vger.kernel.org
Subject: Re: reproducible bug in 2.2.19 & 2.4.x [lkml]
Message-ID: <20011003134143.A26432@balabit.hu>
In-Reply-To: <20010928130138.A19532@balabit.hu> <20011002103112.A13638@balabit.hu> <20011003125319.A32248@sci41.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011003125319.A32248@sci41.imag.fr>; from pierre.lombard@imag.fr on Wed, Oct 03, 2001 at 12:55:16PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 03, 2001 at 12:55:16PM +0200, pierre.lombard@imag.fr wrote:
> Hi,
> 
> I checked glibc syslog() code in misc/syslog.[hc]
> 
> A possible explanation:
> 1. you ignore SIGPIPE
> 2. syslog communicates with syslogd thru a pipe and mess with sigpipe
>   handler
> 3. this breaks things.
> 
> Can you test the patch I attached, it seems to work fine here (whereas your
> snippet crashes quickly) and send feedback if it works ?

The problem is that my the problem occurs in a program completely
independent from my stressthreads program (it is meant only for
demonstration purposes). This SIGSEGV occurs in our multithreaded proxy
firewall software called Zorp.

We are using a dummy signal handler (not SIG_IGN), and the SIGSEGV still
occurs.

A last addition is that the problem occurs on non-SMP kernels as well,
albeit much more rarely.

My workaround is now not to use syslog() from libc. I implemented my own
syslog writing routines, and the problem didn't occur (though it's been
running for two days now, so nothing is for sure yet).

For the time being I'm also trying to reproduce the problem without
syslog() as I think it is a kernel related problem.

I think it must be related to the fact syslog() is changing signal handler
routines very often.

thanks for the feedback.

-- 
Bazsi
PGP info: KeyID 9AF8D0A9 Fingerprint CD27 CFB0 802C 0944 9CFD 804E C82C 8EB1
