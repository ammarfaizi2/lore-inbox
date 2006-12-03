Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936649AbWLCIPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936649AbWLCIPs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 03:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936676AbWLCIPr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 03:15:47 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:32778 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S936649AbWLCIPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 03:15:47 -0500
Date: Sun, 3 Dec 2006 09:15:52 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] FW_LOADER should select HOTPLUG
Message-ID: <20061203081552.GC11084@stusta.de>
References: <20061202194022.GY11084@stusta.de> <20061203071637.GA11084@stusta.de> <20061203005824.37bd8e0f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061203005824.37bd8e0f.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 03, 2006 at 12:58:24AM -0800, Andrew Morton wrote:
> On Sun, 3 Dec 2006 08:16:37 +0100
> Adrian Bunk <bunk@stusta.de> wrote:
> 
> > Since FW_LOADER is an option that is always select'ed by the code using 
> > it, it mustn't depend on HOTPLUG.
> > 
> > It's only relevant in the EMBEDDED=y case, but this might have resulted 
> > in illegal FW_LOADER=, HOTPLUG=n configurations.
> > 
> > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> > 
> > --- linux-2.6.19-rc6-mm2/drivers/base/Kconfig.old	2006-12-02 20:36:49.000000000 +0100
> > +++ linux-2.6.19-rc6-mm2/drivers/base/Kconfig	2006-12-02 20:37:03.000000000 +0100
> > @@ -19,8 +19,8 @@
> >  	  If unsure say Y here.
> >  
> >  config FW_LOADER
> > -	tristate "Userspace firmware loading support"
> > -	depends on HOTPLUG
> > +	tristate
> > +	select HOTPLUG
> 
> It would be a retrograde step to start selecting HOTPLUG - we've managed to
> avoid it thus far.

$ grep -r "select HOTPLUG" * | wc -l
4
$ 

> It'd be better to make those drivers which select FW_LOADER dependent upon
> HOTPLUG.

$ grep -r "select FW_LOADER" * | wc -l
71
$ 

And since the only case where depends<->select makes a difference is 
CONFIG_EMBEDDED=y, people will always continue to forget the dependency 
on HOTPLUG when select'ing FW_LOADER.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

