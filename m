Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262345AbUCLXx7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 18:53:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262347AbUCLXx7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 18:53:59 -0500
Received: from waste.org ([209.173.204.2]:15570 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262345AbUCLXx4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 18:53:56 -0500
Date: Fri, 12 Mar 2004 17:53:49 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bloat report 2.6.3 -> 2.6.4
Message-ID: <20040312235349.GK20174@waste.org>
References: <20040312204458.GJ20174@waste.org> <20040312152206.61604447.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040312152206.61604447.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2004 at 03:22:06PM -0800, Andrew Morton wrote:
> Matt Mackall <mpm@selenic.com> wrote:
> >
> > 2.6.3 -> 2.6.4
> > 
> >    text	   data	    bss	    dec	    hex	filename
> > 3313135	 660247	 162472	4135854	 3f1bae	vmlinux-2.6.3-c2.6.3
> > 3342019	 664154	 162344	4168517	 3f9b45	vmlinux-2.6.4-c2.6.3
> > 
> > [ Results of size <a> <b>. -c2.6.3 means both kernel images were built
> > with the 2.6.3 defconfig.
> 
> But defconfig was changed between 2.6.3 and 2.6.4.

Yes, and I'm attempting to compensate for that because defconfig
changes tend to overwhelm other stuff in the results. 

My strategy here doesn't work as well as I'd hoped. I'm taking the
defconfig from the previous kernel and then running yes "" | make
oldconfig, which sets any new symbols to their defaults. So this deals
with case where existing symbols change defaults, but doesn't address
new symbols at all.

And what's happening with some of the new symbols is that they're off
in defconfig but on in Kconfig. So I need to come up with a way to
take the old defconfig and merge in new symbols from the new
defconfig. Then throw it at make oldconfig to drop out any obsolete
symbols.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
