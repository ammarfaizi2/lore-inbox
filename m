Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262671AbVCJP6h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262671AbVCJP6h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 10:58:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262672AbVCJP5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 10:57:38 -0500
Received: from styx.suse.cz ([82.119.242.94]:44244 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S262671AbVCJP53 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 10:57:29 -0500
Date: Thu, 10 Mar 2005 16:57:29 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: dtor_core@ameritech.net
Cc: Adrian Bunk <bunk@stusta.de>, Borislav Petkov <petkov@uni-muenster.de>,
       perex@suse.cz, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
       linux-input@atrey.karlin.mff.cuni.cz
Subject: Re: [2.6 patch] OSS gameport fixes
Message-ID: <20050310155729.GB27494@ucw.cz>
References: <20050304033215.1ffa8fec.akpm@osdl.org> <200503070941.59365.petkov@uni-muenster.de> <20050307215206.GH3170@stusta.de> <d120d50005030714126e345fe2@mail.gmail.com> <20050307230633.GJ3170@stusta.de> <20050309113217.GB21688@stusta.de> <d120d5000503100736212a9c87@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000503100736212a9c87@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2005 at 10:36:57AM -0500, Dmitry Torokhov wrote:
> On Wed, 9 Mar 2005 12:32:17 +0100, Adrian Bunk <bunk@stusta.de> wrote:
> > This patch adds dummy gameport_register_port, gameport_unregister_port
> > and gameport_set_phys functions to gameport.h for the case when a driver
> > can't use gameport.
> > 
> > This fixes the compilation of some OSS drivers with GAMEPORT=n without
> > the need to #if inside every single driver.
> > 
> > This patch also removes the non-working and now obsolete SOUND_GAMEPORT.
> > 
> > This patch is also an alternative solution for ALSA drivers with similar
> > problems (but #if's inside the drivers might have the advantage of
> > saving some more bytes of gameport is not available).
> > 
> > The only user-visible change is that for GAMEPORT=m the affected OSS
> > drivers are now allowed to be built statically (but they won't have
> > gameport support).
> > 
> 
> Hi Adrian,
> 
> I have somewhat mixed feeling about the patch. Some solutions is
> definitely needed but I don't like allocating memory that will never
> be used. I think I would perfer #ifdefing gameport support is OSS
> modules, _if_ #ifdefs are out of line and not in the middle of code
> path.
> 
> I'll let Vojtech decide which way he wants to go - he could probably
> apply the patch and then we could convert drivers one by one and kill
> the stubs later.

OK, I'll add it, since it fixes immediate breakage. I'll also accept
patches that #ifdef-out the relevant parts of sound drivers if gameport
support is not present.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
