Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261783AbVA3VBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261783AbVA3VBd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 16:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbVA3VBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 16:01:32 -0500
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:1713 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S261783AbVA3VB3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 16:01:29 -0500
From: David Brownell <david-b@pacbell.net>
To: Peter Osterlund <petero2@telia.com>
Subject: Re: Touchpad problems with 2.6.11-rc2
Date: Sun, 30 Jan 2005 12:59:22 -0800
User-Agent: KMail/1.7.1
Cc: dtor_core@ameritech.net, linux-kernel@vger.kernel.org,
       Pete Zaitcev <zaitcev@redhat.com>
References: <200501251155.20430.david-b@pacbell.net> <d120d50005012513304ba0ca88@mail.gmail.com> <m31xc388o9.fsf@telia.com>
In-Reply-To: <m31xc388o9.fsf@telia.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501301259.22584.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 30 January 2005 3:20 am, Peter Osterlund wrote:
> Dmitry Torokhov <dmitry.torokhov@gmail.com> writes:
> > On Tue, 25 Jan 2005 11:55:20 -0800, David Brownell <david-b@pacbell.net> wrote:

> > > The more serious one is that sometimes it seems to spontaneously emit click
> > > events while I'm moving finger across pad.  Which means I've had to learn to
> > > plan my "mouse" motions to avoid areas where clicking could have bad effects.
> > > But that's not always possible ...
> > 
> > That is default sensitivity not suiting your habits I think.

That answer isn't good.  No defaults should be that dangerous!
But I suspect that's not really the issue...


> > I would 
> > recomment trying out Synaptics X driver (which also does ALPS) so you
> > will be able adjust sensitivity the way you like it.

With the Synaptics X driver (as supplied by SuSE -- but NOT configured
automatically by the system install tool) and the ALPS parameters in the
README.alps from synaptics-0.14.0, and kernel parameters "usb-handoff"
and "mousedev.tap_time=0", I'm getting somewhat better results in this
particular area.

I see some new "mouse"-specific failure modes though:

  (a) Sometimes tapping automagically generates extra clicks.  For
      example, pressing the delete button once will delete two or more
      mail messages.  Unfortunately it's not actually smart enough to
      only kick in for spam!  (I think this is exclusively when using
      the touchpad itself.)

  (b) Sometimes tapping the left button seems to start half a drag event.
      For example a GUI button's menu pops up rather than performing the
      action associated with the button.  That could be some funky UI
      settings, but it's not consistent ... and I've observed this with
      very quick button presses.  So I think something else is afoot.

  (c) Sometimes tapping seems to only generate a "down" event ... until
      I move the cursor, the "up" doesn't happen.  Again, this is with
      the left button, not the touchpad itself.

I haven't recently seen that nasty "motion emits random mouseclicks"
behavior, but given the way the hardware programs/trains user behavior,
it's hard to say for sure quite yet.

I've not done enough with non-GUI keyboard interactions to say if that
nasty keyboard blockage issue is gone or not; I wouldn't have seen it.


> I think the problem is that the tap detection in mousedev.c is very
> simplistic. It always generates a button click if the time between
> "finger down" and "finger up" is small enough, even if the finger was
> moved a large x/y distance. The X driver handles this with another
> parameter that specifies the maximum allowed distance. If the finger
> moved more than this distance, no button event is generated.

Sounds like "dueling heuristics" here!

I think the behavior I'm now seeing supports that hypothesis.  But
it's hard to say without knowing more about how all the pieces fit
together.

- Dave

