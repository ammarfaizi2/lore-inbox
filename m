Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263239AbTGASPH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 14:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263245AbTGASPH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 14:15:07 -0400
Received: from smtp805.mail.sc5.yahoo.com ([66.163.168.184]:42621 "HELO
	smtp805.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263239AbTGASPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 14:15:03 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: [RFC/PATCH] Touchpads in absolute mode (synaptics) and mousedev
Date: Tue, 1 Jul 2003 13:29:50 -0500
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
References: <200307010303.53405.dtor_core@ameritech.net> <16129.22286.274059.518816@gargle.gargle.HOWL>
In-Reply-To: <16129.22286.274059.518816@gargle.gargle.HOWL>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307011329.50551.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies if you seen this already but it seems the list ate my previous 
replies...

On Tuesday 01 July 2003 04:40 am, Neil Brown wrote:
> On Tuesday July 1, dtor_core@ameritech.net wrote:
... skip ...
> >
> > 1. Modify mousedev so if an input device announces that it generates both
> >    relative and absolute events mousedev will discard all absolute axis
> >    events and will rely on device supplied relative events.
>
> Nah.  I have an ALPS dualpoint which generates ABSolute events for the
> touchpad part and RElative events for the pointstick part.  I want
> them both.
>

So pass relative events as is and do conversion of absolute to relatives. 
That's what I gonna do about my track stick as well.

Remember that mousedev provides _emulation_ of [Ex]PS/2 mouse protocol for
almost any device, it does not do any advanced tricks it's here to use with 
old software that does not have advanced drivers yet, you are not "loosing"
your absolute mode packets, you hav /dev/input/eventX to access them.  

> > 2. Add absolute->relative conversion code to touchpad drivers themselves
> >    as drivers should know the best how to do that. If they turn out to be
> >    similar across different touchpads then the common module could be
> >    made.
> >
> > What you think?
>
> I think that mousedev should be just clever enough to mostly work and
> no cleverer.  Anything more interesting should be done in user-space.
>

Right, and if device says that it can generate relative packets mousedev 
should not get in its way and do its own absolute->relative conversion.
 
Dmitry
