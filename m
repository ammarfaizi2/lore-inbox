Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262845AbVCWTnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262845AbVCWTnL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 14:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262830AbVCWTnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 14:43:11 -0500
Received: from lakermmtao01.cox.net ([68.230.240.38]:58526 "EHLO
	lakermmtao01.cox.net") by vger.kernel.org with ESMTP
	id S262845AbVCWTi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 14:38:27 -0500
In-Reply-To: <Pine.LNX.4.61.0503231543030.10048@yvahk01.tjqt.qr>
References: <e0716e9f05032019064c7b1cec@mail.gmail.com> <20050322112628.GA18256@roll> <Pine.LNX.4.61.0503221247450.5858@yvahk01.tjqt.qr> <20050322124812.GB18256@roll> <20050322125025.GA9038@roll> <9cde8bff050323025663637241@mail.gmail.com> <1111581459.27969.36.camel@nc> <9cde8bff05032305044f55acf3@mail.gmail.com> <1111586058.27969.72.camel@nc> <Pine.LNX.4.61.0503231543030.10048@yvahk01.tjqt.qr>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <fa82dfa71dabb4d0b3df9a6c2b776349@tjhsst.edu>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
From: Kyle Moffett <kmoffett@tjhsst.edu>
Subject: Re: forkbombing Linux distributions
Date: Wed, 23 Mar 2005 14:38:26 -0500
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 23, 2005, at 09:43, Jan Engelhardt wrote:
>> brings down almost all linux distro's while other *nixes survives.
>
> Let's see if this can be confirmed.

Here at my school we have the workstations running Debian testing. We
have edited /etc/security/limits.conf to have a much more restrictive
startup environment for user processes, limiting to 100 processes per
user and clamping maximum CPU time to 4 hours per process.  It's not
failsafe, but we also have all of the kernel threads set at realtime
levels, with the IRQ threads specifically set at SCHED_RR 99, and we
have a sulogin-type process on tty12 at SCHED_RR 99.

Even in the event of the worst kind of forkbomb, the terminal is as
responsive as if nothing else were running and allows us to kill the
offending processes easily, because when the scheduler refuses to
interrupt the killall process to run anything else, no other forkbomb
processes get started.

I suppose a similar situation could be set up with a user-accessible
server and a rate-limited SSH daemon if necessary, although a ttyS0
console via a console server might work better.  In any case, I think
that while there could perhaps be a better interface for user-limits
in the kernel, the existing one works fine for most purposes, when
combined with appropriate administrative tools.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


