Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbTEKRrX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 13:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261832AbTEKRrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 13:47:23 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:58446 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP id S261827AbTEKRrV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 13:47:21 -0400
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Jamie Lokier <jamie@shareable.org>, Jos Hulzink <josh@stack.nl>,
       Linus Torvalds <torvalds@transmeta.com>, Andi Kleen <ak@muc.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Use correct x86 reboot vector
References: <Pine.LNX.4.44.0305102043320.28287-100000@home.transmeta.com>
	<200305111137.29743.josh@stack.nl>
	<20030511140144.GA5602@mail.jlokier.co.uk>
	<Pine.LNX.4.50.0305111033590.7563-100000@blue1.dev.mcafeelabs.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 11 May 2003 11:56:42 -0600
In-Reply-To: <Pine.LNX.4.50.0305111033590.7563-100000@blue1.dev.mcafeelabs.com>
Message-ID: <m1fznl74f9.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi <davidel@xmailserver.org> writes:

> On Sun, 11 May 2003, Jamie Lokier wrote:
> 
> > Jos Hulzink wrote:
> > > On Sunday 11 May 2003 05:50, Linus Torvalds wrote:
> > > > Hmm.. Doesnt' a _real_ hardware reset actually use a magic segment that
> > > > isn't even really true real mode? I have this memory that the reset value
> > > > for a i386 has CS=0xf000, but the shadow base register actually contains
> > > > 0xffff0000. In other words, the CPU actually starts up in "unreal" mode,
> > > > and will fetch the first instruction from physical address 0xfffffff0.
> > > >
> > > > At least that was true on an original 386. It's something that could
> > > > easily have changed since.
> >
> > I got my info from an article on the net which says that a 386 does
> > behave as you say, but it is possible for the system designer to
> > arrange that it boots into the 286-compatible vector at physical
> > address 0x000ffff0.  It states that the feature is specifically so
> > that system designers don't have to create a "memory hole" (that's as
> > much detail as it gives).
> 
> Guys, mem[0xfffffff0,...] == mem[0x000ffff0,...] since the hw remaps the
> bios. Being picky about Intel specs, it should be f000:fff0 though.

The remapping is quite common but it usually happens that after bootup:
0xf0000-0xfffff is shadowed RAM.  While 0xffff0000-0xffffffff still points
to the rom chip.

Now if someone could tell me how to do a jump to 0xffff0000:0xfff0 in real
mode I would find that very interesting.

Eric
