Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265844AbVBDOTM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265844AbVBDOTM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 09:19:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265793AbVBDOTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 09:19:11 -0500
Received: from rproxy.gmail.com ([64.233.170.201]:29032 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S265863AbVBDORh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 09:17:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=I3FiHw2GXmFJuj/GYVJrust51LNPi7h4v5as6w+SGvciiAR8EKZogmN9yFfi2JTMSTm47S64R7VQtEzvRCG4z5jsozgk7eHI5VeSMZPflgVcKHjbARDrmMstshN0h4irzey8ofct4Fx8NitEm1Z9WpWP+E/3g2/YsPEQulPgjFg=
Message-ID: <d120d500050204061735404d50@mail.gmail.com>
Date: Fri, 4 Feb 2005 09:17:33 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH 2.6.11-rc3] IBM Trackpoint support
Cc: Stephen Evanchik <evanchsa@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20050204065454.GA2796@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <a71293c20502031443764fb4e5@mail.gmail.com>
	 <200502031934.16642.dtor_core@ameritech.net>
	 <20050204063520.GD2329@ucw.cz>
	 <200502040152.39728.dtor_core@ameritech.net>
	 <20050204065454.GA2796@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Feb 2005 07:54:54 +0100, Vojtech Pavlik <vojtech@suse.cz> wrote:
> On Fri, Feb 04, 2005 at 01:52:39AM -0500, Dmitry Torokhov wrote:
> > On Friday 04 February 2005 01:35, Vojtech Pavlik wrote:
> > > On Thu, Feb 03, 2005 at 07:34:16PM -0500, Dmitry Torokhov wrote:
> > > > On Thursday 03 February 2005 17:43, Stephen Evanchik wrote:
> > > > > Vojtech,
> > > > >
> > > > > Here is a patch that exposes the IBM TrackPoint's extended properties
> > > > > as well as scroll wheel emulation.
> > > > >
> > > > >
> > > >
> > > > Hi,
> > > >
> > > > Very nice although I have a couple of comments.
> > > >
> > > > >  /*
> > > > > + * Try to initialize the IBM TrackPoint
> > > > > + */
> > > > > +       if (max_proto > PSMOUSE_PS2 && trackpoint_init(psmouse) == 0) {
> > > > > +               psmouse->vendor = "IBM";
> > > > > +               psmouse->name = "TrackPoint";
> > > > > +
> > > > > +               return PSMOUSE_PS2;
> > > >
> > > > Why PSMOUSE_PS2? Reconnect will surely not like it.
> > >
> > > Indeed. IIRC this patch killed wheel mouse detection in ubuntu.
> > >
> >
> > We may need yet another psmouse_reset after unsuccessful test.
> 
> We probably should do one after every test for isolation. It's not that
> big a problem now that we do the probing from a thread.
> 

It is still a problem if driver is registered after the port has been
detected wich quite often is the case as many people have psmouse as a
module.

I wonder if we should make driver registration asynchronous too. I
don't forsee any issues providing that I bump up module's reference
count while driver structure is "in flight", do you?

-- 
Dmitry
