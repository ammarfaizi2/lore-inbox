Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263136AbUCMRdw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 12:33:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263138AbUCMRdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 12:33:51 -0500
Received: from waste.org ([209.173.204.2]:43427 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263136AbUCMRdp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 12:33:45 -0500
Date: Sat, 13 Mar 2004 11:33:32 -0600
From: Matt Mackall <mpm@selenic.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Bloat report 2.6.3 -> 2.6.4
Message-ID: <20040313173331.GO20174@waste.org>
References: <20040312204458.GJ20174@waste.org> <20040312152206.61604447.akpm@osdl.org> <20040312235349.GK20174@waste.org> <20040313170839.GV14833@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040313170839.GV14833@fs.tum.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13, 2004 at 06:08:40PM +0100, Adrian Bunk wrote:
> On Fri, Mar 12, 2004 at 05:53:49PM -0600, Matt Mackall wrote:
> > On Fri, Mar 12, 2004 at 03:22:06PM -0800, Andrew Morton wrote:
> > > Matt Mackall <mpm@selenic.com> wrote:
> > > >
> > > > 2.6.3 -> 2.6.4
> > > > 
> > > >    text	   data	    bss	    dec	    hex	filename
> > > > 3313135	 660247	 162472	4135854	 3f1bae	vmlinux-2.6.3-c2.6.3
> > > > 3342019	 664154	 162344	4168517	 3f9b45	vmlinux-2.6.4-c2.6.3
> > > > 
> > > > [ Results of size <a> <b>. -c2.6.3 means both kernel images were built
> > > > with the 2.6.3 defconfig.
> > > 
> > > But defconfig was changed between 2.6.3 and 2.6.4.
> > 
> > Yes, and I'm attempting to compensate for that because defconfig
> > changes tend to overwhelm other stuff in the results. 
> > 
> > My strategy here doesn't work as well as I'd hoped. I'm taking the
> > defconfig from the previous kernel and then running yes "" | make
> > oldconfig, which sets any new symbols to their defaults. So this deals
> > with case where existing symbols change defaults, but doesn't address
> > new symbols at all.
> > 
> > And what's happening with some of the new symbols is that they're off
> > in defconfig but on in Kconfig. So I need to come up with a way to
> > take the old defconfig and merge in new symbols from the new
> > defconfig. Then throw it at make oldconfig to drop out any obsolete
> > symbols.
> 
> You have to realize that your "automated scheme to measure the growth of 
> the kernel" doesn't work as you might have expected.
> 
> As an example, consider the following option gets added:
> 
>   config ACPI_NEW_OPTION
> 	bool "new option"
> 	depends on ACPI
> 	default y
> 	help
> 	  This option adds support for $new_feature.
> 	  It enlarges your kernel by about 100k.
> 	  It's save to say Y.
> 
> 
> In your size metric, this option would be pure "bloat".

I actually did explicitly note this problem in the part you clipped.
But I think it's fair to say that new features that are on by default
are in fact bloat in some sense.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
