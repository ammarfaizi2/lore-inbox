Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965055AbWBGMT5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965055AbWBGMT5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 07:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965056AbWBGMT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 07:19:57 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:27402 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965055AbWBGMT4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 07:19:56 -0500
Date: Tue, 7 Feb 2006 13:19:55 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Bernd Petrovitsch <bernd@firmix.at>
Cc: Herbert Poetzl <herbert@13thfloor.at>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Arjan van de Ven <arjan@infradead.org>, Mark Lord <lkml@rtr.ca>,
       Ulrich Mueller <ulm@kph.uni-mainz.de>, linux-kernel@vger.kernel.org,
       Jens Axboe <axboe@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Byron Stanoszek <gandalf@winds.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>
Subject: RFC: add an ADVANCED_USER option
Message-ID: <20060207121955.GD5937@stusta.de>
References: <uhd7irpi7@a1i15.kph.uni-mainz.de> <Pine.LNX.4.61.0602022144190.30391@yvahk01.tjqt.qr> <43E3DB99.9020604@rtr.ca> <Pine.LNX.4.61.0602041204490.30014@yvahk01.tjqt.qr> <1139153913.3131.42.camel@laptopd505.fenrus.org> <Pine.LNX.4.61.0602052212430.330@yvahk01.tjqt.qr> <1139174355.3131.50.camel@laptopd505.fenrus.org> <Pine.LNX.4.61.0602061554550.31522@yvahk01.tjqt.qr> <20060207004147.GA21620@MAIL.13thfloor.at> <1139305085.13091.17.camel@tara.firmix.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1139305085.13091.17.camel@tara.firmix.at>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2006 at 10:38:05AM +0100, Bernd Petrovitsch wrote:
> On Tue, 2006-02-07 at 01:41 +0100, Herbert Poetzl wrote:
> > On Mon, Feb 06, 2006 at 03:56:34PM +0100, Jan Engelhardt wrote:
> [...]
> > > 
> > > So, just as I did in the sample patch, the manual split shall depend on 
> > > EMBEDDED. Those who run fat databases with big malloc/mmap assumptions 
> > > don't probably belong to the group using CONFIG_EMBEDDED.
> > 
> > *sigh* well, the embeded folks are unlikely to have 1-3GB
> 
> ACK.
> But don't be confused by the naming: CONFIG_EMBEDDED nowadays means
> "options for people who know really what they do". It came originally
> from the embedded world but applies now also to others. 
> No one has come up with a better option name up to now ...
>...

It's slightly different:

EMBEDDED is limited to options allowing additional space savings for 
machines with strong space limits.

If you have enough RAM that VMSPLIT matters, you shouldn't enable 
EMBEDDED.

What we could do is to add an additional ADVANCED_USER option that hides 
options like VMSPLIT or the NAPI options for net drivers.

This would result in the following (the text for ADVANCED_USER isn't 
good, but you get the idea):

config ADVANCED_USER
	bool "ask questions that require a deeper knowledge of the kernel"

config EXPERIMENTAL
	bool "Prompt for development and/or incomplete code/drivers"
	depends on ADVANCED_USER

menuconfig EMBEDDED
        bool "Configure standard kernel features (for small systems)"
        depends on ADVANCED_USER

> 	Bernd

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

