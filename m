Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286723AbSA1LLo>; Mon, 28 Jan 2002 06:11:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286968AbSA1LLe>; Mon, 28 Jan 2002 06:11:34 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:3493 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S286723AbSA1LLS>; Mon, 28 Jan 2002 06:11:18 -0500
Message-ID: <3C5531B9.9D4EC697@redhat.com>
Date: Mon, 28 Jan 2002 11:10:49 +0000
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-13smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>, linux-kernel@vger.kernel.org
Subject: Re: unresolved symbols __udivdi3 and __umoddi3
In-Reply-To: <Pine.LNX.3.95.1020125114634.762A-100000@chaos.analogic.com> <E16V9eb-00009M-00@starship.berlin>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> On January 25, 2002 05:56 pm, Richard B. Johnson wrote:
> > On Fri, 25 Jan 2002,  wrote:
> >
> > > I am writing a module and would like to perform arithmetic on long
> > > long variables. When I try to do this the module does not load due
> > > to the unresolved symbols __udivdi3 and __umoddi3. I notice these
> > > are normally defined in libc. Is there any way I can do this in a
> > > kernel module.
> > >
> > > Many Thanks
> > >
> > > Simon.
> >
> > Normally, in modules, the granularity is such that divisions can
> > be made by powers-of-two. In a 32-bit world, the modulus that you
> > obtain with umoddi3 (the remainder from a long-long, division) should
> > normally fit within a 32-bit variable. If you insist upon doing 64-bit
> > math in a 32-bit world, then you can either make your own procedures
> > and link them, of you can "appropriate" them from the 'C' runtime
> > library code, include them with your source, assemble, and link them
> > in.
> 
> Let's be clear on one thing.  There is nothing unnatural about
> 32bits * 32bits = 64bits or 64bits / 32bits = 32bits in a 32 bit world.
> In fact, it is a rare architecture that does not support this directly
> in hardware.  It may be awkward to express it in C, but since when has
> that ever stopped us from using the best machine instructions for the
> job?
> 
> Personally, I find the omission of these mixed size muldiv operations
> from the kernel a great inconvenience.  

*cough* #include <asm/div64.h> *cough*
