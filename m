Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266151AbRF2Soo>; Fri, 29 Jun 2001 14:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266152AbRF2Soe>; Fri, 29 Jun 2001 14:44:34 -0400
Received: from lsmls01.we.mediaone.net ([24.130.1.20]:61384 "EHLO
	lsmls01.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S266151AbRF2SoX>; Fri, 29 Jun 2001 14:44:23 -0400
Message-ID: <3B3CCCFF.2329FEDD@kegel.com>
Date: Fri, 29 Jun 2001 11:46:23 -0700
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christopher Smith <x@xman.org>,
        "Daniel R. Kegel" <dank@alumni.caltech.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: A signal fairy tale
In-Reply-To: <5.1.0.14.0.20010629011855.00a98098@imap.xman.org> <3B3C4A67.1D03A916@kegel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Kegel wrote:
> Pseudocode:
> 
>   sigemptyset(&s);
>   sigaddset(SIGUSR1, &s);
>   fd=sigopen(&s);
>   m=read(fd, buf, n*sizeof(siginfo_t))
>   close(fd);
> 
> should probably be equivalent to
> 
>   sigemptyset(&s);
>   sigaddset(SIGUSR1, &s);
>   struct sigaction newaction, oldaction;
>   newaction.sa_handler = dummy_handler;
>   newaction.sa_flags = SA_SIGINFO;
>   newaction.sa_mask = 0;
>   sigaction(SIGUSR1, &newaction, &oldaction);

I forgot to mask off the signal to avoid traditional delivery:

    sigprocmask(SIG_BLOCK, &s, &oldmask);

>   for (i=0; i<n; i++)
>      if (sigwaitinfo(&s, buf+i))
>         break;
>   m = n * sizeof(siginfo_t);
>   sigaction(SIGUSR1, &oldaction, 0);

    sigprocmask(SIG_UNBLOCK, &s);
 
> (apologies if any of the above is wrong)

- Dan
