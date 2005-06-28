Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262257AbVF2ADg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262257AbVF2ADg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 20:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262247AbVF2ADV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 20:03:21 -0400
Received: from atpro.com ([12.161.0.3]:46862 "EHLO atpro.com")
	by vger.kernel.org with ESMTP id S262222AbVF1XoU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 19:44:20 -0400
Date: Tue, 28 Jun 2005 19:43:10 -0400
From: Jim Crilly <jim@why.dont.jablowme.net>
To: Mike Bell <kernel@mikebell.org>, Arjan van de Ven <arjan@infradead.org>,
       Greg KH <greg@kroah.com>, Dmitry Torokhov <dtor_core@ameritech.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] ndevfs - a "nano" devfs
Message-ID: <20050628234310.GA29653@mail>
Mail-Followup-To: Mike Bell <kernel@mikebell.org>,
	Arjan van de Ven <arjan@infradead.org>, Greg KH <greg@kroah.com>,
	Dmitry Torokhov <dtor_core@ameritech.net>,
	linux-kernel@vger.kernel.org
References: <20050624081808.GA26174@kroah.com> <20050625234305.GA11282@kroah.com> <20050627071907.GA5433@mikebell.org> <200506271735.50565.dtor_core@ameritech.net> <20050627232559.GA7690@mikebell.org> <20050628074015.GA3577@kroah.com> <20050628090852.GA966@mikebell.org> <1119950487.3175.21.camel@laptopd505.fenrus.org> <20050628214929.GB23980@voodoo> <20050628222318.GC4673@mikebell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050628222318.GC4673@mikebell.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/28/05 03:23:18PM -0700, Mike Bell wrote:
> On Tue, Jun 28, 2005 at 05:49:29PM -0400, Jim Crilly wrote:
> > I took a quick look and for OSS devices linphone seems to just loop over
> > /dev/dsp* so if the names were moved, I doubt it would work. 
> > 
> > But it also seems to have ALSA support and in that case it uses 
> > snd_card_get_name in a for loop to build a list of available cards, since 
> > all ALSA functions use card index numbers they should work fine independent 
> > of device file names.
> 
> No, they shouldn't. Try it and see. Yes, your /program/ uses the sound
> card index, but that's because the ALSA library internally assumes that
> sound card index 0 corresponds to certain device nodes.

I stand corrected then. I didn't actually try anything with linphone, the
ALSA API just makes it look like the device nodes don't matter.

> 
> Eventually every program has to be able to find the device node. That's
> just obvious, if you don't need the device node why have it in the first
> place? And if it can't predict what that device node will be named, the
> only thing it can do (short of creating its own private device node,
> which breaks all sorts of stuff /and/ is dumb /and/ doesn't work unless
> you're root) is search over every single device node in /dev to find the
> one with the correct major/minor. Or ask the user to type it in
> manually, which is all well and good for maybe an admin configuring some
> system, but is completely broken for anything GUI or automatic.
> 
> Hence my conclusion, predictable device file names are a requirement.
> udev's "name the device whatever you want" works fine for running vi on
> /etc/fstab, but when you want a program to do anything intelligent like
> present a list of available choices, you need to be able to find the
> device node.

Well it looks like the ALSA library already abstracts the device node
enough that the app itself doesn't know what file is being used because it
just calls snd_card_get_name, snd_open_pcm, etc with the ALSA index. So
wouldn't it be feasible to make ALSA a little bit smarter so that it could
track/find the device nodes no matter what name they have? I'm not
advocating for or against it, but from my cursory look at the API it looks
possible to do without breaking any ALSA apps.

Jim.
