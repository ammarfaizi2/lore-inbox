Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315039AbSECSPv>; Fri, 3 May 2002 14:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315042AbSECSPt>; Fri, 3 May 2002 14:15:49 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:65290 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315039AbSECSPn>; Fri, 3 May 2002 14:15:43 -0400
Date: Fri, 3 May 2002 11:14:51 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: Andi Kleen <ak@muc.de>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.13 IDE and preemptible kernel problems
In-Reply-To: <3CD2A54E.2070404@evision-ventures.com>
Message-ID: <Pine.LNX.4.44.0205031110550.1602-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 3 May 2002, Martin Dalecki wrote:

> Uz.ytkownik Andi Kleen napisa?:
> > Hi,
> >
> > When booting an preemptible kernel 2.5.13 kernel on x86-64 I get
> > very quickly an scheduling in interrupt BUG. It looks like the
> > preempt_count becomes 0 inside the ATA interrupt handler. This
> > could happen when save_flags/restore_flags and friends are unmatched
> > and you have too many flags restores in IDE.
>
> Thank you for pointing out. I will re check it.

Martin, may I suggest that the next line of cleanups should be to remove
all vestiges of the old global interrupt locking from the IDE driver?
Including, for example, the crap "PCI method 1" access stuff in CMD640x..

Also, if you turn on spinlock debugging, that tends to help find the
really silly things faster (leaving the harder races to be solved by
brainforce ;)

		Linus

