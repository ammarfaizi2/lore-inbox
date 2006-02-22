Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750906AbWBVMBY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750906AbWBVMBY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 07:01:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751012AbWBVMBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 07:01:23 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:27020 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S1750860AbWBVMBX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 07:01:23 -0500
Date: Wed, 22 Feb 2006 13:01:21 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Adrian Bunk <bunk@stusta.de>
Cc: Samuel Masham <samuel.masham@gmail.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       linux-input@atrey.karlin.mff.cuni.cz, Andrew Morton <akpm@osdl.org>
Subject: Re: [2.6 patch] make INPUT a bool
Message-ID: <20060222120121.GA5650@MAIL.13thfloor.at>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	Samuel Masham <samuel.masham@gmail.com>,
	Jan Engelhardt <jengelh@linux01.gwdg.de>,
	Dmitry Torokhov <dtor_core@ameritech.net>,
	linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz,
	Andrew Morton <akpm@osdl.org>
References: <Pine.LNX.4.61.0602141912580.32490@yvahk01.tjqt.qr> <20060214182238.GB3513@stusta.de> <Pine.LNX.4.61.0602171655530.27452@yvahk01.tjqt.qr> <20060217163802.GI4422@stusta.de> <93564eb70602191933x2a20ce0m@mail.gmail.com> <20060220132832.GF4971@stusta.de> <20060222013410.GH20204@MAIL.13thfloor.at> <20060222023121.GB4661@stusta.de> <20060222024438.GI20204@MAIL.13thfloor.at> <20060222031001.GC4661@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060222031001.GC4661@stusta.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2006 at 04:10:01AM +0100, Adrian Bunk wrote:
> On Wed, Feb 22, 2006 at 03:44:38AM +0100, Herbert Poetzl wrote:
> > On Wed, Feb 22, 2006 at 03:31:21AM +0100, Adrian Bunk wrote:
> > > On Wed, Feb 22, 2006 at 02:34:11AM +0100, Herbert Poetzl wrote:
> > > > On Mon, Feb 20, 2006 at 02:28:32PM +0100, Adrian Bunk wrote:
> > > > > On Mon, Feb 20, 2006 at 12:33:55PM +0900, Samuel Masham wrote:
> > > > > 
> > > > > > Hi Adrian,
> > > > > 
> > > > > Hi Samuel,
> > > > > 
> > > > > > > And I've already given numbers why CONFIG_EMBEDDED=y and
> > > > > > > CONFIG_MODULES=y at the same time is insane.
> > > > > > 
> > > > > > >From your numbers this sounds true ... but actually you might want the
> > > > > > modules to delay the init of the various hardware bits...
> > > > > > 
> > > > > > Sometime boot-time is king and you just try and get back as much of
> > > > > > the size costs as it takes...
> > > > > 
> > > > > this is irrelevant since CONFIG_INPUT alone does not init any hardware.
> > > > > 
> > > > > > I think for EMBEDDED and MODULES is actually a very common case ... if
> > > > > > somewhat odd.
> > > > > 
> > > > > You are misunderstanding EMBEDDED.
> > > > 
> > > > well, I suggested the following (or a similar)
> > > > change some time ago (unfortunately I could not
> > > > find it in the lkml archives, so it might have
> > > > been lost)
> > > > 
> > > > http://vserver.13thfloor.at/Stuff/embedded_to_expert.txt
> > > 
> > > That's not a good solution since EMBEDDED is really only about 
> > > additional space savings - even if you are an "expert", there's no 
> > > reason to enable EMBEDDED when building a kernel for systems 
> > > with > 50 MB RAM.
> > 
> > well, not sure everybody kows that ...
> > 
> >  config X86_P4_CLOCKMOD
> > 	depends on EMBEDDED
> 
> This one is an x86_64 only issue, and yes, it's wrong.
> 
> >  config VT_CONSOLE
> > 	bool "Support for console on virtual terminal" if EMBEDDED
> 
> Looks OK.
> 
> >  config VGA_CONSOLE
> > 	bool "VGA text console" if EMBEDDED 
> 
> Looks OK.
> 
> >  config DNOTIFY
> > 	bool "Dnotify support" if EMBEDDED
> 
> Looks OK.
> 
> >  config DEBUG_BUGVERBOSE
> > 	bool "Verbose BUG() reporting (adds 70K)" if DEBUG_KERNEL && EMBEDDED
> 
> Looks OK.
> 
> > but, the patch was just considered a starting point
> > so that folks would know _what_ EMBEDDED is currently
> > used for ...
> 
> Except for the X86_P4_CLOCKMOD case, all of your examples are correct 
> usages of EMBEDDED.

ahem, well, then I'm definitely doing something
wrong when I disable the VGA console on my 2GB
servers, as "there's no reason to enable EMBEDDED
when building a kernel for systems with > 50 MB RAM"

sorry, I kind of disagree here, this might be useful
for embedded systems, but it is definitely useful
for other systems as well ... at least I do not like
the 'assumption' that every system with >50MB has
to have a VGA console ...

I agree that the 0815 distro will not need this and
it can be hidden behind some option ...

best,
Herbert

> > > The better solution is IMHO an additional option:
> > >   http://lkml.org/lkml/2006/2/7/93
> > >   http://lkml.org/lkml/2006/2/7/139
> > 
> > whatever, just get rid of the CONFIG_EMBEDDED everybody
> > get's wrong and nobody really understands ...
> 
> No, the EMBEDDED semantics shouldn't be changed and most people get it 
> right.
> 
> Naming it EXPERT as you suggested would make it even worse. We could name it 
> SHOW_OPTIONS_FOR_ADDITIONAL_SPACE_SAVINGS_IF_YOU_REALLY_KNOW_WHAT_YOU_ARE_DOING, 
> but unless someone comes up with a name that is both short and 
> significantely better than EMBEDDED I don't see a reason for changing it.
> 
> cu
> Adrian
> 
> -- 
> 
>        "Is there not promise of rain?" Ling Tan asked suddenly out
>         of the darkness. There had been need of rain for many days.
>        "Only a promise," Lao Er said.
>                                        Pearl S. Buck - Dragon Seed
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
