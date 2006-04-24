Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750818AbWDXO5c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbWDXO5c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 10:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbWDXO5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 10:57:32 -0400
Received: from styx.suse.cz ([82.119.242.94]:2212 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1750818AbWDXO5b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 10:57:31 -0400
Date: Mon, 24 Apr 2006 16:57:47 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: dtor_core@ameritech.net
Cc: bjd <bjdouma@xs4all.nl>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 001/001] INPUT: new ioctl's to retrieve values of EV_REP and EV_SND event codes
Message-ID: <20060424145747.GA5906@suse.cz>
References: <20060422204844.GA16968@skyscraper.unix9.prv> <d120d5000604240731i5a3667f9g37e94de390485aac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000604240731i5a3667f9g37e94de390485aac@mail.gmail.com>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2006 at 10:31:39AM -0400, Dmitry Torokhov wrote:
> On 4/22/06, bjd <bjdouma@xs4all.nl> wrote:
> >
> > From: Bauke Jan Douma <bjdouma@xs4all.nl>
> >
> 
> Hi Bauke,
> 
> Thank you for your patch.
> 
> > Add two new ioctl's to have the input driver return actual current values for
> > EV_REP and EV_SND event codes.
> >
> > Currently there is no ioctl to retrieve EV_REP values, even though they have
> > actually always been stored in dev->rep.  A new ioctl, EVIOCGREPCODE,
> > retrieves them.
> >
> 
> EVIOCGREP and EVIOCSREP ioctls are present in 2.4 but they have been
> removed during 2.6 development. If you need to get/set repeat delay
> and period you need to use KDKBDREP ioctl; it will change the repeat
> rate for all keyboards attached to the box.
> 
> Vojtech, could you remind me why EVIOC{G|S}REP were removed? Some
> people want to have ability to separate keyboards (via grabbing); they
> also might want to control repeat rate independently. Shoudl we
> reinstate these ioctls?

I believe they were replaced by the ability to send EV_REP style events
to the device, setting the repeat rate.

> > The existing EVCGSND ioctl has never returned anything meaningful; the relevant
> > fragment in input.c was missing even a change_bit() call.
> > The actual EV_SND values are now written in dev->snd.  To make this work,
> > dev->snd had to be made an int array, and as a consequence the EVICGSND ioctl
> > became problematic.  I have removed it in this diff, but --even though it never
> > has returned anything meaningful-- I'm not quite sure that's the right thing to
> > do, so I would appreciate feedback on this.
> > Anyway, an EVIOCGSNDCODE ioctl was added to retrieve these values.
> 
> I think we should just fix EVCGSND and just allow userspace to query
> which sound evvects are active fro device - IOW just return bitmap
> like we do for keys and leds and switches. I don't think actuall
> "value" of the SND_TONE is interesting to anyone.

Agreed.

-- 
Vojtech Pavlik
Director SuSE Labs
