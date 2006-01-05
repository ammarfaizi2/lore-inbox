Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932154AbWAEUYt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbWAEUYt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 15:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbWAEUYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 15:24:49 -0500
Received: from mail.gmx.net ([213.165.64.21]:20896 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932154AbWAEUYs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 15:24:48 -0500
X-Authenticated: #271361
Date: Thu, 5 Jan 2006 21:24:28 +0100
From: Edgar Toernig <froese@gmx.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Florian Schmidt <tapas@affenbande.org>, Takashi Iwai <tiwai@suse.de>,
       Adrian Bunk <bunk@stusta.de>, Jesper Juhl <jesper.juhl@gmail.com>,
       Olivier Galibert <galibert@pobox.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, Andi Kleen <ak@suse.de>,
       perex@suse.cz, alsa-devel@alsa-project.org, James@superbug.demon.co.uk,
       sailer@ife.ee.ethz.ch, linux-sound@vger.kernel.org, zab@zabbo.net,
       kyle@parisc-linux.org, parisc-linux@lists.parisc-linux.org,
       jgarzik@pobox.com, Thorsten Knabe <linux@thorsten-knabe.de>,
       zwane@commfireservices.com, zaitcev@yahoo.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
Message-Id: <20060105212428.42da986c.froese@gmx.de>
In-Reply-To: <1136489348.31583.47.camel@mindpipe>
References: <s5h1wzpnjrx.wl%tiwai@suse.de>
	<20060103203732.GF5262@irc.pl>
	<s5hvex1m472.wl%tiwai@suse.de>
	<9a8748490601031256x916bddav794fecdcf263fb55@mail.gmail.com>
	<20060103215654.GH3831@stusta.de>
	<20060103221314.GB23175@irc.pl>
	<20060103231009.GI3831@stusta.de>
	<Pine.BSO.4.63.0601040048010.29027@rudy.mif.pg.gda.pl>
	<20060104000344.GJ3831@stusta.de>
	<Pine.BSO.4.63.0601040113340.29027@rudy.mif.pg.gda.pl>
	<20060104010123.GK3831@stusta.de>
	<Pine.BSO.4.63.0601040242190.29027@rudy.mif.pg.gda.pl>
	<20060104113726.3bd7a649@mango.fruits.de>
	<s5hsls398uv.wl%tiwai@suse.de>
	<20060104191750.798af1da@mango.fruits.de>
	<1136445063.24475.11.camel@mindpipe>
	<20060105200911.5aa4e705.froese@gmx.de>
	<1136489348.31583.47.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
>
> Edgar Toernig wrote:
> > Lee Revell wrote:
> > >
> > >  If it does not Just Work it's a bug and we need to hear about it.
> > 
> > So then:  xawtv4 (dvb-app) works with hw:0 but not with 1.0.9's dmix default.
> > It works with /dev/dsp1 (usb-speakers) but not with /dev/dsp0 (atiixp ac'97).
> > vdr's softdevice (another dvb-app) works with dmix-default but not with hw:0.
> 
> Come on, this is LKML, you should know that "it doesn't work" is not a
> useful bug report.

xawtv4 with dmix is just silent and aborts when its queue of outstanding pcm
data is filled up.

Trying to use /dev/dsp0 starts fine for a fraction of a second but then
either stays silent or stutters until its audio-queue overflows again.

With vdr its similar: when using hw:0 it only stutters (and fills the log
with xrun errors).  I had a short look once - it uses a very small buffer
(iirc about 4kb) and gets constant underruns which it tries to handle
via prepare-something but it's unable to recover.  With dmix it works fine,
probably because of the bigger mixing buffer.

> Sure, maybe badly written apps but there must be something wrong if so
> many developers have problems with Alsa.  I've even resigned to grok
> the config files :-(

Ciao, ET.
