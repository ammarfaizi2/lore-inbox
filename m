Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750701AbWJOMiK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbWJOMiK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 08:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbWJOMiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 08:38:10 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:7433 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750701AbWJOMiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 08:38:09 -0400
Date: Sun, 15 Oct 2006 14:38:04 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Mauro Carvalho Chehab <mchehab@infradead.org>
Cc: Michael Krufky <mkrufky@linuxtv.org>, linux-kernel@vger.kernel.org,
       linux-dvb-maintainer@linuxtv.org,
       Andrew de Quincey <adq_dvb@lidskialf.net>
Subject: Re: [PATCH 08/18] V4L/DVB (4734): Tda826x: fix frontend selection for dvb_attach
Message-ID: <20061015123804.GW30596@stusta.de>
References: <20061014115356.PS36551000000@infradead.org> <20061014120050.PS78628900008@infradead.org> <20061014121608.GN30596@stusta.de> <45312819.4080909@linuxtv.org> <20061014183322.GS30596@stusta.de> <45313306.104@linuxtv.org> <20061014191441.GU30596@stusta.de> <1160877306.28666.21.camel@praia>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1160877306.28666.21.camel@praia>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 14, 2006 at 10:55:06PM -0300, Mauro Carvalho Chehab wrote:
> Em Sáb, 2006-10-14 às 21:14 +0200, Adrian Bunk escreveu:
> > On Sat, Oct 14, 2006 at 02:57:10PM -0400, Michael Krufky wrote:
> > > Adrian Bunk wrote:
> > > 
> > > Two separate problems, please do not confuse them.
> > > 
> > > My tda10086 and tda826x patches are correct -- there is no question of it.
> > 
> > The problem is that they don't fix the whole problem.
> Yes. Trent made two patches using your suggestion of checking for
> MODULE. I'll submit it to Linus probably tomorrow after some tests.
> 
> If you want to review, they are at:
> http://linuxtv.org/hg/v4l-dvb?cmd=changeset;node=b8c06286cb3a;style=gitweb
> http://linuxtv.org/hg/v4l-dvb?cmd=changeset;node=18a778dbf540;style=gitweb

At a first glance they look good.

> > To be honest and after looking deeper at it, I don't like this 
> > CONFIG_DVB_FE_CUSTOMIZE approach at all since it adds that much 
> > complexity for not much gain.
> Yes, it adds some complexity. The gain, however, is to allow having
> smaller kernel size on embedded systems and DVR using MythTV or Freevo.
> There's a similar feature for V4L (Autoselect pertinent
> encoders/decoders and other helper chips), that allows selecting just
> the needed stuff. 

I understand this, but I still don't like the solution.
But unless I can send a patch with a better solution, this is nothing I 
can complain about...

There are two things that might be changed even now:

The "default m if DVB_FE_CUSTOMISE" is something I do not like that 
much, especially considering that embedded users caring about kernel 
size are likely to use CONFIG_MODULES=n.

Another thing is that we might want to let DVB_FE_CUSTOMISE depend on 
EMBEDDED - for the average non-embedded user kernel size doesn't matter 
that much, and CONFIG_DVB_FE_CUSTOMIZE=y might often cause user 
confusion (similar to e.g. KEYBOARD_ATKBD depending on EMBEDDED, 
although many users might use USB keyboards).

> > I'd simply select all frontends unconditionally
> Most users do this, including me :)
> 
> Cheers, 
> Mauro.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

