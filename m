Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284138AbRL1RaV>; Fri, 28 Dec 2001 12:30:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286937AbRL1RaL>; Fri, 28 Dec 2001 12:30:11 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:35853 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S284138AbRL1RaE>; Fri, 28 Dec 2001 12:30:04 -0500
Date: Fri, 28 Dec 2001 09:33:48 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "Jeffrey W. Baker" <jwb@saturn5.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.17 absurd number of context switches
In-Reply-To: <E16K0wH-0001AG-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.40.0112280931271.1466-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Dec 2001, Alan Cox wrote:

> > > The scheduler is _good_ at the three process case. Run some straces it looks
> > > more like postgres is doing wacky yield based locks.
> >
> > The scheduler that Linus merged in 2.5.2-pre3 will solve the problem.
>
> Looking at the postgres traces here it wont make any difference at all. Not
> one iota. If I am reading it right I have processes each going
> yield, yield, yield... so the kernel does just that (and indeed posix
> semantics require that behaviour).

task A old the lock , counter = 2
task B counter = 5 and task C counter = 4 are woke up
try to look at a switch dump.
the scheduler will spend 3 entire time slices switching between B and C
before A will get back the CPU and will free the lock.




- Davide


