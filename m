Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932302AbVJaOm0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302AbVJaOm0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 09:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932326AbVJaOm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 09:42:26 -0500
Received: from styx.suse.cz ([82.119.242.94]:59786 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S932302AbVJaOmZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 09:42:25 -0500
Date: Mon, 31 Oct 2005 15:42:23 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-input@atrey.karlin.mff.cuni.cz, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFT/PATCH] atkbd - speed up setting leds/repeat state
Message-ID: <20051031144223.GB18711@ucw.cz>
References: <200510310224.03010.dtor_core@ameritech.net> <20051031124746.GC18147@ucw.cz> <200510310905.32269.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510310905.32269.dtor_core@ameritech.net>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2005 at 09:05:31AM -0500, Dmitry Torokhov wrote:
> On Monday 31 October 2005 07:47, Vojtech Pavlik wrote:
> > On Mon, Oct 31, 2005 at 02:24:02AM -0500, Dmitry Torokhov wrote:
> > > Input: atkbd - speed up setting leds/repeat state
> > > 
> > > Changing led state is pretty slow operation; when there are multiple
> > > requests coming at a high rate they may interfere with normal typing.
> > > Try optimize (skip) changing hardware state when multiple requests
> > > are coming back-to-back.
> > > 
> > > Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> >  
> > It looks good - just two comments:
> > 
> > 	1) wmb() shouldn't be needed after set_bit()
> >
> 
> Judging by the comments in bitops only i386 implementation of set_bit
> implies memory barrier, other arches do not guarantee it. That's why
> I added wmb() there.

Hmm, OK. I always forget that atomicity doesn't imply a memory barrier.

> > 	2) maybe we want to enforce the delay before we send the 
> >            next SET_LED command.

> Well, with this patch "while true; do xset led 3; xset led -3; done"
> does not interfere with typing on my box and system load is staying
> low which means we don't have too many outstanding requests.

OK. I'll give it a spin if I find the time to.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
