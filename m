Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261727AbUKCSeY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261727AbUKCSeY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 13:34:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261799AbUKCSeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 13:34:24 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:25046 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S261727AbUKCSeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 13:34:17 -0500
Date: Wed, 3 Nov 2004 11:34:15 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: blaisorblade_spam@yahoo.it, akpm@osdl.org, linux-kernel@vger.kernel.org,
       julian@sektor37.de, mcr@sandelman.ottawa.on.ca, sam@ravnborg.org
Subject: Re: [patch 2/2] kbuild: fix crossbuild base config
Message-ID: <20041103183415.GH381@smtp.west.cox.net>
References: <20041102232001.370174C0BC@zion.localdomain> <Pine.LNX.4.61.0411031747020.17266@scrub.home> <20041103174856.GG381@smtp.west.cox.net> <Pine.LNX.4.61.0411031909460.877@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0411031909460.877@scrub.home>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2004 at 07:19:37PM +0100, Roman Zippel wrote:
> Hi,
> 
> On Wed, 3 Nov 2004, Tom Rini wrote:
> 
> > > > This has actually created not-working UML binaries (since UML is always
> > > > "cross-compiled" for this purpose), as reported by Julian Scheid.
> > > 
> > > This rather suggests, there is a problem with UML. Either fix your Kconfig 
> > > to prevent nonvalid configurations or detect and report the problem at 
> > > runtime.
> > 
> > No, this is a damn annoying kbuild problem when cross compiling.
> 
> The ability to create a nonworkable UML binary is _not_ a kbuild problem, 
> especially in the UML case I would expect it should be possible to avoid 
> this.

How about how easy it is to create a totally bogus config for any arch?
This isn't a UML problem, this is a cross compiling for any arch
problem.

> > > > We all agreed on this kind of general, not UML-only fix, and I (Paolo)
> > > > implemented it.
> > > 
> > > I don't like the two separate lists, it would be easier to just skip all 
> > > absolute path names.
> > > I would also like to avoid this patch at all. If this really should be a 
> > > problem, I'd consider to don't run kconfig at all in this case if there 
> > > is no configuration and instead suggest running defconfig (or one of 
> > > machine specific config targets) first.
> > 
> > I have a feeling that changing the behavior of 'make {,x,g,q}config' to
> > fail if there's no .config will upset a lot of users, possibly even more
> > than would be upset by never looking in /boot or /lib ever.
> 
> I'm only talking about cross compiling here. From people who do this, I 
> sort of expect, that they know what they do.

The following argument makes less sense, possibly, as 2.6 lives on, but
this is new breakage for people moving up from 2.4 that just looked in
.config and arch/$(ARCH)/defconfig and who don't otherwise know that
things have been changed or broken, depending on how you look at it.

> You can misconfigure a kernel 
> in native compiles as well, this patch solves the wrong problem. 

I disagree.  This solves the "why did the kernel decide to look at
/boot/config when it really should have known better" problem.

> E.g. if someone wrote a patch which stores the arch in .config and warns/ 
> refuses to load it for a different configuration, I would accept it 
> happily.

We already have part of this, except I don't know for certain of
CONFIG_ARCH == CONFIG_$(SUBARCH) (... to mix syntax all the hell up).

-- 
Tom Rini
http://gate.crashing.org/~trini/
