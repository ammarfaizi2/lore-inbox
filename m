Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262782AbVAKTQr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262782AbVAKTQr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 14:16:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262826AbVAKTQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 14:16:47 -0500
Received: from rproxy.gmail.com ([64.233.170.203]:31505 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262836AbVAKTQJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 14:16:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=kkQ01GliImpJ0Bsq5di8Y65hU73ttnSlvIA8EV0wwPcZUYTrgZWcZhP6O44Tqzgr+ueG1X6xRzbwpftbE3Ap371HJda6Q11Gkp5yzx62Wi/8e5l+Y0BXX+Xz/6cZJyVs4d3XYdyourR9z24InZ+DsFPaBhgubAZ/HGIXEDoU5ng=
Message-ID: <4e1a70d1050111111614670f32@mail.gmail.com>
Date: Tue, 11 Jan 2005 15:16:04 -0400
From: Ilias Biris <xyz.biris@gmail.com>
Reply-To: Ilias Biris <xyz.biris@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: User space out of memory approach
In-Reply-To: <1105461106.16168.41.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <3f250c71050110134337c08ef0@mail.gmail.com>
	 <20050110192012.GA18531@logos.cnet>
	 <4d6522b9050110144017d0c075@mail.gmail.com>
	 <20050110200514.GA18796@logos.cnet>
	 <1105403747.17853.48.camel@tglx.tec.linutronix.de>
	 <4d6522b90501101803523eea79@mail.gmail.com>
	 <1105433093.17853.78.camel@tglx.tec.linutronix.de>
	 <1105461106.16168.41.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

where I come from we say (jokingly of course) 'got a headache? chop
your own head ... end of problem'.

Though your system is not guaranteed to become more stable. When you
forbid overcommitting memory, all you do is make failure occur for ALL
processes at a different time. A process is happily doing something
useful when all of a sudden its fork may die due to 'out of memory'
... Moreover shutting down overcommit will do that for all processes,
not just the one culprit that could be chopped off by oom...

Maybe it is just me but I think with overcommiting a system works more
reliably :-)


On Tue, 11 Jan 2005 16:32:23 +0000, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Maw, 2005-01-11 at 08:44, Thomas Gleixner wrote:
> > I consider the invocation of out_of_memory in the first place. This is
> > the real root of the problems. The ranking is a different playground.
> > Your solution does not solve
> > - invocation madness
> > - reentrancy protection
> > - the ugly mess of timers, counters... in out_of_memory, which aren't
> > neccecary at all
> >
> > This must be solved first in a proper way, before we talk about ranking.
> 
> echo "2" >/proc/sys/vm/overcommit_memory
> 
> End of problem (except for extreme cases) and with current 2.6.10-bk
> (and -ac because I pulled the patch back into -ac) also for most extreme
> cases as Andries pre-reserves the stack address spaces.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
Ilias Biris
