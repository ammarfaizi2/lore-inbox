Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932442AbVLIWHF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932442AbVLIWHF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 17:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932453AbVLIWHF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 17:07:05 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:10701 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S932442AbVLIWHC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 17:07:02 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH][mm] swsusp: limit image size
Date: Fri, 9 Dec 2005 23:08:19 +0100
User-Agent: KMail/1.9
Cc: Stefan Seyfried <seife@suse.de>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <200512072246.06222.rjw@sisk.pl> <4399CD28.9080000@suse.de> <20051209191735.GB4658@elf.ucw.cz>
In-Reply-To: <20051209191735.GB4658@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512092308.19644.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Friday, 9 December 2005 20:17, Pavel Machek wrote:
> > >> What happens if IMAGE_SIZE is bigger than free swap? Do we "try harder"
> > >> or do we fail?
> > > 
> > > First, with swsusp the image can't be bigger than 1/2 of lowmem (1/2 of RAM
> > > on x86-64) and the too great values of IMAGE_SIZE have no effect.  Still, if
> > > the amount of free swap is smaller than 1/2 of RAM and the image happens
> > > to be bigger, we will fail.
> > 
> > ok. This is not nice since we might fail without any _real_ need.

That depends a good deal on how you define "real". :-)

> > Can we make this parameter userspace-tweakable, so that my userspace app
> > can do something like (pseudocode):
> > 
> >     echo 500 > /sys/power/swsusp/imagesize
> >     echo disk > /sys/power/state
> >     R=$?
> >     if [ $R -eq $ENOMEM ]; then
> >         echo 100 > /sys/power/swsusp/imagesize # try again
> 
> You can do 'echo 0' -- as small as possible.
> 
> >         echo disk > /sys/power/state
> >         R=$?
> >     fi
> >     if [ $R -ne 0 ]; then
> >         pop_up_some_loud_beeping_window "suspend failed!"
> >     fi
> > 
> > This would at least give us a chance for a second try. I know that Pavel
> > dislikes userspace tunables, but i dislike failing suspends ;-)
> 
> Can we do that when we start seeing failed suspends? I think it will
> not happen. If we have reasonably-sized swap partition, it should be
> ok.

Yes.  Moreover, we can do something like that without a userspace
tunable, if we check for the free swap before we try to shrink memory.
This would take some time to implement, though, and I'd rather
like to do the userland interface first.

The tunable may be useful to people who'd like to achieve the
maximum efficiency of suspend/resume and it would be a nice
feature to have, I think, but let's say we'll try to implement it
in the future, if still needed/wanted.

Greetings,
Rafael


-- 
Beer is proof that God loves us and wants us to be happy - Benjamin Franklin
