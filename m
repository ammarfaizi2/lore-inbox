Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964870AbWBMWec@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964870AbWBMWec (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 17:34:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964875AbWBMWeb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 17:34:31 -0500
Received: from gate.crashing.org ([63.228.1.57]:19593 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S964870AbWBMWeb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 17:34:31 -0500
Subject: Re: 2.6.16-rc2 powerpc timestamp skew
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Roger Leigh <rleigh@whinlatter.ukfsn.org>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       debian-powerpc@lists.debian.org
In-Reply-To: <87irrj85vp.fsf@hardknott.home.whinlatter.ukfsn.org>
References: <87pslspkj5.fsf@hardknott.home.whinlatter.ukfsn.org>
	 <1139779983.5247.39.camel@localhost.localdomain>
	 <87irrj85vp.fsf@hardknott.home.whinlatter.ukfsn.org>
Content-Type: text/plain
Date: Tue, 14 Feb 2006 09:34:24 +1100
Message-Id: <1139870065.5237.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Can you strace vs. ltrace and see if the gettimeofday or clock_gettime
> > syscalls are ever called ?
> 
>            | strace        | ltrace
> -----------+---------------+------------------------------------
> 2.6.15     |               |
> date       | clock_gettime | clock_gettime -> SYS_clock_gettime,
>            |               |   localtime, strftime
> touch      | utimes        | futimes -> SYS_utimes
>            |               |
> 2.6.16-rc2 |               |
> date       | clock_gettime | clock_gettime -> SYS_clock_gettime,
>            |               |   localtime, strftime
> touch      | utimes        | futimes -> SYS_utimes
> 
> [clock_gettime(CLOCK_REALTIME, {1139826613, 157402000}) = 0]
> 
> > I wonder if you have a glibc new enough to
> > use the vDSO to obtain the time or if it's using the syscall... The vDSO
> > on ppc32 is very new.
> 
> It's glibc 2.3.5 (Debian libc6 2.3.5-13).

Ok, does not using NTP fixes it ?

Ben.


