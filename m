Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267593AbRGQX0Y>; Tue, 17 Jul 2001 19:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267592AbRGQX0P>; Tue, 17 Jul 2001 19:26:15 -0400
Received: from sncgw.nai.com ([161.69.248.229]:13957 "EHLO mcafee-labs.nai.com")
	by vger.kernel.org with ESMTP id <S267590AbRGQX0D>;
	Tue, 17 Jul 2001 19:26:03 -0400
Message-ID: <XFMail.20010717162923.davidel@xmailserver.org>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20010718011329.A1829@home.ds9a.nl>
Date: Tue, 17 Jul 2001 16:29:23 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: bert hubert <ahu@ds9a.nl>
Subject: RE: huge number of context switches under 2.2.x with SMP & threa
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
        Ulrich Drepper <drepper@cygnus.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 17-Jul-2001 bert hubert wrote:
> A threads related question - I have a nameserver with 8 active threads,
> which in turn leads to 6 (in this case) MySQL connections. When
> stresstesting this nameserver, we see a *huge* number of context switches.
> 50.000 has been observered. When raising this to ~50 active threads and ~50
> MySQL connections we've seen 100.000 context switches/second. Performance
> suffers.
> 
> This is a RedHat 6.2 system with a 2.2.16 kernel, 2*PIII, 900MHz.
> 
> I saw some mention of this problem on the MySQL site with regards to
> processes holding a pthread_mutex_lock() for short amounts of time. They
> advise to use 2.4 but right now that is not within the scope of my options.
> 
> My question: is there a 2.2 kernel in which this is resolved? And secondly,
> is there a way to prevent this problem purely from userspace? In other
> words, what causes this problem.
> 
> The MySQL site also mentions that 2.4 could do better in some ways,
> especially regarding 'overspin'.

If the lock is contended the thread start spinning with sched_yield() for a
given number of times.
This could result in an high ctx switch rate with quite long runqueue also.




- Davide

