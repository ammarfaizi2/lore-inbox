Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266674AbUHIPGn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266674AbUHIPGn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 11:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266169AbUHIPDx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 11:03:53 -0400
Received: from waste.org ([209.173.204.2]:48778 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S266692AbUHIOjD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 10:39:03 -0400
Date: Mon, 9 Aug 2004 09:38:30 -0500
From: Matt Mackall <mpm@selenic.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Andi Kleen <ak@suse.de>, Zwane Mwaikambo <zwane@linuxpower.ca>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH][2.6] Completely out of line spinlocks / x86_64
Message-ID: <20040809143829.GN16310@waste.org>
References: <Pine.LNX.4.58.0408072217170.19619@montezuma.fsmlabs.com> <Pine.LNX.4.58.0408080156550.19619@montezuma.fsmlabs.com> <20040809132308.7312656b.ak@suse.de> <20040809114138.GB5191@logos.cnet> <20040809114912.GA5287@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040809114912.GA5287@logos.cnet>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2004 at 08:49:12AM -0300, Marcelo Tosatti wrote:
> 
> Hi Zwane, 
> 
> Just seen your bonnie++ results (should have the whole thread before replying), 
> looks great, except a slight reduction in sequential output:
> 
> out-of-line spinlocks:
> Version  @version@      ------Sequential Output------ --Sequential Input- --Random-
>                     -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
> Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
> stp2-000         2G  7018  99 64560  36 21694  16  6789  97 43729  14 340.6   1
> stp2-000         2G  7055  99 64836  39 21899  16  6752  97 44827  17 330.8   2
> stp2-000         2G  7023  99 64525  38 22987  17  6704  96 44777  14 337.3   1
> 
> mainline:
> Version  @version@      ------Sequential Output------ --Sequential Input- --Random-
>                     -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
> Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
> stp2-000         2G  7048  99 64912  38 22510  17  6732  96 43900  14 332.0   1
> stp2-000         2G  7018  99 63821  39 21732  16  6787  97 44889  17 326.7   2
> stp2-000         2G  7063  99 63834  38 22361  17  6738  97 43310  14 338.3   1
>                     ------Sequential Create------ --------Random Create--------
> 
> Probably just noise, still I think its worth mentioning.

That really does look like noise here, though this is probably not the
ideal benchmark test. My hope is that we can stick this in -mm for a
bit and get some wider benchmarking of it (hence the config option).

-- 
Mathematics is the supreme nostalgia of our time.
