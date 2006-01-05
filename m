Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932196AbWAEVFy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbWAEVFy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 16:05:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbWAEVFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 16:05:54 -0500
Received: from mail.gmx.de ([213.165.64.21]:25820 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932197AbWAEVFw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 16:05:52 -0500
X-Authenticated: #271361
Date: Thu, 5 Jan 2006 22:05:37 +0100
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
Message-Id: <20060105220537.1b90598d.froese@gmx.de>
In-Reply-To: <1136492363.847.12.camel@mindpipe>
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
	<1136492363.847.12.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
>
> > > And btw, with 2.6.15 the usb-speakers only produce noise most of
> > > the time.
> > 
> > Known regression, this is being worked on.  It was known and posted to
> > LKML before the 2.6.15 release, unfortunately 2.6.15 was released with
> > this bug anyway.
> 
> If you'd like to help debug this:
> 
> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1585
> 
> There's a workaround patch available.  We still don't know the exact
> nature of the bug.

Well, the problem I had was not exactly the same (I get loud noise, as
if the samples are byte-swapped) but

   alsa-usbaudio-2.6.15-revert-008.patch

seems to fix that.  Thanks.

But now (alsa-1.0.9 userspace):

  alsaplayer -i text -d hw:0 ...    --> ok
  alsaplayer -i text -d hw:1 ...    --> ok
  alsaplayer -i text -d dmix:0 ...  --> ok
  alsaplayer -i text -d dmix:1 ...  --> no error, no sound, just total
                                        silence.  But the clock's running.

with 2.6.13 all 4 are ok.

Ciao, ET.

PS: Someone reported on bugzilla that his usb-audio is not always detected.
Just for the record - happens here too, usually when cold-booting.
