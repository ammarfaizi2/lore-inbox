Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263775AbTGAX31 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 19:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264075AbTGAX31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 19:29:27 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:21987 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S263775AbTGAX3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 19:29:25 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Date: Wed, 2 Jul 2003 09:43:42 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16130.7342.567086.595743@gargle.gargle.HOWL>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [RFC/PATCH] Touchpads in absolute mode (synaptics) and mousedev
In-Reply-To: message from Dmitry Torokhov on Tuesday July 1
References: <200307010303.53405.dtor_core@ameritech.net>
	<16129.22286.274059.518816@gargle.gargle.HOWL>
	<200307011329.50551.dtor_core@ameritech.net>
X-Mailer: VM 7.16 under Emacs 21.3.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday July 1, dtor_core@ameritech.net wrote:
> Apologies if you seen this already but it seems the list ate my previous 
> replies...
> 
> On Tuesday 01 July 2003 04:40 am, Neil Brown wrote:
> > On Tuesday July 1, dtor_core@ameritech.net wrote:
> ... skip ...
> > >
> > > 1. Modify mousedev so if an input device announces that it generates both
> > >    relative and absolute events mousedev will discard all absolute axis
> > >    events and will rely on device supplied relative events.
> >
> > Nah.  I have an ALPS dualpoint which generates ABSolute events for the
> > touchpad part and RElative events for the pointstick part.  I want
> > them both.
> >
> 
> So pass relative events as is and do conversion of absolute to relatives. 
> That's what I gonna do about my track stick as well.
> 
> Remember that mousedev provides _emulation_ of [Ex]PS/2 mouse protocol for
> almost any device, it does not do any advanced tricks it's here to use with 
> old software that does not have advanced drivers yet, you are not "loosing"
> your absolute mode packets, you hav /dev/input/eventX to access them.  
> 

If I do that, then on the eventX device I will see both 'real'
relative events and 'synthesised' (from absoule) relative events and I
won't be able to tell the difference.

> > > 2. Add absolute->relative conversion code to touchpad drivers themselves
> > >    as drivers should know the best how to do that. If they turn out to be
> > >    similar across different touchpads then the common module could be
> > >    made.
> > >
> > > What you think?
> >
> > I think that mousedev should be just clever enough to mostly work and
> > no cleverer.  Anything more interesting should be done in user-space.
> >
> 
> Right, and if device says that it can generate relative packets mousedev 
> should not get in its way and do its own absolute->relative conversion.

A device should present raw events.  Whatever the user says to the
device should come out eventX uninterpreted.
mousedev should interpret what it can and present this out
/dev/psaux.  As it can do limited interpretation of ABS events, it
should.

This seems different to your perspective, but seeing there is not
standard or other document that we can make reference too, it is not
clear that anyone can decide who is *right*.....

NeilBrown
