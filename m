Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263137AbUCMRI5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 12:08:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263142AbUCMRI5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 12:08:57 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:5862 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263137AbUCMRIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 12:08:47 -0500
Date: Sat, 13 Mar 2004 18:08:40 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Bloat report 2.6.3 -> 2.6.4
Message-ID: <20040313170839.GV14833@fs.tum.de>
References: <20040312204458.GJ20174@waste.org> <20040312152206.61604447.akpm@osdl.org> <20040312235349.GK20174@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040312235349.GK20174@waste.org>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2004 at 05:53:49PM -0600, Matt Mackall wrote:
> On Fri, Mar 12, 2004 at 03:22:06PM -0800, Andrew Morton wrote:
> > Matt Mackall <mpm@selenic.com> wrote:
> > >
> > > 2.6.3 -> 2.6.4
> > > 
> > >    text	   data	    bss	    dec	    hex	filename
> > > 3313135	 660247	 162472	4135854	 3f1bae	vmlinux-2.6.3-c2.6.3
> > > 3342019	 664154	 162344	4168517	 3f9b45	vmlinux-2.6.4-c2.6.3
> > > 
> > > [ Results of size <a> <b>. -c2.6.3 means both kernel images were built
> > > with the 2.6.3 defconfig.
> > 
> > But defconfig was changed between 2.6.3 and 2.6.4.
> 
> Yes, and I'm attempting to compensate for that because defconfig
> changes tend to overwhelm other stuff in the results. 
> 
> My strategy here doesn't work as well as I'd hoped. I'm taking the
> defconfig from the previous kernel and then running yes "" | make
> oldconfig, which sets any new symbols to their defaults. So this deals
> with case where existing symbols change defaults, but doesn't address
> new symbols at all.
> 
> And what's happening with some of the new symbols is that they're off
> in defconfig but on in Kconfig. So I need to come up with a way to
> take the old defconfig and merge in new symbols from the new
> defconfig. Then throw it at make oldconfig to drop out any obsolete
> symbols.

You have to realize that your "automated scheme to measure the growth of 
the kernel" doesn't work as you might have expected.

As an example, consider the following option gets added:

  config ACPI_NEW_OPTION
	bool "new option"
	depends on ACPI
	default y
	help
	  This option adds support for $new_feature.
	  It enlarges your kernel by about 100k.
	  It's save to say Y.


In your size metric, this option would be pure "bloat".


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

