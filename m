Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262570AbVBBPzI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262570AbVBBPzI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 10:55:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262314AbVBBPzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 10:55:07 -0500
Received: from rproxy.gmail.com ([64.233.170.201]:54406 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262585AbVBBPvk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 10:51:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Stp7Hq7b6jqEZJ0fNT9tYOLlmW1tO/f2X2pzVFj8tAyCQ+ykpqxCMuKzuAZOMaQkPgoOXo0RSl3EPpLCbFVrMoYsDBGM2x9dXRlln9sCj9kluzQJiqXSfNQ+Pbtj106nP9goTZM4EjZCVPt4ZbMwIei1khKQNxHuitVKrbaYMrI=
Message-ID: <d120d5000502020751db00e48@mail.gmail.com>
Date: Wed, 2 Feb 2005 10:51:38 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: Touchpad problems with 2.6.11-rc2
Cc: Pete Zaitcev <zaitcev@redhat.com>, Peter Osterlund <petero2@telia.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050202102033.GA2420@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050123190109.3d082021@localhost.localdomain>
	 <m3acqr895h.fsf@telia.com>
	 <20050201234148.4d5eac55@localhost.localdomain>
	 <20050202102033.GA2420@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Feb 2005 11:20:33 +0100, Vojtech Pavlik <vojtech@suse.cz> wrote:
> On Tue, Feb 01, 2005 at 11:41:48PM -0800, Pete Zaitcev wrote:
> > On 30 Jan 2005 12:10:34 +0100, Peter Osterlund <petero2@telia.com> wrote:
> >
> > > > - Slow motion of finger produces no motion, then a jump. So, it's very hard to
> > > >   target smaller UI elements and some web links.
> > >
> > > I see this too when I don't use the X touchpad driver. With the X
> > > driver there is no problem. I think the problem is that mousedev.c in
> > > the kernel has to use integer arithmetic, so probably small movements
> > > are rounded off to 0. I'll try to come up with a fix for this.
> >
> > Thanks for the hint. I tried various schemes and mathematical transformations
> > and found one which gives unquestionably the best result, with smoothest, most
> > precise and comfortable pointer movement:
> 
> Well, you removed the scaling to the touchpad resolution, which will
> cause ALPS touchpad to be significantly slower than Synaptics touchpads.

Yep, Synaptics I think has 4-5x higher resolution.

> Similarly, the screen size used to be taken into account, but probably
> that was a mistake, since the value is usually left at default and
> doesn't correspond to the real screen size.

I wonder if we should just add speed factor (along with tap distance)
options to mousedev. Vojtech, will you take such patch? I know you
want to drop mousedev and have everyone use evdev but, although people
started switching, it will not happen until distributions (or
XOrg/XFree themselves) have these drivers available straight out of
the box.

-- 
Dmitry
