Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262006AbTJNUOR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 16:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262051AbTJNUOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 16:14:04 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:54974 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S262006AbTJNUN7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 16:13:59 -0400
Date: Tue, 14 Oct 2003 22:13:54 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: 4Front Technologies <dev@opensound.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>,
       Martin Josefsson <gandalf@wlug.westbo.se>, linux-kernel@vger.kernel.org
Subject: Re: mouse driver bug in 2.6.0-test7?
Message-ID: <20031014201354.GA10458@ucw.cz>
References: <3F8C3A99.6020106@opensound.com> <1066159113.12171.4.camel@tux.rsn.bth.se> <20031014193847.GA9112@ucw.cz> <3F8C56B3.1080504@opensound.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F8C56B3.1080504@opensound.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 14, 2003 at 01:04:03PM -0700, 4Front Technologies wrote:

> >Patch considered. I'll up the samplerate default to 80, but not more,
> >since samplerates above that cause trouble for a lot of people (keyboard
> >doesn't work when you're moving the mouse).
> >
> >The "set lower rate in case ..." part of the patch doesn't make sense.
> >If the user gives a too low (less than 10) samples per second, then the
> >original code will try to set 0, which is stupid, but harmless. The
> >added code will try to access beyond the bounds of the rates[] array.
> 
> 
> Hi Martin/Vojtech,
> 
> Martin, many thanks for your fix - it works perfectly now.
> 
> Oddly enough the sample rate of 200 seems to have fixed the problem.
> Vojetech,  Martin's fixes are fully functional.

Not completely. One reason wht the sample rate of 200 probably fixed the
problem is that you have very high acceleration settings in X.

Since with report rate 200 you get a medium speed movement as

+1 +1 +1 +1 +1 +1 +1 +1 +1

events, and with report rate 60 you get

       +3      +3       +3

and the X mouse acceleration code is stupid enough to judge the mouse
speed from the event VALUE only, it thinks the mouse is moving much
faster in the second case.

You need to up the acceleration threshold (or disable acceleration
completely).

This also means that with report rate of 200, mouse acceleration is more
or less disabled, since you get +1's only even at quite high speeds of
mouse movement.

> If you want to keep it at 80,

I don't want to. I like the feel of a mouse at 200 samples per second,
however it causes problems on some hardware, which means I have to stay
with a more reasonable default.

> I'd recommend that you make the sample rate a module config option so that
> users may be able to tweak this for their systems.

It already is. Only the code to make it a kernel command line parameter
(when psmouse is compiled into the kernel) is missing.

> The default of 200 has been tested on VIA400 and IntelICH5 systems that I 
> have.

Yes, new boards don't have any problems with it. It's the older ones
that do.

> One running Redhat9/2.6.0-test7 and the other running Gentoo 1.4/2.6.0-test7

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
