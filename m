Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262386AbTEKHUz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 03:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262406AbTEKHUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 03:20:55 -0400
Received: from amsfep15-int.chello.nl ([213.46.243.28]:31022 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S262386AbTEKHUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 03:20:54 -0400
From: Jos Hulzink <josh@stack.nl>
To: Linus Torvalds <torvalds@transmeta.com>,
       Jamie Lokier <jamie@shareable.org>
Subject: Re: [PATCH] Use correct x86 reboot vector
Date: Sun, 11 May 2003 11:37:29 +0200
User-Agent: KMail/1.5
Cc: Andi Kleen <ak@muc.de>, <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0305102043320.28287-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0305102043320.28287-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200305111137.29743.josh@stack.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 11 May 2003 05:50, Linus Torvalds wrote:
> On Sat, 10 May 2003, Jamie Lokier wrote:
> > Jos Hulzink wrote:
> > > For the sake of bad behaving BIOSes however, I'd vote for the f000:fff0
> > > vector, unless someone can hand me a paper that says it is wrong.
> >
> > I agree, for the simple reason that it is what the chip does on a
> > hardware reset signal.
>
> Hmm.. Doesnt' a _real_ hardware reset actually use a magic segment that
> isn't even really true real mode? I have this memory that the reset value
> for a i386 has CS=0xf000, but the shadow base register actually contains
> 0xffff0000. In other words, the CPU actually starts up in "unreal" mode,
> and will fetch the first instruction from physical address 0xfffffff0.
>
> At least that was true on an original 386. It's something that could
> easily have changed since.
>
> In other words, you're all wrong. Nyaah, nyaah.
>
> 			Linus

Source: 80386 Programmers Reference Manual, Intel (1986)

EIP is set 0000FFF0H
CS is set F000H

After RESET, lines A31-A20 are FORCED high till a far JMP is done.

So, unfortunately we have to say Linus is right once again. Damn ;-) My 
conclusion is that we are unable to use the CPU reset as the reference for 
warm boots, for we can't control A312-A20 in real mode. But as far as I can 
see, my arguments still hold...

Jos
Jos
