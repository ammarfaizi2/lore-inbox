Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267607AbUI1HBf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267607AbUI1HBf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 03:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267612AbUI1HBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 03:01:35 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:7810 "EHLO midnight.suse.cz")
	by vger.kernel.org with ESMTP id S267607AbUI1HB2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 03:01:28 -0400
Date: Tue, 28 Sep 2004 09:01:09 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Micha Feigin <michf@post.tau.ac.il>,
       Peter Osterlund <petero2@telia.com>
Subject: Re: [BUG: 2.6.9-rc2-bk11] input completely dead in X
Message-ID: <20040928070107.GC1834@ucw.cz>
References: <20040926210450.GA2960@luna.mooo.com> <20040927124321.GC7486@luna.mooo.com> <20040927145223.GA3117@luna.mooo.com> <200409280126.19919.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200409280126.19919.dtor_core@ameritech.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2004 at 01:26:19AM -0500, Dmitry Torokhov wrote:
> Resending as I forgot to CC Vojtech and Peter first time around...
> 
> On Monday 27 September 2004 10:46 pm, Micha Feigin wrote:
> > > Or better yet, use the auto-dev feature, which should work if you have
> > > a new enough X driver and kernel patch.
> > > 
> > 
> > auto-dev doesn't work for me and I don't have time to check it
> > out.
> 
> Addition of Kensington ThinkingMouse / ExpertMouse support caused Synaptics
> and ALPS protocol numbers to move to 8 and 9 respectively which broke Peter's
> auto-dev detection. 

Ouch. I suspected something bad will happen.

> Vojtech, we need to keep protcol numbers stable, I propose something like this:
> 
> enum psmouse_type {
>         PSMOUSE_PS2             = 0,
>         PSMOUSE_PS2PP,
>         PSMOUSE_THINKPS,
>         PSMOUSE_GENPS           = 64,   /* 4 byte protocol start */
>         PSMOUSE_IMPS,
>         PSMOUSE_IMEX,
>         PSMOUSE_SYNAPTICS       = 128,  /* 5+ byte protocols start */
>         PSMOUSE_ALPS,
> };

No, we really need to keep backwards compatibility with the numbering
here and solve the packetsize issue elsewhere. Probably the best would
be for each of the protocols to have its own packet collection routine,
like the Synaptics and ALPS already have. It could be shared among the
simpler protocols.

We'll need this anyway for a heuristic resynchronizer.

> Peter, if we adopt the scheme above you will have to check both for old and
> new protocol numbers; in addition you need to BTN_TOOL_FINGER device bit to
> make sure you are dealing with a touchpad.
> 
> Any holes here?
 
I really would prefer if old installations of the X driver would work
with new kernel without the need to upgrade the X driver. I propose to
keep the protocol numbers intact, and if possible to also find a better
way for the X driver to detect a touchpad than relying on the IDs of the
input device, namely based on BTN_TOOL_FINGER presence.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
