Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273000AbTHKTCT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 15:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272991AbTHKTBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 15:01:32 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:18902 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S272988AbTHKTAW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 15:00:22 -0400
Date: Mon, 11 Aug 2003 20:59:47 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Johannes Stezenbach <js@convergence.de>, Gerd Knorr <kraxel@bytesex.org>,
       Flameeyes <dgp85@users.sourceforge.net>, Pavel Machek <pavel@suse.cz>,
       Christoph Bartelmus <columbus@hit.handshake.de>,
       LIRC list <lirc-list@lists.sourceforge.net>,
       LKML <linux-kernel@vger.kernel.org>, vojtech@suse.cz
Subject: Re: [PATCH] lirc for 2.5/2.6 kernels - 20030802
Message-ID: <20030811185947.GA8549@ucw.cz>
References: <1060616931.8472.22.camel@defiant.flameeyes> <20030811163913.GA16568@bytesex.org> <20030811175642.GC2053@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030811175642.GC2053@convergence.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 11, 2003 at 07:56:42PM +0200, Johannes Stezenbach wrote:
> Gerd Knorr wrote:
> > 
> > > We can drop /dev/lirc*, and use input events with received codes, but I
> > > think that lircd is still needed to translate them into userland
> > > commands...
> > 
> > That translation isn't done by lircd, but by the lirc_client library.
> > This is no reason for keeping lircd as event dispatcher, the input layer
> > would do equally well (with liblirc_client picking up events from
> > /dev/input/event<x> instead of lircd).
> 
> IMHO there's one problem:
> 
> If a remote control has e.g. a "1" key this doesn't mean that a user
> wants a "1" to be written into your editor while editing source code.
> The "1" key on a remote control simply has a differnt _meaning_ than
> the "1" key on your keyboard -- depending of course on what the user
> thinks this key should mean.

That's what BTN_1 is for. ;)

> - users should be able to prevent remote keys from being fed into
>   the normal keyboard input queue; non lirc aware programs should
>   not recieve these events
>   (OTOH, if you use an IR keyboard...)

Yes, the console needs to be configurable in that respect. Its something
that needs to be fixed.

> - IR events should reach the applications independant of X keyboard
>   focus (well, maybe; the user should be able to decide)
> 
> With the current input subsystem, the only possiblity is lircd
> grabbing the remote events with EVIOCGRAB, and passing them
> on to the applications.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
