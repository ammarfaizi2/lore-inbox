Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314469AbSEXQkL>; Fri, 24 May 2002 12:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314475AbSEXQkK>; Fri, 24 May 2002 12:40:10 -0400
Received: from daimi.au.dk ([130.225.16.1]:35699 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S314469AbSEXQkJ>;
	Fri, 24 May 2002 12:40:09 -0400
Message-ID: <3CEE6CDC.D5D7FF9E@daimi.au.dk>
Date: Fri, 24 May 2002 18:39:56 +0200
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-31smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: It hurts when I shoot myself in the foot
In-Reply-To: <E17BHdL-0006lF-00@the-village.bc.nu>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > Couldn't that be solved in one of the following ways?
> >
> > 1) Disable pre-emption while reading TSC and CPU nr.
> > 2) Use affinity for processes pre-empted in kernel mode.
> > 3) Disable pre-emption for SMP systems.
> 
> You can solve it by disabling pre-emption (and given its questionable
> value doing so permanently might not be a bad idea).

Questionable value of what? TSC or preemption?

> However if you simply
> disable pre-emption during udelay() calls then you've just screwed yourself
> by removing 99% of the use pre-emption had.

I wouldn't want to disable preemption during udelays.
Either I would disable and enable preemption on every
pass through the loop. Or I would just manually check
for every pass if I should give up the CPU. This
obviously requires more computation for every pass,
but being a busy waiting loop I don't see a problem.

Otherwise I would lock the process to a fixed CPU for
the duration of udelay.

> 
> Given all the pain its probably better to not use the TSC

Do we have better alternatives for high resolution
time meassurements?

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:razor-report@daimi.au.dk
