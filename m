Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319655AbSH2Xof>; Thu, 29 Aug 2002 19:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319657AbSH2Xof>; Thu, 29 Aug 2002 19:44:35 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:42648 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S319655AbSH2Xoe>;
	Thu, 29 Aug 2002 19:44:34 -0400
Date: Fri, 30 Aug 2002 09:48:25 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: mike heffner <mdheffner@yahoo.com>
Cc: Frank.Otto@tc.pci.uni-heidelberg.de, linux-kernel@vger.kernel.org,
       mdheffner@yahoo.com
Subject: Re: PROBLEM:  conflict between apm and system clock on Inspiron 8100
Message-Id: <20020830094825.75fd8519.sfr@canb.auug.org.au>
In-Reply-To: <20020829171941.70780.qmail@web40209.mail.yahoo.com>
References: <20020829121103.48b5920d.sfr@canb.auug.org.au>
	<20020829171941.70780.qmail@web40209.mail.yahoo.com>
X-Mailer: Sylpheed version 0.8.2 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On Thu, 29 Aug 2002 10:19:41 -0700 (PDT) mike heffner <mdheffner@yahoo.com> wrote:
>
>   I have timed the "cat /proc/apm" to take at least
> 36ms on my inspiron 8100 using an external clock.  I
> shut down my ntp daemon so the clock is free running. 
> I then did "ntpdate -q clock".  With no calls to apm
> the number returned is rather stable over a few
> minuites with multiple ntpdate calls.  I then execute
> 10 times "cat /proc/apm" and do "ntpdate -q clock"
> again.  I take the difference and divide by 10.  That
> gives me an average of about 36ms, or 3 to 4
> interrupts missed for each call.

Interesting ... My timings were, of course, very suspect ...

>   Last night I also ran though all of Dell's BIOSs.  I
> installed each of the 8 or so of them on there web
> site.  A few of them broke apm, but none fixed this
> problem.  If we are sure the BIOS is the problem, I
> will continue to pester Dell.  So just to verify, you
> are *not* disabling interrupts in the kernel for an
> apm call?  I am still trying to understand the code.
>   I have also tried kernel 2.4.2-2.  I don't remember
> this problem with an earlier installation I had on
> this laptop.  It turns out it is still a problem with
> that kernel version.  I am currently using 2.4.18-10.

OK, for the Dells, we autodetect the 4000 series and allow
interrupts during BIOS calls, but not the 8000's (unless
your RedHat patched kernel does this).  So could you try
booting with "apm=allow_ints" on the command line (or load
the apm modules with "allow_ints=1"). and try again.  If
this changes things, then we need to add the 8100 to the
list of things we automatically allow interrupts for.

The default from the very beginning has been to disable interrupts
and on most machines this works fine.  The option of leaving
interrupts enabled was introduced when we discovered that the
Thinkpads won't resume if you disable them ...

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
