Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422824AbWJNTOo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422824AbWJNTOo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 15:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422826AbWJNTOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 15:14:44 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:3845 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1422824AbWJNTOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 15:14:44 -0400
Date: Sat, 14 Oct 2006 21:14:41 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Michael Krufky <mkrufky@linuxtv.org>
Cc: mchehab@infradead.org, linux-kernel@vger.kernel.org,
       linux-dvb-maintainer@linuxtv.org,
       Andrew de Quincey <adq_dvb@lidskialf.net>
Subject: Re: [PATCH 08/18] V4L/DVB (4734): Tda826x: fix frontend selection for dvb_attach
Message-ID: <20061014191441.GU30596@stusta.de>
References: <20061014115356.PS36551000000@infradead.org> <20061014120050.PS78628900008@infradead.org> <20061014121608.GN30596@stusta.de> <45312819.4080909@linuxtv.org> <20061014183322.GS30596@stusta.de> <45313306.104@linuxtv.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45313306.104@linuxtv.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 14, 2006 at 02:57:10PM -0400, Michael Krufky wrote:
> Adrian Bunk wrote:
> 
> >On Sat, Oct 14, 2006 at 02:10:33PM -0400, Michael Krufky wrote:
> > 
> >
> >>>This breaks with CONFIG_VIDEO_SAA7134_DVB=y, CONFIG_DVB_TDA826X=m.
> >>>     
> >>>
> >>Regardless, the patch must be applied.  The above should only break with 
> >>DVB_FE_CUSTOMIZE=Y ...
> >>
> >>Turn off DVB_FE_CUSTOMIZE, and you will find that the above does NOT 
> >>break.  You can probably reproduce this 'broken' situation by setting any 
> >>card driver = y, with the frontend = m ...
> >>
> >>As stated in the prior thread, "CONFIG_VIDEO_SAA7134_DVB=y, 
> >>CONFIG_DVB_TDA826X=m" is not the problem -- rather, 
> >>"CONFIG_VIDEO_SAA7134_DVB=y, CONFIG_DVB_TDA826X=m, DVB_FE_CUSTOMIZE=Y" 
> >>causes the breakage.
> >>   
> >>
> >This patch fixes only a part of the problem.
> >
> >If this is the way how you want to handle CONFIG_DVB_FE_CUSTOMIZE=y, 
> >I don't understand why you don't use
> > #if defined(CONFIG_DVB_TDA826X) || (defined(CONFIG_DVB_TDA826X_MODULE) && 
> > defined(MODULE))
> >which is what I stated in exactly the thread you quote.
> > 
> >
> Adrian --
> 
> Two separate problems, please do not confuse them.
> 
> My tda10086 and tda826x patches are correct -- there is no question of it.

The problem is that they don't fix the whole problem.

And the fact that all frontends do "default m if DVB_FE_CUSTOMISE" makes 
my scenario of a built-in driver and modular frontends quite likely...

> I did not get an email from you with a suggestion for a fix for 
> DVB_FE_CUSTOMIZE, but my cable / internet has been down for a day and a 
> half, maybe it will come in soon.

I did suggest this in [1], and you answered to my email in [2].

> I am not the author of DVB_FE_CUSTOMIZE, adq (cc added) seems to be busy 
> at the moment.  Please send in your patch suggestion to the 
> v4l-dvb-maintainer list, if you haven't already, and we can discuss that 
> issue separately.

To be honest and after looking deeper at it, I don't like this 
CONFIG_DVB_FE_CUSTOMIZE approach at all since it adds that much 
complexity for not much gain.

I'd simply select all frontends unconditionally, and I'd even make the 
frontend options no longer user visible.

> -Mike Krufky

cu
Adrian

[1] http://lkml.org/lkml/2006/10/9/35
[2] http://lkml.org/lkml/2006/10/9/43

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

