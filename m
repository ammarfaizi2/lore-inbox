Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131233AbRBUAhX>; Tue, 20 Feb 2001 19:37:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131229AbRBUAhN>; Tue, 20 Feb 2001 19:37:13 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:56809 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S131223AbRBUAhD>;
	Tue, 20 Feb 2001 19:37:03 -0500
Date: Wed, 21 Feb 2001 01:36:45 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200102210036.BAA02313@harpo.it.uu.se>
To: mingo@redhat.com
Subject: Re: [PATCH] 2.4.1-ac UP-APIC updates
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
        macro@ds2.pg.gda.pl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Feb 2001 16:00:53 -0500 (EST), Ingo Molnar wrote:

>my major gripe right now is that we still have bug reports that say that
>systems hang when using nmi_watchdog=1 and work if nmi_watchdog=0.
>Changing the NMI watchdog to be 1 Hz will make these bugreports "Linux
>hangs once a week" instead of a "Linux hangs after 1-2 hours", which is
>clearly hiding things and making debugging harder.

All reports I've seen have been for SMP kernels on MP machines using
the IO-APIC to drive the watchdog. Are you saying there are also cases
where UP boxes fail with nmi_watchdog non-zero? (My 1Hz change only
affected the local APIC-driven watchdog which MP boxes normally don't use.)

>(and driving kernel-profiling from the NMI interrupt is a short-term
>patch, so there is just no point in going to 1 Hz right now just to go
>back to 100 Hz a few days later.)

Another "constructive" use of the perfctrs. Ok, this I can see wants
a higher rate.

How far in the future is this? I'm concerned that the conflicting
uses of the perfctrs (watchdog, kernel profiling, my perfctr driver
for user-space performance measurements) is going to require some
low-level request/release API.

>the rest of the changes are excellent - it's only the 100 Hz NMI issue i
>have a problem with.

Ok. 

Alan beat me to it for -ac20, so I'm not including a new patch now
with the 1Hz bit backed out. Ingo, I guess this means the kernel
profiling patch will have to "fix" the 1Hz thing by itself.

/Mikael
