Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932205AbVKETM0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbVKETM0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 14:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932296AbVKETM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 14:12:26 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:523 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932205AbVKETM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 14:12:26 -0500
Date: Sat, 5 Nov 2005 20:12:24 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Milton Miller <miltonm@bga.com>
Cc: gerg@uclinux.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]: linux-2.6.14-uc0 (MMU-less support)
Message-ID: <20051105191224.GB4493@stusta.de>
References: <40564dc5fa508b27c752b692f93562f4@bga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40564dc5fa508b27c752b692f93562f4@bga.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 05, 2005 at 12:42:42PM -0600, Milton Miller wrote:
> On Tue Nov 01 2005 - 23:01:02 EST, Greg Ungerer wrote:
>...
> >@@ -1190,7 +1190,7 @@
> >
> > config NET_PCI
> > 	bool "EISA, VLB, PCI and on board controllers"
> >-	depends on NET_ETHERNET && (ISA || EISA || PCI)
> >+	depends on NET_ETHERNET && (ISA || EISA || PCI || EMBEDDED)
> > 	help
> > 	  This is another class of network cards which attach directly to the
> > 	  bus. If you have one of those, say Y and read the Ethernet-HOWTO,
> >
> 
> Lots of people turn on EMBEDDED for lots of reasons, asking about
> a lot more drivers seems burdensome.
> 
> Care to create a single intermediate Kconfig var for those?
> Something like "Controllers attached directly to a cpu?"

It seems the real problem is a misunderstanding regarding the semantics 
of EMBEDDED.

EMBEDDED is _not_ strictly connected to any usage of the kernel.

All EMBEDDED does is to offer additional option for people needing a 
small kernel in space-limited environments.

CC_OPTIMIZE_FOR_SIZE is one example, but it also allows to e.g. deselect 
futex support.

(ISA || EISA || PCI || EMBEDDED) doesn't make any sense since this 
dependency expresses the supported busses. If this was required for any 
purpose, it should be reported to find a proper solution.

>...
> > ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
> >-CFLAGS		+= -Os
> >+CFLAGS		+= -O
> > else
> > CFLAGS		+= -O2
> > endif
> 
> Sees this undoes part of the benefit, perhaps you should add a
> third option.

Even further, I don't see any reason for using -O - the resulting code 
is expected to be both bigger and slower than with -Os.

Is this a workaround for a gcc bug on some platform?

> milton

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

