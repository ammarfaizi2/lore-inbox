Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261799AbVCOVP6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261799AbVCOVP6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 16:15:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbVCOVP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 16:15:58 -0500
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:59024 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S261799AbVCOVPt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 16:15:49 -0500
From: David Brownell <david-b@pacbell.net>
To: dtor_core@ameritech.net
Subject: Re: [linux-usb-devel] Re: [RFC] Changes to the driver model class code.
Date: Tue, 15 Mar 2005 13:14:40 -0800
User-Agent: KMail/1.7.1
Cc: linux-usb-devel@lists.sourceforge.net, Greg KH <greg@kroah.com>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       linux-kernel@vger.kernel.org, Kay Sievers <kay.sievers@vrfy.org>
References: <20050315170834.GA25475@kroah.com> <200503151235.02934.david-b@pacbell.net> <d120d50005031512485125db18@mail.gmail.com>
In-Reply-To: <d120d50005031512485125db18@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503151314.40510.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 March 2005 12:48 pm, Dmitry Torokhov wrote:
> On Tue, 15 Mar 2005 12:35:02 -0800, David Brownell <david-b@pacbell.net> wrote:
> > On Tuesday 15 March 2005 12:14 pm, Dmitry Torokhov wrote:
> > >
> > > It looks to me (and I might be wrong) that USB was never really
> > > integrated into the driver model. It was glued with it but the driver
> > > model came after most of the domain was defined, and it did not get to
> > > be "bones" of the subsystem. This is why it is so easy to deatch it.
> > 
> > That doesn't seem accurate to me.  Are you thinking maybe about
> > just how it uses the class device stuff?  ...
> > 
> 
> David,
> 
> I was not criticizing the code, not at all, I was commenting on
> evolution of the code (at least the way I perceive it). The fact that
> there is (or was until recently) pre-driver-model binding code shows
> that merging is still ongoing and this fact makes reversing the
> process easier.

You still haven't answered my question.  My observation was that
only the class code can in any sense be called "new" ... so your
blanket statement seemed to overlook several essential points!

Which parts of the driver model were you thinking of?


That pre-driver model stuff went away in maybe 2.6.5 or so, I
forget just when.  If you think those changes can easily be
reversed, I suggest you think again ... they enabled a LOT of
likewise-overdue cleanups.  And they only affected the case of
drivers that bound to multiple interfaces, gettng rid of a
funky "half bound" state and making it look like the primary
case (drivers binding to one interface at a time), which has
been working since 2.5.early.

It's been a long slog to get to a usb core that's a good
match to the relatively complex requirements of USB.  With a
few notable exceptions (like PM non-support for wakeup events
and for selective suspend, and strange locking side effects),
converting to the driver model has been a win at every step
of the way.  It's gone both ways; the driver core has changed
to work better with USB too.

- Dave

