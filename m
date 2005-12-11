Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161085AbVLKJPd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161085AbVLKJPd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 04:15:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161087AbVLKJPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 04:15:32 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:10193
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1161085AbVLKJPc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 04:15:32 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Pavel Machek <pavel@suse.cz>
Subject: Re: ipw2200 [was Re: RFC: Starting a stable kernel series off the 2.6 kernel]
Date: Sun, 11 Dec 2005 03:12:46 -0600
User-Agent: KMail/1.8
Cc: Bill Davidsen <davidsen@tmr.com>, Mark Lord <lkml@rtr.ca>,
       Adrian Bunk <bunk@stusta.de>, David Ranson <david@unsolicited.net>,
       Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
       Matthias Andree <matthias.andree@gmx.de>
References: <20051203135608.GJ31395@stusta.de> <200512102330.31572.rob@landley.net> <20051211083737.GF5187@elf.ucw.cz>
In-Reply-To: <20051211083737.GF5187@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512110312.47142.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 11 December 2005 02:37, Pavel Machek wrote:
> On So 10-12-05 23:30:30, Rob Landley wrote:
> > On Saturday 10 December 2005 02:35, Pavel Machek wrote:
> > > On Wed 07-12-05 12:14:25, Rob Landley wrote:
> > > > On Tuesday 06 December 2005 12:51, Bill Davidsen wrote:
> > > > > Just so we're all on the same page, I think there are two sets of
> > > > > unhappy people here... one is the group who want new stuff fast and
> > > > > stable. For the most part that's not me, although I was in the "if
> > > > > you're going to add ipw2200 support, why not something that works?"
> > > > > group. But new stuff is going in faster than most people can
> > > > > assimilate it if they have a real job, so I don't see too much
> > > > > problem there.
> > > >
> > > > My laptop has an ipw2200 but I can't get it to work in any kernel I
> > > > built because the kernels I build aren't modular.  I hope to be able
> > > > to work around this someday with a clever enough initramfs (if
> > > > necessary, moving the initramfs initialization earlier in the boot
> > > > sequence), but it hasn't made it far enough up my todo list yet.
> > >
> > > Well, building modular kernel for a test is not *that* much work.
> > > Anyway, if you are going to fix it, fix it properly (by
> > > delayed firmware loading) -- initrd hacks are good for you
> > > but unusable for anyone else.
> >
> > I don't see why that's any less usable than using udev from initramfs to
> > find your root partition.
>
> Why use udev from initramfs?

I don't, but I do use a script that mknods the real root's node based on 
running "find" against /sys to locacate the appropriate device name and then 
finding the major/minor numbers there.

This has nothing whatsoever to do with ipw2200.  It just means I'm not using 
the in-kernel root-finder code.

> Just teach ipw2200 to load firmware late.

That's now how I'd fix this.  If you want to fix it this way, be my guest.

> Don't load firmware when ipw2200 is initialized, load it only 
> when someone attempts to talk to your ipw2200. At that time, you
> should have userland already.

Or I could move initramfs extraction earlier in the boot sequence and never 
have to modify any _other_ drivers that want firmware in order to be able to 
make them work too, rather than playing whack-a-mole teaching drivers I don't 
care about how to hold off on wanting firmware.

>         Pavel

Rob
-- 
Steve Ballmer: Innovation!  Inigo Montoya: You keep using that word.
I do not think it means what you think it means.
