Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289823AbSAWML6>; Wed, 23 Jan 2002 07:11:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289815AbSAWMLs>; Wed, 23 Jan 2002 07:11:48 -0500
Received: from [62.245.135.174] ([62.245.135.174]:43966 "EHLO mail.teraport.de")
	by vger.kernel.org with ESMTP id <S289825AbSAWMLg>;
	Wed, 23 Jan 2002 07:11:36 -0500
Message-ID: <3C4EA871.80275293@TeraPort.de>
Date: Wed, 23 Jan 2002 13:11:29 +0100
From: Martin Knoblauch <Martin.Knoblauch@TeraPort.de>
Reply-To: m.knoblauch@TeraPort.de
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.18-pre4-J0-VM-22-preempt-lock i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Helge Hafting <helgehaf@aitel.hist.no>
Subject: Re: Possible Idea with filesystem buffering.
In-Reply-To: <3C4E85BB.FBC5C2E4@TeraPort.de> <3C4EA3FB.93A98AB9@aitel.hist.no>
X-MIMETrack: Itemize by SMTP Server on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 01/23/2002 01:11:28 PM,
	Serialize by Router on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 01/23/2002 01:11:35 PM,
	Serialize complete at 01/23/2002 01:11:35 PM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:
> 
> Martin Knoblauch wrote:
> >
> > > Re: Possible Idea with filesystem buffering.
> > >
> > > From: Richard B. Johnson (root@chaos.analogic.com)
> > > Date: Tue Jan 22 2002 - 17:10:27 EST
> > >
> > >
> > > We need a free-RAM target, possibly based upon a percentage of
> > > available RAM. The lack of such a target is what causes the
> > > out-of-RAM condition we have been experiencing. Somebody thought
> > > that "free RAM is wasted RAM" and the VM has been based upon
> > > that theory. That theory has been proven incorrect. You need
> >
> As far as I know, there is a free target.  The kernel will try to get
> rid of old pages (swapout program memory, toss cache pages)
> when there's too little free memory around.  This keeps memory
> around so future allocations and IO request may start
> immediately.  Maybe the current target is too small, but it is there.
> Without it, _every_ allocation or file operation would block
> waiting for a swapout/cache flush in order to get free pages.  Linux
> isn't nearly _that_ bad.
>

 Nobody said it is  _that_ bad. There are just some [maybe rare]
situations where it falls over and does not recover gracefully.

> >  Now, I think the theory itself is OK. The problem is that the stuff in
> > buffer/caches is to sticky. It does not go away when "more important"
> > uses for memory come up. Or at least it does not go away fast enough.
> >
> Then we need a larger free target to cope with the slow cache freeing.
>

 And as Rik said, we need to make freeing cache faster. All of this will
help the 98+% cases  that the VM can be optimized for. But I doubt that
you can make it 100% and keep it simple at the same time.

> > > free RAM, just like you need "excess horsepower" to make
> > > automobiles drivable. That free RAM is the needed "rubber-band"
> > > to absorb the dynamics of real-world systems.
> >
> >  Question: what about just setting a maximum limit to the cache/buffer
> > size. Either absolute, or as a fraction of total available memory? Sure,
> > it maybe a waste of memory in most situations, but sometimes the
> > administrator/user of a system simply "knows better" than the FVM (F ==
> > Fine ? :-)
> [...]
> >  I know, the tuning-knob approach is frowned upon. But sometimes there
> > are workloads where even the best VM may not know how to react
> > correctly.
> 
> Wasting memory "in most situations" isn't really an option.  But I
> see nothing wrong with "knobs" as long as they are automatic by
> default.  Those who want to optimize for a corner case can
> go and turn off the autopilot.
> 

 Definitely. The defaults need to be set for the general case. 

Martin
-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
C+ITS                    |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759
