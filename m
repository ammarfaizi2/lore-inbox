Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261668AbUKCSUM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261668AbUKCSUM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 13:20:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261727AbUKCSUL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 13:20:11 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:19596 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261668AbUKCSUF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 13:20:05 -0500
Date: Wed, 3 Nov 2004 19:19:37 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Tom Rini <trini@kernel.crashing.org>
cc: blaisorblade_spam@yahoo.it, akpm@osdl.org, linux-kernel@vger.kernel.org,
       julian@sektor37.de, mcr@sandelman.ottawa.on.ca, sam@ravnborg.org
Subject: Re: [patch 2/2] kbuild: fix crossbuild base config
In-Reply-To: <20041103174856.GG381@smtp.west.cox.net>
Message-ID: <Pine.LNX.4.61.0411031909460.877@scrub.home>
References: <20041102232001.370174C0BC@zion.localdomain>
 <Pine.LNX.4.61.0411031747020.17266@scrub.home> <20041103174856.GG381@smtp.west.cox.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 3 Nov 2004, Tom Rini wrote:

> > > This has actually created not-working UML binaries (since UML is always
> > > "cross-compiled" for this purpose), as reported by Julian Scheid.
> > 
> > This rather suggests, there is a problem with UML. Either fix your Kconfig 
> > to prevent nonvalid configurations or detect and report the problem at 
> > runtime.
> 
> No, this is a damn annoying kbuild problem when cross compiling.

The ability to create a nonworkable UML binary is _not_ a kbuild problem, 
especially in the UML case I would expect it should be possible to avoid 
this.

> > > We all agreed on this kind of general, not UML-only fix, and I (Paolo)
> > > implemented it.
> > 
> > I don't like the two separate lists, it would be easier to just skip all 
> > absolute path names.
> > I would also like to avoid this patch at all. If this really should be a 
> > problem, I'd consider to don't run kconfig at all in this case if there 
> > is no configuration and instead suggest running defconfig (or one of 
> > machine specific config targets) first.
> 
> I have a feeling that changing the behavior of 'make {,x,g,q}config' to
> fail if there's no .config will upset a lot of users, possibly even more
> than would be upset by never looking in /boot or /lib ever.

I'm only talking about cross compiling here. From people who do this, I 
sort of expect, that they know what they do. You can misconfigure a kernel 
in native compiles as well, this patch solves the wrong problem. 
E.g. if someone wrote a patch which stores the arch in .config and warns/ 
refuses to load it for a different configuration, I would accept it 
happily.

bye, Roman
