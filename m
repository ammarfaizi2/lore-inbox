Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261350AbVF1VyH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261350AbVF1VyH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 17:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261376AbVF1VwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 17:52:20 -0400
Received: from atpro.com ([12.161.0.3]:47364 "EHLO atpro.com")
	by vger.kernel.org with ESMTP id S261350AbVF1Vv5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 17:51:57 -0400
From: "Jim Crilly" <jim@why.dont.jablowme.net>
Date: Tue, 28 Jun 2005 17:49:29 -0400
To: Arjan van de Ven <arjan@infradead.org>
Cc: Mike Bell <kernel@mikebell.org>, Greg KH <greg@kroah.com>,
       Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] ndevfs - a "nano" devfs
Message-ID: <20050628214929.GB23980@voodoo>
Mail-Followup-To: Arjan van de Ven <arjan@infradead.org>,
	Mike Bell <kernel@mikebell.org>, Greg KH <greg@kroah.com>,
	Dmitry Torokhov <dtor_core@ameritech.net>,
	linux-kernel@vger.kernel.org
References: <20050624081808.GA26174@kroah.com> <20050625234305.GA11282@kroah.com> <20050627071907.GA5433@mikebell.org> <200506271735.50565.dtor_core@ameritech.net> <20050627232559.GA7690@mikebell.org> <20050628074015.GA3577@kroah.com> <20050628090852.GA966@mikebell.org> <1119950487.3175.21.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1119950487.3175.21.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/28/05 11:21:27AM +0200, Arjan van de Ven wrote:
> > 
> > So then explain this to me, I've got a GUI sound player, on first
> > invocation it displays a list of sound cards installed on the system,
> > allows the user to select one, and then plays the sound file. How is it
> > supposed to do that if the device nodes for sound card 0 could be named
> > anything? I can get a list of sound cards from /proc/asound or
> > /sys/class/sound, but unless the sound card device nodes are predictably
> > named there's no way to find them short of searching every node in /dev.
> 
> 
> actually.. linphone for example shows you the name of the device, not
> the device node. And at runtime it finds which device node belongs to
> that name somehow. I didn't look at the code how it does that, but it
> sure isn't impossible since it's done in practice already.

I took a quick look and for OSS devices linphone seems to just loop over
/dev/dsp* so if the names were moved, I doubt it would work. 

But it also seems to have ALSA support and in that case it uses 
snd_card_get_name in a for loop to build a list of available cards, since 
all ALSA functions use card index numbers they should work fine independent 
of device file names.


Jim.
