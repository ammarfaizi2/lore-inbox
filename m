Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269633AbRHAE3Y>; Wed, 1 Aug 2001 00:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269635AbRHAE3O>; Wed, 1 Aug 2001 00:29:14 -0400
Received: from 216-99-213-120.dsl.aracnet.com ([216.99.213.120]:12045 "HELO
	clueserver.org") by vger.kernel.org with SMTP id <S269633AbRHAE25>;
	Wed, 1 Aug 2001 00:28:57 -0400
Date: Tue, 31 Jul 2001 22:42:48 -0700 (PDT)
From: Alan Olsen <alan@clueserver.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PCMCIA IDE_CS in 2.4.7 
In-Reply-To: <11314.996637059@kao2.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.10.10107312226590.26170-100000@clueserver.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Wed, 1 Aug 2001, Keith Owens wrote:

> On Tue, 31 Jul 2001 21:03:45 -0700 (PDT), 
> Alan Olsen <alan@clueserver.org> wrote:
> >The module that used to be called "ide_cs.o" is now called "ide-cs.o".
> >It this on purpose or have I found a bug?
> 
> drivers/ide/Makefile was added to the kernel in 2.4.3-99pre on approx.
> May 19, 2000.  The module was called ide-cs.o then and has had that
> name ever since.  The inconsistency between the kernel and the pcmcia
> package is annoying but changing the kernel name now would probably
> cause more problems that it solved.

I found out about a minute or so *after* I sent that message that the
problem is documented in the pcmcia-cs README-2.4.  (Though it was a
little less than clear.)

I am a little surprised that the whole thing worked at all, given the
changes I had to make...

I still have a puzzling problem though.

I have a removable ide drive that has always been a bit contankerous.
Under 2.2.x, it would error out the first time, but a "cardctl reset"
would make it work fine.

Now when i try to mount it, the cardmgr code complains about a timeout on
the socket and suggests increasing setup_delay.  That does not help.  It
just delays the real problem.

When I insert the card, I get a beep from the cardmgr program seeing the
card being inserted.  Then the whole system refuses to respond to anything
on the keyboard.  (I have not tested if the system is reachable by network
when that happens.) 

The drive is powered up at that point.  If I pull the pcmcia card out,
once the process times out, the system returns to usable again.

Ideas what is causing it?  I am suspecting that I am getting some sort of
irq lockup.  All the other pcmcia devices run fine. Just ide is giving me
the problem.

alan@ctrl-alt-del.com | Note to AOL users: for a quick shortcut to reply
Alan Olsen            | to my mail, just hit the ctrl, alt and del keys.
 "All power is derived from the barrel of a gnu." - Mao Tse Stallman

