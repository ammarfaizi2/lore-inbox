Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317384AbSFKR7b>; Tue, 11 Jun 2002 13:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317424AbSFKR7a>; Tue, 11 Jun 2002 13:59:30 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:24056 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S317384AbSFKR73>; Tue, 11 Jun 2002 13:59:29 -0400
Subject: Re: [PATCH] 2.5.21 Nonlinear CPU support
From: Robert Love <rml@tech9.net>
To: Anton Altaparmakov <aia21@cantab.net>
Cc: Rusty Russell <rusty@rustcorp.com.au>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, k-suganuma@mvj.biglobe.ne.jp,
        Andrew Morton <akpm@zip.com.au>
In-Reply-To: <5.1.0.14.2.20020611114701.00aefec0@pop.cus.cam.ac.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 11 Jun 2002 10:59:25 -0700
Message-Id: <1023818365.21176.237.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-06-11 at 03:57, Anton Altaparmakov wrote:

> This is crazy! It means you are allocating 2MiB of memory instead of just 
> 128kiB on a 2 CPU system, which will be about 99% of the SMP systems in 
> use, at my guess. So your change is throwing away 1920kiB of kernel ram for 
> no reason at all. And that is just ntfs...
>
> CPU hot plugging is an extremely specialised corner case so can you please 
> make it a config option and not get rid of smp_num_cpus? If people enable 
> the option make smp_num_cpus be the same as NR_CPUS and if not leave it be 
> as it is now.

I agree.  One can argue these rants are just for "micro optimizations"
(although I disagree the size issue is "micro") but someone has to stay
on top of these issues...

Hot swappable CPUs is incredibly specialized and corner-cased.
 
> Anything else penalizes the majority of users just to allow a tiny minority 
> to do strange things like swap cpus without rebooting...

It is by no means a solution, but I just posted a patch to configure
NR_CPUS... so setting it to, say, 2 on your dual box should help you
out.  On the converse, however, it introduces a default of 64 on 64-bit
boxen so it compounds the problem for users who don't tweak the
setting... something still needs to be done with the hotplug code.

	Robert Love

