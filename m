Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131483AbRC0TUa>; Tue, 27 Mar 2001 14:20:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131484AbRC0TUU>; Tue, 27 Mar 2001 14:20:20 -0500
Received: from [195.63.194.11] ([195.63.194.11]:7695 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S131483AbRC0TUM>;
	Tue, 27 Mar 2001 14:20:12 -0500
Message-ID: <3AC0E4D9.E157D407@evision-ventures.com>
Date: Tue, 27 Mar 2001 21:07:05 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
CC: Jonathan Morton <chromi@cyberspace.org>,
        Rogier Wolff <R.E.Wolff@BitWizard.nl>, linux-kernel@vger.kernel.org
Subject: Re: OOM killer???
In-Reply-To: <l03130332b6e632432b9f@[192.168.239.101]> <3AC09480.E8317507@evision-ventures.com> <20010327200830.C8133@nightmaster.csn.tu-chemnitz.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser wrote:
> 
> On Tue, Mar 27, 2001 at 03:24:16PM +0200, Martin Dalecki wrote:
> > > @@ -93,6 +95,10 @@
> > >                                 p->uid == 0 || p->euid == 0)
> > >                 points /= 4;
> > >
> > > +       /* Much the same goes for processes with low UIDs */
> > > +       if(p->uid < 100 || p->euid < 100)
> > > +         points /= 2;
> > > +
> >
> > Plase change to 100 to 500 - this would make it consistant with
> > the useradd command, which starts adding new users at the UID 500
> 
> No, useradd reads usally the /etc/login.defs to select the range.
> The oom-killer should have configurables for that, to allow the
> policy decisions in USER space -- where it belongs -- not in KERNEL space

OK sysctl would be more appripriate.

> If we use my OOM killer API, this patch would be a module and
> could have module parameters to select that.
> 
> Johnathan: I URGE you to apply my patch before adding OOM killer
>    stuff. What's wrong with it, that you cannot use it? ;-)
> 
> It is easy to add configurables to a module and play with them
> WITHOUT recompiling.

It's total overkill and therefore not a good design.

> Dynamic sysctl tables would also be possible, IF we had an value
> that is DEFINED to be invalid for sysctrl(2) and only valid for /proc.
> 
> It is also better to include the egid into the decision. There
> are deamons, that I defintely want to be killed on a workstation,
> but not on a server.
> 
> e.g. My important matlab calculation, which runs in user mode
> should not be killed. But killing a local webserver, which serves
> my help system is ok (because I will not loose work, and might
> get it over the net, if there is a problem).
> 
> So as Rik stated: The OOM killer cannot suit all people, so it
> has to be configurable, to be OOM kill, not overkill ;-)

Irony: Why then not store this information permanently - inside
the UID of the application?
