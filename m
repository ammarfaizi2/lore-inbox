Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965177AbVJ1Ic5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965177AbVJ1Ic5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 04:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965183AbVJ1Ic5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 04:32:57 -0400
Received: from alephnull.demon.nl ([83.160.184.112]:33152 "EHLO
	xi.wantstofly.org") by vger.kernel.org with ESMTP id S965177AbVJ1Ic5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 04:32:57 -0400
Date: Fri, 28 Oct 2005 10:32:45 +0200
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: John Bowler <jbowler@acm.org>
Cc: "'Deepak Saxena'" <dsaxena@plexity.net>, linux-kernel@vger.kernel.org,
       linux-arm-kernel@lists.arm.linux.org.uk
Subject: Re: [PATCH] 2.6.14 include/asm-arm/arch-ixp4xx/timex.h: fix clock frequency on NSLU2
Message-ID: <20051028083245.GB26901@xi.wantstofly.org>
References: <001101c5db89$5d5b1560$1001a8c0@kalmiopsis>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001101c5db89$5d5b1560$1001a8c0@kalmiopsis>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John,


On Thu, Oct 27, 2005 at 11:32:25PM -0700, John Bowler wrote:

> The problem is that the NSLU2 deviates from the Intel IXDP425
> system by using a cystal with frequency 66MHz as opposed to the
> Intel stated (not quite mandated) value of 66.666666MHz.  This
> results in serious errors in the RTC (1%).
> 
> The patch configs in the correct value for the NSLU2.  The problem
> with the patch is that a multi-config kernel which includes NSLU2
> support will use the NSLU2 frequency.  However such kernels are
> not a requirement as generic kernels are never flashed into NSLU2
> systems (so there is no need to build NSLU2 support into a generic
> kernel).

As previously stated: with this patch, compiling in support for the
NSLU2 will make the timer tick base right for the NSLU2 but wrong
for everything else.

There are two ways of dealing with this problem:
1/ The patch you sent, plus some config hacks to make it impossible
   to compile in NSLU2 support together with support for another ixp4xx
   machine type that has FREQ=66666666, sidestepping the issue; or
2/ Make the ixp4xx timer tick base runtime selectable altogether, for
   example with the patch that I sent to linux-arm-kernel a while ago.

I'm not very much in favor of 1/, but at least it's better than not
having any kind of protection at all.  If you leave it to the user,
they simply _are_ going to get it messed up.


--L
