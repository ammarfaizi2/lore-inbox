Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261260AbUJZP5H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbUJZP5H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 11:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbUJZP5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 11:57:07 -0400
Received: from web81306.mail.yahoo.com ([206.190.37.81]:40609 "HELO
	web81306.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261260AbUJZP4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 11:56:42 -0400
Message-ID: <20041026155639.42445.qmail@web81306.mail.yahoo.com>
Date: Tue, 26 Oct 2004 08:56:39 -0700 (PDT)
From: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: [PATCH 0/5] Sonypi driver model & PM changes
To: LKML <linux-kernel@vger.kernel.org>, Vojtech Pavlik <vojtech@suse.cz>,
       Stelian Pop <stelian@popies.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


And I am breaking the thread yet again....

Stelian pop wrote:
> On Tue, Oct 26, 2004 at 11:28:02AM +0200, Stelian Pop wrote:
> 
> > > [1]
> > > http://csociety-ftp.ecn.purdue.edu/pub/gentoo/distfiles/xorg-x11-
> 6.8.0-patches-0.2.5.tar.bz2
> > > Extract patches 9000, 9001 and 9002. Btw, these are not mine - I have
> > > Not even tries them myself but I have read several success stories.
> >
> > Got them and trying to build the new drivers right now. Thanks !
> 
> Well, it kinda works, but there are still some rough edges (the kbd
> driver maps all the unknown keys to KEY_UNKNOWN, making them all to
> have the same keycode in X, making them unusable. After removing the
> test it forwards the events ok).
> 
> There are also problems because my sonypi input device acts both like
> a mouse and a keyboard, and the X event driver wants them to be separate.
> 
> Vojtech: should I generate two different input devices in my driver,
> a mouse like and a keyboard like device, or should the userspace be
> able to demultiplex the events ?
> 

If you want jogdial to continue generating BTN_MIDDLE and BTN_WHEEL
events then IMHO you should create 2 separate input devices - one
for jogdial and the other for FN-keys.

On the other hand I am not sure if it is handy as a ponter device -
I think scrolling is much more natural with the touchpad (but
remember I don't have the hardware) and it may be more convenient
to assign brand-new events to jogdial as well and then map it in
userspace (X) into something different, like volume control. In
this case you can continue having just one input device.

Btw, you should probably drop conditional support for input layer
and always compile it in.

-- 
Dmitry

