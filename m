Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261569AbVAaI5v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261569AbVAaI5v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 03:57:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261709AbVAaI5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 03:57:51 -0500
Received: from styx.suse.cz ([82.119.242.94]:45728 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261569AbVAaI5t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 03:57:49 -0500
Date: Mon, 31 Jan 2005 10:01:26 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Roman Zippel <zippel@linux-m68k.org>, Andries Brouwer <aebr@win.tue.nl>,
       linux-kernel@vger.kernel.org
Subject: Re: Possible bug in keyboard.c (2.6.10)
Message-ID: <20050131090126.GB27820@ucw.cz>
References: <Pine.LNX.4.61.0501270318290.4545@82.117.197.34> <20050129045055.GS8859@parcelfarce.linux.theplanet.co.uk> <20050129112510.GB2268@ucw.cz> <200501291835.59597.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501291835.59597.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 29, 2005 at 06:35:59PM -0500, Dmitry Torokhov wrote:
> On Saturday 29 January 2005 06:25, Vojtech Pavlik wrote:
> > On Sat, Jan 29, 2005 at 04:50:55AM +0000, Al Viro wrote:
> > 
> > > > I'm very sorry about the locking, but the thing grew up in times of
> > > > kernel 2.0, which didn't require any locking. There are a few possible
> > > 
> > > Incorrect.  You have blocking allocations in critical areas and they
> > > required locking all way back.
> > 
> > Ok. I see a problem where input_register_device() calls input handler
> > connect methods, which do kmalloc(). This would be bad even on 2.0.
> > 
> > Anything else? I believe the ->open()/->release() methods are still
> > protected.
> > 
> 
> evdev, tsdev, mousedev, joydev need to protect their client lists because
> interrupt could try to deliver event to already deleted device (client)

Oh, of course. The protection doesn't apply to the event routine.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
